//
//  BezierAvatarStatus.swift
//  BezierSwift
//

import UIKit

public final class BezierAvatarStatus: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var type: BezierAvatarStatusType {
    didSet { if oldValue != self.type { self.refreshContent() } }
  }

  public var size: BezierAvatarStatusSize {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  // MARK: - Subviews

  private let indicatorImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let indicatorCircleView: UIView = {
    let view = UIView()
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Layout Constraints

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?
  private var indicatorWidthConstraint: NSLayoutConstraint?
  private var indicatorHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(type: BezierAvatarStatusType, size: BezierAvatarStatusSize) {
    self.type = type
    self.size = size
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.type = .online
    self.size = .small
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.masksToBounds = true

    self.addSubview(self.indicatorCircleView)
    self.addSubview(self.indicatorImageView)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.containerLength)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.containerLength)
    let indicatorWidthConstraint = self.indicatorCircleView.widthAnchor.constraint(equalToConstant: self.size.innerIndicatorLength)
    let indicatorHeightConstraint = self.indicatorCircleView.heightAnchor.constraint(equalToConstant: self.size.innerIndicatorLength)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
      indicatorWidthConstraint,
      indicatorHeightConstraint,
      self.indicatorCircleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.indicatorCircleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.indicatorImageView.widthAnchor.constraint(equalTo: self.indicatorCircleView.widthAnchor),
      self.indicatorImageView.heightAnchor.constraint(equalTo: self.indicatorCircleView.heightAnchor),
      self.indicatorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.indicatorImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint
    self.indicatorWidthConstraint = indicatorWidthConstraint
    self.indicatorHeightConstraint = indicatorHeightConstraint

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
    self.indicatorCircleView.layer.cornerRadius = self.indicatorCircleView.bounds.height / 2
    self.indicatorCircleView.layer.masksToBounds = true
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.widthConstraint?.constant = self.size.containerLength
    self.heightConstraint?.constant = self.size.containerLength
    self.indicatorWidthConstraint?.constant = self.size.innerIndicatorLength
    self.indicatorHeightConstraint?.constant = self.size.innerIndicatorLength
    self.refreshContent()
    self.setNeedsLayout()
  }

  private func refreshContent() {
    let tintColor = self.type.indicatorToken.palette(self)
    if let icon = self.type.indicatorIcon {
      self.indicatorImageView.image = icon.uiImage
      self.indicatorImageView.tintColor = tintColor
      self.indicatorImageView.isHidden = false
      self.indicatorCircleView.isHidden = true
    } else {
      self.indicatorCircleView.backgroundColor = tintColor
      self.indicatorCircleView.isHidden = false
      self.indicatorImageView.isHidden = true
    }
  }

  private func refreshAppearance() {
    self.backgroundColor = BCSemanticToken.surfaceHighest.palette(self)
    self.refreshContent()
  }
}
