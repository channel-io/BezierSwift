import Testing
import UIKit
@testable import BezierSwift

// 리치 텍스트를 만드는 시점엔 모달이 없어 호출부는 아무 컴포넌트나 넘기게 된다.
// 테마를 전혀 따라가지 않는 컴포넌트를 일부러 넘겨, 모달이 색을 되찾는지 검증한다.
private final class FrozenLightComponent: BezierComponentable {
  var colorTheme: BezierColorTheme { .light }
  var componentTheme: BezierComponentTheme = .normal
}

@Suite("BezierConfirmModal 텍스트 갱신 계약", .serialized)
@MainActor
struct BezierConfirmModalTextContractTests {
  @Test("attributedTitle을 설정하면 title은 그 평문이 된다")
  func attributedTitleReplacesPlainTitle() {
    let modal = makeModal(title: "Plain")
    #expect(modal.attributedTitle == nil)

    modal.attributedTitle = NSAttributedString(string: "Rich")

    #expect(modal.title == "Rich")
    #expect(modal.attributedTitle?.string == "Rich")
  }

  @Test("title을 설정하면 attributedTitle 잔재가 남지 않는다")
  func plainTitleClearsAttributedTitle() {
    let modal = makeModal(title: "Plain")
    modal.attributedTitle = NSAttributedString(string: "Rich")

    modal.title = "Plain again"

    #expect(modal.attributedTitle == nil)
    #expect(modal.title == "Plain again")
    #expect(label(withText: "Rich", in: modal) == nil)
  }

  @Test("attributedTitle에 nil을 넣으면 서식만 버리고 평문이 남는다")
  func clearingAttributedTitleKeepsPlainText() {
    let modal = makeModal(title: "Plain")
    modal.attributedTitle = NSAttributedString(string: "Rich")

    modal.attributedTitle = nil

    #expect(modal.attributedTitle == nil)
    #expect(modal.title == "Rich")
  }

  @Test("attributedDescription을 설정하면 descriptionText는 그 평문이 된다")
  func attributedDescriptionReplacesPlainDescription() {
    let modal = makeModal(description: "Plain")

    modal.attributedDescription = NSAttributedString(string: "Rich")

    #expect(modal.descriptionText == "Rich")
    #expect(modal.attributedDescription?.string == "Rich")
  }

  @Test("descriptionText를 설정하면 attributedDescription 잔재가 남지 않는다")
  func plainDescriptionClearsAttributedDescription() {
    let modal = makeModal(description: "Plain")
    modal.attributedDescription = NSAttributedString(string: "Rich")

    modal.descriptionText = "Plain again"

    #expect(modal.attributedDescription == nil)
    #expect(modal.descriptionText == "Plain again")
    #expect(label(withText: "Rich", in: modal) == nil)
  }

  @Test("설명 없이 만든 모달에 attributedDescription을 넣으면 나타난다")
  func attributedDescriptionAppearsOnModalCreatedWithoutDescription() throws {
    let modal = makeModal(description: nil)
    #expect(modal.descriptionText == nil)

    modal.attributedDescription = NSAttributedString(string: "Rich")

    let descriptionLabel = try #require(label(withText: "Rich", in: modal))
    #expect(descriptionLabel.isHidden == false)
  }

  @Test("descriptionText에 nil을 넣으면 attributed 여부와 무관하게 숨겨진다")
  func nilDescriptionHidesRegardlessOfKind() {
    let modal = makeModal(description: "Plain")
    modal.attributedDescription = NSAttributedString(string: "Rich")

    modal.descriptionText = nil

    #expect(modal.descriptionText == nil)
    #expect(modal.attributedDescription == nil)
    #expect(label(withText: "Rich", in: modal) == nil)
  }
}

