//
//  SUBezierConfirmModal.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierConfirmModal<CustomContent: View>: View {
  private let title: String
  private let description: String?
  private let type: BezierConfirmModalType
  private let buttonLayout: BezierConfirmModalButtonLayout
  private let confirmAction: BezierConfirmModalAction
  private let cancelAction: BezierConfirmModalAction?
  private let customContent: CustomContent?

  public init(
    title: String,
    description: String? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?,
    @ViewBuilder customContent: () -> CustomContent
  ) {
    self.init(
      title: title,
      description: description,
      type: type,
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      cancelAction: cancelAction,
      customContent: customContent()
    )
  }

  private init(
    title: String,
    description: String?,
    type: BezierConfirmModalType,
    buttonLayout: BezierConfirmModalButtonLayout,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?,
    customContent: CustomContent?
  ) {
    self.title = title
    self.description = description
    self.type = type

    var sanitizedLayout = buttonLayout
    // 취소 없는 1버튼(acknowledge) 케이스는 altAction 조합이 무효 (Figma showCancel 유효 조합 규칙)
    if cancelAction == nil, case .vertical(let altAction) = buttonLayout, altAction != nil {
      assertionFailure("cancelAction 없이 altAction을 사용할 수 없습니다")
      sanitizedLayout = .vertical(altAction: nil)
    }
    self.buttonLayout = sanitizedLayout

    self.confirmAction = confirmAction
    self.cancelAction = cancelAction
    self.customContent = customContent
  }

  public var body: some View {
    SUBezierModal {
      VStack(spacing: 0) {
        VStack(spacing: BezierConfirmModalSpec.contentSpacing) {
          Text(self.title)
            .applyBezierFontStyle(
              BezierConfirmModalSpec.titleTypography,
              semanticColorToken: BezierConfirmModalSpec.textColorToken
            )
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)

          if let description = self.description {
            Text(description)
              .applyBezierFontStyle(
                BezierConfirmModalSpec.descriptionTypography,
                semanticColorToken: BezierConfirmModalSpec.textColorToken
              )
              .multilineTextAlignment(.center)
              .frame(maxWidth: .infinity)
          }
        }
        .padding(.bottom, BezierConfirmModalSpec.contentBottomPadding)

        if let customContent = self.customContent {
          customContent
            .frame(maxWidth: .infinity)
        }

        self.buttons
          .padding(.top, BezierConfirmModalSpec.buttonsTopPadding)
      }
    }
  }

  @ViewBuilder
  private var buttons: some View {
    switch self.buttonLayout {
    case .vertical(let altAction):
      VStack(spacing: BezierConfirmModalSpec.verticalButtonSpacing) {
        self.button(for: self.confirmAction, semantic: self.type.confirmButtonSemantic)
        if let altAction {
          self.button(for: altAction, semantic: BezierConfirmModalSpec.cancelSemantic)
        }
        if let cancelAction = self.cancelAction {
          self.button(for: cancelAction, semantic: BezierConfirmModalSpec.cancelSemantic)
        }
      }

    case .horizontal:
      HStack(spacing: BezierConfirmModalSpec.horizontalButtonSpacing) {
        if let cancelAction = self.cancelAction {
          self.button(for: cancelAction, semantic: BezierConfirmModalSpec.cancelSemantic)
        }
        self.button(for: self.confirmAction, semantic: self.type.confirmButtonSemantic)
      }
    }
  }

  private func button(
    for action: BezierConfirmModalAction,
    semantic: BezierButtonSemantic
  ) -> some View {
    SUBezierButton(
      size: BezierConfirmModalSpec.buttonSize,
      variant: BezierConfirmModalSpec.buttonVariant,
      semantic: semantic,
      title: action.title,
      isFillWidth: true,
      action: action.handler
    )
  }
}

extension SUBezierConfirmModal where CustomContent == EmptyView {
  public init(
    title: String,
    description: String? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?
  ) {
    self.init(
      title: title,
      description: description,
      type: type,
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      cancelAction: cancelAction,
      customContent: nil
    )
  }
}

struct SUBezierConfirmModal_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
      ScrollView {
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
        }
        .padding(.vertical, 24)
      }
    }
  }
}
