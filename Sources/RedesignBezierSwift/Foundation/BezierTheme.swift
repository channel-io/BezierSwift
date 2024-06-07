//
//  BezierTheme.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI

public enum BezierTheme {
  case light
  case dark
}

public protocol Themeable {
  var colorScheme: ColorScheme { get }
}

extension Themeable {
  public func palette(_ bezierColor: BezierColorType) -> Color {
    switch self.colorScheme {
    case .light: return bezierColor.color(for: .light)
    case .dark: return bezierColor.color(for: .dark)
    @unknown default: return bezierColor.color(for: .light)
    }
  }
}
