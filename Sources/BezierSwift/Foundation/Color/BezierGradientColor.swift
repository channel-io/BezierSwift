//
//  BezierGradient.swift
//
//
//  Created by Tom on 9/16/24.
//

import SwiftUI
import UIKit

public enum BezierGradientColor {
  case fgGreen
  case fgBlack
  case bgPurple
  case bgOrange
  case bgGreen
  case bgBlue
  
  public var uiColors: [UIColor] {
    switch self {
    case .fgGreen:
      [UIColor(hex: GlobalColorToken.green400.hex), UIColor(hex: GlobalColorToken.green300.hex)]
    case .fgBlack:
      [BezierColor.fgBlackLightest.uiColor, BezierColor.fgBlackLight.uiColor]
    case .bgPurple:
      [UIColor(hex: GlobalColorToken.purple300.hex), UIColor(hex: GlobalColorToken.pink200.hex)]
    case .bgOrange:
      [UIColor(hex: GlobalColorToken.orange300.hex), UIColor(hex: GlobalColorToken.yellow200.hex)]
    case .bgGreen:
      [UIColor(hex: GlobalColorToken.green300.hex), UIColor(hex: GlobalColorToken.teal200.hex)]
    case .bgBlue:
      [UIColor(hex: GlobalColorToken.blue300.hex), UIColor(hex: GlobalColorToken.green200.hex)]
    }
  }
  
  public var colors: [Color] {
    self.uiColors.map { Color(uiColor: $0) }
  }
}
