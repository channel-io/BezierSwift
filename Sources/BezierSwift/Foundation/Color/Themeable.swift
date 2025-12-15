//
//  Themeable.swift
//  
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

public protocol Themeable {
  var colorScheme: ColorScheme { get }
}

extension Themeable {
  public func palette(_ semanticColor: SemanticColor, isInverted: Bool = false) -> Color {
    switch self.colorScheme {
    case .light: return isInverted ? semanticColor.dark.color : semanticColor.light.color
    case .dark: return isInverted ? semanticColor.light.color : semanticColor.dark.color
    @unknown default: return semanticColor.light.color
    }
  }
}
