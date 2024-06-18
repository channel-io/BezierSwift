//
//  BezierButtonConfiguration.swift
//
//
//  Created by 구본욱 on 6/18/24.
//

import Foundation

public struct BezierButtonConfiguration {
  private(set) var text: String
  private(set) var variant: BezierButtonVariant
  private(set) var color: BezierButtonColor
  private(set) var size: BezierButtonSize
  private(set) var prefixContent: BezierButtonPrefix?
  private(set) var suffixContent: BezierButtonSuffix?

  public init(
    text: String,
    variant: BezierButtonVariant,
    color: BezierButtonColor, 
    size: BezierButtonSize,
    prefixContent: BezierButtonPrefix? = nil,
    suffixContent: BezierButtonSuffix? = nil
  ) {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
  }
}

extension BezierButtonConfiguration {
  var showPrefixContent: Bool { self.prefixContent != nil }
  var showSuffixContent: Bool { self.suffixContent != nil }

  var backgroundColor: BezierColor { self.variant.backgroundColor(with: self.color) }
  var textColor: BezierColor { self.variant.textColor(with: self.color) }
  var affixContentColor: BezierColor { self.variant.affixColor(with: self.color) }

  var font: BezierFont { self.size.font }
  var radius: CGFloat { self.size.radius }

  var horizontalPadding: CGFloat { self.size.horizontalPadding }
  var verticalPadding: CGFloat { self.size.verticalPadding }
  var textHorizontalPadding: CGFloat { self.size.textHorizontalPadding }
  var textVerticalPadding: CGFloat { self.size.textVerticalPadding }
  var affixSize: CGSize { self.size.affixSize }
}
