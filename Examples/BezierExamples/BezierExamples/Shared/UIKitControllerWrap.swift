import SwiftUI
import UIKit

struct UIKitControllerWrap<VC: UIViewController>: UIViewControllerRepresentable {
  private let make: () -> VC
  private let update: (VC) -> Void

  init(_ make: @escaping () -> VC, update: @escaping (VC) -> Void = { _ in }) {
    self.make = make
    self.update = update
  }

  func makeUIViewController(context: Context) -> VC { self.make() }
  func updateUIViewController(_ uiViewController: VC, context: Context) { self.update(uiViewController) }
}
