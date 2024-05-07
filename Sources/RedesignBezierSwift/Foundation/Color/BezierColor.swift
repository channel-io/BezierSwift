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

//MARK: - FunctionalColorToken
extension BezierColor {
  // MARK: ForegroundBlue
  public static var fgBlueNormal: BezierColor { BezierColor(functionalColorToken: .fgBlueNormal) }
  public static var fgBlueLight: BezierColor { BezierColor(functionalColorToken: .fgBlueLight) }
  public static var fgBlueDark: BezierColor { BezierColor(functionalColorToken: .fgBlueDark) }

  // MARK: ForegroundCobalt
  public static var fgCobaltNormal: BezierColor { BezierColor(functionalColorToken: .fgCobaltNormal) }
  public static var fgCobaltLight: BezierColor { BezierColor(functionalColorToken: .fgCobaltLight) }
  public static var fgCobaltDark: BezierColor { BezierColor(functionalColorToken: .fgCobaltDark) }

  // MARK: ForegroundRed
  public static var fgRedNormal: BezierColor { BezierColor(functionalColorToken: .fgRedNormal) }
  public static var fgRedLight: BezierColor { BezierColor(functionalColorToken: .fgRedLight) }
  public static var fgRedDark: BezierColor { BezierColor(functionalColorToken: .fgRedDark) }

  // MARK: ForegroundOrange
  public static var fgOrangeNormal: BezierColor { BezierColor(functionalColorToken: .fgOrangeNormal) }
  public static var fgOrangeLight: BezierColor { BezierColor(functionalColorToken: .fgOrangeLight) }
  public static var fgOrangeDark: BezierColor { BezierColor(functionalColorToken: .fgOrangeDark) }

  // MARK: ForegroundGreen
  public static var fgGreenNormal: BezierColor { BezierColor(functionalColorToken: .fgGreenNormal) }
  public static var fgGreenLight: BezierColor { BezierColor(functionalColorToken: .fgGreenLight) }
  public static var fgGreenDark: BezierColor { BezierColor(functionalColorToken: .fgGreenDark) }

  // MARK: ForegroundTeal
  public static var fgTealNormal: BezierColor { BezierColor(functionalColorToken: .fgTealNormal) }
  public static var fgTealLight: BezierColor { BezierColor(functionalColorToken: .fgTealLight) }
  public static var fgTealDark: BezierColor { BezierColor(functionalColorToken: .fgTealDark) }

  // MARK: ForegroundOlive
  public static var fgOliveNormal: BezierColor { BezierColor(functionalColorToken: .fgOliveNormal) }
  public static var fgOliveLight: BezierColor { BezierColor(functionalColorToken: .fgOliveLight) }
  public static var fgOliveDark: BezierColor { BezierColor(functionalColorToken: .fgOliveDark) }

  // MARK: ForegroundYellow
  public static var fgYellowNormal: BezierColor { BezierColor(functionalColorToken: .fgOliveNormal) }
  public static var fgYellowLight: BezierColor { BezierColor(functionalColorToken: .fgOliveLight) }
  public static var fgYellowDark: BezierColor { BezierColor(functionalColorToken: .fgOliveDark) }

  // MARK: ForegroundPink
  public static var fgPinkNormal: BezierColor { BezierColor(functionalColorToken: .fgPinkNormal) }
  public static var fgPinkLight: BezierColor { BezierColor(functionalColorToken: .fgPinkLight) }
  public static var fgPinkDark: BezierColor { BezierColor(functionalColorToken: .fgPinkDark) }

  // MARK: ForegroundPurple
  public static var fgPurpleNormal: BezierColor { BezierColor(functionalColorToken: .fgPurpleNormal) }
  public static var fgPurpleLight: BezierColor { BezierColor(functionalColorToken: .fgPurpleLight) }
  public static var fgPurpleDark: BezierColor { BezierColor(functionalColorToken: .fgPurpleDark) }

