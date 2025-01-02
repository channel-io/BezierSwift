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
  
  var lightColorToken: ColorTokenType {
    self.functionalColorToken.lightColorToken
  }
  
  var darkColorToken: ColorTokenType {
    self.functionalColorToken.darkColorToken
  }
  
  var pressedColorToken: ThemeableColorTokenType {
    self.functionalColorToken.pressedColorToken
  }
  
  init(functionalColorToken: FunctionalColorToken) {
    self.functionalColorToken = functionalColorToken
  }
}

// MARK: PrimaryBackground
extension SemanticColorToken {
  static let primaryBgNormal = SemanticColorToken(functionalColorToken: .bgBlueNormal)
  static let primaryBgLight = SemanticColorToken(functionalColorToken: .bgBlueLight)
  static let primaryBgLighter = SemanticColorToken(functionalColorToken: .bgBlueLighter)
  static let primaryBgLightest = SemanticColorToken(functionalColorToken: .bgBlueLightest)
  static let primaryBgDark = SemanticColorToken(functionalColorToken: .bgBlueDark)
  static let primaryBgTransparent = SemanticColorToken(functionalColorToken: .bgBlueTransparent)
}

// MARK: PrimaryForeground
extension SemanticColorToken {
  static let primaryFgNormal = SemanticColorToken(functionalColorToken: .fgBlueNormal)
  static let primaryFgLight = SemanticColorToken(functionalColorToken: .fgBlueLight)
  static let primaryFgDark = SemanticColorToken(functionalColorToken: .fgBlueDark)
}

// MARK: CriticalBackground
extension SemanticColorToken {
  static let criticalBgDark = SemanticColorToken(functionalColorToken: .bgRedDark)
  static let criticalBgNormal = SemanticColorToken(functionalColorToken: .bgRedNormal)
  static let criticalBgLight = SemanticColorToken(functionalColorToken: .bgRedLight)
  static let criticalBgLighter = SemanticColorToken(functionalColorToken: .bgRedLighter)
  static let criticalBgLightest = SemanticColorToken(functionalColorToken: .bgRedLightest)
  static let criticalBgTransparent = SemanticColorToken(functionalColorToken: .bgRedTransparent)
}

// MARK: CriticalForeground
extension SemanticColorToken {
  static let criticalFgNormal = SemanticColorToken(functionalColorToken: .fgRedNormal)
  static let criticalFgLight = SemanticColorToken(functionalColorToken: .fgRedLight)
  static let criticalFgDark = SemanticColorToken(functionalColorToken: .fgRedDark)
}

// MARK: WarningBackground
extension SemanticColorToken {
  static let warningBgDark = SemanticColorToken(functionalColorToken: .bgOrangeDark)
  static let warningBgNormal = SemanticColorToken(functionalColorToken: .bgOrangeNormal)
  static let warningBgLight = SemanticColorToken(functionalColorToken: .bgOrangeLight)
  static let warningBgLighter = SemanticColorToken(functionalColorToken: .bgOrangeLighter)
  static let warningBgLightest = SemanticColorToken(functionalColorToken: .bgOrangeLightest)
  static let warningBgTransparent = SemanticColorToken(functionalColorToken: .bgOrangeTransparent)
}

// MARK: WarningForeground
extension SemanticColorToken {
  static let warningFgNormal = SemanticColorToken(functionalColorToken: .fgOrangeNormal)
  static let warningFgLight = SemanticColorToken(functionalColorToken: .fgOrangeLight)
  static let warningFgDark = SemanticColorToken(functionalColorToken: .fgOrangeDark)
}

// MARK: AccentBackground
extension SemanticColorToken {
  static let accentBgDark = SemanticColorToken(functionalColorToken: .bgCobaltDark)
  static let accentBgNormal = SemanticColorToken(functionalColorToken: .bgCobaltNormal)
  static let accentBgLight = SemanticColorToken(functionalColorToken: .bgCobaltLight)
  static let accentBgLighter = SemanticColorToken(functionalColorToken: .bgCobaltLighter)
  static let accentBgLightest = SemanticColorToken(functionalColorToken: .bgCobaltLightest)
  static let accentBgTransparent = SemanticColorToken(functionalColorToken: .bgCobaltTransparent)
}

// MARK: AccentForeground
extension SemanticColorToken {
  static let accentFgNormal = SemanticColorToken(functionalColorToken: .fgCobaltNormal)
  static let accentFgLight = SemanticColorToken(functionalColorToken: .fgCobaltLight)
  static let accentFgDark = SemanticColorToken(functionalColorToken: .fgCobaltDark)
}

// MARK: SuccessForeground
extension SemanticColorToken {
  static let successBgDark = SemanticColorToken(functionalColorToken: .bgGreenDark)
  static let successBgNormal = SemanticColorToken(functionalColorToken: .bgGreenNormal)
  static let successBgLight = SemanticColorToken(functionalColorToken: .bgGreenLight)
  static let successBgLighter = SemanticColorToken(functionalColorToken: .bgGreenLighter)
  static let successBgLightest = SemanticColorToken(functionalColorToken: .bgGreenLightest)
  static let successBgTransparent = SemanticColorToken(functionalColorToken: .bgGreenTransparent)
}

// MARK: SuccessForeground
extension SemanticColorToken {
  static let successFgNormal = SemanticColorToken(functionalColorToken: .fgGreenNormal)
  static let successFgLight = SemanticColorToken(functionalColorToken: .fgGreenLight)
  static let successFgDark = SemanticColorToken(functionalColorToken: .fgGreenDark)
}
