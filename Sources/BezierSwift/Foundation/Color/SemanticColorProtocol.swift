//
//  SemanticColorProtocol.swift
//  BezierSwift
//
//  Created by 구본욱 on 12/10/25.
//

import UIKit
import SwiftUI

public protocol SemanticColorProtocol {
  var light: ColorComponentsWithAlpha { get }
  var dark: ColorComponentsWithAlpha { get }
  
  func palette(_ component: BezierComponentable) -> UIColor
}

extension SemanticColorProtocol {
  public func palette(_ component: BezierComponentable) -> UIColor {
    UIColor { [weak component] _ in
      let component = component ?? TempBezierComponent()
      let colorTheme = component.colorTheme
      let componentTheme = component.componentTheme
      switch componentTheme {
      case .normal:
        switch colorTheme {
        case .light:
          return self.light.uiColor
        case .dark:
          return self.dark.uiColor
        }
      case .inverted:
        switch colorTheme {
        case .light:
          return self.dark.uiColor
        case .dark:
          return self.light.uiColor
        }
      }
    }
  }
  
  public func palette(_ themeable: Themeable, isInverted: Bool = false) -> Color {
    switch themeable.colorScheme {
    case .light: return isInverted ? self.dark.color : self.light.color
    case .dark: return isInverted ? self.light.color : self.dark.color
    @unknown default: return self.light.color
    }
  }
}
