//
//  Typography.swift
//
//
//  Created by Tom on 12/20/23.
//

import SwiftUI

extension View {
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont
  ) -> some View {
    self.modifier(BezierFontStyle(bezierFont: bezierFont))
  }
}

private struct BezierFontStyle: ViewModifier {
  let bezierFont: BezierFont
  
  func body(content: Content) -> some View {
    content
      .font(self.bezierFont.font)
  }
}
