import SwiftUI
import UIKit
import BezierSwift

@main
struct BezierExamplesApp: App {
  @State private var bezierWindow: UIWindow?

  var body: some Scene {
    WindowGroup {
      RootView()
        .onAppear(perform: self.setupBezierWindowIfNeeded)
    }
  }

  private func setupBezierWindowIfNeeded() {
    guard self.bezierWindow == nil else { return }
    let windowScene = UIApplication.shared.connectedScenes
      .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
      ?? UIApplication.shared.connectedScenes
        .compactMap({ $0 as? UIWindowScene }).first
    guard let scene = windowScene else { return }
    self.bezierWindow = BezierSwift.initializeWindow(windowScene: scene)
  }
}
