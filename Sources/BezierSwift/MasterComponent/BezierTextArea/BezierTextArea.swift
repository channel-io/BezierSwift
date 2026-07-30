//
//  BezierTextArea.swift
//  BezierSwift
//

import UIKit

/// 여러 줄 텍스트 입력 영역 (UIKit). 설명·메모·답변 템플릿처럼 여러 줄이거나 길이를 예측할 수 없는 텍스트를 입력받을 때 쓴다. 한 줄로 충분한 입력(이름·이메일 등)에는 `BezierTextInput`을 사용한다. SwiftUI에서는 `SUBezierTextArea`를 사용한다.
///
/// 너비는 컨테이너가 결정한다 — leading/trailing 제약으로 부모 폭을 채우는 배치가 기본이다.
/// 높이는 기본 64pt(2행)에서 내용에 따라 최대 160pt(6행)까지 자동 확장되고, 초과분은 내부 스크롤로 표시된다.
public final class BezierTextArea: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 현재 입력값. 코드로 값을 바꿔도 `onTextChanged`는 호출되지 않는다.
  public var text: String {
    get { self.textView.text ?? "" }
    set {
      guard self.textView.text != newValue else { return }
      self.textView.text = newValue
      self.applyTextAttributes()
      self.refreshPlaceholder()
      self.refreshHeight()
    }
  }

  /// 입력 전 안내 텍스트. 입력 예시나 안내를 보여준다 (예: `채널의 특징을 간략히 소개해보세요`). 기본값은 빈 문자열.
  public var placeholder: String = "" {
    didSet { if oldValue != self.placeholder { self.refreshPlaceholder() } }
  }

  /// 에러 상태 여부. 켜면 에러 보더가 표시된다. 원인·해결 방법 메시지를 함께 노출해야 한다. 기본값 `false`.
  public var hasError: Bool = false {
    didSet { if oldValue != self.hasError { self.refreshAppearance() } }
  }

  /// 읽기 전용 여부. 편집만 차단하고 텍스트 선택·복사는 유지한다. 기본값 `false`.
  public var isReadOnly: Bool = false {
    didSet {
      if oldValue != self.isReadOnly {
        self.refreshEditable()
        self.refreshAppearance()
      }
    }
  }

  /// 활성화 여부. 끄면 모든 인터랙션이 차단되고 40% 투명도가 적용된다. 기본값 `true`.
  public var isEnabled: Bool = true {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  /// 키보드 타입. 내부 텍스트 뷰에 그대로 전달된다.
  public var keyboardType: UIKeyboardType {
    get { self.textView.keyboardType }
    set {
      self.textView.keyboardType = newValue
      // 이미 올라와 있는 키보드는 입력 trait을 다시 읽지 않는다 — 표시 중일 때만 재조회를 강제한다
      if self.textView.isFirstResponder { self.textView.reloadInputViews() }
    }
  }

  // MARK: - Callbacks

  /// 사용자 입력으로 값이 바뀔 때마다 호출된다.
  public var onTextChanged: ((String) -> Void)?

  /// 포커스가 시작(`true`)·종료(`false`)될 때 호출된다.
  public var onEditingChanged: ((Bool) -> Void)?

  // MARK: - Subviews

  // TextKit 2(iOS 16+ UITextView 기본값)는 paragraphStyle의 minimumLineHeight를 무시해 행 피치가
  // 폰트 고유값(약 22.7pt)으로 좁아진다 — 160pt 안에 6행이 아니라 7행이 걸치고 SwiftUI와도 어긋난다.
  // TextKit 1로 되돌려 공유 타이포 헬퍼가 UILabel에서와 동일하게 24pt 행 높이를 만들게 한다
  private let textView: UITextView = {
    let textView = UITextView(usingTextLayoutManager: false)
    textView.backgroundColor = .clear
    textView.textContainerInset = UIEdgeInsets(
      top: BezierTextAreaConstant.verticalPadding,
      left: BezierBaseInputConstant.horizontalPadding,
      bottom: BezierTextAreaConstant.verticalPadding,
      right: BezierBaseInputConstant.horizontalPadding
    )
    textView.textContainer.lineFragmentPadding = 0
    textView.alwaysBounceVertical = false
    // SwiftUI TextField(axis: .vertical)는 내부 스크롤 뷰에 접근할 수단이 없어 인디케이터를 켤 수
    // 없다 — 두 구현을 맞추려면 UIKit 쪽을 끄는 방향뿐이다. 되돌리면 패리티가 깨진다
    textView.showsVerticalScrollIndicator = false
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()

  // 컨테이너는 값이 비어 있는 동안 minHeight(2행)에 머문다 — placeholder도 같은 행 수로 막지 않으면
  // masksToBounds에 걸려 말줄임 없이 중간에서 잘린다
  private let placeholderLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = BezierTextAreaConstant.minLineCount
    label.isUserInteractionEnabled = false
    // UILabel은 기본이 접근성 요소다 — 켜둔 채로 두면 UITextField가 placeholder를 자기 label로
    // 흡수하는 것과 달리 입력 요소와 무관한 별도 항목으로 읽힌다. 노출은 textView가 전담한다
    label.isAccessibilityElement = false
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Constraints

  private var heightConstraint: NSLayoutConstraint?
  private var lastLayoutWidth: CGFloat = 0

  // MARK: - Init

  /// placeholder를 지정해 생성한다.
  public init(placeholder: String = "") {
    self.placeholder = placeholder
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.masksToBounds = true
    self.layer.cornerRadius = BezierTextAreaConstant.cornerRadius

    self.textView.delegate = self
    self.addSubview(self.textView)
    self.addSubview(self.placeholderLabel)

    let heightConstraint = self.heightAnchor.constraint(
      equalToConstant: BezierTextAreaConstant.minHeight
    )
    self.heightConstraint = heightConstraint
    NSLayoutConstraint.activate([
      self.textView.topAnchor.constraint(equalTo: self.topAnchor),
      self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.placeholderLabel.topAnchor.constraint(
        equalTo: self.topAnchor,
        constant: BezierTextAreaConstant.verticalPadding
      ),
      self.placeholderLabel.leadingAnchor.constraint(
        equalTo: self.leadingAnchor,
        constant: BezierBaseInputConstant.horizontalPadding
      ),
      self.placeholderLabel.trailingAnchor.constraint(
        lessThanOrEqualTo: self.trailingAnchor,
        constant: -BezierBaseInputConstant.horizontalPadding
      ),
      self.widthAnchor.constraint(greaterThanOrEqualToConstant: BezierBaseInputConstant.minWidth),
      heightConstraint,
    ])

    self.refreshEnabled()
    self.refreshAppearance()
  }

  // MARK: - First Responder

  // isUserInteractionEnabled는 터치만 막는다 — 프로그램적 포커스 요청은 이 경로로 들어오고 하드웨어
  // 키보드 입력은 hit test를 거치지 않으므로, 여기서 막지 않으면 비활성 상태에서도 입력이 반영된다
  public override var canBecomeFirstResponder: Bool {
    self.isEnabled && self.textView.canBecomeFirstResponder
  }

  public override var isFirstResponder: Bool { self.textView.isFirstResponder }

  @discardableResult
  public override func becomeFirstResponder() -> Bool {
    guard self.isEnabled else { return false }
    return self.textView.becomeFirstResponder()
  }

  @discardableResult
  public override func resignFirstResponder() -> Bool {
    self.textView.resignFirstResponder()
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    if self.bounds.width != self.lastLayoutWidth {
      self.lastLayoutWidth = self.bounds.width
      self.refreshHeight()
    }
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - State

  private var currentState: BezierBaseInputState {
    .resolve(
      isEnabled: self.isEnabled,
      isReadOnly: self.isReadOnly,
      hasError: self.hasError,
      isFocused: self.textView.isFirstResponder
    )
  }

  // MARK: - Refresh

  private func refreshEnabled() {
    // isUserInteractionEnabled = false는 first responder를 해제하는 게 아니라 유예한다 — 명시적으로
    // resign하지 않으면 다시 활성화되는 순간 사용자 조작 없이 포커스와 키보드가 되살아난다
    if !self.isEnabled { self.textView.resignFirstResponder() }
    self.isUserInteractionEnabled = self.isEnabled
    self.refreshEditable()
    self.refreshAppearance()
  }

  // isEnabled·isReadOnly 두 축이 같은 프로퍼티를 다투므로 한 곳에서만 계산한다 — 각 didSet에서 직접
  // 대입하면 나중에 바뀐 쪽이 다른 쪽의 편집 차단을 덮어쓴다.
  // isSelectable은 건드리지 않는다 — readOnly는 편집만 막고 선택·복사는 유지해야 한다
  private func refreshEditable() {
    self.textView.isEditable = self.isEnabled && !self.isReadOnly
  }

  private func refreshAppearance() {
    let state = self.currentState

    self.backgroundColor = BezierBaseInputAppearance
      .backgroundColor(variant: .primary, state: state)
      .palette(self)

    if let borderColor = BezierBaseInputAppearance.borderColor(variant: .primary, state: state) {
      self.layer.borderWidth = BezierBaseInputConstant.borderWidth
      self.layer.borderColor = borderColor.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }

    self.alpha = state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1

    self.applyTextAttributes()
    self.refreshPlaceholder()
  }

  private var textAttributes: [NSAttributedString.Key: Any] {
    BezierBaseInputConstant.textTypography.attributes(
      self,
      semanticColorToken: BezierBaseInputAppearance.textColor(state: self.currentState)
    )
  }

  // 입력 중에는 스토리지를 건드리지 않는다 — 삽입된 글자는 typingAttributes를 상속하므로 재지정이
  // 불필요한데, 전 구간 setAttributes는 TextKit 1에서 전체 레이아웃을 무효화해 캐럿이 한 프레임 동안
  // 미완성 레이아웃 위(항상 컨테이너 상단 45pt 지점)에 그려졌다가 제자리로 돌아간다
  private func applyTypingAttributes() {
    self.textView.typingAttributes = self.textAttributes
  }

  // 반대로 프로그래밍 방식 대입(`text` setter)은 UITextView가 스토리지 속성을 자체 기본값으로 덮고,
  // state·trait 변경은 이미 굳은 속성을 갱신하지 못하므로 이쪽은 전 구간 재지정이 필요하다
  private func applyTextAttributes() {
    let attributes = self.textAttributes
    self.textView.typingAttributes = attributes

    // 한글 등 IME 조합 중 textStorage 속성을 갈아끼우면 조합이 끊긴다 — 조합 중에는 typingAttributes만 갱신
    guard self.textView.markedTextRange == nil else { return }
    let fullRange = NSRange(location: 0, length: self.textView.textStorage.length)
    self.textView.textStorage.beginEditing()
    self.textView.textStorage.setAttributes(attributes, range: fullRange)
    self.textView.textStorage.endEditing()
  }

  private func refreshPlaceholder() {
    var attributes = BezierBaseInputConstant.textTypography.attributes(
      self,
      semanticColorToken: BezierBaseInputConstant.placeholderColor
    )
    // 헬퍼에 lineBreakMode를 인자로 넘기면 .byWordWrapping일 때만 붙는 한글 줄바꿈 전략을 잃는다 —
    // 전략은 남긴 채 말줄임만 켠다
    if let paragraphStyle = (attributes[.paragraphStyle] as? NSParagraphStyle)?
      .mutableCopy() as? NSMutableParagraphStyle {
      paragraphStyle.lineBreakMode = .byTruncatingTail
      attributes[.paragraphStyle] = paragraphStyle
    }
    self.placeholderLabel.attributedText = NSAttributedString(
      string: self.placeholder,
      attributes: attributes
    )
    self.placeholderLabel.isHidden = !self.text.isEmpty

    // 값이 차 있어도 유지한다 — UITextView는 입력값을 accessibilityValue로 내보내므로 label을 비우면
    // 입력 후 이 필드가 무엇을 받는 칸인지 알 수 없어진다 (UITextField.placeholder 폴백과 동일한 규약)
    self.textView.accessibilityLabel = self.placeholder.isEmpty ? nil : self.placeholder
  }

  private func refreshHeight() {
    guard self.bounds.width > 0 else { return }
    let fittingHeight = self.textView.sizeThatFits(
      CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)
    ).height
    let clampedHeight = min(
      max(fittingHeight, BezierTextAreaConstant.minHeight),
      BezierTextAreaConstant.maxHeight
    )
    if self.heightConstraint?.constant != clampedHeight {
      self.heightConstraint?.constant = clampedHeight
      self.invalidateIntrinsicContentSize()
    }

    // 높이 제약이 갱신되기 전에 UITextView가 캐럿을 따라 먼저 스크롤해 둔 오프셋 잔여분 제거
    if fittingHeight <= clampedHeight, self.textView.contentOffset != .zero {
      self.textView.setContentOffset(.zero, animated: false)
    }
  }
}

// MARK: - UITextViewDelegate

extension BezierTextArea: UITextViewDelegate {
  public func textViewDidChange(_ textView: UITextView) {
    self.applyTypingAttributes()
    self.refreshPlaceholder()
    self.refreshHeight()
    self.onTextChanged?(self.text)
  }

  public func textViewDidBeginEditing(_ textView: UITextView) {
    self.refreshAppearance()
    self.onEditingChanged?(true)
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    self.refreshAppearance()
    self.onEditingChanged?(false)
  }
}
