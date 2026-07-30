//
//  BCSemanticToken+PressedColor.swift
//  BezierSwift
//
//  Created by 구본욱 on 7/30/26.
//

import Foundation

extension BCSemanticToken {
  public var pressedColor: BCSemanticToken {
    return .custom(
      light: ColorUtils.getPressedColor(originalColor: self.light, colorTheme: .light),
      dark: ColorUtils.getPressedColor(originalColor: self.dark, colorTheme: .dark)
    )
  }
}
