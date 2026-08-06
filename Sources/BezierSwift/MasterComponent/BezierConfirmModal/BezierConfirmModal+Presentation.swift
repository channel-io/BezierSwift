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
    self.makeConfirm(
      title: title,
      customContent: customContent,
      type: type,
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      cancelAction: cancelAction
    ) { modalView in
      modalView.descriptionText = description
    }
  }

  /// 설명에 리치 텍스트를 넣는 `confirm(...)` 오버로드. `<b>` 강조나 `<br />` 줄바꿈이 섞인 문구에 쓴다.
  ///
  /// `attributedDescription`의 전경색은 모달이 표시 시점에 다시 칠하므로, 리치 텍스트를 만들 때 넘기는 `BezierComponentable`이 무엇이든(그리고 그 사이 해제되더라도) 색 결과는 달라지지 않는다. 자세한 계약은 `BezierConfirmModal.attributedDescription`에 있다.
  public static func confirm(
    title: String,
    attributedDescription: NSAttributedString,
    customContent: UIView? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?
  ) -> BezierModalViewController {
    self.makeConfirm(
      title: title,
      customContent: customContent,
      type: type,
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      cancelAction: cancelAction
    ) { modalView in
      modalView.attributedDescription = attributedDescription
    }
  }

  private static func makeConfirm(
    title: String,
    customContent: UIView?,
    type: BezierConfirmModalType,
    buttonLayout: BezierConfirmModalButtonLayout,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?,
    applyDescription: (BezierConfirmModal) -> Void
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
      customContent: customContent,
      type: type,
      buttonLayout: wrappedLayout,
      confirmAction: dismissingAction(confirmAction),
      cancelAction: cancelAction.map(dismissingAction)
    )
    applyDescription(modalView)

    let controller = BezierModalViewController(modalView: modalView)
    weakController = controller
    return controller
  }
}
