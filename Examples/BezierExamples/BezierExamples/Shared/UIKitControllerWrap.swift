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

  func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: VC, context: Context) -> CGSize? {
    uiViewController.view.systemLayoutSizeFitting(
      CGSize(
        width: proposal.width ?? UIView.layoutFittingCompressedSize.width,
        height: proposal.height ?? UIView.layoutFittingCompressedSize.height
      ),
      withHorizontalFittingPriority: .fittingSizeLevel,
      verticalFittingPriority: .fittingSizeLevel
    )
  }
}
