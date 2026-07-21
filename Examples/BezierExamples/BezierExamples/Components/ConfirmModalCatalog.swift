import SwiftUI
import UIKit
import BezierSwift

struct ConfirmModalCatalog: View {
  @State private var isVerticalPresented = false
  @State private var isHorizontalPresented = false

  var body: some View {
    CatalogScreen(title: "ConfirmModal") {
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    VStack(spacing: 24) {
      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        confirmAction: BezierConfirmModalAction(title: "Confirm"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        type: .destructive,
        confirmAction: BezierConfirmModalAction(title: "Delete"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        buttonLayout: .vertical(altAction: nil),
        confirmAction: BezierConfirmModalAction(title: "Confirm"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        type: .destructive,
        buttonLayout: .vertical(altAction: nil),
        confirmAction: BezierConfirmModalAction(title: "Delete"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        buttonLayout: .vertical(altAction: BezierConfirmModalAction(title: "Alt Action")),
        confirmAction: BezierConfirmModalAction(title: "Confirm"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        confirmAction: BezierConfirmModalAction(title: "OK"),
        cancelAction: nil
      )

      SUBezierConfirmModal(
        title: "Dialog Title",
        description: "Description text goes here.",
        buttonLayout: .vertical(altAction: nil),
        confirmAction: BezierConfirmModalAction(title: "Confirm"),
        cancelAction: BezierConfirmModalAction(title: "Cancel")
      ) {
        RoundedRectangle(cornerRadius: 8)
          .fill(Color.secondary.opacity(0.15))
          .frame(height: 64)
          .overlay(
            Text("Custom Content")
              .font(.system(size: 13))
              .foregroundStyle(.secondary)
          )
      }

      HStack(spacing: 12) {
        SUBezierButton(
          size: .medium,
          variant: .filled,
          semantic: .primary,
          title: "Present (vertical)"
        ) {
          self.isVerticalPresented = true
        }
        .bezierConfirmModal(
          isPresented: self.$isVerticalPresented,
          title: "게시글을 삭제할까요?",
          description: "삭제하면 되돌릴 수 없어요.",
          type: .destructive,
          buttonLayout: .vertical(altAction: nil),
          confirmAction: BezierConfirmModalAction(title: "삭제"),
          cancelAction: BezierConfirmModalAction(title: "취소")
        )

        SUBezierButton(
          size: .medium,
          variant: .filled,
          semantic: .secondary,
          title: "Present (horizontal)"
        ) {
          self.isHorizontalPresented = true
        }
        .bezierConfirmModal(
          isPresented: self.$isHorizontalPresented,
          title: "변경사항을 저장할까요?",
          description: "저장하지 않으면 변경사항이 사라져요.",
          confirmAction: BezierConfirmModalAction(title: "저장"),
          cancelAction: BezierConfirmModalAction(title: "취소")
        )
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 24)
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    VStack(spacing: 24) {
      UIKitWrap {
        BezierConfirmModal(
          title: "Dialog Title",
          description: "Description text goes here.",
          confirmAction: BezierConfirmModalAction(title: "Confirm"),
          cancelAction: BezierConfirmModalAction(title: "Cancel")
        )
      }
      .fixedSize()

      UIKitWrap {
        BezierConfirmModal(
          title: "Dialog Title",
          description: "Description text goes here.",
          type: .destructive,
          buttonLayout: .vertical(altAction: nil),
          confirmAction: BezierConfirmModalAction(title: "Delete"),
          cancelAction: BezierConfirmModalAction(title: "Cancel")
        )
      }
      .fixedSize()

      UIKitWrap {
        BezierConfirmModal(
          title: "Dialog Title",
          description: "Description text goes here.",
          buttonLayout: .vertical(altAction: BezierConfirmModalAction(title: "Alt Action")),
          confirmAction: BezierConfirmModalAction(title: "Confirm"),
          cancelAction: BezierConfirmModalAction(title: "Cancel")
        )
      }
      .fixedSize()

      UIKitWrap {
        BezierConfirmModal(
          title: "Dialog Title",
          description: "Description text goes here.",
          confirmAction: BezierConfirmModalAction(title: "OK"),
          cancelAction: nil
        )
      }
      .fixedSize()

      UIKitWrap {
        let button = BezierButton(size: .medium, variant: .filled, semantic: .primary)
        button.title = "Present (UIKit)"
        button.addAction(
          UIAction { [weak button] _ in
            guard let presenter = button?.topPresentingViewController else { return }
            let modalController = BezierModalViewController.confirm(
              title: "채팅에서 나갈까요?",
              description: "나가면 대화 내용이 보이지 않아요.",
              type: .destructive,
              buttonLayout: .vertical(altAction: nil),
              confirmAction: BezierConfirmModalAction(title: "나가기"),
              cancelAction: BezierConfirmModalAction(title: "취소")
            )
            presenter.present(modalController, animated: true)
          },
          for: .touchUpInside
        )
        return button
      }
      .fixedSize()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 24)
  }
}
