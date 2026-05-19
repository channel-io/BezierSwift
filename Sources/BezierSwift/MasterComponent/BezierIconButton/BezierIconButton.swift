//
//  BezierIconButton.swift
//  BezierSwift
//

import UIKit

public final class BezierIconButton: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierIconButtonSize = .medium {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  public var variant: BezierIconButtonVariant = .ghost {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  public var icon: UIImage? {
    didSet { self.refreshContent() }
  }

  public var isLoading: Bool = false {
    didSet { if oldValue != self.isLoading { self.refreshLoading() } }
  }

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  public override var isHighlighted: Bool {
    didSet { if oldValue != self.isHighlighted { self.refreshAppearance() } }
  }

  /// Toggle ON 상태(SPEC §4의 `active`). ghost variant에서만 시각 변화 발생.
  public override var isSelected: Bool {
    didSet { if oldValue != self.isSelected { self.refreshAppearance() } }
  }

  // MARK: - Subviews

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()

  // MARK: - Layout Constraints (mutable)

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  private var iconWidthConstraint: NSLayoutConstraint?
  private var iconHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierIconButtonSize = .medium,
    variant: BezierIconButtonVariant = .ghost
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
    self.layer.masksToBounds = true
    self.layer.borderWidth = 0

    self.addSubview(self.iconImageView)
    self.addSubview(self.activityIndicator)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.length)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.length)
    let iconWidthConstraint = self.iconImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let iconHeightConstraint = self.iconImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
      iconWidthConstraint,
      iconHeightConstraint,
      self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint
    self.iconWidthConstraint = iconWidthConstraint
    self.iconHeightConstraint = iconHeightConstraint

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
    self.widthConstraint?.constant = self.size.length
    self.heightConstraint?.constant = self.size.length
    self.iconWidthConstraint?.constant = self.size.iconLength
    self.iconHeightConstraint?.constant = self.size.iconLength

    let baseSize = self.activityIndicator.intrinsicContentSize.width
    if baseSize > 0 {
      let scale = self.size.spinnerLength / baseSize
      self.activityIndicator.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    self.setNeedsLayout()
    self.invalidateIntrinsicContentSize()
  }

  private func refreshContent() {
    self.iconImageView.image = self.icon?.withRenderingMode(.alwaysTemplate)
  }

  private func refreshAppearance() {
    let baseBackground: UIColor = self.variant.backgroundToken?.palette(self) ?? .clear
    let isInteractionOverlayActive = self.isHighlighted || self.isSelected

    if self.variant == .ghost && isInteractionOverlayActive {
      // SPEC §4: ghost의 pressed / active 상태는 raw rgba(0,0,0,0.05) overlay 적용
      self.backgroundColor = UIColor(white: 0, alpha: BezierIconButtonConstant.ghostOverlayAlpha)
    } else {
      self.backgroundColor = baseBackground
    }

    let foregroundColor = self.variant.foregroundToken.palette(self)
    self.iconImageView.tintColor = foregroundColor
    self.activityIndicator.color = foregroundColor
  }

  private func refreshLoading() {
    self.isUserInteractionEnabled = !self.isLoading
    if self.isLoading {
      self.iconImageView.isHidden = true
      self.activityIndicator.startAnimating()
    } else {
      self.iconImageView.isHidden = false
      self.activityIndicator.stopAnimating()
    }
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierIconButtonConstant.disabledOpacity
  }

  // MARK: - Touch

  public override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
    guard !self.isLoading else { return }
    super.sendAction(action, to: target, for: event)
  }
}
