//
//  BezierGradient.swift
//
//
//  Created by Tom on 9/16/24.
//

import SwiftUI

public enum BezierGradient {
  case fgGreen
  case fgBlack
  case bgPurple
  case bgOrange
  case bgGreen
  case bgBlue
  
  private var gradient: Gradient {
    switch self {
    case .fgGreen:
      Gradient(colors: [Color(hex: GlobalColorToken.green400.hex), Color(hex: GlobalColorToken.green300.hex)])
    case .fgBlack: 
      Gradient(colors: [BezierColor.fgBlackLightest.color, BezierColor.fgBlackLight.color])
    case .bgPurple: 
      Gradient(colors: [Color(hex: GlobalColorToken.purple300.hex), Color(hex: GlobalColorToken.pink200.hex)])
    case .bgOrange: 
      Gradient(colors: [Color(hex: GlobalColorToken.orange300.hex), Color(hex: GlobalColorToken.yellow200.hex)])
    case .bgGreen:
      Gradient(colors: [Color(hex: GlobalColorToken.green300.hex), Color(hex: GlobalColorToken.teal200.hex)])
    case .bgBlue: 
      Gradient(colors: [Color(hex: GlobalColorToken.blue300.hex), Color(hex: GlobalColorToken.green200.hex)])
    }
  }
  
  public var leadingToTrailing: LinearGradient {
    LinearGradient(gradient: self.gradient, startPoint: .leading, endPoint: .trailing)
  }
  
  public var trailingToLeading: LinearGradient {
    LinearGradient(gradient: self.gradient, startPoint: .trailing, endPoint: .leading)
  }
  
  public var topToBottom: LinearGradient {
    LinearGradient(gradient: self.gradient, startPoint: .top, endPoint: .bottom)
  }
  
  public var bottomToTop: LinearGradient {
    LinearGradient(gradient: self.gradient, startPoint: .bottom, endPoint: .top)
  }
}
