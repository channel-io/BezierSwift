//
//  BezierSearch.swift
//  BezierSwift
//

import UIKit

/// SearchIcon이 고정된 단일 행 검색 입력 필드 (UIKit). 리스트 필터링·데이터 탐색처럼 키워드를 입력해 검색을 실행할 때 쓴다. 이름·이메일 등 일반 폼 입력에는 `BezierTextInput`을 사용한다. SwiftUI에서는 `SUBezierSearch`를 사용한다.
///
/// 너비는 컨테이너가 결정한다 — leading/trailing 제약으로 부모 폭을 채우는 배치가 기본이다. 높이는 40pt로 고정된다 (Figma `Search`는 size 축 없음).
/// placeholder는 검색 범위를 명시한다 (예: `고객 이름, 이메일, 전화번호로 검색`) — `검색` 한 단어만 쓰지 않는다.
public final class BezierSearch: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 현재 입력값. 코드로 값을 바꿔도 `onTextChanged`는 호출되지 않는다.
  public var text: String {
    get { self.textField.text ?? "" }
    set {
      guard self.textField.text != newValue else { return }
      self.textField.text = newValue
      self.refreshClearButton()
    }
  }

  /// 입력 전 안내 텍스트. 검색 범위를 명시한다 (예: `고객 이름, 이메일, 전화번호로 검색`). 기본값은 빈 문자열.
  public var placeholder: String = "" {
    didSet { if oldValue != self.placeholder { self.refreshPlaceholder() } }
  }

  /// 활성화 여부. 끄면 모든 인터랙션이 차단되고 40% 투명도가 적용된다. 기본값 `true`.
  public var isEnabled: Bool = true {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  /// 값이 있을 때 값을 한 번에 지우는 clear 버튼을 표시할지 여부. 포커스와 무관하게 값이 있으면 표시된다. 기본값 `false`.
  public var allowClear: Bool = false {
    didSet { if oldValue != self.allowClear { self.refreshClearButton() } }
  }

  /// 검색 필드 우측 바깥에 검색 모드를 종료하는 cancel 버튼을 표시할지 여부 (Figma `cancelButton`). 기본값 `false`.
  public var showsCancelButton: Bool = false {
    didSet { if oldValue != self.showsCancelButton { self.refreshCancelButton() } }
  }

  /// cancel 버튼의 라벨 텍스트. 제품 언어에 맞춰 지정한다. 기본값 `"Cancel"`.
  public var cancelButtonTitle: String = "Cancel" {
    didSet { if oldValue != self.cancelButtonTitle { self.refreshCancelButton() } }
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

  /// 리턴 키 타입. 기본값 `.search`.
  public var returnKeyType: UIReturnKeyType {
    get { self.textField.returnKeyType }
    set {
      self.textField.returnKeyType = newValue
      if self.textField.isFirstResponder { self.textField.reloadInputViews() }
    }
  }

  // MARK: - Callbacks

  /// 사용자 입력으로 값이 바뀔 때마다 호출된다. clear 버튼 탭으로 값이 비워질 때도 호출된다.
  public var onTextChanged: ((String) -> Void)?

  /// 포커스가 시작(`true`)·종료(`false`)될 때 호출된다.
  public var onEditingChanged: ((Bool) -> Void)?

  /// 리턴 키(검색)를 눌렀을 때 호출된다.
  public var onSubmit: (() -> Void)?

  /// cancel 버튼을 눌렀을 때 호출된다. 포커스는 자동으로 해제되며, 입력값 초기화 여부는 호출부가 결정한다.
  public var onCancel: (() -> Void)?

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierSearchConstant.cancelButtonSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let fieldView: UIView = {
    let view = UIView()
    view.layer.masksToBounds = true
    view.layer.cornerRadius = BezierSearchConstant.metric.cornerRadius
    return view
  }()

  private let fieldStackView: UIStackView = {
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

  private let iconView: UIImageView = {
    let imageView = UIImageView(image: BezierSearchConstant.searchIcon.uiImage)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let textField: UITextField = {
    let textField = UITextField()
    textField.borderStyle = .none
    textField.backgroundColor = .clear
    textField.contentVerticalAlignment = .center
    textField.returnKeyType = .search
    return textField
  }()

  private let clearButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(BezierSearchConstant.clearIcon.uiImage, for: .normal)
    return button
  }()

  private let cancelControl = UIControl()

  private let cancelLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

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

    self.setUpIconView()
    self.setUpTextField()
    self.setUpClearButton()
    self.setUpCancelControl()

    self.fieldStackView.addArrangedSubview(self.iconView)
    self.fieldStackView.addArrangedSubview(self.textField)
    self.fieldStackView.addArrangedSubview(self.clearButton)
    self.fieldView.addSubview(self.fieldStackView)

    self.rootStackView.addArrangedSubview(self.fieldView)
    self.rootStackView.addArrangedSubview(self.cancelControl)
    self.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.fieldStackView.topAnchor.constraint(equalTo: self.fieldView.topAnchor),
      self.fieldStackView.leadingAnchor.constraint(equalTo: self.fieldView.leadingAnchor),
      self.fieldStackView.trailingAnchor.constraint(equalTo: self.fieldView.trailingAnchor),
      self.fieldStackView.bottomAnchor.constraint(equalTo: self.fieldView.bottomAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.widthAnchor.constraint(greaterThanOrEqualToConstant: BezierBaseInputConstant.minWidth),
      self.heightAnchor.constraint(equalToConstant: BezierSearchConstant.metric.height),
    ])

    // 패딩·아이콘 영역을 탭해도 포커스되도록 한다. cancelsTouchesInView를 끄면 clearButton 탭을 삼키지 않는다.
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    tapGesture.cancelsTouchesInView = false
    self.fieldView.addGestureRecognizer(tapGesture)

    self.refreshEnabled()
    self.refreshClearButton()
    self.refreshCancelButton()
    self.refreshAppearance()
  }

  private func setUpIconView() {
    self.iconView.setContentHuggingPriority(.required, for: .horizontal)
    self.iconView.setContentCompressionResistancePriority(.required, for: .horizontal)
    NSLayoutConstraint.activate([
      self.iconView.widthAnchor.constraint(
        equalToConstant: BezierSearchConstant.metric.leadingContentLength
      ),
      self.iconView.heightAnchor.constraint(
        equalToConstant: BezierSearchConstant.metric.leadingContentLength
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

  private func setUpCancelControl() {
    self.cancelControl.setContentHuggingPriority(.required, for: .horizontal)
    self.cancelControl.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.cancelControl.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside)
    self.cancelControl.addSubview(self.cancelLabel)
    NSLayoutConstraint.activate([
      self.cancelLabel.leadingAnchor.constraint(
        equalTo: self.cancelControl.leadingAnchor,
        constant: BezierSearchConstant.cancelButtonHorizontalPadding
      ),
      self.cancelLabel.trailingAnchor.constraint(
        equalTo: self.cancelControl.trailingAnchor,
        constant: -BezierSearchConstant.cancelButtonHorizontalPadding
      ),
      self.cancelLabel.centerYAnchor.constraint(equalTo: self.cancelControl.centerYAnchor),
    ])
    self.cancelControl.isHidden = true
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
      isReadOnly: false,
      hasError: false,
      isFocused: self.textField.isEditing
    )
  }

  // MARK: - Refresh

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

    self.fieldView.backgroundColor = BezierBaseInputAppearance
      .backgroundColor(variant: BezierSearchConstant.variant, state: state)
      .palette(self)

    if let borderColor = BezierBaseInputAppearance.borderColor(
      variant: BezierSearchConstant.variant,
      state: state
    ) {
      self.fieldView.layer.borderWidth = BezierBaseInputConstant.borderWidth
      self.fieldView.layer.borderColor = borderColor.palette(self).cgColor
    } else {
      self.fieldView.layer.borderWidth = 0
      self.fieldView.layer.borderColor = nil
    }

    self.alpha = state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1

    let typography = BezierBaseInputConstant.textTypography
    var attributes = self.textField.defaultTextAttributes
    attributes[.font] = typography.uiFont
    attributes[.kern] = typography.letterSpacing
    attributes[.foregroundColor] = BezierBaseInputAppearance.textColor(state: state).palette(self)
    self.textField.defaultTextAttributes = attributes

    self.iconView.tintColor = BezierBaseInputConstant.iconColor.palette(self)
    self.clearButton.tintColor = BezierBaseInputConstant.iconColor.palette(self)

    self.refreshPlaceholder()
    self.refreshCancelButton()
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
      && !self.text.isEmpty
      && self.isEnabled
    self.clearButton.isHidden = !isVisible
  }

  private func refreshCancelButton() {
    self.cancelControl.isHidden = !self.showsCancelButton
    self.cancelLabel.attributedText = BezierSearchConstant.cancelButtonTypography.attributedString(
      self,
      text: self.cancelButtonTitle,
      semanticColorToken: BezierSearchConstant.cancelButtonTextColor,
      alignment: .center,
      lineBreakMode: .byClipping
    )
  }

  // MARK: - Action

  @objc private func handleTap() {
    guard self.isEnabled, !self.textField.isEditing else { return }
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

  @objc private func handleCancel() {
    self.textField.resignFirstResponder()
    self.onCancel?()
  }
}

// MARK: - UITextFieldDelegate

extension BezierSearch: UITextFieldDelegate {
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    self.refreshAppearance()
    self.onEditingChanged?(true)
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    self.refreshAppearance()
    self.onEditingChanged?(false)
  }

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.onSubmit?()
    return true
  }
}
