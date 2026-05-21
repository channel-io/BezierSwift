import SwiftUI
import UIKit

struct UIKitWrap<V: UIView>: UIViewRepresentable {
  private let make: () -> V
  private let update: (V) -> Void

  init(_ make: @escaping () -> V, update: @escaping (V) -> Void = { _ in }) {
    self.make = make
    self.update = update
  }

  func makeUIView(context: Context) -> V { self.make() }
  func updateUIView(_ uiView: V, context: Context) { self.update(uiView) }
}
