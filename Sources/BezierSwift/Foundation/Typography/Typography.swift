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
    semanticColor: SemanticColor,
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
  
  public func attributedString(
    _ component: BezierComponentable,
    text: String,
    semanticColorToken: BCSemanticToken = .textNeutral,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping,
    hasTagProperty: Bool = false
  ) -> NSAttributedString {
    let color = semanticColorToken.palette(component)
    
    guard !hasTagProperty else {
      return text.applyBezierTagFont(
        component,
        normalFont: self,
        normalColor: semanticColorToken,
        boldFont: self.getPairedBoldFont,
        boldColor: semanticColorToken,
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
    semanticColor: SemanticColor
  ) -> some View {
    self.applyBezierFontStyle(bezierFont, semanticColor)
  }
  
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    semanticColorToken: BCSemanticToken
  ) -> some View {
    self.applyBezierFontStyle(bezierFont, semanticColorToken)
  }
  
  public func applyBezierFontStyle(
    _ bezierFont: BezierFont,
    _ semanticColor: SemanticColorProtocol = BCSemanticToken.textNeutral
  ) -> some View {
    self.modifier(BezierFontStyle(bezierFont: bezierFont, semanticColor: semanticColor))
  }
}

private struct BezierFontStyle: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let bezierFont: BezierFont
  let semanticColor: SemanticColorProtocol

  func body(content: Content) -> some View {
    content
      .font(bezierFont.font)
      .lineSpacing(bezierFont.lineSpacing)
      .padding(.vertical, bezierFont.verticalPadding)
      .foregroundColor(self.palette(self.semanticColor))
  }
}

// MARK: - V3 Typography Token Support

extension View {
  public func applyBezierFontStyle(
    _ token: BTSemanticToken,
    semanticColorToken: BCSemanticToken = .textNeutral
  ) -> some View {
    self.modifier(BezierTypographyStyle(token: token, semanticColor: semanticColorToken))
  }

  public func applyBezierFontStyle(
    _ token: BTSemanticToken,
    semanticColor: SemanticColor
  ) -> some View {
    self.modifier(BezierTypographyStyle(token: token, semanticColor: semanticColor))
  }

  public func applyBezierFontStyle(
    _ token: BTSemanticToken,
    _ semanticColor: SemanticColorProtocol = BCSemanticToken.textNeutral
  ) -> some View {
    self.modifier(BezierTypographyStyle(token: token, semanticColor: semanticColor))
  }
}

private struct BezierTypographyStyle: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let token: BTSemanticToken
  let semanticColor: SemanticColorProtocol

  private let resolvedFont: Font
  private let resolvedLineSpacing: CGFloat
  private let resolvedVerticalPadding: CGFloat
  private let resolvedLetterSpacing: CGFloat

  init(token: BTSemanticToken, semanticColor: SemanticColorProtocol) {
    self.token = token
    self.semanticColor = semanticColor
    self.resolvedFont = token.font
    self.resolvedLineSpacing = token.lineSpacing
    self.resolvedVerticalPadding = token.verticalPadding
    self.resolvedLetterSpacing = token.letterSpacing
  }

  func body(content: Content) -> some View {
    content
      .font(resolvedFont)
      .lineSpacing(resolvedLineSpacing)
      .padding(.vertical, resolvedVerticalPadding)
      .bezierLetterSpacing(resolvedLetterSpacing)
      .foregroundColor(self.palette(self.semanticColor))
  }
}

private extension View {
  @ViewBuilder
  func bezierLetterSpacing(_ spacing: CGFloat) -> some View {
    if #available(iOS 16.0, *) {
      self.tracking(spacing)
    } else {
      self
    }
  }
}

// MARK: - V3 Typography UIKit Support

extension BTSemanticToken {
  public func attributedString(
    _ component: BezierComponentable,
    text: String,
    semanticColorToken: BCSemanticToken = .textNeutral,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSAttributedString {
    let color = semanticColorToken.palette(component)

    return text.applyBezierFont(
      height: self.lineHeight,
      font: self.uiFont,
      color: color,
      letterSpacing: self.letterSpacing,
      alignment: alignment,
      lineBreakMode: lineBreakMode
    )
  }

  public func attributedString(
    _ component: BezierComponentable,
    text: String,
    semanticColor: SemanticColor,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSAttributedString {
    let color = semanticColor.palette(component)

    return text.applyBezierFont(
      height: self.lineHeight,
      font: self.uiFont,
      color: color,
      letterSpacing: self.letterSpacing,
      alignment: alignment,
      lineBreakMode: lineBreakMode
    )
  }

  public func attributes(
    _ component: BezierComponentable,
    semanticColorToken: BCSemanticToken = .textNeutral,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> [NSAttributedString.Key: Any] {
    let font = self.uiFont
    let paragraphStyle = self.makeParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode)
    let baselineOffset = (paragraphStyle.minimumLineHeight - font.lineHeight) / 4

    return [
      .foregroundColor: semanticColorToken.palette(component),
      .font: font,
      .kern: self.letterSpacing,
      .paragraphStyle: paragraphStyle,
      .baselineOffset: baselineOffset,
    ]
  }

  public func sizeAttributes(
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> [NSAttributedString.Key: Any] {
    let font = self.uiFont
    let paragraphStyle = self.makeParagraphStyle(alignment: alignment, lineBreakMode: lineBreakMode)
    let baselineOffset = (paragraphStyle.minimumLineHeight - font.lineHeight) / 4

    return [
      .font: font,
      .kern: self.letterSpacing,
      .paragraphStyle: paragraphStyle,
      .baselineOffset: baselineOffset,
    ]
  }

  func makeParagraphStyle(
    alignment: NSTextAlignment,
    lineBreakMode: NSLineBreakMode
  ) -> NSMutableParagraphStyle {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = lineBreakMode
    paragraphStyle.alignment = alignment
    paragraphStyle.minimumLineHeight = self.lineHeight

    if lineBreakMode == .byWordWrapping {
      paragraphStyle.lineBreakStrategy = .hangulWordPriority
    }

    return paragraphStyle
  }
}
