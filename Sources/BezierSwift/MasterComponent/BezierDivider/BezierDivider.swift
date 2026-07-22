//
//  BezierDivider.swift
//  BezierSwift
//

import UIKit

public final class BezierDivider: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var sideIndent: Bool = true {
    didSet { if oldValue != self.sideIndent { self.setNeedsLayout() } }
  }

  public var parallelIndent: Bool = true {
    didSet { if oldValue != self.parallelIndent { self.refreshLayout() } }
  }

  // MARK: - Subviews

  private let lineLayer = CALayer()

  // MARK: - Init

  public init(sideIndent: Bool = true, parallelIndent: Bool = true) {
    self.sideIndent = sideIndent
    self.parallelIndent = parallelIndent
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
    self.layer.addSublayer(self.lineLayer)
    self.refreshAppearance()
  }

  // MARK: - Layout

  public override var intrinsicContentSize: CGSize {
    let height = BezierDividerConstant.lineThickness
      + (self.parallelIndent ? BezierDividerConstant.indentSize * 2 : 0)
    return CGSize(width: UIView.noIntrinsicMetric, height: height)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    let sideInset = self.sideIndent ? BezierDividerConstant.indentSize : 0
    let lineHeight = BezierDividerConstant.lineThickness

    self.lineLayer.frame = CGRect(
      x: sideInset,
      y: (self.bounds.height - lineHeight) / 2,
      width: max(self.bounds.width - sideInset * 2, BezierDividerConstant.lineThickness),
      height: lineHeight
    )
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshAppearance() {
    self.lineLayer.backgroundColor = BCSemanticToken.borderNeutral.palette(self).cgColor
  }
}
