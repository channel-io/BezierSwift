//
//  BezierProgressBar.swift
//  BezierSwift
//

import UIKit

/// 작업의 진행률을 0~1 범위의 색상 바로 시각화하는 컴포넌트 (UIKit). 진행률을 모르는 불확정 로딩에는 `BezierSpinner`를 사용한다. 가로 폭은 컨테이너가 결정한다 (intrinsic width 없음). SwiftUI에서는 `SUBezierProgressBar`를 사용한다.
public final class BezierProgressBar: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 색상 변형. 기본값은 `.default`다.
  public var variant: BezierProgressBarVariant = .default {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  /// 바 크기. 기본값은 `.medium`이다.
  public var size: BezierProgressBarSize = .medium {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  /// 진행률. 0~1 범위를 벗어난 값은 clamp된다. 애니메이션 없이 즉시 반영되며, 애니메이션이 필요하면 `setValue(_:animated:)`를 사용한다.
  public var value: CGFloat {
    get { self.clampedValue }
    set { self.setValue(newValue, animated: false) }
  }

  // MARK: - Private Properties

  private var clampedValue: CGFloat

  // MARK: - Subviews

  private let activeView = UIView()

  // MARK: - Init

  /// 진행률(0~1, 범위 밖 값은 clamp)·색상 변형·크기를 지정해 생성한다.
  public init(
    value: CGFloat = 0,
    variant: BezierProgressBarVariant = .default,
    size: BezierProgressBarSize = .medium
  ) {
    self.clampedValue = min(max(value, 0), 1)
    self.variant = variant
    self.size = size
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.clampedValue = 0
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Public Methods

  /// 진행률을 갱신한다. 0~1 범위를 벗어난 값은 clamp된다. `animated`가 `true`면 진행 바 너비가 easeInOut으로 전환되며, 시스템 Reduce Motion이 켜져 있으면 애니메이션을 생략한다.
  public func setValue(_ value: CGFloat, animated: Bool) {
    let clamped = min(max(value, 0), 1)
    guard clamped != self.clampedValue else { return }
    self.clampedValue = clamped

    self.setNeedsLayout()
    if animated && !UIAccessibility.isReduceMotionEnabled {
      UIView.animate(
        withDuration: BezierProgressBarConstant.animationDuration,
        delay: 0,
        options: [.curveEaseInOut, .beginFromCurrentState]
      ) {
        self.layoutIfNeeded()
      }
    }
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isUserInteractionEnabled = false
    self.addSubview(self.activeView)

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout

  public override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: self.size.height)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.activeView.frame = CGRect(
      x: 0,
      y: 0,
      width: self.bounds.width * self.clampedValue,
      height: self.bounds.height
    )
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.layer.cornerRadius = self.size.cornerRadius
    self.activeView.layer.cornerRadius = self.size.cornerRadius
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshAppearance() {
    self.backgroundColor = self.variant.trackColorToken.palette(self)
    self.activeView.backgroundColor = self.variant.activeColorToken.palette(self)
  }
}
