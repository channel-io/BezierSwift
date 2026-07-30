//
//  BezierTextInput.swift
//  BezierSwift
//

import UIKit

/// 단일 행 텍스트 입력 필드 (UIKit). 폼 안에서 이름·이메일 등 한 줄 텍스트를 자유 입력받을 때 쓴다. SwiftUI에서는 `SUBezierTextInput`을 사용한다.
///
/// 너비는 컨테이너가 결정한다 — leading/trailing 제약으로 부모 폭을 채우는 배치가 기본이다. 높이는 `size`에 따라 고정된다.
public final class BezierTextInput: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 입력 필드의 스타일. 기본값 `.primary`.
  public var variant: BezierTextInputVariant = .primary {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  /// 입력 필드의 크기. 기본값 `.medium`.
  public var size: BezierTextInputSize = .medium {
    didSet { if oldValue != self.size { self.refreshSize() } }
  }

  /// 현재 입력값. 코드로 값을 바꿔도 `onTextChanged`는 호출되지 않는다.
  public var text: String {
    get { self.textField.text ?? "" }
    set {
      guard self.textField.text != newValue else { return }
      self.textField.text = newValue
      self.refreshClearButton()
    }
  }

  /// 입력 전 안내 텍스트. 입력 형식이나 예시를 보여준다 (예: `예: hong@company.com`). 기본값은 빈 문자열.
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
        self.refreshAppearance()
        self.refreshClearButton()
      }
    }
  }

  /// 활성화 여부. 끄면 모든 인터랙션이 차단되고 40% 투명도가 적용된다. 기본값 `true`.
  public var isEnabled: Bool = true {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  /// 편집 중 값이 있을 때 값을 한 번에 지우는 clear 버튼을 표시할지 여부. 기본값 `false`.
  public var allowClear: Bool = false {
    didSet { if oldValue != self.allowClear { self.refreshClearButton() } }
  }

  /// leading(앞) 영역에 넣는 뷰 (아이콘 또는 `BezierTextInputAffix`). 슬롯 높이는 `size`에 맞춰 고정되고 너비는 콘텐츠를 따른다. 기본값 `nil`.
  public var leadingContent: UIView? {
    didSet { self.updateSlot(container: self.leadingContainer, old: oldValue, new: self.leadingContent) }
  }

  /// trailing(뒤) 영역에 넣는 뷰 (아이콘 또는 `BezierTextInputAffix`). 기본값 `nil`.
  public var trailingContent: UIView? {
    didSet { self.updateSlot(container: self.trailingContainer, old: oldValue, new: self.trailingContent) }
  }

  /// 키보드 타입. 내부 텍스트 필드에 그대로 전달된다.
  public var keyboardType: UIKeyboardType {
    get { self.textField.keyboardType }
    set {
      self.textField.keyboardType = newValue
      // 이미 올라와 있는 키보드는 입력 trait을 다시 읽지 않는다 — 표시 중일 때만 재조회를 강제한다
      if self.textField.isFirstResponder { self.textField.reloadInputViews() }
    }
  }

  /// 리턴 키 타입. 내부 텍스트 필드에 그대로 전달된다.
  public var returnKeyType: UIReturnKeyType {
    get { self.textField.returnKeyType }
    set {
      self.textField.returnKeyType = newValue
      if self.textField.isFirstResponder { self.textField.reloadInputViews() }
    }
  }

  // MARK: - Callbacks

  /// 사용자 입력으로 값이 바뀔 때마다 호출된다.
  public var onTextChanged: ((String) -> Void)?

  /// 포커스가 시작(`true`)·종료(`false`)될 때 호출된다.
  public var onEditingChanged: ((Bool) -> Void)?

  /// 리턴 키를 눌렀을 때 호출된다.
  public var onSubmit: (() -> Void)?

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierBaseInputConstant.contentSpacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierBaseInputConstant.horizontalPadding,
      bottom: 0,
      trailing: BezierBaseInputConstant.horizontalPadding
    )
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let leadingContainer = UIView()

  private let textField: BezierTextInputTextField = {
    let textField = BezierTextInputTextField()
    textField.borderStyle = .none
    textField.backgroundColor = .clear
    textField.contentVerticalAlignment = .center
    return textField
  }()

  private let trailingContainer = UIView()

  private let clearButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(BezierIcon.cancelCircleFilled.uiImage, for: .normal)
    return button
  }()

  // MARK: - Constraints

  private var heightConstraint: NSLayoutConstraint?
  private var leadingHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// 스타일·크기·placeholder를 지정해 생성한다. 슬롯 뷰는 생성 후 `leadingContent`·`trailingContent`로 주입한다.
  public init(
    variant: BezierTextInputVariant = .primary,
    size: BezierTextInputSize = .medium,
    placeholder: String = ""
  ) {
    self.variant = variant
    self.size = size
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

    self.setUpSlotContainers()
    self.setUpTextField()
    self.setUpClearButton()

    self.rootStackView.addArrangedSubview(self.leadingContainer)
    self.rootStackView.addArrangedSubview(self.textField)
    self.rootStackView.addArrangedSubview(self.trailingContainer)
    self.rootStackView.addArrangedSubview(self.clearButton)
    self.addSubview(self.rootStackView)

    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.metric.height)
    self.heightConstraint = heightConstraint
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.widthAnchor.constraint(greaterThanOrEqualToConstant: BezierBaseInputConstant.minWidth),
      heightConstraint,
    ])

    // 패딩·슬롯 영역을 탭해도 포커스되도록 한다. cancelsTouchesInView를 끄면 clearButton 등 내부 컨트롤 탭을 삼키지 않는다.
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    tapGesture.cancelsTouchesInView = false
    self.addGestureRecognizer(tapGesture)

    self.refreshSize()
    self.refreshEnabled()
    self.refreshClearButton()
    self.refreshAppearance()
  }

  private func setUpSlotContainers() {
    for container in [self.leadingContainer, self.trailingContainer] {
      container.setContentHuggingPriority(.required, for: .horizontal)
      container.setContentCompressionResistancePriority(.required, for: .horizontal)
      container.isHidden = true
    }
    let leadingHeightConstraint = self.leadingContainer.heightAnchor.constraint(
      equalToConstant: self.size.metric.leadingContentLength
    )
    self.leadingHeightConstraint = leadingHeightConstraint
    NSLayoutConstraint.activate([
      leadingHeightConstraint,
      self.trailingContainer.heightAnchor.constraint(
        equalToConstant: BezierBaseInputConstant.trailingContentLength
      ),
    ])
  }

  private func setUpTextField() {
    self.textField.delegate = self
    self.textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
    self.textField.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
    self.textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }

  private func setUpClearButton() {
    self.clearButton.addTarget(self, action: #selector(self.handleClear), for: .touchUpInside)
    NSLayoutConstraint.activate([
      self.clearButton.widthAnchor.constraint(
        equalToConstant: BezierBaseInputConstant.systemElementLength
      ),
      self.clearButton.heightAnchor.constraint(
        equalToConstant: BezierBaseInputConstant.systemElementLength
      ),
    ])
    self.clearButton.isHidden = true
  }

  // MARK: - Slot

  private func updateSlot(container: UIView, old: UIView?, new: UIView?) {
    old?.removeFromSuperview()
    guard let new = new else {
      container.isHidden = true
      return
    }
    new.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(new)
    NSLayoutConstraint.activate([
      new.topAnchor.constraint(equalTo: container.topAnchor),
      new.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      new.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      new.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    container.isHidden = false
  }

  // MARK: - First Responder

  // isUserInteractionEnabled는 터치만 막는다 — 프로그램적 포커스 요청은 이 경로로 들어오고 하드웨어
  // 키보드 입력은 hit test를 거치지 않으므로, 여기서 막지 않으면 비활성 상태에서도 입력이 반영된다
  public override var canBecomeFirstResponder: Bool {
    self.isEnabled && self.textField.canBecomeFirstResponder
  }

  public override var isFirstResponder: Bool { self.textField.isFirstResponder }

  @discardableResult
  public override func becomeFirstResponder() -> Bool {
    guard self.isEnabled else { return false }
    return self.textField.becomeFirstResponder()
  }

  @discardableResult
  public override func resignFirstResponder() -> Bool {
    self.textField.resignFirstResponder()
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
      isFocused: self.textField.isEditing
    )
  }

  // MARK: - Refresh

  private func refreshSize() {
    let metric = self.size.metric
    self.heightConstraint?.constant = metric.height
    self.leadingHeightConstraint?.constant = metric.leadingContentLength
    self.layer.cornerRadius = metric.cornerRadius
    self.setNeedsLayout()
  }

  private func refreshEnabled() {
    // isUserInteractionEnabled = false는 first responder를 해제하는 게 아니라 유예한다 — 명시적으로
    // resign하지 않으면 다시 활성화되는 순간 사용자 조작 없이 포커스와 키보드가 되살아난다
    if !self.isEnabled { self.textField.resignFirstResponder() }
    self.textField.isEnabled = self.isEnabled
    self.isUserInteractionEnabled = self.isEnabled
    self.refreshClearButton()
    self.refreshAppearance()
  }

  private func refreshAppearance() {
    let state = self.currentState

    self.backgroundColor = BezierBaseInputAppearance
      .backgroundColor(variant: self.variant.base, state: state)
      .palette(self)

    if let borderColor = BezierBaseInputAppearance.borderColor(variant: self.variant.base, state: state) {
      self.layer.borderWidth = BezierBaseInputConstant.borderWidth
      self.layer.borderColor = borderColor.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }

    self.alpha = state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1

    let typography = BezierBaseInputConstant.textTypography
    var attributes = self.textField.defaultTextAttributes
    attributes[.font] = typography.uiFont
    attributes[.kern] = typography.letterSpacing
    attributes[.foregroundColor] = BezierBaseInputAppearance.textColor(state: state).palette(self)
    self.textField.defaultTextAttributes = attributes

    self.clearButton.tintColor = BezierBaseInputConstant.iconColor.palette(self)
    self.textField.hidesCaret = self.isReadOnly

    self.refreshPlaceholder()
  }

  private func refreshPlaceholder() {
    let typography = BezierBaseInputConstant.textTypography
    self.textField.attributedPlaceholder = NSAttributedString(
      string: self.placeholder,
      attributes: [
        .font: typography.uiFont,
        .kern: typography.letterSpacing,
        .foregroundColor: BezierBaseInputConstant.placeholderColor.palette(self),
      ]
    )
  }

  private func refreshClearButton() {
    let isVisible = self.allowClear
      && self.textField.isEditing
      && !self.text.isEmpty
      && !self.isReadOnly
      && self.isEnabled
    self.clearButton.isHidden = !isVisible
  }

  // MARK: - Action

  @objc private func handleTap() {
    guard self.isEnabled, !self.isReadOnly, !self.textField.isEditing else { return }
    self.textField.becomeFirstResponder()
  }

  @objc private func handleTextChanged() {
    self.onTextChanged?(self.text)
    self.refreshClearButton()
  }

  @objc private func handleClear() {
    self.textField.text = ""
    self.onTextChanged?("")
    self.refreshClearButton()
  }
}

// MARK: - UITextFieldDelegate

extension BezierTextInput: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    self.refreshAppearance()
    self.refreshClearButton()
    self.onEditingChanged?(true)
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    self.refreshAppearance()
    self.refreshClearButton()
    self.onEditingChanged?(false)
  }

  public func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    !self.isReadOnly
  }

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard !self.isReadOnly else { return false }
    self.onSubmit?()
    return true
  }
}

// MARK: - Caret

// readOnly에서 캐럿만 감추기 위한 서브클래스. isEnabled = false는 선택·복사까지 함께 죽이고
// tintColor = .clear는 선택 하이라이트와 드래그 핸들까지 투명하게 만들어 둘 다 쓸 수 없다
private final class BezierTextInputTextField: UITextField {
  var hidesCaret: Bool = false {
    didSet {
      guard oldValue != self.hidesCaret, self.isFirstResponder else { return }
      // 캐럿 뷰는 selection이 바뀔 때만 caretRect를 다시 묻는다 — 값만 갱신하면 떠 있던 캐럿이 그대로 남는다
      let selectedTextRange = self.selectedTextRange
      self.selectedTextRange = nil
      self.selectedTextRange = selectedTextRange
    }
  }

  override func caretRect(for position: UITextPosition) -> CGRect {
    guard self.hidesCaret else { return super.caretRect(for: position) }
    // 캐럿 뷰는 이 rect를 그대로 frame으로 받는다 — 크기를 0으로 접어 렌더 결과를 없앤다.
    // origin은 살려 두어야 캐럿 위치 기준 스크롤 계산이 어긋나지 않는다
    return CGRect(origin: super.caretRect(for: position).origin, size: .zero)
  }
}
