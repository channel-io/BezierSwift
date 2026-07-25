//
//  BezierConfirmModal+Presentation.swift
//  BezierSwift
//

import UIKit

extension BezierModalViewController {
  /// 확인 모달을 카드로 감싸 dim 배경과 함께 띄울 수 있는 컨트롤러를 만든다. 각 버튼 액션은 탭 시 모달을 먼저 닫은 뒤 핸들러를 실행한다.
  public static func confirm(
    title: String,
    description: String? = nil,
    customContent: UIView? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?
  ) -> BezierModalViewController {
    weak var weakController: BezierModalViewController?

    func dismissingAction(_ action: BezierConfirmModalAction) -> BezierConfirmModalAction {
      BezierConfirmModalAction(title: action.title) {
        weakController?.dismiss(animated: true) {
          action.handler()
        }
      }
    }

    let wrappedLayout: BezierConfirmModalButtonLayout
    switch buttonLayout {
    case .vertical(let altAction):
      wrappedLayout = .vertical(altAction: altAction.map(dismissingAction))
    case .horizontal:
      wrappedLayout = .horizontal
    }

    let modalView = BezierConfirmModal(
      title: title,
      description: description,
      customContent: customContent,
      type: type,
      buttonLayout: wrappedLayout,
      confirmAction: dismissingAction(confirmAction),
      cancelAction: cancelAction.map(dismissingAction)
    )

    let controller = BezierModalViewController(modalView: modalView)
    weakController = controller
    return controller
  }
}