  // MARK: ForegroundNavy
  public static var fgNavyNormal: BezierColor { BezierColor(functionalColorToken: .fgNavyNormal) }
  public static var fgNavyLight: BezierColor { BezierColor(functionalColorToken: .fgNavyLight) }
  public static var fgNavyDark: BezierColor { BezierColor(functionalColorToken: .fgNavyDark) }

  // MARK: ForegroundGrey
  static var fgGreyDarkest: BezierColor { BezierColor(functionalColorToken: .fgGreyDarkest) }
  static var fgGreyDark: BezierColor { BezierColor(functionalColorToken: .fgGreyDark) }
  static var fgGreyNormal: BezierColor { BezierColor(functionalColorToken: .fgGreyNormal) }
  static var fgGreyLight: BezierColor { BezierColor(functionalColorToken: .fgGreyLight) }
  static var fgGreyLighter: BezierColor { BezierColor(functionalColorToken: .fgGreyLighter) }
  static var fgGreyLightest: BezierColor { BezierColor(functionalColorToken: .fgGreyLightest) }

  // MARK: ForegroundGreyAlpha
  static var fgGreyAlphaDarkest: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDarkest) }
  static var fgGreyAlphaDarker: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDarker) }
  static var fgGreyAlphaDark: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDark) }
  static var fgGreyAlphaLight: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaLight) }

  // MARK: ForegroundWhite
  static var fgWhiteNormal: BezierColor { BezierColor(functionalColorToken: .fgWhiteNormal) }

  // MARK: ForegroundBlack
  static var fgBlackLightest: BezierColor { BezierColor(functionalColorToken: .fgBlackLightest) }
  static var fgBlackLight: BezierColor { BezierColor(functionalColorToken: .fgBlackLight) }
  static var fgBlackDark: BezierColor { BezierColor(functionalColorToken: .fgBlackDark) }
  static var fgBlackDarker: BezierColor { BezierColor(functionalColorToken: .fgBlackDarker) }
  static var fgBlackDarkest: BezierColor { BezierColor(functionalColorToken: .fgBlackDarkest) }
  static var fgBlackPure: BezierColor { BezierColor(functionalColorToken: .fgBlackPure) }

  // MARK: ForegroundAbsoluteWhite
  static var fgAbsoluteWhiteLightest: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLightest) }
  static var fgAbsoluteWhiteLighter: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLighter) }
  static var fgAbsoluteWhiteLight: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLight) }
  static var fgAbsoluteWhiteNormal: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteNormal) }
  static var fgAbsoluteWhiteDark: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteDark) }

  // MARK: ForegroundAbsoluteBlack
  static var fgAbsoluteBlackLightest: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLightest) }
  static var fgAbsoluteBlackLighter: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLighter) }
  static var fgAbsoluteBlackLight: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLight) }
  static var fgAbsoluteBlackNormal: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackNormal) }
  static var fgAbsoluteBlackDark: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackDark) }

  // MARK: BackgroundBlue
  static var bgBlueNormal: BezierColor { BezierColor(functionalColorToken: .bgBlueNormal) }
  static var bgBlueLight: BezierColor { BezierColor(functionalColorToken: .bgBlueLight) }
  static var bgBlueLighter: BezierColor { BezierColor(functionalColorToken: .bgBlueLighter) }
  static var bgBlueLightest: BezierColor { BezierColor(functionalColorToken: .bgBlueLightest) }
  static var bgBlueDark: BezierColor { BezierColor(functionalColorToken: .bgBlueDark) }
  static var bgBlueShadeLight: BezierColor { BezierColor(functionalColorToken: .bgBlueShadeLight) }
  static var bgBlueShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgBlueShadeNormal) }

  // MARK: BackgroundCobalt
  static var bgCobaltNormal: BezierColor { BezierColor(functionalColorToken: .bgCobaltNormal) }
  static var bgCobaltLight: BezierColor { BezierColor(functionalColorToken: .bgCobaltLight) }
  static var bgCobaltLighter: BezierColor { BezierColor(functionalColorToken: .bgCobaltLighter) }
  static var bgCobaltLightest: BezierColor { BezierColor(functionalColorToken: .bgCobaltLightest) }
  static var bgCobaltDark: BezierColor { BezierColor(functionalColorToken: .bgCobaltDark) }
  static var bgCobaltShadeLight: BezierColor { BezierColor(functionalColorToken: .bgCobaltShadeLight) }
  static var bgCobaltShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgCobaltShadeNormal) }

  // MARK: BackgroundRed
  static var bgRedNormal: BezierColor { BezierColor(functionalColorToken: .bgRedNormal) }
  static var bgRedLight: BezierColor { BezierColor(functionalColorToken: .bgRedLight) }
  static var bgRedLighter: BezierColor { BezierColor(functionalColorToken: .bgRedLighter) }
  static var bgRedLightest: BezierColor { BezierColor(functionalColorToken: .bgRedLightest) }
  static var bgRedDark: BezierColor { BezierColor(functionalColorToken: .bgRedDark) }
  static var bgRedShadeLight: BezierColor { BezierColor(functionalColorToken: .bgRedShadeLight) }
  static var bgRedShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgRedShadeNormal) }

  // MARK: BackgroundOrange
  static var bgOrangeNormal: BezierColor { BezierColor(functionalColorToken: .bgOrangeNormal) }
  static var bgOrangeLight: BezierColor { BezierColor(functionalColorToken: .bgOrangeLight) }
  static var bgOrangeLighter: BezierColor { BezierColor(functionalColorToken: .bgOrangeLighter) }
  static var bgOrangeLightest: BezierColor { BezierColor(functionalColorToken: .bgOrangeLightest) }
  static var bgOrangeDark: BezierColor { BezierColor(functionalColorToken: .bgOrangeDark) }
  static var bgOrangeShadeLight: BezierColor { BezierColor(functionalColorToken: .bgOrangeShadeLight) }
  static var bgOrangeShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgOrangeShadeNormal) }

  // MARK: BackgroundGreen
  static var bgGreenNormal: BezierColor { BezierColor(functionalColorToken: .bgGreenNormal) }
  static var bgGreenLight: BezierColor { BezierColor(functionalColorToken: .bgGreenLight) }
  static var bgGreenLighter: BezierColor { BezierColor(functionalColorToken: .bgGreenLighter) }
  static var bgGreenLightest: BezierColor { BezierColor(functionalColorToken: .bgGreenLightest) }
  static var bgGreenDark: BezierColor { BezierColor(functionalColorToken: .bgGreenDark) }
  static var bgGreenShadeLight: BezierColor { BezierColor(functionalColorToken: .bgGreenShadeLight) }
  static var bgGreenShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgGreenShadeNormal) }

  // MARK: BackgroundTeal
  static var bgTealNormal: BezierColor { BezierColor(functionalColorToken: .bgTealNormal) }
  static var bgTealLight: BezierColor { BezierColor(functionalColorToken: .bgTealLight) }
  static var bgTealLighter: BezierColor { BezierColor(functionalColorToken: .bgTealLighter) }
  static var bgTealLightest: BezierColor { BezierColor(functionalColorToken: .bgTealLightest) }
  static var bgTealDark: BezierColor { BezierColor(functionalColorToken: .bgTealDark) }
  static var bgTealShadeLight: BezierColor { BezierColor(functionalColorToken: .bgTealShadeLight) }
  static var bgTealShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgTealShadeNormal) }

  // MARK: BackgroundOlive
  static var bgOliveNormal: BezierColor { BezierColor(functionalColorToken: .bgOliveNormal) }
  static var bgOliveLight: BezierColor { BezierColor(functionalColorToken: .bgOliveLight) }
  static var bgOliveLighter: BezierColor { BezierColor(functionalColorToken: .bgOliveLighter) }
  static var bgOliveLightest: BezierColor { BezierColor(functionalColorToken: .bgOliveLightest) }
  static var bgOliveDark: BezierColor { BezierColor(functionalColorToken: .bgOliveDark) }
  static var bgOliveShadeLight: BezierColor { BezierColor(functionalColorToken: .bgOliveShadeLight) }
  static var bgOliveShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgOliveShadeNormal) }

  // MARK: BackgroundYellow
  static var bgYellowNormal: BezierColor { BezierColor(functionalColorToken: .bgYellowNormal) }
  static var bgYellowLight: BezierColor { BezierColor(functionalColorToken: .bgYellowLight) }
  static var bgYellowLighter: BezierColor { BezierColor(functionalColorToken: .bgYellowLighter) }
  static var bgYellowLightest: BezierColor { BezierColor(functionalColorToken: .bgYellowLightest) }
  static var bgYellowDark: BezierColor { BezierColor(functionalColorToken: .bgYellowDark) }
  static var bgYellowShadeLight: BezierColor { BezierColor(functionalColorToken: .bgYellowShadeLight) }
  static var bgYellowShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgYellowShadeNormal) }

  // MARK: BackgroundPink
  static var bgPinkNormal: BezierColor { BezierColor(functionalColorToken: .bgPinkNormal) }
  static var bgPinkLight: BezierColor { BezierColor(functionalColorToken: .bgPinkLight) }
  static var bgPinkLighter: BezierColor { BezierColor(functionalColorToken: .bgPinkLighter) }
  static var bgPinkLightest: BezierColor { BezierColor(functionalColorToken: .bgPinkLightest) }
  static var bgPinkDark: BezierColor { BezierColor(functionalColorToken: .bgPinkDark) }
  static var bgPinkShadeLight: BezierColor { BezierColor(functionalColorToken: .bgPinkShadeLight) }
  static var bgPinkShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgPinkShadeNormal) }

  // MARK: BackgroundPurple
  static var bgPurpleNormal: BezierColor { BezierColor(functionalColorToken: .bgPurpleNormal) }
  static var bgPurpleLight: BezierColor { BezierColor(functionalColorToken: .bgPurpleLight) }
  static var bgPurpleLighter: BezierColor { BezierColor(functionalColorToken: .bgPurpleLighter) }
  static var bgPurpleLightest: BezierColor { BezierColor(functionalColorToken: .bgPurpleLightest) }
  static var bgPurpleDark: BezierColor { BezierColor(functionalColorToken: .bgPurpleDark) }
  static var bgPurpleShadeLight: BezierColor { BezierColor(functionalColorToken: .bgPurpleShadeLight) }
  static var bgPurpleShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgPurpleShadeNormal) }

  // MARK: - BackgroundNavy
  static var bgNavyNormal: BezierColor { BezierColor(functionalColorToken: .bgNavyNormal) }
  static var bgNavyLight: BezierColor { BezierColor(functionalColorToken: .bgNavyLight) }
  static var bgNavyLighter: BezierColor { BezierColor(functionalColorToken: .bgNavyLighter) }
  static var bgNavyLightest: BezierColor { BezierColor(functionalColorToken: .bgNavyLightest) }
  static var bgNavyDark: BezierColor { BezierColor(functionalColorToken: .bgNavyDark) }
  static var bgNavyShadeLight: BezierColor { BezierColor(functionalColorToken: .bgNavyShadeLight) }
  static var bgNavyShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgNavyShadeNormal) }

  // MARK: BackgroundGrey
  static var bgGreyDarkest: BezierColor { BezierColor(functionalColorToken: .bgGreyDarkest) }
  static var bgGreyDark: BezierColor { BezierColor(functionalColorToken: .bgGreyDark) }
  static var bgGreyNormal: BezierColor { BezierColor(functionalColorToken: .bgGreyNormal) }
  static var bgGreyLight: BezierColor { BezierColor(functionalColorToken: .bgGreyLight) }
  static var bgGreyLighter: BezierColor { BezierColor(functionalColorToken: .bgGreyLighter) }
  static var bgGreyLightest: BezierColor { BezierColor(functionalColorToken: .bgGreyLightest) }

  // MARK: BackgroundGreyAlpha
  static var bgGreyAlphaDarkest: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDarkest) }
  static var bgGreyAlphaDarker: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDarker) }
  static var bgGreyAlphaDark: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDark) }
  static var bgGreyAlphaLight: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaLight) }

  // MARK: BackgroundBlack
  static var bgBlackDarkest: BezierColor { BezierColor(functionalColorToken: .bgBlackDarkest) }
  static var bgBlackDarker: BezierColor { BezierColor(functionalColorToken: .bgBlackDarker) }
  static var bgBlackDark: BezierColor { BezierColor(functionalColorToken: .bgBlackDark) }
  static var bgBlackLight: BezierColor { BezierColor(functionalColorToken: .bgBlackLight) }
  static var bgBlackLighter: BezierColor { BezierColor(functionalColorToken: .bgBlackLighter) }
  static var bgBlackLightest: BezierColor { BezierColor(functionalColorToken: .bgBlackLightest) }

  // MARK: BackgroundWhite
  static var bgWhiteHighest: BezierColor { BezierColor(functionalColorToken: .bgWhiteHighest) }
  static var bgWhiteHigher: BezierColor { BezierColor(functionalColorToken: .bgWhiteHigher) }
  static var bgWhiteNormal: BezierColor { BezierColor(functionalColorToken: .bgWhiteNormal) }

  // MARK: BackgroundWhiteAlpha
  static var bgWhiteAlphaLightest: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLightest) }
  static var bgWhiteAlphaLighter: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLighter) }
  static var bgWhiteAlphaLight: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLight) }

  // MARK: BackgroundAbsoluteBlack
  static var bgAbsoluteBlackDark: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackDark) }
  static var bgAbsoluteBlackNormal: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackNormal) }
  static var bgAbsoluteBlackLight: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLight) }
  static var bgAbsoluteBlackLighter: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLighter) }
  static var bgAbsoluteBlackLightest: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLightest) }

  // MARK: BackgroundAbsoluteWhite
  static var bgAbsoluteWhiteDark: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteDark) }
  static var bgAbsoluteWhiteNormal: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteNormal) }
  static var bgAbsoluteWhiteLight: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLight) }
  static var bgAbsoluteWhiteLighter: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLighter) }
  static var bgAbsoluteWhiteLightest: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLightest) }

  // MARK: Surface
  static var surfaceLowest: BezierColor { BezierColor(functionalColorToken: .surfaceLowest) }
  static var surfaceLower: BezierColor { BezierColor(functionalColorToken: .surfaceLower) }
  static var surfaceNormal: BezierColor { BezierColor(functionalColorToken: .surfaceNormal) }

  // MARK: Shadow
  static var shadowXlarge: BezierColor { BezierColor(functionalColorToken: .shadowXlarge) }
  static var shadowLarge: BezierColor { BezierColor(functionalColorToken: .shadowLarge) }
  static var shadowMedium: BezierColor { BezierColor(functionalColorToken: .shadowMedium) }
  static var shadowSmall: BezierColor { BezierColor(functionalColorToken: .shadowSmall) }
  static var shadowBase: BezierColor { BezierColor(functionalColorToken: .shadowBase) }
  static var shadowBaseInner: BezierColor { BezierColor(functionalColorToken: .shadowBaseInner) }
}

