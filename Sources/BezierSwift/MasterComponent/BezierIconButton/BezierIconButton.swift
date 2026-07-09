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

  public var semantic: BezierIconButtonSemantic = .secondary {
    didSet { if oldValue != self.semantic { self.refreshAppearance() } }
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

  private let spinner: BezierSpinner = {
    let spinner = BezierSpinner()
    spinner.isHidden = true
    return spinner
  }()

  // MARK: - Layout Constraints (mutable)

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  private var iconWidthConstraint: NSLayoutConstraint?
  private var iconHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierIconButtonSize = .medium,
    variant: BezierIconButtonVariant = .ghost,
    semantic: BezierIconButtonSemantic = .secondary
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

    self.addSubview(self.iconImageView)
    self.addSubview(self.spinner)

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
      self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
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

    self.spinner.size = self.size.spinnerSize

    self.setNeedsLayout()
    self.invalidateIntrinsicContentSize()
  }

  private func refreshContent() {
    self.iconImageView.image = self.icon?.withRenderingMode(.alwaysTemplate)
  }

  private func refreshAppearance() {
    let backgroundToken = self.variant.backgroundToken(self.semantic)
    let isInteractionOverlayActive = self.isHighlighted || self.isSelected

    if backgroundToken == nil && isInteractionOverlayActive {
      // 배경 없는 variant(outlined·ghost)의 pressed / active — bezier-tokens 미등록 raw overlay
      self.backgroundColor = UIColor(white: 0, alpha: BezierIconButtonConstant.ghostOverlayAlpha)
    } else {
      self.backgroundColor = backgroundToken?.palette(self) ?? .clear
    }

    if let borderToken = self.variant.borderToken(self.semantic) {
      self.layer.borderWidth = BezierIconButtonConstant.borderWidth
      self.layer.borderColor = borderToken.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }

    self.iconImageView.tintColor = self.variant.foregroundToken(self.semantic).palette(self)
    self.spinner.fillColorOverride = self.variant.loadingSpinnerToken(self.semantic).palette(self)
  }

  private func refreshLoading() {
    self.isUserInteractionEnabled = !self.isLoading
    self.iconImageView.isHidden = self.isLoading
    self.spinner.isHidden = !self.isLoading
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
