//
//  BezierFloatingBanner.swift
//  BezierSwift
//

import UIKit

public final class BezierFloatingBanner: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var leadingIcon: BezierIcon? {
    didSet { if oldValue != self.leadingIcon { self.refreshContent() } }
  }

  public var leadingIconColor: BCSemanticToken = BezierFloatingBannerConstant.defaultLeadingIconColor {
    didSet { if oldValue != self.leadingIconColor { self.refreshAppearance() } }
  }

  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  public var bannerDescription: String = "" {
    didSet { if oldValue != self.bannerDescription { self.refreshContent() } }
  }

  public var clickArea: BezierFloatingBannerClickArea = .none {
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
    stackView.spacing = BezierFloatingBannerConstant.contentSpacing
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
    leadingIcon: BezierIcon? = nil,
    leadingIconColor: BCSemanticToken = BezierFloatingBannerConstant.defaultLeadingIconColor,
    title: String? = nil,
    description: String,
    clickArea: BezierFloatingBannerClickArea = .none
  ) {
    self.leadingIcon = leadingIcon
    self.leadingIconColor = leadingIconColor
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
    self.layer.cornerRadius = BezierFloatingBannerConstant.cornerRadius
    // elevation 그림자를 렌더하려면 masksToBounds = false. 배경은 layer.cornerRadius로 둥글게 유지된다.
    self.layer.masksToBounds = false

    self.setUpLeadingIcon()
    self.setUpContent()
    self.setUpActionIcon()

    self.rootStackView.addArrangedSubview(self.leadingIconContainer)
    self.rootStackView.addArrangedSubview(self.contentContainer)
    self.rootStackView.addArrangedSubview(self.actionIconContainer)
    self.addSubview(self.rootStackView)

    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: BezierFloatingBannerConstant.verticalPadding,
      leading: BezierFloatingBannerConstant.leadingPadding,
      bottom: BezierFloatingBannerConstant.verticalPadding,
      trailing: BezierFloatingBannerConstant.trailingPadding
    )
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: margins.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierFloatingBannerConstant.minHeight),
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
      self.leadingImageView.widthAnchor.constraint(equalToConstant: BezierFloatingBannerConstant.iconLength),
      self.leadingImageView.heightAnchor.constraint(equalToConstant: BezierFloatingBannerConstant.iconLength),
      self.leadingImageView.leadingAnchor.constraint(
        equalTo: self.leadingIconContainer.leadingAnchor,
        constant: BezierFloatingBannerConstant.leadingIconLeadingPadding
      ),
      self.leadingImageView.trailingAnchor.constraint(equalTo: self.leadingIconContainer.trailingAnchor),
      self.leadingImageView.topAnchor.constraint(
        equalTo: self.leadingIconContainer.topAnchor,
        constant: BezierFloatingBannerConstant.leadingIconVerticalPadding
      ),
      self.leadingImageView.bottomAnchor.constraint(
        equalTo: self.leadingIconContainer.bottomAnchor,
        constant: -BezierFloatingBannerConstant.leadingIconVerticalPadding
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
        constant: BezierFloatingBannerConstant.contentPadding
      ),
      self.contentStackView.leadingAnchor.constraint(
        equalTo: self.contentContainer.leadingAnchor,
        constant: BezierFloatingBannerConstant.contentPadding
      ),
      self.contentStackView.trailingAnchor.constraint(
        equalTo: self.contentContainer.trailingAnchor,
        constant: -BezierFloatingBannerConstant.contentPadding
      ),
      self.contentStackView.bottomAnchor.constraint(
        equalTo: self.contentContainer.bottomAnchor,
        constant: -BezierFloatingBannerConstant.contentPadding
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
        equalToConstant: BezierFloatingBannerConstant.actionIconContainerLength
      ),
      self.actionIconContainer.heightAnchor.constraint(
        equalToConstant: BezierFloatingBannerConstant.actionIconContainerLength
      ),
      self.actionImageView.widthAnchor.constraint(equalToConstant: BezierFloatingBannerConstant.iconLength),
      self.actionImageView.heightAnchor.constraint(equalToConstant: BezierFloatingBannerConstant.iconLength),
      self.actionImageView.centerXAnchor.constraint(equalTo: self.actionIconContainer.centerXAnchor),
      self.actionImageView.centerYAnchor.constraint(equalTo: self.actionIconContainer.centerYAnchor),
    ])
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.shadowPath = UIBezierPath(
      roundedRect: self.bounds,
      cornerRadius: BezierFloatingBannerConstant.cornerRadius
    ).cgPath
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
      self.titleLabel.attributedText = BezierFloatingBannerConstant.titleTypography.attributedString(
        self,
        text: title,
        semanticColorToken: BezierFloatingBannerConstant.textColor,
        alignment: .left
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    self.descriptionLabel.attributedText = BezierFloatingBannerConstant.descriptionTypography.attributedString(
      self,
      text: self.bannerDescription,
      semanticColorToken: BezierFloatingBannerConstant.textColor,
      alignment: .left
    )
  }

  private func refreshClickArea() {
    let trailingIcon = self.clickArea.trailingIcon
    if let trailingIcon = trailingIcon {
      self.actionImageView.image = trailingIcon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.actionImageView.tintColor = BezierFloatingBannerConstant.actionIconColor.palette(self)
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
    self.backgroundColor = BezierFloatingBannerConstant.backgroundColor.palette(self)
    self.leadingImageView.tintColor = self.leadingIconColor.palette(self)
    self.actionImageView.tintColor = BezierFloatingBannerConstant.actionIconColor.palette(self)
    self.refreshElevation()
    self.refreshContent()
  }

  private func refreshElevation() {
    let elevation = BezierFloatingBannerConstant.elevation.rawValue
    self.layer.shadowColor = elevation.semanticColor.palette(self).cgColor
    self.layer.shadowOffset = CGSize(width: elevation.x, height: elevation.y)
    self.layer.shadowRadius = elevation.blur
    self.layer.shadowOpacity = 1
  }

  // MARK: - Actions

  @objc private func handleFullTap() {
    if case .full(let onClick) = self.clickArea { onClick() }
  }

  @objc private func handleActionIconTap() {
    if case .actionIcon(let onClick) = self.clickArea { onClick() }
  }
}
