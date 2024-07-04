//
//  SceneDelegate.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/27.
//

import UIKit
import BezierSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    self.window = UIWindow(windowScene: windowScene)
    let viewController = ViewController()
    
    self.window?.rootViewController = viewController
    self.window?.makeKeyAndVisible()
    
    BezierSwift.shared.delegate = self
  }
}

extension SceneDelegate: BezierSwiftDelegate {
  func windowsForThemeUpdate() -> [UIWindow] {
    guard let window else { return [] }
    
    return [window]
  }
}
