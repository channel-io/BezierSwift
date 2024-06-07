//
//  SemanticColorToken.swift
//
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

public struct SemanticColorToken: BezierColorType {
  let functionalColorToken: FunctionalColorToken
  
  public func color(for bezierTheme: BezierTheme) -> Color {
    return self.functionalColorToken.color(for: bezierTheme)
  }
  
  public func uiColor(for bezierTheme: BezierTheme) -> UIColor {
    return self.functionalColorToken.uiColor(for: bezierTheme)
  }
}

extension BezierColorType where Self == SemanticColorToken {
  // MARK: PrimaryBackground
  public static var primaryBgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgBlueNormal) }
  public static var primaryBgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgBlueLight) }
  public static var primaryBgLighter: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgBlueLighter) }
  public static var primaryBgLightest: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgBlueLightest) }
  public static var primaryBgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgBlueDark) }

  // MARK: PrimaryForeground
  public static var primaryFgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgBlueNormal) }
  public static var primaryFgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgBlueLight) }
  public static var primaryFgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgBlueDark) }

  // MARK: CriticalBackground
  public static var criticalBgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgRedDark) }
  public static var criticalBgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgRedNormal) }
  public static var criticalBgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgRedLight) }
  public static var criticalBgLighter: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgRedLighter) }
  public static var criticalBgLightest: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgRedLightest) }

  // MARK: CriticalForeground
  public static var criticalFgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgRedNormal) }
  public static var criticalFgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgRedLight) }
  public static var criticalFgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgRedDark) }

  // MARK: WarningBackground
  public static var warningBgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgOrangeDark) }
  public static var warningBgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgOrangeNormal) }
  public static var warningBgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgOrangeLight) }
  public static var warningBgLighter: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgOrangeLighter) }
  public static var warningBgLightest: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgOrangeLightest) }

  // MARK: WarningForeground
  public static var warningFgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgOrangeNormal) }
  public static var warningFgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgOrangeLight) }
  public static var warningFgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgOrangeDark) }

  // MARK: AccentBackground
  public static var accentBgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgCobaltDark) }
  public static var accentBgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgCobaltNormal) }
  public static var accentBgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgCobaltLight) }
  public static var accentBgLighter: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgCobaltLighter) }
  public static var accentBgLightest: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgCobaltLightest) }

  // MARK: AccentForeground
  public static var accentFgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgCobaltNormal) }
  public static var accentFgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgCobaltLight) }
  public static var accentFgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgCobaltDark) }

  // MARK: SuccessForeground
  public static var successBgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgGreenDark) }
  public static var successBgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgGreenNormal) }
  public static var successBgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgGreenLight) }
  public static var successBgLighter: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgGreenLighter) }
  public static var successBgLightest: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.bgGreenLightest) }

  // MARK: SuccessForeground
  public static var successFgNormal: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgGreenNormal) }
  public static var successFgLight: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgGreenLight) }
  public static var successFgDark: SemanticColorToken { SemanticColorToken(functionalColorToken: FunctionalColorToken.fgGreenDark) }
}
