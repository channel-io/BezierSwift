//
//  Typography.swift
//
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

extension BezierFont {
  public func attributedString(
    text: String,
    bezierColor: BezierColor = .fgBlackDarkest,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping,
    hasTagProperty: Bool = false
  ) -> NSAttributedString {
    guard !hasTagProperty else {
      return text.applyBezierTagFont(
        normalFont: self,
        normalColor: bezierColor,
        boldFont: self.getPairedBoldFont,
        boldColor: bezierColor,
        alignment: alignment,
        lineBreakMode: lineBreakMode
      )
    }
    
    return text.applyBezierFont(
      height: self.lineHeight,
      font: self.uiFont,
      color: bezierColor.uiColor,
      letterSpacing: self.letterSpacing,
      alignment: alignment,
      lineBreakMode: lineBreakMode
    )
  }
}

extension View {
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    bezierColor: BezierColor = .fgBlackDarkest
  ) -> some View {
    self
      .font(bezierFont.font)
      .lineSpacing(bezierFont.lineSpacing)
      .padding(.vertical, bezierFont.verticalPadding)
      .foregroundColor(bezierColor.color)
  }
}
