//
//  Typography.swift
//
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

extension BezierFont {
  public func attributedString(
    _ component: BezierComponentable,
    text: String,
    semanticColor: SemanticColor = .txtBlackDarkest,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping,
    hasTagProperty: Bool = false
  ) -> NSAttributedString {
    let color = semanticColor.palette(component)
    
    guard !hasTagProperty else {
      return text.applyBezierTagFont(
        component,
        normalFont: self,
        normalColor: semanticColor,
        boldFont: self.getPairedBoldFont,
        boldColor: semanticColor,
        alignment: alignment,
        lineBreakMode: lineBreakMode
      )
    }
    
    return text.applyBezierFont(
      height: self.lineHeight,
      font: self.uiFont,
      color: color,
      letterSpacing: self.letterSpacing,
      alignment: alignment,
      lineBreakMode: lineBreakMode
    )
  }
}

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

