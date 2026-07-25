//
//  BezierSectionItemAccessoryView.swift
//  BezierSwift
//

import UIKit

final class BezierSectionItemAccessoryView: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.toggleView.componentTheme = self.componentTheme
      self.refreshAppearance()
    }
  }

  // MARK: - Private Properties

  private var accessory: BezierSectionItemAccessory<UIView>?

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionItemConstant.accessoryTextSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let valueLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let toggleView = BezierSectionItemToggleView()
  private let customContainer = UIView()

  // MARK: - Constraints

  private var iconWidthConstraint: NSLayoutConstraint?
  private var iconHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  init() {
    super.init(frame: .zero)
    self.setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isUserInteractionEnabled = false

    self.valueLabel.setContentHuggingPriority(.required, for: .horizontal)
    self.valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    let iconWidth = self.iconImageView.widthAnchor.constraint(
      equalToConstant: BezierSectionItemConstant.accessoryIconLength
    )
    let iconHeight = self.iconImageView.heightAnchor.constraint(
      equalToConstant: BezierSectionItemConstant.accessoryIconLength
    )
    self.iconWidthConstraint = iconWidth
    self.iconHeightConstraint = iconHeight

    self.contentStackView.addArrangedSubview(self.valueLabel)
    self.contentStackView.addArrangedSubview(self.iconImageView)
    self.contentStackView.addArrangedSubview(self.toggleView)
    self.contentStackView.addArrangedSubview(self.customContainer)
    self.addSubview(self.contentStackView)

    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      iconWidth,
      iconHeight,
      self.contentStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.contentStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.heightAnchor.constraint(equalToConstant: BezierSectionItemConstant.accessoryHeight),
      self.customContainer.heightAnchor.constraint(equalTo: self.heightAnchor),
    ])
  }

  // MARK: - Apply

  func apply(_ accessory: BezierSectionItemAccessory<UIView>?) {
    if case .custom(let old)? = self.accessory, old.superview === self.customContainer {
      old.removeFromSuperview()
    }
    self.accessory = accessory

    self.valueLabel.isHidden = true
    self.iconImageView.isHidden = true
    self.toggleView.isHidden = true
    self.customContainer.isHidden = true

    guard let accessory else {
      self.isHidden = true
      return
    }
    self.isHidden = false

    switch accessory {
    case .navigation:
      self.showIcon(.chevronSmallRight, length: BezierSectionItemConstant.accessoryIconLength)
    case .outlink:
      self.showIcon(.arrowRightUpSmall, length: BezierSectionItemConstant.accessoryIconLength)
    case .select:
      self.valueLabel.isHidden = false
      self.showIcon(.chevronUpdown, length: BezierSectionItemConstant.accessoryChevronUpdownLength)
    case .multiselect:
      self.valueLabel.isHidden = false
      self.showIcon(.chevronUpdown, length: BezierSectionItemConstant.accessoryChevronUpdownLength)
    case .display:
      self.valueLabel.isHidden = false
    case .toggle(let isOn):
      self.toggleView.isHidden = false
      self.toggleView.isOn = isOn
    case .custom(let content):
      self.customContainer.isHidden = false
      content.translatesAutoresizingMaskIntoConstraints = false
      self.customContainer.addSubview(content)
      NSLayoutConstraint.activate([
        content.topAnchor.constraint(equalTo: self.customContainer.topAnchor),
        content.leadingAnchor.constraint(equalTo: self.customContainer.leadingAnchor),
        content.trailingAnchor.constraint(equalTo: self.customContainer.trailingAnchor),
        content.bottomAnchor.constraint(equalTo: self.customContainer.bottomAnchor),
      ])
    }

    self.refreshTextPadding()
    self.refreshAppearance()
  }

  private func showIcon(_ icon: BezierIcon, length: CGFloat) {
    self.iconImageView.isHidden = false
    self.iconImageView.image = icon.uiImage?.withRenderingMode(.alwaysTemplate)
    self.iconWidthConstraint?.constant = length
    self.iconHeightConstraint?.constant = length
  }

  private func refreshTextPadding() {
    let padding = self.valueLabel.isHidden ? 0 : BezierSectionItemConstant.accessoryTextHorizontalPadding
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: padding,
      bottom: 0,
      trailing: padding
    )
  }

  // MARK: - Trait

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    guard let accessory = self.accessory else { return }

    self.iconImageView.tintColor = BezierSectionItemConstant.accessoryIconColor.palette(self)

    let value: String?
    switch accessory {
    case .select(let selectedValue): value = selectedValue
    case .multiselect(let values): value = BezierSectionItemConstant.multiselectText(values: values)
    case .display(let displayValue): value = displayValue
    default: value = nil
    }

    if let value {
      self.valueLabel.attributedText = BezierSectionItemConstant.accessoryTextTypography.attributedString(
        self,
        text: value,
        semanticColorToken: BezierSectionItemConstant.accessoryTextColor,
        alignment: .right,
        lineBreakMode: .byTruncatingTail
      )
    } else {
      self.valueLabel.attributedText = nil
    }
  }
}

// MARK: - Toggle Indicator

final class BezierSectionItemToggleView: UIView, BezierComponentable {
  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  var isOn: Bool = false {
    didSet { if oldValue != self.isOn { self.refresh() } }
  }

  private let thumbView = UIView()
  private var thumbLeadingConstraint: NSLayoutConstraint?

  init() {
    super.init(frame: .zero)
    self.setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isUserInteractionEnabled = false
    self.layer.cornerRadius = BezierSectionItemConstant.toggleCornerRadius

    self.thumbView.translatesAutoresizingMaskIntoConstraints = false
    self.thumbView.layer.cornerRadius = BezierSectionItemConstant.toggleThumbLength / 2
    self.thumbView.layer.shadowColor = UIColor.black.cgColor
    self.thumbView.layer.shadowOpacity = BezierSectionItemConstant.toggleThumbShadowOpacity
    self.thumbView.layer.shadowOffset = BezierSectionItemConstant.toggleThumbShadowOffset
    self.thumbView.layer.shadowRadius = BezierSectionItemConstant.toggleThumbShadowRadius
    self.addSubview(self.thumbView)

    let thumbLeading = self.thumbView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: BezierSectionItemConstant.toggleThumbInset
    )
    self.thumbLeadingConstraint = thumbLeading
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: BezierSectionItemConstant.toggleWidth),
      self.heightAnchor.constraint(equalToConstant: BezierSectionItemConstant.toggleHeight),
      thumbLeading,
      self.thumbView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.thumbView.widthAnchor.constraint(equalToConstant: BezierSectionItemConstant.toggleThumbLength),
      self.thumbView.heightAnchor.constraint(equalToConstant: BezierSectionItemConstant.toggleThumbLength),
    ])

    self.refresh()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  private func refresh() {
    self.thumbLeadingConstraint?.constant = self.isOn
      ? BezierSectionItemConstant.toggleWidth
        - BezierSectionItemConstant.toggleThumbInset
        - BezierSectionItemConstant.toggleThumbLength
      : BezierSectionItemConstant.toggleThumbInset
    self.refreshAppearance()
  }

  private func refreshAppearance() {
    self.backgroundColor = (
      self.isOn
        ? BezierSectionItemConstant.toggleTrackOnColor
        : BezierSectionItemConstant.toggleTrackOffColor
    ).palette(self)
    self.thumbView.backgroundColor = BezierSectionItemConstant.toggleThumbColor.palette(self)
  }
}
