//
//  RedesignSwiftUIExampleApp.swift
//  RedesignSwiftUIExample
//
//  Created by Tom on 12/20/23.
//

import SwiftUI

@main
struct RedesignSwiftUIExampleApp: App {
  @UIApplicationDelegateAdaptor(RedesignSwiftUIExampleAppDelegate.self) private var appDelegate
  @StateObject var colorSchemeManager = ColorSchemeManager()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(self.colorSchemeManager)
        .onAppear {
          self.appDelegate.initWindow()
        }
        .onChange(of: self.colorSchemeManager.colorScheme) { oldValue, newValue in
          guard oldValue != newValue else { return }

          self.appDelegate.overrideUIInterfaceThemeStyle(newValue)
        }
    }
  }
}
