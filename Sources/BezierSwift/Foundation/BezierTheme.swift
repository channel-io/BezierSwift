//
//  BezierTheme.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI

protocol BezierThemeCompatible {
  static var light: Self { get }
  static var dark: Self { get }
}

public enum BezierAppearance: BezierThemeCompatible {
  case light
  case dark
}

public enum BezierTheme: BezierThemeCompatible {
  case light
  case dark
  case system
  
  var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .light: return .light
    case .dark: return .dark
    case .system: return .unspecified
    }
  }
  
  public var appearance: BezierAppearance {
    switch self {
    case .light: return .light
    case .dark: return .dark
    case .system:
      switch UITraitCollection.current.userInterfaceStyle {
      case .light: return .light
      case .dark: return .dark
      default: return .light
      }
    }
  }
}