@Suite("BezierConfirmModal 리치 텍스트 색 소유", .serialized)
@MainActor
struct BezierConfirmModalAttributedColorTests {
  @Test("주입한 전경색은 모달의 시맨틱 색으로 덮어써진다")
  func injectedForegroundColorIsOverwritten() throws {
    let modal = makeModal()
    let injected = NSMutableAttributedString(string: "Rich")
    injected.addAttribute(
      .foregroundColor,
      value: UIColor.red,
      range: NSRange(location: 0, length: injected.length)
    )
    modal.attributedDescription = injected

    let rendered = try #require(foregroundColor(ofTextMatching: "Rich", in: modal))
    let expected = BezierConfirmModalSpec.textColorToken.palette(modal)

    for style in [UIUserInterfaceStyle.light, .dark] {
      #expect(resolved(rendered, style: style) == resolved(expected, style: style))
      #expect(resolved(rendered, style: style) != resolved(.red, style: style))
    }
  }

  @Test("테마를 따라가지 않는 컴포넌트로 만든 리치 텍스트도 라이트·다크가 갈린다")
  func attributedTextTracksInterfaceStyleEvenWhenBuiltWithFrozenComponent() throws {
    let frozen = FrozenLightComponent()
    let modal = makeModal()
    modal.attributedDescription = BezierConfirmModalSpec.descriptionTypography.attributedString(
      frozen,
      text: "Rich",
      semanticColorToken: BezierConfirmModalSpec.textColorToken,
      alignment: .center
    )

    try withExtendedLifetime(frozen) {
      let rendered = try #require(foregroundColor(ofTextMatching: "Rich", in: modal))
      #expect(resolved(rendered, style: .light) != resolved(rendered, style: .dark))
    }
  }

  @Test("componentTheme을 뒤집으면 리치 텍스트 색도 평문 경로처럼 반전된다")
  func attributedTextFollowsComponentThemeInversion() throws {
    let modal = makeModal()
    modal.attributedDescription = NSAttributedString(string: "Rich")

    let normal = try #require(foregroundColor(ofTextMatching: "Rich", in: modal))
    let normalDark = resolved(normal, style: .dark)

    modal.componentTheme = .inverted
    let inverted = try #require(foregroundColor(ofTextMatching: "Rich", in: modal))

    #expect(resolved(inverted, style: .light) == normalDark)
  }

  @Test("색만 덮어쓰고 글꼴은 넘긴 그대로 유지된다")
  func fontRunsArePreserved() throws {
    let modal = makeModal()
    let bold = UIFont.boldSystemFont(ofSize: 20)
    let injected = NSMutableAttributedString(string: "AB")
    injected.addAttribute(.font, value: bold, range: NSRange(location: 1, length: 1))
    modal.attributedDescription = injected

    let descriptionLabel = try #require(label(withText: "AB", in: modal))
    let rendered = try #require(descriptionLabel.attributedText)

    #expect(rendered.attribute(.font, at: 1, effectiveRange: nil) as? UIFont == bold)
    #expect(rendered.attribute(.font, at: 0, effectiveRange: nil) as? UIFont == nil)
  }
}

// MARK: - Helpers

@MainActor
private func makeModal(title: String = "Title", description: String? = nil) -> BezierConfirmModal {
  BezierConfirmModal(
    title: title,
    description: description,
    confirmAction: BezierConfirmModalAction(title: "Confirm"),
    cancelAction: BezierConfirmModalAction(title: "Cancel")
  )
}

@MainActor
private func label(withText text: String, in view: UIView) -> UILabel? {
  if let label = view as? UILabel, label.attributedText?.string == text, !label.isHidden {
    return label
  }
  for subview in view.subviews {
    if let found = label(withText: text, in: subview) {
      return found
    }
  }
  return nil
}

@MainActor
private func foregroundColor(ofTextMatching text: String, in view: UIView) -> UIColor? {
  label(withText: text, in: view)?
    .attributedText?
    .attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
}

// palette(_:)의 dynamic provider는 인자 대신 UITraitCollection.current를 읽으므로
// performAsCurrent 없이 resolvedColor(with:)만 부르면 주변 스타일이 그대로 나온다
private func resolved(_ color: UIColor, style: UIUserInterfaceStyle) -> UIColor {
  let traits = UITraitCollection(userInterfaceStyle: style)
  var result = color
  traits.performAsCurrent { result = color.resolvedColor(with: traits) }
  return result
}
