import Testing
import UIKit
@testable import BezierSwift

// MARK: - Helpers

@MainActor
private func findTextView(in view: UIView) -> UITextView? {
  view.subviews.compactMap { $0 as? UITextView }.first
}

@MainActor
private func findPlaceholderLabel(in view: UIView) -> UILabel? {
  view.subviews.compactMap { $0 as? UILabel }.first
}

// window에 붙이지 않으면 becomeFirstResponder()가 무조건 false를 반환해 음성 결과가 무의미해진다 —
// 포커스 테스트는 key window까지 필요하고, 레이아웃 테스트는 key window로 만들면 다른 스위트의
// first responder 상태를 건드리므로 필요한 쪽만 켠다
@MainActor
private func host(_ view: UIView, width: CGFloat = 320, makeKey: Bool = false) -> UIWindow {
  let window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 600))
  window.addSubview(view)
  NSLayoutConstraint.activate([
    view.topAnchor.constraint(equalTo: window.topAnchor),
    view.leadingAnchor.constraint(equalTo: window.leadingAnchor),
    view.widthAnchor.constraint(equalToConstant: width),
  ])
  if makeKey { window.makeKeyAndVisible() }
  window.setNeedsLayout()
  window.layoutIfNeeded()
  return window
}

@MainActor
private func dismiss(_ window: UIWindow, _ view: UIView) {
  view.resignFirstResponder()
  view.removeFromSuperview()
  window.isHidden = true
}

// MARK: - 높이 모델 상수

@Suite("BezierTextArea 높이 모델")
struct BezierTextAreaSpecTests {
  @Test("최소 높이는 64pt다 (2행 × lineHeight 24 + 상하 패딩 8×2에서 파생)")
  func minHeightDerivation() {
    #expect(BezierTextAreaConstant.minHeight == 64)
  }

  @Test("최대 높이는 160pt다 (6행 × lineHeight 24 + 상하 패딩 8×2에서 파생)")
  func maxHeightDerivation() {
    #expect(BezierTextAreaConstant.maxHeight == 160)
  }
}

// MARK: - 상태 프로퍼티

@Suite("BezierTextArea 상태 프로퍼티")
@MainActor
struct BezierTextAreaStateTests {
  @Test(
    "isEditable은 isEnabled && !isReadOnly와 일치한다",
    arguments: [
      (true, false, true),
      (true, true, false),
      (false, false, false),
      (false, true, false),
    ]
  )
  func isEditableMatrix(isEnabled: Bool, isReadOnly: Bool, expected: Bool) throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))

    textArea.isEnabled = isEnabled
    textArea.isReadOnly = isReadOnly

    #expect(textView.isEditable == expected)
  }

  // isEnabled 기본값이 true라서 위 매트릭스에는 isEnabled의 didSet을 통과하지 않는 조합이 있다 —
  // readOnly가 켜진 상태로 refreshEnabled()를 실제로 통과시키는 경로는 이 시나리오뿐이다
  @Test("양방향 토글 후에도 isEditable이 복원된다")
  func isEditableRoundTrip() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))

    textArea.isReadOnly = true
    textArea.isEnabled = false
    textArea.isEnabled = true
    #expect(!textView.isEditable)

    textArea.isReadOnly = false
    #expect(textView.isEditable)
  }

  @Test("readOnly는 편집만 막고 선택은 유지한다")
  func readOnlyKeepsSelectable() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))

    for (isEnabled, isReadOnly) in [(true, false), (true, true), (false, false), (false, true)] {
      textArea.isEnabled = isEnabled
      textArea.isReadOnly = isReadOnly
      #expect(textView.isSelectable)
    }
  }
}

// MARK: - 내부 텍스트 뷰 · placeholder 구성

@Suite("BezierTextArea 텍스트 뷰·placeholder")
@MainActor
struct BezierTextAreaTextViewConfigurationTests {
  @Test("TextKit 1을 사용한다 (24pt 행 피치 전제)")
  func usesTextKitOne() throws {
    let textView = try #require(findTextView(in: BezierTextArea()))

    // textLayoutManager는 TextKit 2에서만 존재한다 — layoutManager 쪽은 non-optional이라 비교가
    // 항상 참이고, 접근 자체가 TextKit 1 폴백을 유발해 검사 대상을 바꿔버린다
    #expect(textView.textLayoutManager == nil)
  }

  @Test("스크롤 인디케이터는 숨긴다 (SwiftUI 패리티)")
  func hidesScrollIndicator() throws {
    let textView = try #require(findTextView(in: BezierTextArea()))

    #expect(!textView.showsVerticalScrollIndicator)
    #expect(!textView.alwaysBounceVertical)
  }

