//
//  UIBezierLoader.swift
//
//
//  Created by Tom on 8/1/24.
//

import UIKit

private enum Constant {
  static let beginTime: Double = 0.4
  static let strokeStartDuration: Double = 1.8
  static let strokeEndDuration: Double = 1.5
}

// - MARK: UIBezierLoader
public class UIBezierLoader: UIView {
  private let configuration: BezierLoaderConfiguration
  
  // MARK: - Views
  private lazy var trackLayer = {
    var path = UIBezierPath()
    path.addArc(
      withCenter: CGPoint(
        x: self.configuration.loaderLength / 2,
        y: self.configuration.loaderLength / 2
      ),
      radius: self.configuration.loaderRadius,
      startAngle: -(.pi / 2),
      endAngle: .pi + .pi / 2,
      clockwise: true
    )
    $0.path = path.cgPath
    $0.fillColor = nil
    $0.backgroundColor = nil
    $0.strokeColor = self.configuration.trackColor.cgColor
    $0.lineWidth = self.configuration.lineWidth
    $0.frame = CGRect(
      origin: .zero,
      size: CGSize(width: self.configuration.loaderLength, height: self.configuration.loaderLength)
    )
    
    return $0
  }(CAShapeLayer())
  
  private lazy var indicatorLayer = {
    var path: UIBezierPath = UIBezierPath()
    path.addArc(
      withCenter: CGPoint(
        x: self.configuration.loaderLength / 2,
        y: self.configuration.loaderLength / 2
      ),
      radius: self.configuration.loaderRadius,
      startAngle: -(.pi / 2),
      endAngle: .pi + .pi / 2,
      clockwise: true
    )
    $0.path = path.cgPath
    $0.lineCap = .round
    $0.fillColor = nil
    $0.backgroundColor = nil
    $0.strokeColor = self.configuration.indicatorColor.cgColor
    $0.lineWidth = self.configuration.lineWidth
    $0.frame = CGRect(
      origin: .zero,
      size: CGSize(width: self.configuration.loaderLength, height: self.configuration.loaderLength)
    )
    
    return $0
  }(CAShapeLayer())
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierLoaderConfiguration` 객체입니다.
  public init(configuration: BezierLoaderConfiguration) {
    self.configuration = configuration
    
    super.init(
      frame: CGRect(
        origin: .zero,
        size: CGSize(width: self.configuration.loaderLength, height: self.configuration.loaderLength)
      )
    )
    
    self.initialize()
    self.setLayouts()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Cycles
  private func initialize() {
    self.layer.addSublayer(self.indicatorLayer)
    self.layer.addSublayer(self.trackLayer)
    
    self.setAnimation()
  }
  
  private func setLayouts() {
    self.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: self.configuration.loaderLength),
      self.heightAnchor.constraint(equalToConstant: self.configuration.loaderLength)
    ])
  }
  
  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    self.indicatorLayer.strokeColor = self.configuration.indicatorColor.cgColor
    self.trackLayer.strokeColor = self.configuration.trackColor.cgColor
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
  let loader = UIBezierLoader(configuration: .init(size: .medium, variant: .primary))
  
  return loader
}
