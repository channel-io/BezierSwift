//
//  Typography.swift
//
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

extension View {
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    semanticColor: SemanticColor = .txtBlackDarkest
  ) -> some View {
    self.modifier(BezierFontStyle(bezierFont: bezierFont, semanticColor: semanticColor))
  }
}

private struct BezierFontStyle: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  let bezierFont: BezierFont
  let semanticColor: SemanticColor
  
  func body(content: Content) -> some View {
    content
      .font(bezierFont.font)
      .lineSpacing(bezierFont.lineSpacing)
      .padding(.vertical, bezierFont.verticalPadding)
      .foregroundColor(self.palette(self.semanticColor))
  }
}