  @Test("placeholder는 2행 + tail 말줄임으로 막는다")
  func twoLineTruncation() throws {
    let textArea = BezierTextArea(placeholder: "긴 안내 문구")
    let label = try #require(findPlaceholderLabel(in: textArea))

    #expect(label.numberOfLines == BezierTextAreaConstant.minLineCount)

    let attributes = try #require(label.attributedText?.attributes(at: 0, effectiveRange: nil))
    let paragraphStyle = try #require(attributes[.paragraphStyle] as? NSParagraphStyle)
    #expect(paragraphStyle.lineBreakMode == .byTruncatingTail)
    // 타이포 헬퍼는 lineBreakMode가 .byWordWrapping일 때만 한글 줄바꿈 전략을 붙인다 — 말줄임을
    // 헬퍼 인자로 넘기는 방식으로 단순화하면 이 전략을 잃는다. 구현이 생성된 paragraphStyle을
    // 복사해 lineBreakMode만 덮어쓰는 우회를 유지하는지 확인한다
    #expect(paragraphStyle.lineBreakStrategy == .hangulWordPriority)
  }

  @Test("placeholder는 값이 있으면 숨고 비면 다시 보인다")
  func visibilityFollowsText() throws {
    let textArea = BezierTextArea(placeholder: "안내")
    let label = try #require(findPlaceholderLabel(in: textArea))

    #expect(!label.isHidden)

    textArea.text = "값"
    #expect(label.isHidden)

    textArea.text = ""
    #expect(!label.isHidden)
  }
}

// MARK: - placeholder 접근성 노출

// UILabel은 기본이 접근성 요소라, 별도 라벨로 그린 placeholder는 입력 요소와 무관한 항목으로 읽힌다.
// 노출 창구를 textView로 단일화한 규약을 잠근다. 라벨 쪽 isAccessibilityElement = false는 여기서
// 검증하지 않는다 — 유닛 테스트 프로세스에는 UIKit 접근성 번들이 주입되지 않아 기본값도 false로
// 읽히므로, 구현을 지워도 통과하는 무의미한 단언이 된다
@Suite("BezierTextArea placeholder 접근성")
@MainActor
struct BezierTextAreaAccessibilityTests {
  @Test("placeholder를 textView의 accessibilityLabel로 노출한다")
  func placeholderBecomesLabel() throws {
    let textArea = BezierTextArea(placeholder: "채널의 특징을 간략히 소개해보세요")
    let textView = try #require(findTextView(in: textArea))

    #expect(textView.accessibilityLabel == "채널의 특징을 간략히 소개해보세요")
  }

  // UITextView는 입력값을 accessibilityValue로 내보낸다 — 값이 찼다고 label을 비우면 그 시점부터
  // 이 필드가 무엇을 받는 칸인지 알 수 없어진다. placeholder가 보이지 않게 되는 것과 무관하게 유지한다
  @Test("값이 있어도 accessibilityLabel은 placeholder를 유지한다")
  func labelSurvivesTextEntry() throws {
    let textArea = BezierTextArea(placeholder: "안내")
    let textView = try #require(findTextView(in: textArea))

    textArea.text = "입력한 값"
    #expect(textView.accessibilityLabel == "안내")

    textArea.textViewDidChange(textView)
    #expect(textView.accessibilityLabel == "안내")
  }

  @Test("placeholder를 바꾸면 accessibilityLabel도 따라간다")
  func labelFollowsPlaceholderUpdate() throws {
    let textArea = BezierTextArea(placeholder: "이전 안내")
    let textView = try #require(findTextView(in: textArea))

    textArea.placeholder = "새 안내"

    #expect(textView.accessibilityLabel == "새 안내")
  }

  @Test("placeholder가 비면 accessibilityLabel은 nil이다 (빈 문자열 낭독 방지)")
  func emptyPlaceholderClearsLabel() throws {
    let textArea = BezierTextArea(placeholder: "안내")
    let textView = try #require(findTextView(in: textArea))

    textArea.placeholder = ""

    #expect(textView.accessibilityLabel == nil)
  }
}

// MARK: - 콜백

@Suite("BezierTextArea 콜백")
@MainActor
struct BezierTextAreaCallbackTests {
  @Test("코드로 text를 대입하면 onTextChanged가 호출되지 않는다")
  func programmaticTextDoesNotNotify() {
    let textArea = BezierTextArea()
    var received: [String] = []
    textArea.onTextChanged = { received.append($0) }

    textArea.text = "값"

    #expect(received.isEmpty)
    #expect(textArea.text == "값")
  }

