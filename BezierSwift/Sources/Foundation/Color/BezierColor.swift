//
//  BezierColor.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI
import UIKit

public protocol ColorToken {
  /// 색상을 나타내는 HEX 문자열 (예: "#FFFFFF", "#FFFFFFFF").
  var hex: String { get }
}

public protocol BezierColorType {
  var lightColorToken: ColorToken { get }
  var darkColorToken: ColorToken { get }
}

public struct BezierColor {
  private let original: BezierColorType
  
  public init(bezierColor: BezierColorType) {
    self.original = bezierColor
  }
  
  private init(functionalColorToken: FunctionalColorToken) {
    self.original = functionalColorToken
  }
  
  private init(semanticToken: SemanticColorToken) {
    self.original = semanticToken
  }
  
  public var color: Color {
    return Color(self.uiColor)
  }
  
  public var uiColor: UIColor {
    return UIColor { traitCollection in
      switch BezierSwift.shared.currentTheme {
      case .system:
        switch traitCollection.userInterfaceStyle {
        case .light:
          return UIColor(hex: self.original.lightColorToken.hex)
        case .dark:
          return UIColor(hex: self.original.darkColorToken.hex)
        default:
          return UIColor(hex: self.original.lightColorToken.hex)
        }
      case .light:
        return UIColor(hex: self.original.lightColorToken.hex)
      case .dark:
        return UIColor(hex: self.original.darkColorToken.hex)
      }
    }
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
  public static var fgGreyDarkest: BezierColor { BezierColor(functionalColorToken: .fgGreyDarkest) }
  public static var fgGreyDark: BezierColor { BezierColor(functionalColorToken: .fgGreyDark) }
  public static var fgGreyNormal: BezierColor { BezierColor(functionalColorToken: .fgGreyNormal) }
  public static var fgGreyLight: BezierColor { BezierColor(functionalColorToken: .fgGreyLight) }
  public static var fgGreyLighter: BezierColor { BezierColor(functionalColorToken: .fgGreyLighter) }
  public static var fgGreyLightest: BezierColor { BezierColor(functionalColorToken: .fgGreyLightest) }

  // MARK: ForegroundGreyAlpha
  public static var fgGreyAlphaDarkest: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDarkest) }
  public static var fgGreyAlphaDarker: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDarker) }
  public static var fgGreyAlphaDark: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaDark) }
  public static var fgGreyAlphaLight: BezierColor { BezierColor(functionalColorToken: .fgGreyAlphaLight) }

  // MARK: ForegroundWhite
  public static var fgWhiteNormal: BezierColor { BezierColor(functionalColorToken: .fgWhiteNormal) }

  // MARK: ForegroundBlack
  public static var fgBlackLightest: BezierColor { BezierColor(functionalColorToken: .fgBlackLightest) }
  public static var fgBlackLight: BezierColor { BezierColor(functionalColorToken: .fgBlackLight) }
  public static var fgBlackDark: BezierColor { BezierColor(functionalColorToken: .fgBlackDark) }
  public static var fgBlackDarker: BezierColor { BezierColor(functionalColorToken: .fgBlackDarker) }
  public static var fgBlackDarkest: BezierColor { BezierColor(functionalColorToken: .fgBlackDarkest) }
  public static var fgBlackPure: BezierColor { BezierColor(functionalColorToken: .fgBlackPure) }

  // MARK: ForegroundAbsoluteWhite
  public static var fgAbsoluteWhiteLightest: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLightest) }
  public static var fgAbsoluteWhiteLighter: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLighter) }
  public static var fgAbsoluteWhiteLight: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteLight) }
  public static var fgAbsoluteWhiteNormal: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteNormal) }
  public static var fgAbsoluteWhiteDark: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteWhiteDark) }

  // MARK: ForegroundAbsoluteBlack
  public static var fgAbsoluteBlackLightest: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLightest) }
  public static var fgAbsoluteBlackLighter: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLighter) }
  public static var fgAbsoluteBlackLight: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackLight) }
  public static var fgAbsoluteBlackNormal: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackNormal) }
  public static var fgAbsoluteBlackDark: BezierColor { BezierColor(functionalColorToken: .fgAbsoluteBlackDark) }

  // MARK: BackgroundBlue
  public static var bgBlueNormal: BezierColor { BezierColor(functionalColorToken: .bgBlueNormal) }
  public static var bgBlueLight: BezierColor { BezierColor(functionalColorToken: .bgBlueLight) }
  public static var bgBlueLighter: BezierColor { BezierColor(functionalColorToken: .bgBlueLighter) }
  public static var bgBlueLightest: BezierColor { BezierColor(functionalColorToken: .bgBlueLightest) }
  public static var bgBlueDark: BezierColor { BezierColor(functionalColorToken: .bgBlueDark) }
  public static var bgBlueShadeLight: BezierColor { BezierColor(functionalColorToken: .bgBlueShadeLight) }
  public static var bgBlueShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgBlueShadeNormal) }

  // MARK: BackgroundCobalt
  public static var bgCobaltNormal: BezierColor { BezierColor(functionalColorToken: .bgCobaltNormal) }
  public static var bgCobaltLight: BezierColor { BezierColor(functionalColorToken: .bgCobaltLight) }
  public static var bgCobaltLighter: BezierColor { BezierColor(functionalColorToken: .bgCobaltLighter) }
  public static var bgCobaltLightest: BezierColor { BezierColor(functionalColorToken: .bgCobaltLightest) }
  public static var bgCobaltDark: BezierColor { BezierColor(functionalColorToken: .bgCobaltDark) }
  public static var bgCobaltShadeLight: BezierColor { BezierColor(functionalColorToken: .bgCobaltShadeLight) }
  public static var bgCobaltShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgCobaltShadeNormal) }

  // MARK: BackgroundRed
  public static var bgRedNormal: BezierColor { BezierColor(functionalColorToken: .bgRedNormal) }
  public static var bgRedLight: BezierColor { BezierColor(functionalColorToken: .bgRedLight) }
  public static var bgRedLighter: BezierColor { BezierColor(functionalColorToken: .bgRedLighter) }
  public static var bgRedLightest: BezierColor { BezierColor(functionalColorToken: .bgRedLightest) }
  public static var bgRedDark: BezierColor { BezierColor(functionalColorToken: .bgRedDark) }
  public static var bgRedShadeLight: BezierColor { BezierColor(functionalColorToken: .bgRedShadeLight) }
  public static var bgRedShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgRedShadeNormal) }

  // MARK: BackgroundOrange
  public static var bgOrangeNormal: BezierColor { BezierColor(functionalColorToken: .bgOrangeNormal) }
  public static var bgOrangeLight: BezierColor { BezierColor(functionalColorToken: .bgOrangeLight) }
  public static var bgOrangeLighter: BezierColor { BezierColor(functionalColorToken: .bgOrangeLighter) }
  public static var bgOrangeLightest: BezierColor { BezierColor(functionalColorToken: .bgOrangeLightest) }
  public static var bgOrangeDark: BezierColor { BezierColor(functionalColorToken: .bgOrangeDark) }
  public static var bgOrangeShadeLight: BezierColor { BezierColor(functionalColorToken: .bgOrangeShadeLight) }
  public static var bgOrangeShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgOrangeShadeNormal) }

  // MARK: BackgroundGreen
  public static var bgGreenNormal: BezierColor { BezierColor(functionalColorToken: .bgGreenNormal) }
  public static var bgGreenLight: BezierColor { BezierColor(functionalColorToken: .bgGreenLight) }
  public static var bgGreenLighter: BezierColor { BezierColor(functionalColorToken: .bgGreenLighter) }
  public static var bgGreenLightest: BezierColor { BezierColor(functionalColorToken: .bgGreenLightest) }
  public static var bgGreenDark: BezierColor { BezierColor(functionalColorToken: .bgGreenDark) }
  public static var bgGreenShadeLight: BezierColor { BezierColor(functionalColorToken: .bgGreenShadeLight) }
  public static var bgGreenShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgGreenShadeNormal) }

  // MARK: BackgroundTeal
  public static var bgTealNormal: BezierColor { BezierColor(functionalColorToken: .bgTealNormal) }
  public static var bgTealLight: BezierColor { BezierColor(functionalColorToken: .bgTealLight) }
  public static var bgTealLighter: BezierColor { BezierColor(functionalColorToken: .bgTealLighter) }
  public static var bgTealLightest: BezierColor { BezierColor(functionalColorToken: .bgTealLightest) }
  public static var bgTealDark: BezierColor { BezierColor(functionalColorToken: .bgTealDark) }
  public static var bgTealShadeLight: BezierColor { BezierColor(functionalColorToken: .bgTealShadeLight) }
  public static var bgTealShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgTealShadeNormal) }

  // MARK: BackgroundOlive
  public static var bgOliveNormal: BezierColor { BezierColor(functionalColorToken: .bgOliveNormal) }
  public static var bgOliveLight: BezierColor { BezierColor(functionalColorToken: .bgOliveLight) }
  public static var bgOliveLighter: BezierColor { BezierColor(functionalColorToken: .bgOliveLighter) }
  public static var bgOliveLightest: BezierColor { BezierColor(functionalColorToken: .bgOliveLightest) }
  public static var bgOliveDark: BezierColor { BezierColor(functionalColorToken: .bgOliveDark) }
  public static var bgOliveShadeLight: BezierColor { BezierColor(functionalColorToken: .bgOliveShadeLight) }
  public static var bgOliveShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgOliveShadeNormal) }

  // MARK: BackgroundYellow
  public static var bgYellowNormal: BezierColor { BezierColor(functionalColorToken: .bgYellowNormal) }
  public static var bgYellowLight: BezierColor { BezierColor(functionalColorToken: .bgYellowLight) }
  public static var bgYellowLighter: BezierColor { BezierColor(functionalColorToken: .bgYellowLighter) }
  public static var bgYellowLightest: BezierColor { BezierColor(functionalColorToken: .bgYellowLightest) }
  public static var bgYellowDark: BezierColor { BezierColor(functionalColorToken: .bgYellowDark) }
  public static var bgYellowShadeLight: BezierColor { BezierColor(functionalColorToken: .bgYellowShadeLight) }
  public static var bgYellowShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgYellowShadeNormal) }

  // MARK: BackgroundPink
  public static var bgPinkNormal: BezierColor { BezierColor(functionalColorToken: .bgPinkNormal) }
  public static var bgPinkLight: BezierColor { BezierColor(functionalColorToken: .bgPinkLight) }
  public static var bgPinkLighter: BezierColor { BezierColor(functionalColorToken: .bgPinkLighter) }
  public static var bgPinkLightest: BezierColor { BezierColor(functionalColorToken: .bgPinkLightest) }
  public static var bgPinkDark: BezierColor { BezierColor(functionalColorToken: .bgPinkDark) }
  public static var bgPinkShadeLight: BezierColor { BezierColor(functionalColorToken: .bgPinkShadeLight) }
  public static var bgPinkShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgPinkShadeNormal) }

  // MARK: BackgroundPurple
  public static var bgPurpleNormal: BezierColor { BezierColor(functionalColorToken: .bgPurpleNormal) }
  public static var bgPurpleLight: BezierColor { BezierColor(functionalColorToken: .bgPurpleLight) }
  public static var bgPurpleLighter: BezierColor { BezierColor(functionalColorToken: .bgPurpleLighter) }
  public static var bgPurpleLightest: BezierColor { BezierColor(functionalColorToken: .bgPurpleLightest) }
  public static var bgPurpleDark: BezierColor { BezierColor(functionalColorToken: .bgPurpleDark) }
  public static var bgPurpleShadeLight: BezierColor { BezierColor(functionalColorToken: .bgPurpleShadeLight) }
  public static var bgPurpleShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgPurpleShadeNormal) }

  // MARK: - BackgroundNavy
  public static var bgNavyNormal: BezierColor { BezierColor(functionalColorToken: .bgNavyNormal) }
  public static var bgNavyLight: BezierColor { BezierColor(functionalColorToken: .bgNavyLight) }
  public static var bgNavyLighter: BezierColor { BezierColor(functionalColorToken: .bgNavyLighter) }
  public static var bgNavyLightest: BezierColor { BezierColor(functionalColorToken: .bgNavyLightest) }
  public static var bgNavyDark: BezierColor { BezierColor(functionalColorToken: .bgNavyDark) }
  public static var bgNavyShadeLight: BezierColor { BezierColor(functionalColorToken: .bgNavyShadeLight) }
  public static var bgNavyShadeNormal: BezierColor { BezierColor(functionalColorToken: .bgNavyShadeNormal) }

  // MARK: BackgroundGrey
  public static var bgGreyDarkest: BezierColor { BezierColor(functionalColorToken: .bgGreyDarkest) }
  public static var bgGreyDark: BezierColor { BezierColor(functionalColorToken: .bgGreyDark) }
  public static var bgGreyNormal: BezierColor { BezierColor(functionalColorToken: .bgGreyNormal) }
  public static var bgGreyLight: BezierColor { BezierColor(functionalColorToken: .bgGreyLight) }
  public static var bgGreyLighter: BezierColor { BezierColor(functionalColorToken: .bgGreyLighter) }
  public static var bgGreyLightest: BezierColor { BezierColor(functionalColorToken: .bgGreyLightest) }

  // MARK: BackgroundGreyAlpha
  public static var bgGreyAlphaDarkest: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDarkest) }
  public static var bgGreyAlphaDarker: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDarker) }
  public static var bgGreyAlphaDark: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaDark) }
  public static var bgGreyAlphaLight: BezierColor { BezierColor(functionalColorToken: .bgGreyAlphaLight) }

  // MARK: BackgroundBlack
  public static var bgBlackDarkest: BezierColor { BezierColor(functionalColorToken: .bgBlackDarkest) }
  public static var bgBlackDarker: BezierColor { BezierColor(functionalColorToken: .bgBlackDarker) }
  public static var bgBlackDark: BezierColor { BezierColor(functionalColorToken: .bgBlackDark) }
  public static var bgBlackLight: BezierColor { BezierColor(functionalColorToken: .bgBlackLight) }
  public static var bgBlackLighter: BezierColor { BezierColor(functionalColorToken: .bgBlackLighter) }
  public static var bgBlackLightest: BezierColor { BezierColor(functionalColorToken: .bgBlackLightest) }

  // MARK: BackgroundWhite
  public static var bgWhiteHighest: BezierColor { BezierColor(functionalColorToken: .bgWhiteHighest) }
  public static var bgWhiteHigher: BezierColor { BezierColor(functionalColorToken: .bgWhiteHigher) }
  public static var bgWhiteNormal: BezierColor { BezierColor(functionalColorToken: .bgWhiteNormal) }

  // MARK: BackgroundWhiteAlpha
  public static var bgWhiteAlphaLightest: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLightest) }
  public static var bgWhiteAlphaLighter: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLighter) }
  public static var bgWhiteAlphaLight: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaLight) }
  public static var bgWhiteAlphaTransparent: BezierColor { BezierColor(functionalColorToken: .bgWhiteAlphaTransparent) }

  // MARK: BackgroundAbsoluteBlack
  public static var bgAbsoluteBlackDark: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackDark) }
  public static var bgAbsoluteBlackNormal: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackNormal) }
  public static var bgAbsoluteBlackLight: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLight) }
  public static var bgAbsoluteBlackLighter: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLighter) }
  public static var bgAbsoluteBlackLightest: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteBlackLightest) }

  // MARK: BackgroundAbsoluteWhite
  public static var bgAbsoluteWhiteDark: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteDark) }
  public static var bgAbsoluteWhiteNormal: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteNormal) }
  public static var bgAbsoluteWhiteLight: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLight) }
  public static var bgAbsoluteWhiteLighter: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLighter) }
  public static var bgAbsoluteWhiteLightest: BezierColor { BezierColor(functionalColorToken: .bgAbsoluteWhiteLightest) }

  // MARK: Surface
  public static var surfaceLowest: BezierColor { BezierColor(functionalColorToken: .surfaceLowest) }
  public static var surfaceLower: BezierColor { BezierColor(functionalColorToken: .surfaceLower) }
  public static var surfaceNormal: BezierColor { BezierColor(functionalColorToken: .surfaceNormal) }

  // MARK: Shadow
  public static var shadowXlarge: BezierColor { BezierColor(functionalColorToken: .shadowXlarge) }
  public static var shadowLarge: BezierColor { BezierColor(functionalColorToken: .shadowLarge) }
  public static var shadowMedium: BezierColor { BezierColor(functionalColorToken: .shadowMedium) }
  public static var shadowSmall: BezierColor { BezierColor(functionalColorToken: .shadowSmall) }
  public static var shadowBase: BezierColor { BezierColor(functionalColorToken: .shadowBase) }
  public static var shadowBaseInner: BezierColor { BezierColor(functionalColorToken: .shadowBaseInner) }
}

