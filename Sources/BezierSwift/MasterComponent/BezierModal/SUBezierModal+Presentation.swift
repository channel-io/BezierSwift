//
//  SUBezierModal+Presentation.swift
//  BezierSwift
//

import SwiftUI
import UIKit

extension View {
  /// 이 뷰 위에 `SUBezierModal` 카드를 dim 배경과 함께 띄우는 modifier. `isPresented` 바인딩으로 표시·해제를 제어하고, `onDismiss`로 닫힘 시점을 후처리한다.
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
    var hostingController: UIHostingController<BezierModalEnvironmentContent<ModalContent>>?
    var environment = EnvironmentValues()
    var isDismissing = false
    var isActive = true
    var updatePresentation: (() -> Void)?
    var onDismiss: (() -> Void)?
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  func makeUIViewController(context: Context) -> BezierModalAnchorViewController {
    BezierModalAnchorViewController()
  }

  func updateUIViewController(_ anchor: BezierModalAnchorViewController, context: Context) {
    let coordinator = context.coordinator
    coordinator.environment = context.environment
    coordinator.onDismiss = self.onDismiss
    coordinator.updatePresentation = { [weak anchor, weak coordinator] in
      guard let anchor, let coordinator, coordinator.isActive else { return }
      self.updatePresentation(from: anchor, coordinator: coordinator)
    }
    anchor.onReady = { [weak coordinator] in coordinator?.updatePresentation?() }
    coordinator.updatePresentation?()
  }

  private func updatePresentation(from anchor: UIViewController, coordinator: Coordinator) {
    if self.isPresented {
      if let hostingController = coordinator.hostingController {
        hostingController.rootView = BezierModalEnvironmentContent(
          content: self.modalContent(), environment: coordinator.environment
        )
      } else if coordinator.modalController == nil, !coordinator.isDismissing {
        self.present(from: anchor, coordinator: coordinator)
      }
    } else if let modalController = coordinator.modalController, !coordinator.isDismissing {
      coordinator.isDismissing = true
      modalController.dismiss(animated: true) { [weak coordinator] in
        guard let coordinator, coordinator.isActive else { return }
        coordinator.modalController = nil
        coordinator.hostingController = nil
        coordinator.isDismissing = false
        coordinator.onDismiss?()
        coordinator.updatePresentation?()
      }
    }
  }

  static func dismantleUIViewController(_ uiViewController: BezierModalAnchorViewController, coordinator: Coordinator) {
    coordinator.isActive = false
    coordinator.updatePresentation = nil
    coordinator.onDismiss = nil
    uiViewController.onReady = nil
    coordinator.modalController?.dismiss(animated: false)
    coordinator.modalController = nil
    coordinator.hostingController = nil
    coordinator.isDismissing = false
  }

  private func present(from anchor: UIViewController, coordinator: Coordinator) {
    // 최초 갱신은 window 연결보다 빠를 수 있다. 준비 전에는 viewDidAppear 알림을 기다린다.
    guard anchor.view.window != nil else { return }

    let hostingController = UIHostingController(rootView: BezierModalEnvironmentContent(
      content: self.modalContent(), environment: coordinator.environment
    ))
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

final class BezierModalAnchorViewController: UIViewController {
  var onReady: (() -> Void)?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.onReady?()
  }
}

struct BezierModalEnvironmentContent<Content: View>: View {
  let content: Content
  let environment: EnvironmentValues

  var body: some View {
    self.content.environment(\.self, self.environment)
  }
}
