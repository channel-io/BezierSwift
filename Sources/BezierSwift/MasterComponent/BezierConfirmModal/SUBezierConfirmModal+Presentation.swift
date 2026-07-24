//
//  SUBezierConfirmModal+Presentation.swift
//  BezierSwift
//

import SwiftUI
import UIKit

extension View {
  public func bezierConfirmModal(
    isPresented: Binding<Bool>,
    title: String,
    description: String? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?
  ) -> some View {
    self.background(
      SUBezierConfirmModalPresenter<EmptyView>(
        isPresented: isPresented,
        title: title,
        description: description,
        type: type,
        buttonLayout: buttonLayout,
        confirmAction: confirmAction,
        cancelAction: cancelAction,
        customContent: nil
      )
    )
  }

  public func bezierConfirmModal<CustomContent: View>(
    isPresented: Binding<Bool>,
    title: String,
    description: String? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?,
    @ViewBuilder customContent: @escaping () -> CustomContent
  ) -> some View {
    self.background(
      SUBezierConfirmModalPresenter(
        isPresented: isPresented,
        title: title,
        description: description,
        type: type,
        buttonLayout: buttonLayout,
        confirmAction: confirmAction,
        cancelAction: cancelAction,
        customContent: customContent
      )
    )
  }
}

// 프레젠테이션 시각 결과(dim/너비 정책/전환)를 UIKit 경로 하나로 수렴시키기 위해
// SwiftUI에서도 UIKit BezierConfirmModal을 카드로 present한다
private struct SUBezierConfirmModalPresenter<CustomContent: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let title: String
  let description: String?
  let type: BezierConfirmModalType
  let buttonLayout: BezierConfirmModalButtonLayout
  let confirmAction: BezierConfirmModalAction
  let cancelAction: BezierConfirmModalAction?
  let customContent: (() -> CustomContent)?

  final class Coordinator {
    var modalController: BezierModalViewController?
    var hostingController: UIHostingController<CustomContent>?
    var pendingHandler: (() -> Void)?
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
      if let hostingController = coordinator.hostingController, let customContent = self.customContent {
        hostingController.rootView = customContent()
      } else if coordinator.modalController == nil, !coordinator.isDismissing {
        self.present(from: anchor, coordinator: coordinator)
      }
    } else if let modalController = coordinator.modalController, !coordinator.isDismissing {
      coordinator.isDismissing = true
      let pendingHandler = coordinator.pendingHandler
      coordinator.pendingHandler = nil
      modalController.dismiss(animated: true) {
        coordinator.modalController = nil
        coordinator.hostingController = nil
        coordinator.isDismissing = false
        pendingHandler?()
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
    coordinator.pendingHandler = nil
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

    // 버튼 액션은 binding을 단일 dismiss 경로로 사용하고,
    // handler는 dismiss 완료 후 실행되도록 coordinator에 보관한다
    func bindingAction(_ action: BezierConfirmModalAction) -> BezierConfirmModalAction {
      BezierConfirmModalAction(title: action.title) {
        coordinator.pendingHandler = action.handler
        self.isPresented = false
      }
    }

    let wrappedLayout: BezierConfirmModalButtonLayout
    switch self.buttonLayout {
    case .vertical(let altAction):
      wrappedLayout = .vertical(altAction: altAction.map(bindingAction))
    case .horizontal:
      wrappedLayout = .horizontal
    }

    var customContentView: UIView?
    if let customContent = self.customContent {
      let hostingController = UIHostingController(rootView: customContent())
      hostingController.view.backgroundColor = .clear
      hostingController.sizingOptions = .intrinsicContentSize
      coordinator.hostingController = hostingController
      customContentView = hostingController.view
    }

    let modalView = BezierConfirmModal(
      title: self.title,
      description: self.description,
      customContent: customContentView,
      type: self.type,
      buttonLayout: wrappedLayout,
      confirmAction: bindingAction(self.confirmAction),
      cancelAction: self.cancelAction.map(bindingAction)
    )

    let modalController = BezierModalViewController(modalView: modalView)
    if let hostingController = coordinator.hostingController {
      modalController.addChild(hostingController)
      hostingController.didMove(toParent: modalController)
    }

    coordinator.modalController = modalController
    anchor.present(modalController, animated: true)
  }
}