//MARK: - SemanticColorToken
extension BezierColor {
  // MARK: PrimaryBackground
  public static var primaryBgNormal: BezierColor { BezierColor(semanticToken: .primaryBgNormal) }
  public static var primaryBgLight: BezierColor { BezierColor(semanticToken: .primaryBgLight) }
  public static var primaryBgLighter: BezierColor { BezierColor(semanticToken: .primaryBgLighter) }
  public static var primaryBgLightest: BezierColor { BezierColor(semanticToken: .primaryBgLightest) }
  public static var primaryBgDark: BezierColor { BezierColor(semanticToken: .primaryBgDark) }

  // MARK: PrimaryForeground
  public static var primaryFgNormal: BezierColor { BezierColor(semanticToken: .primaryFgNormal) }
  public static var primaryFgLight: BezierColor { BezierColor(semanticToken: .primaryFgLight) }
  public static var primaryFgDark: BezierColor { BezierColor(semanticToken: .primaryFgDark) }

  // MARK: CriticalBackground
  public static var criticalBgDark: BezierColor { BezierColor(semanticToken: .criticalBgDark) }
  public static var criticalBgNormal: BezierColor { BezierColor(semanticToken: .criticalBgNormal) }
  public static var criticalBgLight: BezierColor { BezierColor(semanticToken: .criticalBgLight) }
  public static var criticalBgLighter: BezierColor { BezierColor(semanticToken: .criticalBgLighter) }
  public static var criticalBgLightest: BezierColor { BezierColor(semanticToken: .criticalBgLightest) }

