//
//  BezierSectionRowDivider.swift
//  BezierSwift
//

import UIKit

final class BezierSectionRowDivider: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Private Properties

  private var divider: BezierSectionVariant.Appearance.Divider?

  // MARK: - Subviews

  private let lineView = UIView()

  // MARK: - Constraints

  private var lineLeadingConstraint: NSLayoutConstraint?
  private var lineTrailingConstraint: NSLayoutConstraint?
  private var lineHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  init() {
    super.init(frame: .zero)
    self.setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isUserInteractionEnabled = false

    self.lineView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.lineView)

    let leading = self.lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = self.lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    let height = self.lineView.heightAnchor.constraint(equalToConstant: 0)
    NSLayoutConstraint.activate([
      leading,
      trailing,
      height,
      self.lineView.topAnchor.constraint(equalTo: self.topAnchor),
      self.lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
    self.lineLeadingConstraint = leading
    self.lineTrailingConstraint = trailing
    self.lineHeightConstraint = height
  }

  // MARK: - Layout

  override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: self.divider?.thickness ?? 0)
  }

  // MARK: - Apply

  func apply(_ divider: BezierSectionVariant.Appearance.Divider) {
    self.divider = divider
    self.lineLeadingConstraint?.constant = divider.leadingInset
    self.lineTrailingConstraint?.constant = -divider.trailingInset
    self.lineHeightConstraint?.constant = divider.thickness
    self.invalidateIntrinsicContentSize()
    self.refreshAppearance()
  }

  // MARK: - Trait

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    guard let divider = self.divider else { return }
    self.lineView.backgroundColor = divider.color.palette(self)
  }
}
