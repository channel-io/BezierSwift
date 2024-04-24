//
//  SemanticColorToken.swift
//
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

internal struct SemanticColorToken: BezierColorType {
  let functionalColorToken: FunctionalColorToken
  
  func color(for bezierTheme: BezierTheme) -> Color {
    return self.functionalColorToken.color(for: bezierTheme)
  }
  
  func uiColor(for bezierTheme: BezierTheme) -> UIColor {
    return self.functionalColorToken.uiColor(for: bezierTheme)
  }
}

// MARK: PrimaryBackground
extension SemanticColorToken {
  static var primaryBgNormal: Self = SemanticColorToken(functionalColorToken: .bgBlueNormal)
  static var primaryBgLight: Self = SemanticColorToken(functionalColorToken: .bgBlueLight)
  static var primaryBgLighter: Self = SemanticColorToken(functionalColorToken: .bgBlueLighter)
  static var primaryBgLightest: Self = SemanticColorToken(functionalColorToken: .bgBlueLightest)
  static var primaryBgDark: Self = SemanticColorToken(functionalColorToken: .bgBlueDark)
}

// MARK: PrimaryForeground
extension SemanticColorToken {
  static var primaryFgNormal: Self = SemanticColorToken(functionalColorToken: .fgBlueNormal)
  static var primaryFgLight: Self = SemanticColorToken(functionalColorToken: .fgBlueLight)
  static var primaryFgDark: Self = SemanticColorToken(functionalColorToken: .fgBlueDark)
}

// MARK: CriticalBackground
extension SemanticColorToken {
  static var criticalBgDark: Self = SemanticColorToken(functionalColorToken: .bgRedDark)
  static var criticalBgNormal: Self = SemanticColorToken(functionalColorToken: .bgRedNormal)
  static var criticalBgLight: Self = SemanticColorToken(functionalColorToken: .bgRedLight)
  static var criticalBgLighter: Self = SemanticColorToken(functionalColorToken: .bgRedLighter)
  static var criticalBgLightest: Self = SemanticColorToken(functionalColorToken: .bgRedLightest)
}

// MARK: CriticalForeground
extension SemanticColorToken {
  static var criticalFgNormal: Self = SemanticColorToken(functionalColorToken: .fgRedNormal)
  static var criticalFgLight: Self = SemanticColorToken(functionalColorToken: .fgRedLight)
  static var criticalFgDark: Self = SemanticColorToken(functionalColorToken: .fgRedDark)
}

// MARK: WarningBackground
extension SemanticColorToken {
  static var warningBgDark: Self = SemanticColorToken(functionalColorToken: .bgOrangeDark)
  static var warningBgNormal: Self = SemanticColorToken(functionalColorToken: .bgOrangeNormal)
  static var warningBgLight: Self = SemanticColorToken(functionalColorToken: .bgOrangeLight)
  static var warningBgLighter: Self = SemanticColorToken(functionalColorToken: .bgOrangeLighter)
  static var warningBgLightest: Self = SemanticColorToken(functionalColorToken: .bgOrangeLightest)
}

// MARK: WarningForeground
extension SemanticColorToken {
  static var warningFgNormal: Self = SemanticColorToken(functionalColorToken: .fgOrangeNormal)
  static var warningFgLight: Self = SemanticColorToken(functionalColorToken: .fgOrangeLight)
  static var warningFgDark: Self = SemanticColorToken(functionalColorToken: .fgOrangeDark)
}

// MARK: AccentBackground
extension SemanticColorToken {
  static var accentBgDark: Self = SemanticColorToken(functionalColorToken: .bgCobaltDark)
  static var accentBgNormal: Self = SemanticColorToken(functionalColorToken: .bgCobaltNormal)
  static var accentBgLight: Self = SemanticColorToken(functionalColorToken: .bgCobaltLight)
  static var accentBgLighter: Self = SemanticColorToken(functionalColorToken: .bgCobaltLighter)
  static var accentBgLightest: Self = SemanticColorToken(functionalColorToken: .bgCobaltLightest)
}

// MARK: AccentForeground
extension SemanticColorToken {
  static var accentFgNormal: Self = SemanticColorToken(functionalColorToken: .fgCobaltNormal)
  static var accentFgLight: Self = SemanticColorToken(functionalColorToken: .fgCobaltLight)
  static var accentFgDark: Self = SemanticColorToken(functionalColorToken: .fgCobaltDark)
}

// MARK: SuccessForeground
extension SemanticColorToken {
  static var successBgDark: Self = SemanticColorToken(functionalColorToken: .bgGreenDark)
  static var successBgNormal: Self = SemanticColorToken(functionalColorToken: .bgGreenNormal)
  static var successBgLight: Self = SemanticColorToken(functionalColorToken: .bgGreenLight)
  static var successBgLighter: Self = SemanticColorToken(functionalColorToken: .bgGreenLighter)
  static var successBgLightest: Self = SemanticColorToken(functionalColorToken: .bgGreenLightest)
}

// MARK: SuccessForeground
extension SemanticColorToken {
  static var successFgNormal: Self = SemanticColorToken(functionalColorToken: .fgGreenNormal)
  static var successFgLight: Self = SemanticColorToken(functionalColorToken: .fgGreenLight)
  static var successFgDark: Self = SemanticColorToken(functionalColorToken: .fgGreenDark)
}
