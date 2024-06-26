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

// MARK: - Themeable(SwiftUI)
public protocol Themeable {
  var colorScheme: ColorScheme { get }
}

extension Themeable {
  public func palette(_ bezierColor: BezierColor) -> Color {
    switch self.colorScheme {
    case .light: return bezierColor.color(for: .light)
    case .dark: return bezierColor.color(for: .dark)
    @unknown default: return bezierColor.color(for: .light)
    }
  }
}

// MARK: - UIThemeable(UIKit)
public protocol UIThemeable {
  var theme: BezierTheme { get }
}

extension UIView: UIThemeable {
  public var theme: BezierTheme {
    UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
  }
}
