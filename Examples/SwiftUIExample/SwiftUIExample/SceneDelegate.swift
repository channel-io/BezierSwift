//
//  SceneDelegate.swift
//  SwiftUIExample
//
//  Created by Tom on 7/4/24.
//

import UIKit
import BezierSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  weak var windowScene: UIWindowScene?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    self.windowScene = windowScene
    
    BezierSwift.shared.delegate = self
  }
}

extension SceneDelegate: BezierSwiftDelegate {
  func windowsForThemeUpdate() -> [UIWindow] {
    self.windowScene?.windows ?? []
  }
}
