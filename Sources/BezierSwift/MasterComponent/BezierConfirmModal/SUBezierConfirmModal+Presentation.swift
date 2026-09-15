//
//  SUBezierConfirmModal+Presentation.swift
//  BezierSwift
//

import SwiftUI
import UIKit

extension View {
  /// 이 뷰 위에 `SUBezierConfirmModal`을 dim 배경과 함께 띄우는 modifier. `isPresented` 바인딩으로 표시·해제를 제어한다.
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

  /// 커스텀 콘텐츠를 추가로 담아 `SUBezierConfirmModal`을 띄우는 modifier 오버로드.
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
struct SUBezierConfirmModalPresenter<CustomContent: View>: UIViewControllerRepresentable {
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
    var modalView: BezierConfirmModal?
    var hostingController: UIHostingController<BezierModalEnvironmentContent<CustomContent>>?
    var environment = EnvironmentValues()
    var pendingHandler: (() -> Void)?
    var isDismissing = false
    var isActive = true
    var updatePresentation: (() -> Void)?

    func takeDismissalCompletion() -> () -> Void {
      let handler = self.pendingHandler
      self.pendingHandler = nil
      // 액션의 수명은 presenter와 다르다. 해체돼도 이미 선택한 액션은 해제 완료 후 실행한다.
      return { [weak self] in
        if let self, self.isActive {
          self.modalController = nil
          self.modalView = nil
          self.hostingController = nil
          self.isDismissing = false
        }
        handler?()
        guard let self, self.isActive else { return }
        self.updatePresentation?()
      }
    }
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
    coordinator.updatePresentation = { [weak anchor, weak coordinator] in
      guard let anchor, let coordinator, coordinator.isActive else { return }
      self.updatePresentation(from: anchor, coordinator: coordinator)
    }
    anchor.onReady = { [weak coordinator] in coordinator?.updatePresentation?() }
    coordinator.updatePresentation?()
  }

  private func updatePresentation(from anchor: UIViewController, coordinator: Coordinator) {
    if self.isPresented {
      if let hostingController = coordinator.hostingController, let customContent = self.customContent {
        hostingController.rootView = BezierModalEnvironmentContent(
          content: customContent(), environment: coordinator.environment
        )
      }
      if let modalView = coordinator.modalView {
        modalView.update(
          title: self.title, description: self.description, type: self.type,
          buttonLayout: self.wrappedButtonLayout(coordinator: coordinator),
          confirmAction: self.bindingAction(self.confirmAction, coordinator: coordinator),
          cancelAction: self.cancelAction.map { self.bindingAction($0, coordinator: coordinator) }
        )
      } else if coordinator.modalController == nil, !coordinator.isDismissing {
        self.present(from: anchor, coordinator: coordinator)
      }
    } else if let modalController = coordinator.modalController, !coordinator.isDismissing {
      coordinator.isDismissing = true
      modalController.dismiss(animated: true, completion: coordinator.takeDismissalCompletion())
    }
  }

  static func dismantleUIViewController(_ uiViewController: BezierModalAnchorViewController, coordinator: Coordinator) {
    let completion = coordinator.takeDismissalCompletion()
    let modalController = coordinator.modalController
    coordinator.isActive = false
    coordinator.updatePresentation = nil
    uiViewController.onReady = nil
    coordinator.modalController = nil
    coordinator.modalView = nil
    coordinator.hostingController = nil
    coordinator.isDismissing = false
    if let modalController {
      modalController.dismiss(animated: false, completion: completion)
    } else {
      completion()
    }
  }

  private func present(from anchor: UIViewController, coordinator: Coordinator) {
    // 최초 갱신은 window 연결보다 빠를 수 있다. 준비 전에는 viewDidAppear 알림을 기다린다.
    guard anchor.view.window != nil else { return }

    var customContentView: UIView?
    if let customContent = self.customContent {
      let hostingController = UIHostingController(rootView: BezierModalEnvironmentContent(
        content: customContent(), environment: coordinator.environment
      ))
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
      buttonLayout: self.wrappedButtonLayout(coordinator: coordinator),
      confirmAction: self.bindingAction(self.confirmAction, coordinator: coordinator),
      cancelAction: self.cancelAction.map { self.bindingAction($0, coordinator: coordinator) }
    )

    let modalController = BezierModalViewController(modalView: modalView)
    if let hostingController = coordinator.hostingController {
      modalController.addChild(hostingController)
      hostingController.didMove(toParent: modalController)
    }

    coordinator.modalController = modalController
    coordinator.modalView = modalView
    anchor.present(modalController, animated: true)
  }

  private func bindingAction(_ action: BezierConfirmModalAction, coordinator: Coordinator) -> BezierConfirmModalAction {
    BezierConfirmModalAction(title: action.title) { [weak coordinator] in
      guard let coordinator, coordinator.isActive, self.isPresented, !coordinator.isDismissing else { return }
      coordinator.pendingHandler = action.handler
      self.isPresented = false
    }
  }

  private func wrappedButtonLayout(coordinator: Coordinator) -> BezierConfirmModalButtonLayout {
    switch self.buttonLayout {
    case .vertical(let altAction):
      return .vertical(altAction: altAction.map { self.bindingAction($0, coordinator: coordinator) })
    case .horizontal:
      return .horizontal
    }
  }
}