  // MARK: CriticalForeground
  public static var criticalFgNormal: BezierColor { BezierColor(semanticToken: .criticalFgNormal) }
  public static var criticalFgLight: BezierColor { BezierColor(semanticToken: .criticalFgLight) }
  public static var criticalFgDark: BezierColor { BezierColor(semanticToken: .criticalFgDark) }

  // MARK: WarningBackground
  public static var warningBgDark: BezierColor { BezierColor(semanticToken: .warningBgDark) }
  public static var warningBgNormal: BezierColor { BezierColor(semanticToken: .warningBgNormal) }
  public static var warningBgLight: BezierColor { BezierColor(semanticToken: .warningBgLight) }
  public static var warningBgLighter: BezierColor { BezierColor(semanticToken: .warningBgLighter) }
  public static var warningBgLightest: BezierColor { BezierColor(semanticToken: .warningBgLightest) }

  // MARK: WarningForeground
  public static var warningFgNormal: BezierColor { BezierColor(semanticToken: .warningFgNormal) }
  public static var warningFgLight: BezierColor { BezierColor(semanticToken: .warningFgLight) }
  public static var warningFgDark: BezierColor { BezierColor(semanticToken: .warningFgDark) }

  // MARK: AccentBackground
  public static var accentBgDark: BezierColor { BezierColor(semanticToken: .accentBgDark) }
  public static var accentBgNormal: BezierColor { BezierColor(semanticToken: .accentBgNormal) }
  public static var accentBgLight: BezierColor { BezierColor(semanticToken: .accentBgLight) }
  public static var accentBgLighter: BezierColor { BezierColor(semanticToken: .accentBgLighter) }
  public static var accentBgLightest: BezierColor { BezierColor(semanticToken: .accentBgLightest) }

  // MARK: AccentForeground
  public static var accentFgNormal: BezierColor { BezierColor(semanticToken: .accentFgNormal) }
  public static var accentFgLight: BezierColor { BezierColor(semanticToken: .accentFgLight) }
  public static var accentFgDark: BezierColor { BezierColor(semanticToken: .accentFgDark) }

  // MARK: SuccessForeground
  public static var successBgDark: BezierColor { BezierColor(semanticToken: .successBgDark) }
  public static var successBgNormal: BezierColor { BezierColor(semanticToken: .successBgNormal) }
  public static var successBgLight: BezierColor { BezierColor(semanticToken: .successBgLight) }
  public static var successBgLighter: BezierColor { BezierColor(semanticToken: .successBgLighter) }
  public static var successBgLightest: BezierColor { BezierColor(semanticToken: .successBgLightest) }

  // MARK: SuccessForeground
  public static var successFgNormal: BezierColor { BezierColor(semanticToken: .successFgNormal) }
  public static var successFgLight: BezierColor { BezierColor(semanticToken: .successFgLight) }
  public static var successFgDark: BezierColor { BezierColor(semanticToken: .successFgDark) }
}
