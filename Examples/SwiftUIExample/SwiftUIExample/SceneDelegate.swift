//
//  SceneDelegate.swift
//  SwiftUIExample
//
//  Created by Tom on 7/4/24.
//

import UIKit
import BezierSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    self.window = windowScene.windows.first { $0.isKeyWindow }
    
    BezierSwift.shared.delegate = self
  }
}

extension SceneDelegate: BezierSwiftDelegate {
  func windowsForThemeUpdate() -> [UIWindow] {
    guard let window else { return [] }
    
    return [window]
  }
}
