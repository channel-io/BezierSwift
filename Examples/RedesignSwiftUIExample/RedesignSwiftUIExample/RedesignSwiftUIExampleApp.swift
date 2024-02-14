//
//  RedesignSwiftUIExampleApp.swift
//  RedesignSwiftUIExample
//
//  Created by Tom on 12/20/23.
//

import SwiftUI

struct Container: View {
  var body: some View {
    ContentView()
  }
}

@main
struct RedesignSwiftUIExampleApp: App {
  @UIApplicationDelegateAdaptor(RedesignSwiftUIExampleAppDelegate.self) private var appDelegate
  @StateObject var colorSchemeManager = ColorSchemeManager()

  var body: some Scene {
    WindowGroup {
      Container()
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
