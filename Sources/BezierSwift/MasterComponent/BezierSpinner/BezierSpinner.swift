//
//  BezierSpinner.swift
//  BezierSwift
//

import UIKit

public final class BezierSpinner: UIView, BezierComponentable {
  private enum Metric {
    static let arcStartAngle: CGFloat = .pi * 3 / 4
    static let arcEndAngle: CGFloat = .pi / 4
    static let rotationAnimationKey = "bezierSpinnerRotation"
  }

  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierSpinnerSize = .size12 {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  // MARK: - Subviews

  private let arcLayer = CAShapeLayer()

  // MARK: - Layout Constraints

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(size: BezierSpinnerSize = .size12) {
    self.size = size
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
    self.layer.addSublayer(self.arcLayer)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.length)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.length)
    NSLayoutConstraint.activate([widthConstraint, heightConstraint])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.arcLayer.frame = self.bounds
    self.arcLayer.path = self.donutArcPath(length: self.size.length)
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  /// CAAnimation은 뷰가 window에서 분리되거나 앱이 백그라운드에 다녀오면 시스템이 제거한다.
  /// 회전이 멈춘 채 표시되는 것을 막기 위해 window 복귀 시점마다 애니메이션을 다시 건다.
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    if self.window != nil {
      self.startRotation()
    }
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.widthConstraint?.constant = self.size.length
    self.heightConstraint?.constant = self.size.length
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshAppearance() {
    self.arcLayer.fillColor = BCSemanticToken.borderNeutral.palette(self).cgColor
  }

  // MARK: - Arc Path

  private func donutArcPath(length: CGFloat) -> CGPath {
    let center = CGPoint(x: length / 2, y: length / 2)
    let outerRadius = length / 2
    let innerRadius = outerRadius * BezierSpinnerConstant.innerRadiusRatio

    let path = UIBezierPath()
    path.addArc(
      withCenter: center,
      radius: outerRadius,
      startAngle: Metric.arcStartAngle,
      endAngle: Metric.arcEndAngle,
      clockwise: true
    )
    path.addArc(
      withCenter: center,
      radius: innerRadius,
      startAngle: Metric.arcEndAngle,
      endAngle: Metric.arcStartAngle,
      clockwise: false
    )
    path.close()
    return path.cgPath
  }

  // MARK: - Rotation

  private func startRotation() {
    guard self.arcLayer.animation(forKey: Metric.rotationAnimationKey) == nil else { return }

    let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.fromValue = 0
    rotation.toValue = CGFloat.pi * 2
    rotation.duration = BezierSpinnerConstant.rotationDuration
    rotation.timingFunction = CAMediaTimingFunction(name: .linear)
    rotation.repeatCount = .infinity
    self.arcLayer.add(rotation, forKey: Metric.rotationAnimationKey)
  }
}
