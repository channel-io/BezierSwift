import SwiftUI
import UIKit
import BezierSwift

@main
struct BezierExamplesApp: App {
  @State private var bezierWindow: UIWindow?

  var body: some Scene {
    WindowGroup {
      entryView
        .onAppear(perform: self.setupBezierWindowIfNeeded)
    }
  }

  @ViewBuilder
  private var entryView: some View {
    #if DEBUG
    if let scenario = SwiftUIReviewProbe.requestedCase {
      SwiftUIReviewProbe(scenario: scenario)
    } else {
      RootView()
    }
    #else
    RootView()
    #endif
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
