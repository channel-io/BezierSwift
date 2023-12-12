//
//  BezierWindow.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

final class BezierWindow: UIWindow {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initialize()
  }
  
  override init(windowScene: UIWindowScene) {
    super.init(windowScene: windowScene)
    
    self.initialize()
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
  private func initialize() {
    self.windowLevel = .statusBar - 1
    self.backgroundColor = nil
    self.rootViewController = UIHostingController(rootView: BezierContainerView())
    self.rootViewController?.view.backgroundColor = nil
    self.makeKeyAndVisible()
  }
}
