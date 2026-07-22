//
//  BezierConfirmModal+Presentation.swift
//  BezierSwift
//

import UIKit

extension BezierModalViewController {
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
