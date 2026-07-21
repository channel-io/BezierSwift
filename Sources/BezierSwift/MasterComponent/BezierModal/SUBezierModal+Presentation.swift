//
//  SUBezierModal+Presentation.swift
//  BezierSwift
//

import SwiftUI
import UIKit

extension View {
  public func bezierModal<ModalContent: View>(
    isPresented: Binding<Bool>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> ModalContent
  ) -> some View {
    self.background(
      SUBezierModalPresenter(
        isPresented: isPresented,
        onDismiss: onDismiss,
        modalContent: content
      )
    )
  }
}

struct SUBezierModalPresenter<ModalContent: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let onDismiss: (() -> Void)?
  let modalContent: () -> ModalContent

  final class Coordinator {
    var modalController: BezierModalViewController?
    var hostingController: UIHostingController<ModalContent>?
    var isDismissing = false
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  func makeUIViewController(context: Context) -> UIViewController {
    UIViewController()
  }

  func updateUIViewController(_ anchor: UIViewController, context: Context) {
    let coordinator = context.coordinator

    if self.isPresented {
      if let hostingController = coordinator.hostingController {
        hostingController.rootView = self.modalContent()
      } else if coordinator.modalController == nil, !coordinator.isDismissing {
        self.present(from: anchor, coordinator: coordinator)
      }
    } else if let modalController = coordinator.modalController, !coordinator.isDismissing {
      coordinator.isDismissing = true
      modalController.dismiss(animated: true) {
        coordinator.modalController = nil
        coordinator.hostingController = nil
        coordinator.isDismissing = false
        self.onDismiss?()
        // dismiss 진행 중 binding이 다시 true가 된 경우 여기서 재-present (update가 다시 불리지 않음)
        if self.isPresented {
          self.present(from: anchor, coordinator: coordinator)
        }
      }
    }
  }

  static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: Coordinator) {
    coordinator.modalController?.dismiss(animated: false)
    coordinator.modalController = nil
    coordinator.hostingController = nil
    coordinator.isDismissing = false
  }

  private func present(from anchor: UIViewController, coordinator: Coordinator) {
    // 최초 렌더 직후에는 anchor가 아직 window에 붙지 않았을 수 있어 다음 runloop에 재시도
    guard anchor.view.window != nil else {
      DispatchQueue.main.async {
        guard self.isPresented, coordinator.modalController == nil, !coordinator.isDismissing else { return }
        self.present(from: anchor, coordinator: coordinator)
      }
      return
    }

    let hostingController = UIHostingController(rootView: self.modalContent())
    hostingController.view.backgroundColor = .clear
    hostingController.sizingOptions = .intrinsicContentSize

    let modalController = BezierModalViewController(contentView: hostingController.view)
    modalController.addChild(hostingController)
    hostingController.didMove(toParent: modalController)

    coordinator.modalController = modalController
    coordinator.hostingController = hostingController

    anchor.present(modalController, animated: true)
  }
}
