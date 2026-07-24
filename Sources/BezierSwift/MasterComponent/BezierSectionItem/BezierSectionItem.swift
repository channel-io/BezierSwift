//
//  BezierSectionItem.swift
//  BezierSwift
//

import UIKit

public final class BezierSectionItem: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierSectionItemSize = .medium {
    didSet { if oldValue != self.size { self.refreshSize() } }
  }

  public var content: String = "" {
    didSet { if oldValue != self.content { self.refreshText() } }
  }

  public var itemDescription: String? {
    didSet { if oldValue != self.itemDescription { self.refreshDescription() } }
  }

  public var leading: BezierSectionItemLeading<UIView> = .none {
    didSet { self.refreshLeading() }
  }

  public var centerSlot: UIView? {
    didSet { self.updateSlot(container: self.centerSlotContainer, old: oldValue, new: self.centerSlot) }
  }

  public var customCenterContent: UIView? {
    didSet {
      self.updateSlot(container: self.customCenterContainer, old: oldValue, new: self.customCenterContent)
      self.refreshText()
    }
  }

  public var accessory: BezierSectionItemAccessory<UIView>? {
    didSet { self.accessoryView.apply(self.accessory) }
  }

  public var isDestructive: Bool = false {
    didSet { if oldValue != self.isDestructive { self.refreshAppearance() } }
  }

  public var onTap: (() -> Void)? {
    didSet { self.refreshInteraction() }
  }

  // MARK: - State

  public override var isHighlighted: Bool {
    didSet {
      if oldValue != self.isHighlighted {
        self.refreshAppearance()
        self.refreshPressScale()
      }
    }
  }

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionItemConstant.slotSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.isUserInteractionEnabled = false
    return stackView
  }()

  private let contentColumnStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()

  private let labelWrapperStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionItemConstant.slotSpacing
    return stackView
  }()

  private let leadingContainer = UIView()
  private let leadingIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let centerContentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()

  private let labelRowStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionItemConstant.labelRowSpacing
    return stackView
  }()

  private let contentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let customCenterContainer = UIView()
  private let centerSlotContainer = UIView()
  private let labelSpacer = UIView()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  private let denestDescriptionWrapper: UIView = {
    let view = UIView()
    view.insetsLayoutMarginsFromSafeArea = false
    return view
  }()

  private let accessoryView = BezierSectionItemAccessoryView()

  // MARK: - Constraints

  private var leadingWidthConstraint: NSLayoutConstraint?
  private var leadingHeightConstraint: NSLayoutConstraint?
  private var minHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierSectionItemSize = .medium,
    content: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil
  ) {
    self.size = size
    self.content = content
    self.itemDescription = description
    self.onTap = onTap
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

    self.setUpLeading()
    self.setUpCenter()
    self.setUpDescription()

    self.labelWrapperStackView.addArrangedSubview(self.leadingContainer)
    self.labelWrapperStackView.addArrangedSubview(self.centerContentStackView)
    self.contentColumnStackView.addArrangedSubview(self.labelWrapperStackView)
    self.contentColumnStackView.addArrangedSubview(self.denestDescriptionWrapper)
    self.rootStackView.addArrangedSubview(self.contentColumnStackView)
    self.rootStackView.addArrangedSubview(self.accessoryView)
    self.addSubview(self.rootStackView)

    let expandingPriority = UILayoutPriority(1)
    self.contentColumnStackView.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.contentColumnStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.accessoryView.setContentHuggingPriority(.required, for: .horizontal)
    self.accessoryView.setContentCompressionResistancePriority(.required, for: .horizontal)

    let margins = self.layoutMarginsGuide
    let minHeightConstraint = self.heightAnchor.constraint(
      greaterThanOrEqualToConstant: self.size.minHeight
    )
    self.minHeightConstraint = minHeightConstraint
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: margins.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
      minHeightConstraint,
    ])

    self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)

    self.accessoryView.apply(self.accessory)
    self.refreshSize()
    self.refreshLeading()
    self.refreshInteraction()
    self.refreshEnabled()
    self.refreshAppearance()
  }

  private func setUpLeading() {
    self.leadingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.leadingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    let widthConstraint = self.leadingContainer.widthAnchor.constraint(
      equalToConstant: self.size.leadingLength
    )
    let heightConstraint = self.leadingContainer.heightAnchor.constraint(
      equalToConstant: self.size.leadingLength
    )
    self.leadingWidthConstraint = widthConstraint
    self.leadingHeightConstraint = heightConstraint
    NSLayoutConstraint.activate([widthConstraint, heightConstraint])
  }

  private func setUpCenter() {
    let expandingPriority = UILayoutPriority(1)
    self.centerContentStackView.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.centerContentStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.contentLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.customCenterContainer.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.customCenterContainer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.centerSlotContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.centerSlotContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.labelSpacer.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.labelSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.centerSlotContainer.heightAnchor.constraint(
      equalToConstant: BezierSectionItemConstant.centerSlotHeight
    ).isActive = true

    self.labelRowStackView.addArrangedSubview(self.contentLabel)
    self.labelRowStackView.addArrangedSubview(self.customCenterContainer)
    self.labelRowStackView.addArrangedSubview(self.centerSlotContainer)
    self.labelRowStackView.addArrangedSubview(self.labelSpacer)
    self.centerContentStackView.addArrangedSubview(self.labelRowStackView)

    self.customCenterContainer.isHidden = true
    self.centerSlotContainer.isHidden = true
  }

  private func setUpDescription() {
    self.denestDescriptionWrapper.addSubview(self.descriptionLabel)
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    let margins = self.denestDescriptionWrapper.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.descriptionLabel.topAnchor.constraint(equalTo: margins.topAnchor),
      self.descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.descriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.descriptionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
    ])
    self.denestDescriptionWrapper.isHidden = true
  }

  // MARK: - Slot

  private func updateSlot(container: UIView, old: UIView?, new: UIView?) {
    old?.removeFromSuperview()
    guard let new else {
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

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshSize() {
    self.minHeightConstraint?.constant = self.size.minHeight
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: self.size.verticalPadding,
      leading: BezierSectionItemConstant.horizontalPadding,
      bottom: self.size.verticalPadding,
      trailing: BezierSectionItemConstant.horizontalPadding
    )
    self.refreshLeading()
    self.refreshDescription()
    self.setNeedsLayout()
  }

  private func refreshLeading() {
    self.leadingContainer.subviews
      .filter { $0 !== self.leadingIconImageView }
      .forEach { $0.removeFromSuperview() }
    self.leadingIconImageView.removeFromSuperview()

    switch self.leading {
    case .none:
      self.leadingContainer.isHidden = true

    case .icon(let icon):
      self.leadingContainer.isHidden = false
      self.leadingIconImageView.image = icon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.leadingIconImageView.translatesAutoresizingMaskIntoConstraints = false
      self.leadingContainer.addSubview(self.leadingIconImageView)
      NSLayoutConstraint.activate([
        self.leadingIconImageView.topAnchor.constraint(equalTo: self.leadingContainer.topAnchor),
        self.leadingIconImageView.leadingAnchor.constraint(equalTo: self.leadingContainer.leadingAnchor),
        self.leadingIconImageView.trailingAnchor.constraint(equalTo: self.leadingContainer.trailingAnchor),
        self.leadingIconImageView.bottomAnchor.constraint(equalTo: self.leadingContainer.bottomAnchor),
      ])

    case .avatar(let view), .custom(let view):
      self.leadingContainer.isHidden = false
      view.translatesAutoresizingMaskIntoConstraints = false
      self.leadingContainer.addSubview(view)
      NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: self.leadingContainer.topAnchor),
        view.leadingAnchor.constraint(equalTo: self.leadingContainer.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: self.leadingContainer.trailingAnchor),
        view.bottomAnchor.constraint(equalTo: self.leadingContainer.bottomAnchor),
      ])
    }

    let length = self.leading.leadingLength(size: self.size)
    self.leadingWidthConstraint?.constant = length
    self.leadingHeightConstraint?.constant = length

    self.refreshText()
    self.refreshDescription()
  }

  private func refreshDescription() {
    let isCustom = self.leading.isCustom
    let description = (self.itemDescription?.isEmpty == false && !isCustom) ? self.itemDescription : nil

    self.descriptionLabel.removeFromSuperview()
    if self.size.isDescriptionNested {
      self.denestDescriptionWrapper.isHidden = true
      self.centerContentStackView.spacing = BezierSectionItemConstant.nestedDescriptionSpacing
      self.centerContentStackView.addArrangedSubview(self.descriptionLabel)
      self.descriptionLabel.isHidden = description == nil
    } else {
      self.centerContentStackView.spacing = 0
      self.setUpDescription()
      self.denestDescriptionWrapper.isHidden = description == nil
      self.denestDescriptionWrapper.directionalLayoutMargins = NSDirectionalEdgeInsets(
        top: 0,
        leading: self.leading.hasLeadingContent ? BezierSectionItemConstant.descriptionIndent : 0,
        bottom: 0,
        trailing: 0
      )
    }

    self.refreshText()
  }

  private func refreshInteraction() {
    self.isUserInteractionEnabled = self.onTap != nil
    if self.onTap == nil {
      BezierPressFeedback.reset(self.rootStackView)
    }
  }

  private func refreshPressScale() {
    guard self.onTap != nil else {
      BezierPressFeedback.reset(self.rootStackView)
      return
    }
    BezierPressFeedback.apply(isPressed: self.isHighlighted, to: self.rootStackView)
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierSectionItemConstant.disabledOpacity
  }

  private func refreshAppearance() {
    self.backgroundColor = self.isHighlighted
      ? BezierSectionItemConstant.pressedBackgroundColor.palette(self)
      : .clear

    if case .icon = self.leading {
      let iconColor = self.isDestructive
        ? BezierSectionItemConstant.destructiveIconColor
        : BezierSectionItemConstant.leadingIconColor
      self.leadingIconImageView.tintColor = iconColor.palette(self)
    }

    self.refreshText()
  }

  private func refreshText() {
    let isCustom = self.leading.isCustom
    let showsContentLabel = !self.content.isEmpty && (!isCustom || self.customCenterContent == nil)

    if showsContentLabel {
      let contentColor = self.isDestructive
        ? BezierSectionItemConstant.destructiveContentColor
        : BezierSectionItemConstant.contentColor
      self.contentLabel.attributedText = BezierSectionItemConstant.contentTypography.attributedString(
        self,
        text: self.content,
        semanticColorToken: contentColor,
        alignment: .left,
        lineBreakMode: .byTruncatingTail
      )
      self.contentLabel.isHidden = false
    } else {
      self.contentLabel.attributedText = nil
      self.contentLabel.isHidden = true
    }

    self.customCenterContainer.isHidden = !(isCustom && self.customCenterContent != nil)
    if isCustom {
      self.centerSlotContainer.isHidden = true
    } else {
      self.centerSlotContainer.isHidden = self.centerSlot == nil
    }

    if let description = self.itemDescription, !description.isEmpty, !isCustom {
      self.descriptionLabel.attributedText = BezierSectionItemConstant.descriptionTypography.attributedString(
        self,
        text: description,
        semanticColorToken: BezierSectionItemConstant.descriptionColor,
        alignment: .left,
        lineBreakMode: .byWordWrapping
      )
    } else {
      self.descriptionLabel.attributedText = nil
    }
  }

  // MARK: - Action

  @objc private func handleTap() {
    self.onTap?()
  }
}
