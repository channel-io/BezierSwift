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
    guard
      BezierSwift.shared.allowHitTest,
      let hitView = super.hitTest(point, with: event),
      let rootView = rootViewController?.view
    else { return nil }
    
    // NOTE: iOS 18, Xcode 16 이상 버전을 사용할 때, hitTest 결과가 다르게 나옵니다.
    // view -> subView 로 이어지는 hitTest 플로우가 역으로 다시 UIHostingViewController 의 hitTest로 가는 상황이 생깁니다.
    // https://forums.developer.apple.com/forums/thread/762292
    // by Tom 25.01.08
    if #available(iOS 18, *) {
      for subview in rootView.subviews.reversed() {
        let convertedPoint = subview.convert(point, from: rootView)
        if subview.hitTest(convertedPoint, with: event) != nil {
          return hitView
        }
      }
      return nil
    } else {
      return (hitView == self || rootView == hitView) ? nil : hitView
    }
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
