//
//  BezierBadge.swift
//  BezierSwift
//

import UIKit

public final class BezierBadge: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierBadgeSize = .small {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  public var variant: BezierBadgeVariant = .default {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  public var label: String? {
    didSet { if oldValue != self.label { self.refreshContent() } }
  }

  public var leadingIcon: UIImage? {
    didSet { self.refreshContent() }
  }

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.isUserInteractionEnabled = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let leadingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: BezierBadgePaddedLabel = {
    let label = BezierBadgePaddedLabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()

  // MARK: - Layout Constraints

  private var heightConstraint: NSLayoutConstraint?
  private var leadingImageWidthConstraint: NSLayoutConstraint?
  private var leadingImageHeightConstraint: NSLayoutConstraint?
  private var contentLeadingConstraint: NSLayoutConstraint?
  private var contentTrailingConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierBadgeSize = .small,
    variant: BezierBadgeVariant = .default
  ) {
    self.size = size
    self.variant = variant
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
    self.isUserInteractionEnabled = false

    self.layer.masksToBounds = true
    self.layer.borderWidth = 0

    self.contentStackView.addArrangedSubview(self.leadingImageView)
    self.contentStackView.addArrangedSubview(self.titleLabel)

    self.addSubview(self.contentStackView)

    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.height)
    let leadingImageWidthConstraint = self.leadingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let leadingImageHeightConstraint = self.leadingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)
    let contentLeadingConstraint = self.contentStackView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: self.size.horizontalPadding
    )
    let contentTrailingConstraint = self.contentStackView.trailingAnchor.constraint(
      equalTo: self.trailingAnchor,
      constant: -self.size.horizontalPadding
    )

    NSLayoutConstraint.activate([
      heightConstraint,
      leadingImageWidthConstraint,
      leadingImageHeightConstraint,
      contentLeadingConstraint,
      contentTrailingConstraint,
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.heightConstraint = heightConstraint
    self.leadingImageWidthConstraint = leadingImageWidthConstraint
    self.leadingImageHeightConstraint = leadingImageHeightConstraint
    self.contentLeadingConstraint = contentLeadingConstraint
    self.contentTrailingConstraint = contentTrailingConstraint

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

  public override var intrinsicContentSize: CGSize {
    var width = self.size.horizontalPadding * 2
    if !self.leadingImageView.isHidden {
      width += self.size.iconLength
    }
    if !self.titleLabel.isHidden {
      width += self.titleLabel.intrinsicContentSize.width
    }
    return CGSize(width: width, height: self.size.height)
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.heightConstraint?.constant = self.size.height
    self.leadingImageWidthConstraint?.constant = self.size.iconLength
    self.leadingImageHeightConstraint?.constant = self.size.iconLength
    self.contentLeadingConstraint?.constant = self.size.horizontalPadding
    self.contentTrailingConstraint?.constant = -self.size.horizontalPadding

    self.titleLabel.contentInsets = UIEdgeInsets(
      top: 0,
      left: self.size.textHorizontalPadding,
      bottom: 0,
      right: self.size.textHorizontalPadding
    )

    self.refreshContent()
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshContent() {
    self.leadingImageView.image = self.leadingIcon?.withRenderingMode(.alwaysTemplate)
    self.leadingImageView.isHidden = self.leadingIcon == nil

    let foregroundToken = self.variant.foregroundToken
    self.leadingImageView.tintColor = foregroundToken.palette(self)

    if let label = self.label, !label.isEmpty {
      // TYPO-MIGRATION: Figma raw 값을 직접 사용. 추후 BTSemanticToken으로 통합 예정 (BezierBadgeSpec.swift 참고).
      let font = UIFont.systemFont(
        ofSize: self.size.fontSize,
        weight: self.size.fontWeight.uiKitWeight
      )
      self.titleLabel.attributedText = label.applyBezierFont(
        height: self.size.lineHeight,
        font: font,
        color: foregroundToken.palette(self),
        letterSpacing: self.size.letterSpacing,
        alignment: .center
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    self.invalidateIntrinsicContentSize()
  }

  private func refreshAppearance() {
    self.backgroundColor = self.variant.backgroundToken.palette(self)
    self.leadingImageView.tintColor = self.variant.foregroundToken.palette(self)
    self.refreshContent()
  }
}

// MARK: - Padded Label

final class BezierBadgePaddedLabel: UILabel {
  var contentInsets: UIEdgeInsets = .zero {
    didSet {
      self.invalidateIntrinsicContentSize()
      self.setNeedsDisplay()
    }
  }

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: self.contentInsets))
  }

  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(
      width: size.width + self.contentInsets.left + self.contentInsets.right,
      height: size.height + self.contentInsets.top + self.contentInsets.bottom
    )
  }
}
