//
//  SUBezierFormField.swift
//  BezierSwift
//

import SwiftUI

/// 라벨 · 컨트롤 · 설명 · 에러 메시지를 하나의 필드 행으로 묶는 FormField (SwiftUI). `SUBezierForm` 안에서만 사용하고 단독 배치하지 않는다. 컨트롤 슬롯에는 `SUBezierTextInput` 등 실제 입력 컴포넌트를 넣으며, 에러 시 컨트롤 자체의 에러 표시(`SUBezierTextInput`의 `hasError` 등)는 소비자가 별도로 지정한다. UIKit에서는 `BezierFormField`를 사용한다.
public struct SUBezierFormField<Control: View, CustomContent: View>: View {
  private let labelPosition: BezierFormFieldLabelPosition
  private let labelText: String?
  private let description: String?
  private let isRequired: Bool
  private let errorText: String?
  private let control: Control
  private let customContent: CustomContent

  /// 배치·라벨·설명·필수 여부·에러 메시지와 슬롯 빌더로 필드를 만든다.
  /// - `labelText`: `.top`에서 `nil`이면 라벨 영역(설명 포함)을 숨긴다. `.left`는 라벨을 전제로 한 배치라 `nil`이어도 라벨 영역이 자리를 유지한다.
  /// - `errorText`: `nil`이 아니면 필드 하단에 에러 메시지 행을 표시한다.
  /// - `customContent`: 필드 직속 복합 콘텐츠 슬롯(전체 폭).
  public init(
    labelPosition: BezierFormFieldLabelPosition = .top,
    labelText: String? = nil,
    description: String? = nil,
    isRequired: Bool = false,
    errorText: String? = nil,
    @ViewBuilder control: () -> Control,
    @ViewBuilder customContent: () -> CustomContent
  ) {
    self.labelPosition = labelPosition
    self.labelText = labelText
    self.description = description
    self.isRequired = isRequired
    self.errorText = errorText
    self.control = control()
    self.customContent = customContent()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: BezierFormConstant.fieldContentSpacing) {
      self.contentView

      if CustomContent.self != EmptyView.self {
        self.customContent
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      if let errorText = self.errorText {
        SUBezierFormFieldErrorMessage(errorText)
      }
    }
    .padding(.bottom, BezierFormConstant.fieldBottomPadding)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: - Content

  @ViewBuilder
  private var contentView: some View {
    switch self.labelPosition {
    case .top:
      VStack(alignment: .leading, spacing: BezierFormConstant.labelToControlSpacing) {
        self.labelAreaView
        self.control
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    case .left:
      HStack(alignment: .top, spacing: 0) {
        self.labelAreaView
          .frame(maxWidth: .infinity, alignment: .leading)
        self.control
          .frame(
            minWidth: BezierFormConstant.inlineControlMinWidth,
            maxWidth: BezierFormConstant.inlineControlMaxWidth,
            alignment: .topTrailing
          )
          .fixedSize(horizontal: true, vertical: false)
      }
    }
  }

  // left 배치는 LabelArea가 상시 표시된다. 라벨이 비어도 컨테이너를 남겨야 남는 폭을
  // 흡수해 컨트롤이 우측에 고정된다 — 걷어내면 space-between 구조가 무너진다.
  @ViewBuilder
  private var labelAreaView: some View {
    if self.labelText != nil || self.labelPosition == .left {
      VStack(alignment: .leading, spacing: BezierFormConstant.labelToDescriptionSpacing) {
        HStack(alignment: .top, spacing: BezierFormConstant.labelRowSpacing) {
          if let labelText = self.labelText {
            Text(labelText)
              .applyBezierFontStyle(
                BezierFormConstant.labelTypography,
                semanticColorToken: BezierFormConstant.labelColor
              )
              .lineLimit(1)
              .truncationMode(.tail)
          }

          if self.isRequired {
            Text(BezierFormConstant.requiredMarkerText)
              .applyBezierFontStyle(
                BezierFormConstant.labelTypography,
                semanticColorToken: BezierFormConstant.requiredMarkerColor
              )
          }
        }

        if let description = self.description {
          Text(description)
            .applyBezierFontStyle(
              BezierFormConstant.descriptionTypography,
              semanticColorToken: BezierFormConstant.descriptionColor
            )
            .fixedSize(horizontal: false, vertical: true)
        }
      }
      .padding(.leading, BezierFormConstant.labelAreaLeadingPadding)
    }
  }
}

// MARK: - Convenience init

extension SUBezierFormField where CustomContent == EmptyView {
  /// 커스텀 콘텐츠 슬롯 없이 만드는 편의 이니셜라이저.
  public init(
    labelPosition: BezierFormFieldLabelPosition = .top,
    labelText: String? = nil,
    description: String? = nil,
    isRequired: Bool = false,
    errorText: String? = nil,
    @ViewBuilder control: () -> Control
  ) {
    self.init(
      labelPosition: labelPosition,
      labelText: labelText,
      description: description,
      isRequired: isRequired,
      errorText: errorText,
      control: control,
      customContent: { EmptyView() }
    )
  }
}

struct SUBezierFormField_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      SUBezierForm {
        SUBezierFormField(
          labelText: "소개글",
          description: "프로필에 표시할 소개를 입력해요",
          isRequired: true,
          errorText: "소개글을 입력해주세요"
        ) {
          SUBezierTextInput(
            text: .constant(""),
            placeholder: "Placeholder",
            hasError: true
          )
        }

        SUBezierFormField(labelText: "Label") {
          SUBezierTextInput(text: .constant(""), placeholder: "placeholder")
        }

        SUBezierFormField(
          labelPosition: .left,
          labelText: "번역",
          description: "Description text",
          control: {
            SUBezierCheckbox(label: "사용")
          },
          customContent: {
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.red.opacity(0.1))
              .frame(height: 100)
          }
        )
      }
      .padding(16)
    }
  }
}