  @Test("사용자 입력은 onTextChanged로 현재 값을 전달한다")
  func userInputNotifies() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))
    var received: [String] = []
    textArea.onTextChanged = { received.append($0) }

    textView.text = "입력"
    textArea.textViewDidChange(textView)

    #expect(received == ["입력"])
  }

  @Test("편집 시작·종료가 onEditingChanged로 전달된다")
  func editingChangedNotifies() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))
    var received: [Bool] = []
    textArea.onEditingChanged = { received.append($0) }

    textArea.textViewDidBeginEditing(textView)
    textArea.textViewDidEndEditing(textView)

    #expect(received == [true, false])
  }

  @Test("입력 중에는 기존 스토리지 속성을 재지정하지 않는다 (캐럿 튐 회귀 방지)")
  func typingDoesNotRewriteTextStorage() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))
    textArea.text = "abcdef"

    // 전 구간 setAttributes가 다시 들어오면 지워지는 표식. 지워지면 applyTextAttributes()가
    // 입력 경로로 되돌아온 것이고, 그것이 캐럿 튐의 원인이었다
    let marker = NSAttributedString.Key.underlineStyle
    textView.textStorage.addAttribute(
      marker,
      value: NSUnderlineStyle.single.rawValue,
      range: NSRange(location: 0, length: 3)
    )

    textArea.textViewDidChange(textView)

    #expect(textView.textStorage.attribute(marker, at: 0, effectiveRange: nil) != nil)
  }

  @Test("코드 대입은 반대로 스토리지 속성을 전 구간 재지정한다")
  func programmaticAssignmentRewritesTextStorage() throws {
    let textArea = BezierTextArea()
    let textView = try #require(findTextView(in: textArea))
    textArea.text = "abcdef"
    textView.textStorage.addAttribute(
      NSAttributedString.Key.underlineStyle,
      value: NSUnderlineStyle.single.rawValue,
      range: NSRange(location: 0, length: 3)
    )

    textArea.text = "ghijkl"

    let attributes = textView.textStorage.attributes(at: 0, effectiveRange: nil)
    #expect(attributes[.underlineStyle] == nil)
    #expect(attributes[.font] as? UIFont == BezierBaseInputConstant.textTypography.uiFont)
  }
}

// MARK: - 포커스 가능 여부

@Suite("BezierTextArea 포커스 가능 여부")
@MainActor
struct BezierTextAreaFocusabilityTests {
  @Test("비활성 상태에서는 포커스를 받을 수 없다")
  func disabledCannotBecomeFirstResponder() {
    let textArea = BezierTextArea()
    textArea.isEnabled = false

    #expect(!textArea.canBecomeFirstResponder)
  }

  @Test("활성 상태에서는 포커스를 받을 수 있다 (위 테스트의 대조군)")
  func enabledCanBecomeFirstResponder() {
    #expect(BezierTextArea().canBecomeFirstResponder)
  }

  @Test("readOnly에서도 포커스는 받을 수 있다 (선택·복사 유지)")
  func readOnlyStillFocusable() {
    let textArea = BezierTextArea()
    textArea.isReadOnly = true

    #expect(textArea.canBecomeFirstResponder)
  }
}

// MARK: - 포커스 획득·해제 (key window 필요)

@Suite("BezierTextArea 포커스 획득·해제", .serialized)
@MainActor
struct BezierTextAreaFocusTests {
  @Test("비활성 상태의 becomeFirstResponder는 실패한다")
  func disabledBecomeFirstResponderFails() {
    let textArea = BezierTextArea()
    let window = host(textArea, makeKey: true)
    defer { dismiss(window, textArea) }

    textArea.isEnabled = false

    #expect(!textArea.becomeFirstResponder())
    #expect(!textArea.isFirstResponder)
  }

  @Test("활성 상태의 becomeFirstResponder는 성공한다 (위 테스트의 대조군)")
  func enabledBecomeFirstResponderSucceeds() {
    let textArea = BezierTextArea()
    let window = host(textArea, makeKey: true)
    defer { dismiss(window, textArea) }

    #expect(textArea.becomeFirstResponder())
    #expect(textArea.isFirstResponder)
  }

  @Test("포커스 중 비활성화하면 포커스가 즉시 해제된다")
  func disablingResignsFocus() {
    let textArea = BezierTextArea()
    let window = host(textArea, makeKey: true)
    defer { dismiss(window, textArea) }

    #expect(textArea.becomeFirstResponder())

    textArea.isEnabled = false

    #expect(!textArea.isFirstResponder)
  }
}

// MARK: - 높이 자동 확장 (window 필요)

@Suite("BezierTextArea 높이 자동 확장", .serialized)
@MainActor
struct BezierTextAreaHeightTests {
  @Test("3행은 88pt = 24×3 + 8×2다")
  func threeLinesIs88() {
    let textArea = BezierTextArea()
    let window = host(textArea)
    defer { dismiss(window, textArea) }

    textArea.text = "1\n2\n3"
    window.layoutIfNeeded()

    #expect(textArea.bounds.height == 88)
  }

  @Test("6행 초과는 최대 높이 160pt로 잘린다")
  func overflowClampsToMaxHeight() {
    let textArea = BezierTextArea()
    let window = host(textArea)
    defer { dismiss(window, textArea) }

    textArea.text = (1...12).map(String.init).joined(separator: "\n")
    window.layoutIfNeeded()

    #expect(textArea.bounds.height == BezierTextAreaConstant.maxHeight)
  }

  @Test("값을 비우면 높이와 스크롤 오프셋이 초기 상태로 돌아온다")
  func clearingResetsHeightAndOffset() throws {
    let textArea = BezierTextArea()
    let window = host(textArea)
    defer { dismiss(window, textArea) }
    let textView = try #require(findTextView(in: textArea))

    textArea.text = (1...12).map(String.init).joined(separator: "\n")
    window.layoutIfNeeded()
    textView.setContentOffset(CGPoint(x: 0, y: 60), animated: false)

    textArea.text = ""
    window.layoutIfNeeded()

    #expect(textArea.bounds.height == BezierTextAreaConstant.minHeight)
    #expect(textView.contentOffset == .zero)
  }
}