//MARK: - SemanticColorToken
extension BezierColor {
  // MARK: PrimaryBackground
  static var primaryBgNormal: BezierColor { BezierColor(semanticToken: .primaryBgNormal) }
  static var primaryBgLight: BezierColor { BezierColor(semanticToken: .primaryBgLight) }
  static var primaryBgLighter: BezierColor { BezierColor(semanticToken: .primaryBgLighter) }
  static var primaryBgLightest: BezierColor { BezierColor(semanticToken: .primaryBgLightest) }
  static var primaryBgDark: BezierColor { BezierColor(semanticToken: .primaryBgDark) }

  // MARK: PrimaryForeground
  static var primaryFgNormal: BezierColor { BezierColor(semanticToken: .primaryFgNormal) }
  static var primaryFgLight: BezierColor { BezierColor(semanticToken: .primaryFgLight) }
  static var primaryFgDark: BezierColor { BezierColor(semanticToken: .primaryFgDark) }

  // MARK: CriticalBackground
  static var criticalBgDark: BezierColor { BezierColor(semanticToken: .criticalBgDark) }
  static var criticalBgNormal: BezierColor { BezierColor(semanticToken: .criticalBgNormal) }
  static var criticalBgLight: BezierColor { BezierColor(semanticToken: .criticalBgLight) }
  static var criticalBgLighter: BezierColor { BezierColor(semanticToken: .criticalBgLighter) }
  static var criticalBgLightest: BezierColor { BezierColor(semanticToken: .criticalBgLightest) }

