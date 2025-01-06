//
//  SwiftUIExampleApp.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/06/28.
//

import SwiftUI

@main
struct SwiftUIExampleApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

