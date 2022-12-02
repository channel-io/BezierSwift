//
//  Typography.swift
//
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

public extension Text {
  func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    textColor: SemanticColor = .txtBlackDarkest,
    truncationMode: TruncationMode? = nil
  ) -> some View {
    return self
      .font(bezierFont.font)
      .ifApply(truncationMode.isNotNil) {
        $0.truncationMode(truncationMode ?? .tail)
      }
      .frame(height: bezierFont.lineHeight)
  }
}
