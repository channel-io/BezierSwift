//
//  UIBezierSpinner.swift
//
//
//  Created by Tom on 6/29/24.
//

import UIKit
import SnapKit

private enum Constant {
  static let beginTime: Double = 0.4
  static let strokeStartDuration: Double = 1.8
  static let strokeEndDuration: Double = 1.5
}

// MARK: - BezierSpinner
public class UIBezierSpinner: BaseView {
  private let configuration: BezierSpinnerConfiguration
  
  // MARK: - Views
  private lazy var trackLayer = {
    var path = UIBezierPath()
    path.addArc(
      withCenter: CGPoint(
        x: self.configuration.spinnerSize.width / 2,
        y: self.configuration.spinnerSize.height / 2
      ),
      radius: self.configuration.spinnerRadius,
      startAngle: -(.pi / 2),
      endAngle: .pi + .pi / 2,
      clockwise: true
    )
    $0.path = path.cgPath
    $0.fillColor = nil
    $0.backgroundColor = nil
    $0.strokeColor = self.configuration.trackColor.uiColor(for: self.theme).cgColor
    $0.lineWidth = self.configuration.lineWidth
    $0.frame = CGRect(origin: .zero, size: self.configuration.spinnerSize)
    
    return $0
  }(CAShapeLayer())
  
  private lazy var indicatorLayer = {
    var path: UIBezierPath = UIBezierPath()
    path.addArc(
      withCenter: CGPoint(
        x: self.configuration.spinnerSize.width / 2,
        y: self.configuration.spinnerSize.height / 2
      ),
      radius: self.configuration.spinnerRadius,
      startAngle: -(.pi / 2),
      endAngle: .pi + .pi / 2,
      clockwise: true
    )
    $0.path = path.cgPath
    $0.lineCap = .round
    $0.fillColor = nil
    $0.backgroundColor = nil
    $0.strokeColor = self.configuration.indicatorColor.uiColor(for: self.theme).cgColor
    $0.lineWidth = self.configuration.lineWidth
    $0.frame = CGRect(origin: .zero, size: self.configuration.spinnerSize)
    
    return $0
  }(CAShapeLayer())
  
  public init(configuration: BezierSpinnerConfiguration) {
    self.configuration = configuration
    
    super.init(frame: CGRect(origin: .zero, size: self.configuration.spinnerSize))
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Cycles
  override func initialize() {
    super.initialize()
    
    self.layer.addSublayer(self.indicatorLayer)
    self.layer.addSublayer(self.trackLayer)
    
    self.setAnimation()
  }
  
  override func setLayouts() {
    super.setLayouts()
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    self.snp.makeConstraints {
      $0.size.equalTo(self.configuration.spinnerSize)
    }
  }
  
  private func setAnimation() {
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotationAnimation.byValue = Float.pi * 2
    rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
    
    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
    strokeEndAnimation.duration = Constant.strokeEndDuration
    strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
    strokeEndAnimation.fromValue = 0
    strokeEndAnimation.toValue = 1
    
    let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
    strokeStartAnimation.duration = Constant.strokeStartDuration
    strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
    strokeStartAnimation.fromValue = 0
    strokeStartAnimation.toValue = 1
    strokeStartAnimation.beginTime = Constant.beginTime
    
    let groupAnimation = CAAnimationGroup()
    groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
    groupAnimation.duration = Constant.strokeStartDuration + Constant.beginTime
    groupAnimation.repeatCount = .infinity
    groupAnimation.isRemovedOnCompletion = false
    groupAnimation.fillMode = .forwards
    
    self.indicatorLayer.add(groupAnimation, forKey: "animation")
  }
}

@available(iOS 17.0, *)
#Preview {
  let spinner = UIBezierSpinner(configuration: .init(variant: .primary, size: .medium))
  
  return spinner
}
