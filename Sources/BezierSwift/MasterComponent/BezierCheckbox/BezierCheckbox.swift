//
//  BezierCheckbox.swift
//  BezierSwift
//

import UIKit

/// 입력·동의용 체크박스 (UIKit). 라벨이 곧 체크 대상이므로 라벨 없이 쓰지 않는다. 폼 입력·약관 동의에 쓰고, 리스트 다중 선택에는 쓰지 않는다. 탭하면 `checked`가 전환되고 `onCheckedChange`로 통지한다. SwiftUI에서는 `SUBezierCheckbox`를 사용한다.
public final class BezierCheckbox: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 선택 상태 (기본값 `.unchecked`). 탭하면 `toggled` 값으로 전환된다.
  public var checked: BezierCheckboxChecked = .unchecked {
    didSet { if oldValue != self.checked { self.refreshAppearance() } }
  }

  /// 에러 상태 (기본값 `false`). `true`면 박스 둘레에 3pt 간격의 warning 링을 표시한다. disabled 상태에서는 링을 표시하지 않는다.
  public var hasError: Bool = false {
    didSet { if oldValue != self.hasError { self.refreshAppearance() } }
  }

  /// 체크 대상을 설명하는 라벨. 라벨이 곧 체크 대상이므로 비우지 않는다.
  public var label: String = "" {
    didSet { if oldValue != self.label { self.refreshText() } }
  }

  /// 탭으로 상태가 전환된 뒤 호출되는 클로저. 전환된 새 값이 전달된다. 기본값 `nil`.
  public var onCheckedChange: ((BezierCheckboxChecked) -> Void)?

  // MARK: - State

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierCheckboxConstant.contentSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.isUserInteractionEnabled = false
    return stackView
  }()

  private let boxView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = BezierCheckboxConstant.boxCornerRadius
    view.clipsToBounds = false
    return view
  }()

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let ringView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = BezierCheckboxConstant.errorRingCornerRadius
    view.layer.borderWidth = BezierCheckboxConstant.errorRingBorderWidth
    view.isUserInteractionEnabled = false
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  // MARK: - Init

  /// 라벨과 초기 선택 상태를 지정해 생성한다.
  public init(
    label: String,
    checked: BezierCheckboxChecked = .unchecked,
    hasError: Bool = false,
    onCheckedChange: ((BezierCheckboxChecked) -> Void)? = nil
  ) {
    self.label = label
    self.checked = checked
    self.hasError = hasError
    self.onCheckedChange = onCheckedChange
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
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: BezierCheckboxConstant.verticalPadding,
      leading: 0,
      bottom: BezierCheckboxConstant.verticalPadding,
      trailing: 0
    )

    self.boxView.translatesAutoresizingMaskIntoConstraints = false
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
    self.ringView.translatesAutoresizingMaskIntoConstraints = false
    self.boxView.addSubview(self.iconImageView)
    self.boxView.addSubview(self.ringView)

    self.rootStackView.addArrangedSubview(self.boxView)
    self.rootStackView.addArrangedSubview(self.titleLabel)
    self.addSubview(self.rootStackView)

    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: margins.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierCheckboxConstant.minHeight),

      self.boxView.widthAnchor.constraint(equalToConstant: BezierCheckboxConstant.boxLength),
      self.boxView.heightAnchor.constraint(equalToConstant: BezierCheckboxConstant.boxLength),

      self.iconImageView.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor),
      self.iconImageView.centerYAnchor.constraint(equalTo: self.boxView.centerYAnchor),
      self.iconImageView.widthAnchor.constraint(equalToConstant: BezierCheckboxConstant.iconLength),
      self.iconImageView.heightAnchor.constraint(equalToConstant: BezierCheckboxConstant.iconLength),

      self.ringView.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor),
      self.ringView.centerYAnchor.constraint(equalTo: self.boxView.centerYAnchor),
      self.ringView.widthAnchor.constraint(equalToConstant: BezierCheckboxConstant.errorRingLength),
      self.ringView.heightAnchor.constraint(equalToConstant: BezierCheckboxConstant.errorRingLength),
    ])

    self.boxView.setContentHuggingPriority(.required, for: .horizontal)
    self.boxView.setContentCompressionResistancePriority(.required, for: .horizontal)

    self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)

    self.refreshText()
    self.refreshEnabled()
    self.refreshAppearance()
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    switch self.checked {
    case .unchecked:
      let backgroundToken: BCSemanticToken = self.isEnabled
        ? BezierCheckboxConstant.uncheckedBackgroundColor
        : BezierCheckboxConstant.uncheckedDisabledBackgroundColor
      self.boxView.backgroundColor = backgroundToken.palette(self)
      self.boxView.layer.borderWidth = BezierCheckboxConstant.boxBorderWidth
      self.boxView.layer.borderColor = BezierCheckboxConstant.uncheckedBorderColor.palette(self).cgColor
      self.iconImageView.image = nil
      self.iconImageView.isHidden = true
    case .checked, .indeterminate:
      self.boxView.backgroundColor = BezierCheckboxConstant.checkedBackgroundColor.palette(self)
      self.boxView.layer.borderWidth = 0
      let icon: BezierIcon = self.checked == .checked ? .checkBold : .hyphenBold
      self.iconImageView.image = icon.uiImage
      self.iconImageView.isHidden = false
    }
    self.iconImageView.tintColor = BezierCheckboxConstant.iconColor.palette(self)

    // SPEC §7: disabled + hasError 조합은 Figma variant에 없어 disabled 시각을 우선하고 링을 숨긴다.
    self.ringView.isHidden = !(self.hasError && self.isEnabled)
    self.ringView.layer.borderColor = BezierCheckboxConstant.errorRingColor.palette(self).cgColor

    self.refreshText()
  }

  private func refreshText() {
    self.titleLabel.attributedText = BezierCheckboxConstant.labelTypography.attributedString(
      self,
      text: self.label,
      semanticColorToken: BezierCheckboxConstant.labelColor,
      alignment: .left,
      lineBreakMode: .byWordWrapping
    )
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierCheckboxConstant.disabledOpacity
    self.refreshAppearance()
  }

  // MARK: - Action

  @objc private func handleTap() {
    self.checked = self.checked.toggled
    self.onCheckedChange?(self.checked)
  }
}
