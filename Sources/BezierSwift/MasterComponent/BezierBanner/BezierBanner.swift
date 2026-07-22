//
//  BezierBanner.swift
//  BezierSwift
//

import UIKit

public final class BezierBanner: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var variant: BezierBannerVariant = .default {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  public var leadingIcon: BezierIcon? {
    didSet { if oldValue != self.leadingIcon { self.refreshContent() } }
  }

  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  public var bannerDescription: String = "" {
    didSet { if oldValue != self.bannerDescription { self.refreshContent() } }
  }

  public var clickArea: BezierBannerClickArea = .none {
    didSet { self.refreshClickArea() }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let leadingIconContainer = UIView()
  private let leadingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let contentContainer = UIView()
  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierBannerConstant.contentSpacing
    return stackView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  private let actionIconContainer = UIView()
  private let actionImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private lazy var fullTapGesture = UITapGestureRecognizer(
    target: self,
    action: #selector(self.handleFullTap)
  )
  private lazy var actionIconTapGesture = UITapGestureRecognizer(
    target: self,
    action: #selector(self.handleActionIconTap)
  )

  // MARK: - Init

  public init(
    variant: BezierBannerVariant = .default,
    leadingIcon: BezierIcon? = nil,
    title: String? = nil,
    description: String,
    clickArea: BezierBannerClickArea = .none
  ) {
    self.variant = variant
    self.leadingIcon = leadingIcon
    self.title = title
    self.bannerDescription = description
    self.clickArea = clickArea
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
    self.layer.cornerRadius = BezierBannerConstant.cornerRadius
    self.layer.masksToBounds = true

    self.setUpLeadingIcon()
    self.setUpContent()
    self.setUpActionIcon()

    self.rootStackView.addArrangedSubview(self.leadingIconContainer)
    self.rootStackView.addArrangedSubview(self.contentContainer)
    self.rootStackView.addArrangedSubview(self.actionIconContainer)
    self.addSubview(self.rootStackView)

    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: BezierBannerConstant.verticalPadding,
      leading: BezierBannerConstant.horizontalPadding,
      bottom: BezierBannerConstant.verticalPadding,
      trailing: BezierBannerConstant.horizontalPadding
    )
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: margins.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
    ])

    self.addGestureRecognizer(self.fullTapGesture)
    self.actionIconContainer.addGestureRecognizer(self.actionIconTapGesture)

    self.refreshContent()
    self.refreshClickArea()
    self.refreshAppearance()
  }

  private func setUpLeadingIcon() {
    self.leadingImageView.translatesAutoresizingMaskIntoConstraints = false
    self.leadingIconContainer.addSubview(self.leadingImageView)
    self.leadingIconContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.leadingIconContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    NSLayoutConstraint.activate([
      self.leadingImageView.widthAnchor.constraint(equalToConstant: BezierBannerConstant.iconLength),
      self.leadingImageView.heightAnchor.constraint(equalToConstant: BezierBannerConstant.iconLength),
      self.leadingImageView.leadingAnchor.constraint(
        equalTo: self.leadingIconContainer.leadingAnchor,
        constant: BezierBannerConstant.leadingIconLeadingPadding
      ),
      self.leadingImageView.trailingAnchor.constraint(
        equalTo: self.leadingIconContainer.trailingAnchor,
        constant: -BezierBannerConstant.leadingIconTrailingPadding
      ),
      self.leadingImageView.topAnchor.constraint(
        equalTo: self.leadingIconContainer.topAnchor,
        constant: BezierBannerConstant.leadingIconVerticalPadding
      ),
      self.leadingImageView.bottomAnchor.constraint(
        equalTo: self.leadingIconContainer.bottomAnchor,
        constant: -BezierBannerConstant.leadingIconVerticalPadding
      ),
    ])
  }

  private func setUpContent() {
    self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.descriptionLabel)
    self.contentContainer.addSubview(self.contentStackView)
    self.contentContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
    self.contentContainer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    NSLayoutConstraint.activate([
      self.contentStackView.topAnchor.constraint(
        equalTo: self.contentContainer.topAnchor,
        constant: BezierBannerConstant.contentPadding
      ),
      self.contentStackView.leadingAnchor.constraint(
        equalTo: self.contentContainer.leadingAnchor,
        constant: BezierBannerConstant.contentPadding
      ),
      self.contentStackView.trailingAnchor.constraint(
        equalTo: self.contentContainer.trailingAnchor,
        constant: -BezierBannerConstant.contentPadding
      ),
      self.contentStackView.bottomAnchor.constraint(
        equalTo: self.contentContainer.bottomAnchor,
        constant: -BezierBannerConstant.contentPadding
      ),
    ])
  }

  private func setUpActionIcon() {
    self.actionImageView.translatesAutoresizingMaskIntoConstraints = false
    self.actionIconContainer.addSubview(self.actionImageView)
    self.actionIconContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.actionIconContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    NSLayoutConstraint.activate([
      self.actionIconContainer.widthAnchor.constraint(
        equalToConstant: BezierBannerConstant.actionIconContainerLength
      ),
      self.actionIconContainer.heightAnchor.constraint(
        equalToConstant: BezierBannerConstant.actionIconContainerLength
      ),
      self.actionImageView.widthAnchor.constraint(equalToConstant: BezierBannerConstant.iconLength),
      self.actionImageView.heightAnchor.constraint(equalToConstant: BezierBannerConstant.iconLength),
      self.actionImageView.centerXAnchor.constraint(equalTo: self.actionIconContainer.centerXAnchor),
      self.actionImageView.centerYAnchor.constraint(equalTo: self.actionIconContainer.centerYAnchor),
    ])
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshContent() {
    if let leadingIcon = self.leadingIcon {
      self.leadingImageView.image = leadingIcon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.leadingIconContainer.isHidden = false
    } else {
      self.leadingImageView.image = nil
      self.leadingIconContainer.isHidden = true
    }

    if let title = self.title, !title.isEmpty {
      self.titleLabel.attributedText = BezierBannerConstant.titleTypography.attributedString(
        self,
        text: title,
        semanticColorToken: self.variant.textColor,
        alignment: .left
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    self.descriptionLabel.attributedText = BezierBannerConstant.descriptionTypography.attributedString(
      self,
      text: self.bannerDescription,
      semanticColorToken: self.variant.textColor,
      alignment: .left
    )
  }

  private func refreshClickArea() {
    let trailingIcon = self.clickArea.trailingIcon
    if let trailingIcon = trailingIcon {
      self.actionImageView.image = trailingIcon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.actionImageView.tintColor = self.variant.iconColor.palette(self)
      self.actionIconContainer.isHidden = false
    } else {
      self.actionImageView.image = nil
      self.actionIconContainer.isHidden = true
    }

    switch self.clickArea {
    case .none:
      self.fullTapGesture.isEnabled = false
      self.actionIconContainer.isUserInteractionEnabled = false
    case .full:
      self.fullTapGesture.isEnabled = true
      self.actionIconContainer.isUserInteractionEnabled = false
    case .actionIcon:
      self.fullTapGesture.isEnabled = false
      self.actionIconContainer.isUserInteractionEnabled = true
    }
  }

  private func refreshAppearance() {
    self.backgroundColor = self.variant.backgroundColor.palette(self)
    self.leadingImageView.tintColor = self.variant.iconColor.palette(self)
    self.actionImageView.tintColor = self.variant.iconColor.palette(self)
    self.refreshContent()
  }

  // MARK: - Actions

  @objc private func handleFullTap() {
    if case .full(let onClick) = self.clickArea { onClick() }
  }

  @objc private func handleActionIconTap() {
    if case .actionIcon(let onClick) = self.clickArea { onClick() }
  }
}
