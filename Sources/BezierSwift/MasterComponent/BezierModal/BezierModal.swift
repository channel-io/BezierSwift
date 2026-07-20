//
//  BezierModal.swift
//  BezierSwift
//

import UIKit

public final class BezierModal: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public let contentView = UIView()

  // MARK: - Subviews

  private let containerView = UIView()

  // MARK: - Init

  public init() {
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

    // 그림자는 클리핑되지 않는 바깥 layer에, 콘텐츠 클리핑은 containerView에 분리 적용
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = 1

    self.containerView.translatesAutoresizingMaskIntoConstraints = false
    self.containerView.layer.cornerRadius = BezierModalSpec.cornerRadius.rawValue
    self.containerView.layer.cornerCurve = .continuous
    self.containerView.layer.masksToBounds = true

    self.contentView.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(self.containerView)
    self.containerView.addSubview(self.contentView)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: BezierModalSpec.width)
    widthConstraint.priority = .defaultHigh

    NSLayoutConstraint.activate([
      widthConstraint,
      self.widthAnchor.constraint(lessThanOrEqualToConstant: BezierModalSpec.maxWidth),
      self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
      self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.contentView.topAnchor.constraint(
        equalTo: self.containerView.topAnchor,
        constant: BezierModalSpec.topPadding
      ),
      self.contentView.bottomAnchor.constraint(
        equalTo: self.containerView.bottomAnchor,
        constant: -BezierModalSpec.bottomPadding
      ),
      self.contentView.leadingAnchor.constraint(
        equalTo: self.containerView.leadingAnchor,
        constant: BezierModalSpec.horizontalPadding
      ),
      self.contentView.trailingAnchor.constraint(
        equalTo: self.containerView.trailingAnchor,
        constant: -BezierModalSpec.horizontalPadding
      ),
      self.contentView.heightAnchor.constraint(
        greaterThanOrEqualToConstant: BezierModalSpec.contentMinHeight
      ),
    ])

    self.refreshAppearance()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.shadowPath = UIBezierPath(
      roundedRect: self.bounds,
      cornerRadius: BezierModalSpec.cornerRadius.rawValue
    ).cgPath
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.containerView.backgroundColor = BezierModalSpec.backgroundToken.palette(self)

    let elevation = BezierModalSpec.elevation.rawValue
    self.layer.shadowColor = elevation.semanticColor.palette(self).cgColor
    self.layer.shadowOffset = CGSize(width: elevation.x, height: elevation.y)
    self.layer.shadowRadius = elevation.blur
  }
}
