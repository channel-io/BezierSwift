//
//  Typography.swift
//
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

public extension View {
  func applyBezierFontStyle(
    _ bezierFont: BezierFont
  ) -> some View {
    return self
      .font(bezierFont.font)
      .lineSpacing(bezierFont.lineSpacing)
      .padding(.vertical, bezierFont.verticalPadding)
  }
}
