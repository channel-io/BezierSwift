//
//  BezierWindow.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

final class BezierWindow: UIWindow {
  init(frame: CGRect, windowLevel: UIWindow.Level) {
    super.init(frame: frame)
    
    self.initialize(windowLevel: windowLevel)
  }
  
  init(windowScene: UIWindowScene, windowLevel: UIWindow.Level) {
    super.init(windowScene: windowScene)
    
    self.initialize(windowLevel: windowLevel)
  }
  
  required init?(coder: NSCoder) {
    super.init(frame: .zero)
    
    assertionFailure("init(coder:) has not been implemented")
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    
    guard BezierSwift.shared.allowHitTest else { return nil }
    
    return (hitView == self || self.rootViewController?.view == hitView) ? nil : hitView
  }
}

extension BezierWindow {
  private func initialize(windowLevel: UIWindow.Level) {
    self.windowLevel = windowLevel
    self.backgroundColor = nil
    self.rootViewController = UIHostingController(rootView: BezierContainerView())
    self.rootViewController?.view.backgroundColor = nil
    self.isHidden = false
  }
}
