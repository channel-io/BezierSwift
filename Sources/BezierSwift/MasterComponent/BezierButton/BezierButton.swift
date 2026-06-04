//
//  BezierButton.swift
//  BezierSwift
//

import UIKit

public final class BezierButton: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierButtonSize = .medium {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  public var variant: BezierButtonVariant = .filled {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  public var semantic: BezierButtonSemantic = .primary {
    didSet { if oldValue != self.semantic { self.refreshAppearance() } }
  }

  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  public var leadingIcon: UIImage? {
    didSet { self.refreshContent() }
  }

  public var trailingIcon: UIImage? {
    didSet { self.refreshContent() }
  }

  public var isLoading: Bool = false {
    didSet { if oldValue != self.isLoading { self.refreshLoading() } }
  }

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  public override var isHighlighted: Bool {
    didSet { self.refreshHighlight() }
  }

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
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

  private let trailingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: BezierButtonPaddedLabel = {
    let label = BezierButtonPaddedLabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()

  private let spinner: BezierSpinner = {
    let spinner = BezierSpinner()
    spinner.isHidden = true
    return spinner
  }()

  // MARK: - Layout Constraints (mutable)

  private var heightConstraint: NSLayoutConstraint?
  private var minWidthConstraint: NSLayoutConstraint?
  private var leadingImageWidthConstraint: NSLayoutConstraint?
  private var leadingImageHeightConstraint: NSLayoutConstraint?
  private var trailingImageWidthConstraint: NSLayoutConstraint?
  private var trailingImageHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierButtonSize = .medium,
    variant: BezierButtonVariant = .filled,
    semantic: BezierButtonSemantic = .primary
  ) {
    self.size = size
    self.variant = variant
    self.semantic = semantic
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
    self.layer.borderWidth = 0

    self.contentStackView.addArrangedSubview(self.leadingImageView)
    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.trailingImageView)

    self.addSubview(self.contentStackView)
    self.addSubview(self.spinner)

    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.height)
    let minWidthConstraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.size.minWidth)

    let leadingImageWidthConstraint = self.leadingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let leadingImageHeightConstraint = self.leadingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)
    let trailingImageWidthConstraint = self.trailingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let trailingImageHeightConstraint = self.trailingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)

    NSLayoutConstraint.activate([
      heightConstraint,
      minWidthConstraint,
      leadingImageWidthConstraint,
      leadingImageHeightConstraint,
      trailingImageWidthConstraint,
      trailingImageHeightConstraint,
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.contentStackView.leadingAnchor.constraint(
        greaterThanOrEqualTo: self.leadingAnchor,
        constant: self.size.horizontalPadding
      ).withIdentifier("contentLeading"),
      self.contentStackView.trailingAnchor.constraint(
        lessThanOrEqualTo: self.trailingAnchor,
        constant: -self.size.horizontalPadding
      ).withIdentifier("contentTrailing"),
      self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.heightConstraint = heightConstraint
    self.minWidthConstraint = minWidthConstraint
    self.leadingImageWidthConstraint = leadingImageWidthConstraint
    self.leadingImageHeightConstraint = leadingImageHeightConstraint
    self.trailingImageWidthConstraint = trailingImageWidthConstraint
    self.trailingImageHeightConstraint = trailingImageHeightConstraint

    self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    self.refreshLayout()
    self.refreshContent()
    self.refreshAppearance()
    self.refreshLoading()
    self.refreshEnabled()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.heightConstraint?.constant = self.size.height
    self.minWidthConstraint?.constant = self.size.minWidth
    self.leadingImageWidthConstraint?.constant = self.size.iconLength
    self.leadingImageHeightConstraint?.constant = self.size.iconLength
    self.trailingImageWidthConstraint?.constant = self.size.iconLength
    self.trailingImageHeightConstraint?.constant = self.size.iconLength

    for constraint in self.constraints {
      if constraint.identifier == "contentLeading" {
        constraint.constant = self.size.horizontalPadding
      } else if constraint.identifier == "contentTrailing" {
        constraint.constant = -self.size.horizontalPadding
      }
    }

    self.contentStackView.spacing = self.size.contentSpacing
    self.titleLabel.contentInsets = UIEdgeInsets(
      top: 0,
      left: self.size.textHorizontalPadding,
      bottom: 0,
      right: self.size.textHorizontalPadding
    )
    self.spinner.size = self.size.spinnerSize
    self.refreshContent()
    self.setNeedsLayout()
    self.invalidateIntrinsicContentSize()
  }

  private func refreshContent() {
    self.leadingImageView.image = self.leadingIcon?.withRenderingMode(.alwaysTemplate)
    self.leadingImageView.isHidden = self.leadingIcon == nil

    self.trailingImageView.image = self.trailingIcon?.withRenderingMode(.alwaysTemplate)
    self.trailingImageView.isHidden = self.trailingIcon == nil

    let foregroundToken = self.variant.foregroundToken(self.semantic)
    let foregroundColor = foregroundToken.palette(self)

    self.leadingImageView.tintColor = foregroundColor
    self.trailingImageView.tintColor = foregroundColor

    if let title = self.title, !title.isEmpty {
      self.titleLabel.attributedText = title.applyBezierFont(
        height: self.size.lineHeight,
        font: BTGlobalToken.FontFamily.system.uiFont(
          size: self.size.fontSize,
          weight: self.size.fontWeight
        ),
        color: foregroundColor,
        letterSpacing: 0,
        alignment: .center
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }
  }

  private func refreshAppearance() {
    if let backgroundToken = self.variant.backgroundToken(self.semantic) {
      self.backgroundColor = backgroundToken.palette(self)
    } else {
      self.backgroundColor = .clear
    }

    if let borderToken = self.variant.borderToken(self.semantic) {
      self.layer.borderWidth = BezierButtonConstant.borderWidth
      self.layer.borderColor = borderToken.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }

    let foregroundColor = self.variant.foregroundToken(self.semantic).palette(self)
    self.leadingImageView.tintColor = foregroundColor
    self.trailingImageView.tintColor = foregroundColor
    self.spinner.fillColorOverride = self.variant.loadingSpinnerColorOverride

    self.refreshContent()
  }

  private func refreshLoading() {
    self.isUserInteractionEnabled = !self.isLoading
    self.contentStackView.isHidden = self.isLoading
    self.spinner.isHidden = !self.isLoading
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierButtonConstant.disabledOpacity
  }

  private func refreshHighlight() {
    UIView.animate(withDuration: 0.1) {
      self.alpha = self.isHighlighted
        ? BezierButtonConstant.pressedOpacity
        : (self.isEnabled ? 1 : BezierButtonConstant.disabledOpacity)
    }
  }

  // MARK: - Touch

  public override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
    guard !self.isLoading else { return }
    super.sendAction(action, to: target, for: event)
  }
}

// MARK: - Padded Label

final class BezierButtonPaddedLabel: UILabel {
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

// MARK: - NSLayoutConstraint Identifier Helper

private extension NSLayoutConstraint {
  func withIdentifier(_ identifier: String) -> NSLayoutConstraint {
    self.identifier = identifier
    return self
  }
}
