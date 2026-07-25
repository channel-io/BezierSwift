//
//  BezierDivider.swift
//  BezierSwift
//

import UIKit

/// 콘텐츠를 구분하는 가로 구분선 (UIKit). Figma `Divider`의 `orientation` 중 가로(horizontal)만 지원하며 세로(vertical)는 제공하지 않는다. SwiftUI에서는 `SUBezierDivider`를 사용한다.
public final class BezierDivider: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 좌우 끝의 여백 적용 여부. Figma `Divider`의 `sideIndent` BOOLEAN 프로퍼티에 대응. 기본값 `true`.
  public var sideIndent: Bool = true {
    didSet { if oldValue != self.sideIndent { self.refreshLayout() } }
  }

  /// 선 위아래(상하) 여백 적용 여부. Figma `Divider`의 `parallelIndent` BOOLEAN 프로퍼티에 대응. 기본값 `true`.
  public var parallelIndent: Bool = true {
    didSet { if oldValue != self.parallelIndent { self.refreshLayout() } }
  }

  // MARK: - Subviews

  private let lineView = UIView()

  // MARK: - Layout Constraints

  private var lineLeadingConstraint: NSLayoutConstraint?
  private var lineTrailingConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// 좌우(`sideIndent`)·상하(`parallelIndent`) 여백 적용 여부를 지정해 생성한다. 두 값 모두 기본 `true`다.
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
