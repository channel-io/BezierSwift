//
//  RedesignSwiftUIExampleAppDelegate.swift
//  RedesignSwiftUIExampleAppDelegate
//
//  Created by 구본욱 on 2/7/24.
//

import UIKit
import SwiftUI

final class RedesignSwiftUIExampleAppDelegate: NSObject, UIApplicationDelegate {
  private var mainWindow: UIWindow?

  func initWindow() {
     self.mainWindow = self.getKeyWindow()
  }

  func overrideUIInterfaceThemeStyle(_ colorScheme: ColorScheme?) {
    switch colorScheme {
    case .light:
      self.mainWindow?.overrideUserInterfaceStyle = .light
    case .dark:
      self.mainWindow?.overrideUserInterfaceStyle = .dark
    default:
      self.mainWindow?.overrideUserInterfaceStyle = .unspecified
    }
  }
}

// MARK: - Private Functions
extension RedesignSwiftUIExampleAppDelegate {
  private func getKeyWindow() -> UIWindow? {
    guard
      let scene = self.getUIWindowScene(),
      let keyWindow = scene.windows.filter({ $0.isKeyWindow }).first
    else {
      return nil
    }

    return keyWindow
  }

  private func getUIWindowScene() -> UIWindowScene? {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.session.role == .windowApplication }
  }
}