  // MARK: CriticalForeground
  static var criticalFgNormal: BezierColor { BezierColor(semanticToken: .criticalFgNormal) }
  static var criticalFgLight: BezierColor { BezierColor(semanticToken: .criticalFgLight) }
  static var criticalFgDark: BezierColor { BezierColor(semanticToken: .criticalFgDark) }

  // MARK: WarningBackground
  static var warningBgDark: BezierColor { BezierColor(semanticToken: .warningBgDark) }
  static var warningBgNormal: BezierColor { BezierColor(semanticToken: .warningBgNormal) }
  static var warningBgLight: BezierColor { BezierColor(semanticToken: .warningBgLight) }
  static var warningBgLighter: BezierColor { BezierColor(semanticToken: .warningBgLighter) }
  static var warningBgLightest: BezierColor { BezierColor(semanticToken: .warningBgLightest) }

  // MARK: WarningForeground
  static var warningFgNormal: BezierColor { BezierColor(semanticToken: .warningFgNormal) }
  static var warningFgLight: BezierColor { BezierColor(semanticToken: .warningFgLight) }
  static var warningFgDark: BezierColor { BezierColor(semanticToken: .warningFgDark) }

  // MARK: AccentBackground
  static var accentBgDark: BezierColor { BezierColor(semanticToken: .accentBgDark) }
  static var accentBgNormal: BezierColor { BezierColor(semanticToken: .accentBgNormal) }
  static var accentBgLight: BezierColor { BezierColor(semanticToken: .accentBgLight) }
  static var accentBgLighter: BezierColor { BezierColor(semanticToken: .accentBgLighter) }
  static var accentBgLightest: BezierColor { BezierColor(semanticToken: .accentBgLightest) }

  // MARK: AccentForeground
  static var accentFgNormal: BezierColor { BezierColor(semanticToken: .accentFgNormal) }
  static var accentFgLight: BezierColor { BezierColor(semanticToken: .accentFgLight) }
  static var accentFgDark: BezierColor { BezierColor(semanticToken: .accentFgDark) }

  // MARK: SuccessForeground
  static var successBgDark: BezierColor { BezierColor(semanticToken: .successBgDark) }
  static var successBgNormal: BezierColor { BezierColor(semanticToken: .successBgNormal) }
  static var successBgLight: BezierColor { BezierColor(semanticToken: .successBgLight) }
  static var successBgLighter: BezierColor { BezierColor(semanticToken: .successBgLighter) }
  static var successBgLightest: BezierColor { BezierColor(semanticToken: .successBgLightest) }

  // MARK: SuccessForeground
  static var successFgNormal: BezierColor { BezierColor(semanticToken: .successFgNormal) }
  static var successFgLight: BezierColor { BezierColor(semanticToken: .successFgLight) }
  static var successFgDark: BezierColor { BezierColor(semanticToken: .successFgDark) }
}
