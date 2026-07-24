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
    didSet { if oldValue != self.sideIndent { self.refreshLayout() } }
  }

  public var parallelIndent: Bool = true {
    didSet { if oldValue != self.parallelIndent { self.refreshLayout() } }
  }

  // MARK: - Subviews

  private let lineView = UIView()

  // MARK: - Layout Constraints

  private var lineLeadingConstraint: NSLayoutConstraint?
  private var lineTrailingConstraint: NSLayoutConstraint?

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

    self.lineView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.lineView)

    let leading = self.lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = self.lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    // 부모가 좌우 여백(2 × indentSize)보다 좁아지면 trailing을 깨고 최소 너비를 지킨다 (SPEC min-width 1pt).
    trailing.priority = .init(999)
    NSLayoutConstraint.activate([
      leading,
      trailing,
      self.lineView.widthAnchor.constraint(greaterThanOrEqualToConstant: BezierDividerConstant.lineThickness),
      self.lineView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.lineView.heightAnchor.constraint(equalToConstant: BezierDividerConstant.lineThickness),
    ])
    self.lineLeadingConstraint = leading
    self.lineTrailingConstraint = trailing

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout

  public override var intrinsicContentSize: CGSize {
    let height = BezierDividerConstant.lineThickness
      + (self.parallelIndent ? BezierDividerConstant.indentSize * 2 : 0)
    return CGSize(width: UIView.noIntrinsicMetric, height: height)
  }

  // MARK: - Refresh

  private func refreshLayout() {
    let sideInset = self.sideIndent ? BezierDividerConstant.indentSize : 0
    self.lineLeadingConstraint?.constant = sideInset
    self.lineTrailingConstraint?.constant = -sideInset
    self.invalidateIntrinsicContentSize()
  }

  private func refreshAppearance() {
    self.lineView.backgroundColor = BCSemanticToken.borderNeutral.palette(self)
  }
}
