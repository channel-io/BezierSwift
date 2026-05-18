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

  public var shape: BezierBadgeShape = .text("Badge") {
    didSet { if oldValue != self.shape { self.refreshShape() } }
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
  private var minWidthConstraint: NSLayoutConstraint?
  private var leadingImageWidthConstraint: NSLayoutConstraint?
  private var leadingImageHeightConstraint: NSLayoutConstraint?
  private var contentLeadingConstraint: NSLayoutConstraint?
  private var contentTrailingConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierBadgeSize = .small,
    variant: BezierBadgeVariant = .default,
    shape: BezierBadgeShape = .text("Badge")
  ) {
    self.size = size
    self.variant = variant
    self.shape = shape
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
    let minWidthConstraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.size.height)
    let leadingImageWidthConstraint = self.leadingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let leadingImageHeightConstraint = self.leadingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)
    let contentLeadingConstraint = self.contentStackView.leadingAnchor.constraint(
      greaterThanOrEqualTo: self.leadingAnchor,
      constant: self.size.horizontalPadding
    )
    let contentTrailingConstraint = self.contentStackView.trailingAnchor.constraint(
      lessThanOrEqualTo: self.trailingAnchor,
      constant: -self.size.horizontalPadding
    )

    NSLayoutConstraint.activate([
      heightConstraint,
      minWidthConstraint,
      leadingImageWidthConstraint,
      leadingImageHeightConstraint,
      contentLeadingConstraint,
      contentTrailingConstraint,
      self.contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.heightConstraint = heightConstraint
    self.minWidthConstraint = minWidthConstraint
    self.leadingImageWidthConstraint = leadingImageWidthConstraint
    self.leadingImageHeightConstraint = leadingImageHeightConstraint
    self.contentLeadingConstraint = contentLeadingConstraint
    self.contentTrailingConstraint = contentTrailingConstraint

    self.refreshLayout()
    self.refreshShape()
    self.refreshAppearance()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

  public override var intrinsicContentSize: CGSize {
    if self.shape.isDot {
      return CGSize(width: self.size.dotLength, height: self.size.dotLength)
    }
    return super.intrinsicContentSize
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.heightConstraint?.constant = self.shape.isDot ? self.size.dotLength : self.size.height
    self.minWidthConstraint?.constant = self.shape.isDot ? self.size.dotLength : self.size.height
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

  private func refreshShape() {
    self.contentStackView.isHidden = self.shape.isDot
    self.heightConstraint?.constant = self.shape.isDot ? self.size.dotLength : self.size.height
    self.minWidthConstraint?.constant = self.shape.isDot ? self.size.dotLength : self.size.height
    self.refreshContent()
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshContent() {
    self.leadingImageView.image = self.leadingIcon?.withRenderingMode(.alwaysTemplate)
    self.leadingImageView.isHidden = self.leadingIcon == nil || self.shape.isDot

    let foregroundToken = self.variant.foregroundToken
    self.leadingImageView.tintColor = foregroundToken.palette(self)

    if let text = self.shape.displayText, !text.isEmpty {
      self.titleLabel.attributedText = self.size.typography.attributedString(
        self,
        text: text,
        semanticColorToken: foregroundToken,
        alignment: .center
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }
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
