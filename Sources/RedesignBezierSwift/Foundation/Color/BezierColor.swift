//
//  BezierColor.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI
import UIKit

public protocol BezierColorType {
  func color(for bezierTheme: BezierTheme) -> Color
  func uiColor(for bezierTheme: BezierTheme) -> UIColor
}

public struct BezierColor: BezierColorType {
  private let original: BezierColorType

  private init(functionalColorToken: FunctionalColorToken) {
    self.original = functionalColorToken
  }
  
  private init(semanticToken: SemanticColorToken) {
    self.original = semanticToken
  }
  
  public func color(for bezierTheme: BezierTheme) -> Color {
    return self.original.color(for: bezierTheme)
  }

  public func uiColor(for bezierTheme: BezierTheme) -> UIColor {
    return self.original.uiColor(for: bezierTheme)
  }
}

extension BezierColor {
  public static var bgRedNormal: BezierColor {
    BezierColor(functionalColorToken: .bgRedNormal)
  }

  public static var primary: BezierColor {
    BezierColor(semanticToken: .primary)
  }
}
