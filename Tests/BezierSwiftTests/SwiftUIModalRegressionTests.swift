import SwiftUI
import Testing
import UIKit
@testable import BezierSwift

extension SwiftUIRegressionTests {
  @Suite("확인 모달 갱신")
  @MainActor
  struct Modal {
    @Test("해제 시작 전에 presenter가 해체돼도 선택한 액션을 한 번 실행한다")
    func actionSurvivesEarlyDismantle() {
      typealias Presenter = SUBezierConfirmModalPresenter<EmptyView>
      let coordinator = Presenter.Coordinator()
      let anchor = BezierModalAnchorViewController()
      var calls = 0
      var updates = 0
      coordinator.pendingHandler = { calls += 1 }
      coordinator.updatePresentation = { updates += 1 }

      Presenter.dismantleUIViewController(anchor, coordinator: coordinator)
      Presenter.dismantleUIViewController(anchor, coordinator: coordinator)

      #expect(calls == 1)
      #expect(updates == 0)
      #expect(coordinator.pendingHandler == nil)
      #expect(!coordinator.isActive)
    }

    @Test("해제 도중 presenter와 coordinator가 사라져도 완료 시 액션을 한 번 실행한다")
    func actionSurvivesInFlightDismantle() {
      typealias Presenter = SUBezierConfirmModalPresenter<EmptyView>
      var coordinator: Presenter.Coordinator? = Presenter.Coordinator()
      weak var weakCoordinator = coordinator
      var calls = 0
      coordinator?.pendingHandler = { calls += 1 }
      let completion = coordinator!.takeDismissalCompletion()
      Presenter.dismantleUIViewController(BezierModalAnchorViewController(), coordinator: coordinator!)
      #expect(calls == 0)
      coordinator = nil
      #expect(weakCoordinator == nil)

      completion()
      #expect(calls == 1)
    }

    @Test("정상 해제는 표시 상태를 정리하고 액션 다음에 최신 표시 요청을 처리한다")
    func dismissalCleansUpBeforeAction() {
      let coordinator = SUBezierConfirmModalPresenter<EmptyView>.Coordinator()
      coordinator.isDismissing = true
      coordinator.modalController = BezierModalViewController(contentView: UIView())
      var events: [String] = []
      coordinator.pendingHandler = { [weak coordinator] in
        #expect(coordinator?.isDismissing == false)
        #expect(coordinator?.modalController == nil)
        events.append("action")
      }
      coordinator.updatePresentation = { events.append("update") }
      coordinator.takeDismissalCompletion()()
      #expect(events == ["action", "update"])
    }

    @Test("제목·설명·시맨틱과 액션이 최신 입력을 반영한다")
    func updatesContentAndAction() {
      var actions: [String] = []
      let modal = BezierConfirmModal(
        title: "A", description: "설명 A",
        confirmAction: .init(title: "확인 A") { actions.append("A") }, cancelAction: nil
      )
      let originalButton = modal.confirmButton

      modal.update(
        title: "B", description: "설명 B", type: .destructive, buttonLayout: .horizontal,
        confirmAction: .init(title: "확인 B") { actions.append("B") }, cancelAction: nil
      )
      #expect(modal.title == "B")
      #expect(modal.descriptionText == "설명 B")
      #expect(modal.confirmButton.title == "확인 B")
      #expect(modal.confirmButton.semantic == .destructive)
      #expect(modal.confirmButton === originalButton)
      modal.confirmButton.sendActions(for: .touchUpInside)
      #expect(actions == ["B"])

      modal.update(
        title: "C", description: nil, type: .default, buttonLayout: .horizontal,
        confirmAction: .init(title: "확인 C") { actions.append("C") }, cancelAction: nil
      )
      modal.confirmButton.sendActions(for: .touchUpInside)
      #expect(modal.descriptionText == nil)
      #expect(actions == ["B", "C"])
    }

    @Test("버튼 추가·제거와 가로·세로 전환이 현재 구성을 따른다")
    func updatesButtonConfiguration() throws {
      var actions: [String] = []
      let modal = BezierConfirmModal(title: "제목", confirmAction: .init(title: "확인"), cancelAction: nil)
      #expect(modal.cancelButton == nil)
      #expect(modal.altButton == nil)

      modal.update(
        title: "제목", description: nil, type: .default,
        buttonLayout: .vertical(altAction: .init(title: "대체 B") { actions.append("B") }),
        confirmAction: .init(title: "확인"), cancelAction: .init(title: "취소")
      )
      let originalAlternative = try #require(modal.altButton)
      let stack = try #require(modal.confirmButton.superview as? UIStackView)
      #expect(stack.axis == .vertical)
      #expect(stack.arrangedSubviews.count == 3)
      #expect(stack.arrangedSubviews[0] === modal.confirmButton)
      #expect(stack.arrangedSubviews[1] === modal.altButton)
      #expect(stack.arrangedSubviews[2] === modal.cancelButton)

      modal.update(
        title: "제목", description: nil, type: .default,
        buttonLayout: .vertical(altAction: .init(title: "대체 C") { actions.append("C") }),
        confirmAction: .init(title: "확인"), cancelAction: .init(title: "취소")
      )
      #expect(modal.altButton === originalAlternative)
      modal.altButton?.sendActions(for: .touchUpInside)
      #expect(actions == ["C"])

      modal.update(
        title: "제목", description: nil, type: .default, buttonLayout: .horizontal,
        confirmAction: .init(title: "확인"), cancelAction: nil
      )
      #expect(modal.cancelButton == nil)
      #expect(modal.altButton == nil)
      #expect(stack.axis == .horizontal)
      #expect(stack.arrangedSubviews.count == 1)
      #expect(originalAlternative.superview == nil)
    }

    @Test("문구와 버튼 구성을 갱신해도 커스텀 입력 뷰를 보존한다")
    func preservesCustomContent() {
      let field = UITextField()
      field.text = "입력 중인 값"
      let modal = BezierConfirmModal(
        title: "A", customContent: field,
        confirmAction: .init(title: "확인"), cancelAction: nil
      )
      let parent = field.superview
      modal.update(
        title: "B", description: "변경", type: .default,
        buttonLayout: .vertical(altAction: nil),
        confirmAction: .init(title: "확인"), cancelAction: .init(title: "취소")
      )
      #expect(parent != nil)
      #expect(field.superview === parent)
      #expect(field.text == "입력 중인 값")
    }
  }
}
