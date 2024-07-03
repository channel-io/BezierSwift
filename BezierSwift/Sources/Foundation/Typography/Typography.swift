//
//  Typography.swift
//
//
//  Created by Tom on 12/20/23.
//

import SwiftUI

extension View {
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    bezierColor: BezierColor
  ) -> some View {
    self.modifier(BezierFontStyle(bezierFont: bezierFont, bezierColor: bezierColor))
  }
}

private struct BezierFontStyle: ViewModifier {
  private let bezierFont: BezierFont
  private let bezierColor: BezierColor
  
  init(bezierFont: BezierFont, bezierColor: BezierColor) {
    self.bezierFont = bezierFont
    self.bezierColor = bezierColor
  }
  
  func body(content: Content) -> some View {
    content
      .font(self.bezierFont.font)
      .foregroundColor(self.bezierColor.color)
  }
}
