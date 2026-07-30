//
//  SUBezierFormFieldErrorMessage.swift
//  BezierSwift
//

import SwiftUI

/// FormField 하단에 붙는 에러 메시지 행 (SwiftUI, internal). `SUBezierFormField`의 `errorText`가 설정될 때만 표시되며 단독 사용하지 않는다.
struct SUBezierFormFieldErrorMessage: View, Themeable {
  @Environment(\.colorScheme) var colorScheme

  private let text: String

  init(_ text: String) {
    self.text = text
  }

  var body: some View {
    HStack(alignment: .top, spacing: BezierFormConstant.errorMessageSpacing) {
      BezierFormConstant.errorIcon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(
          width: BezierFormConstant.errorIconLength,
          height: BezierFormConstant.errorIconLength
        )
        .foregroundColor(self.palette(BezierFormConstant.errorMessageIconColor))
        .frame(height: BezierFormConstant.errorIconBoxHeight)

      Text(self.text)
        .applyBezierFontStyle(
          BezierFormConstant.errorMessageTypography,
          semanticColorToken: BezierFormConstant.errorMessageTextColor
        )
        .fixedSize(horizontal: false, vertical: true)
    }
    .padding(.leading, BezierFormConstant.errorMessageLeadingPadding)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
