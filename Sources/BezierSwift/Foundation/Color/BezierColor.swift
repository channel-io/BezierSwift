//
//  BezierColor.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI
import UIKit

public protocol ColorTokenType {
  /// 색상을 나타내는 HEX 문자열 (예: "#FFFFFF", "#FFFFFFFF").
  var hex: String { get }
}

public protocol ThemeableColorTokenType {
  /// 색상을 나타내는 HEX 문자열 (예: "#FFFFFF", "#FFFFFFFF").
  var lightColorHex: String { get }
  /// 색상을 나타내는 HEX 문자열 (예: "#FFFFFF", "#FFFFFFFF").
  var darkColorHex: String { get }
}

public protocol BezierColorType {
  var lightColorToken: ColorTokenType { get }
  var darkColorToken: ColorTokenType { get }
  var pressedColorToken: ThemeableColorTokenType { get }
}

public struct BezierColor {
  private let bezierColor: BezierColorType
  
  public init(bezierColor: BezierColorType) {
    self.bezierColor = bezierColor
  }
  
  private init(functionalColorToken: FunctionalColorToken) {
    self.bezierColor = functionalColorToken
  }
  
  private init(semanticToken: SemanticColorToken) {
    self.bezierColor = semanticToken
  }
  
  public var color: Color {
    return Color(self.uiColor)
  }
  
  public var pressedColor: Color {
    return Color(self.pressedUiColor)
  }
  
  public var uiColor: UIColor {
    return UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .light:
        return UIColor(hex: self.bezierColor.lightColorToken.hex)
      case .dark:
        return UIColor(hex: self.bezierColor.darkColorToken.hex)
      default:
        return UIColor(hex: self.bezierColor.lightColorToken.hex)
      }
    }
  }
  
  public var pressedUiColor: UIColor {
    return UIColor { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .light:
        return UIColor(hex: self.bezierColor.pressedColorToken.lightColorHex)
      case .dark:
        return UIColor(hex: self.bezierColor.pressedColorToken.darkColorHex)
      default:
        return UIColor(hex: self.bezierColor.pressedColorToken.lightColorHex)
      }
    }
  }
  
  public var cgColor: CGColor {
    return self.uiColor.cgColor
  }
  
  public var pressedCgColor: CGColor {
    return self.pressedUiColor.cgColor
  }
}

extension BezierColor: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.bezierColor.lightColorToken.hex)
    hasher.combine(self.bezierColor.darkColorToken.hex)
  }
  
  public static func == (lhs: BezierColor, rhs: BezierColor) -> Bool {
    lhs.bezierColor.lightColorToken.hex == rhs.bezierColor.lightColorToken.hex
    && lhs.bezierColor.darkColorToken.hex == rhs.bezierColor.darkColorToken.hex
  }
}

//MARK: - FunctionalColorToken
extension BezierColor {
  // MARK: ForegroundBlue
  public static let fgBlueNormal = BezierColor(functionalColorToken: .fgBlueNormal)
  public static let fgBlueLight = BezierColor(functionalColorToken: .fgBlueLight)
  public static let fgBlueDark = BezierColor(functionalColorToken: .fgBlueDark)

  // MARK: ForegroundCobalt
  public static let fgCobaltNormal = BezierColor(functionalColorToken: .fgCobaltNormal)
  public static let fgCobaltLight = BezierColor(functionalColorToken: .fgCobaltLight)
  public static let fgCobaltDark = BezierColor(functionalColorToken: .fgCobaltDark)

  // MARK: ForegroundRed
  public static let fgRedNormal = BezierColor(functionalColorToken: .fgRedNormal)
  public static let fgRedLight = BezierColor(functionalColorToken: .fgRedLight)
  public static let fgRedDark = BezierColor(functionalColorToken: .fgRedDark)

  // MARK: ForegroundOrange
  public static let fgOrangeNormal = BezierColor(functionalColorToken: .fgOrangeNormal)
  public static let fgOrangeLight = BezierColor(functionalColorToken: .fgOrangeLight)
  public static let fgOrangeDark = BezierColor(functionalColorToken: .fgOrangeDark)

  // MARK: ForegroundGreen
  public static let fgGreenNormal = BezierColor(functionalColorToken: .fgGreenNormal)
  public static let fgGreenLight = BezierColor(functionalColorToken: .fgGreenLight)
  public static let fgGreenDark = BezierColor(functionalColorToken: .fgGreenDark)

  // MARK: ForegroundTeal
  public static let fgTealNormal = BezierColor(functionalColorToken: .fgTealNormal)
  public static let fgTealLight = BezierColor(functionalColorToken: .fgTealLight)
  public static let fgTealDark = BezierColor(functionalColorToken: .fgTealDark)

  // MARK: ForegroundOlive
  public static let fgOliveNormal = BezierColor(functionalColorToken: .fgOliveNormal)
  public static let fgOliveLight = BezierColor(functionalColorToken: .fgOliveLight)
  public static let fgOliveDark = BezierColor(functionalColorToken: .fgOliveDark)

  // MARK: ForegroundYellow
  public static let fgYellowNormal = BezierColor(functionalColorToken: .fgYellowNormal)
  public static let fgYellowLight = BezierColor(functionalColorToken: .fgYellowLight)
  public static let fgYellowDark = BezierColor(functionalColorToken: .fgYellowDark)

  // MARK: ForegroundPink
  public static let fgPinkNormal = BezierColor(functionalColorToken: .fgPinkNormal)
  public static let fgPinkLight = BezierColor(functionalColorToken: .fgPinkLight)
  public static let fgPinkDark = BezierColor(functionalColorToken: .fgPinkDark)

  // MARK: ForegroundPurple
  public static let fgPurpleNormal = BezierColor(functionalColorToken: .fgPurpleNormal)
  public static let fgPurpleLight = BezierColor(functionalColorToken: .fgPurpleLight)
  public static let fgPurpleDark = BezierColor(functionalColorToken: .fgPurpleDark)

  // MARK: ForegroundNavy
  public static let fgNavyNormal = BezierColor(functionalColorToken: .fgNavyNormal)
  public static let fgNavyLight = BezierColor(functionalColorToken: .fgNavyLight)
  public static let fgNavyDark = BezierColor(functionalColorToken: .fgNavyDark)

  // MARK: ForegroundGrey
  public static let fgGreyDarkest = BezierColor(functionalColorToken: .fgGreyDarkest)
  public static let fgGreyDark = BezierColor(functionalColorToken: .fgGreyDark)
  public static let fgGreyNormal = BezierColor(functionalColorToken: .fgGreyNormal)
  public static let fgGreyLight = BezierColor(functionalColorToken: .fgGreyLight)
  public static let fgGreyLighter = BezierColor(functionalColorToken: .fgGreyLighter)
  public static let fgGreyLightest = BezierColor(functionalColorToken: .fgGreyLightest)

  // MARK: ForegroundGreyAlpha
  public static let fgGreyAlphaDarkest = BezierColor(functionalColorToken: .fgGreyAlphaDarkest)
  public static let fgGreyAlphaDarker = BezierColor(functionalColorToken: .fgGreyAlphaDarker)
  public static let fgGreyAlphaDark = BezierColor(functionalColorToken: .fgGreyAlphaDark)
  public static let fgGreyAlphaLight = BezierColor(functionalColorToken: .fgGreyAlphaLight)

  // MARK: ForegroundWhite
  public static let fgWhiteNormal = BezierColor(functionalColorToken: .fgWhiteNormal)

  // MARK: ForegroundBlack
  public static let fgBlackLightest = BezierColor(functionalColorToken: .fgBlackLightest)
  public static let fgBlackLight = BezierColor(functionalColorToken: .fgBlackLight)
  public static let fgBlackDark = BezierColor(functionalColorToken: .fgBlackDark)
  public static let fgBlackDarker = BezierColor(functionalColorToken: .fgBlackDarker)
  public static let fgBlackDarkest = BezierColor(functionalColorToken: .fgBlackDarkest)
  public static let fgBlackPure = BezierColor(functionalColorToken: .fgBlackPure)

  // MARK: ForegroundAbsoluteWhite
  public static let fgAbsoluteWhiteLightest = BezierColor(functionalColorToken: .fgAbsoluteWhiteLightest)
  public static let fgAbsoluteWhiteLighter = BezierColor(functionalColorToken: .fgAbsoluteWhiteLighter)
  public static let fgAbsoluteWhiteLight = BezierColor(functionalColorToken: .fgAbsoluteWhiteLight)
  public static let fgAbsoluteWhiteNormal = BezierColor(functionalColorToken: .fgAbsoluteWhiteNormal)
  public static let fgAbsoluteWhiteDark = BezierColor(functionalColorToken: .fgAbsoluteWhiteDark)

  // MARK: ForegroundAbsoluteBlack
  public static let fgAbsoluteBlackLightest = BezierColor(functionalColorToken: .fgAbsoluteBlackLightest)
  public static let fgAbsoluteBlackLighter = BezierColor(functionalColorToken: .fgAbsoluteBlackLighter)
  public static let fgAbsoluteBlackLight = BezierColor(functionalColorToken: .fgAbsoluteBlackLight)
  public static let fgAbsoluteBlackNormal = BezierColor(functionalColorToken: .fgAbsoluteBlackNormal)
  public static let fgAbsoluteBlackDark = BezierColor(functionalColorToken: .fgAbsoluteBlackDark)

  // MARK: BackgroundBlue
  public static let bgBlueNormal = BezierColor(functionalColorToken: .bgBlueNormal)
  public static let bgBlueLight = BezierColor(functionalColorToken: .bgBlueLight)
  public static let bgBlueLighter = BezierColor(functionalColorToken: .bgBlueLighter)
  public static let bgBlueLightest = BezierColor(functionalColorToken: .bgBlueLightest)
  public static let bgBlueDark = BezierColor(functionalColorToken: .bgBlueDark)
  public static let bgBlueShadeLighter = BezierColor(functionalColorToken: .bgBlueShadeLighter)
  public static let bgBlueShadeNormal = BezierColor(functionalColorToken: .bgBlueShadeNormal)
  public static let bgBlueTransparent = BezierColor(functionalColorToken: .bgBlueTransparent)

  // MARK: BackgroundCobalt
  public static let bgCobaltNormal = BezierColor(functionalColorToken: .bgCobaltNormal)
  public static let bgCobaltLight = BezierColor(functionalColorToken: .bgCobaltLight)
  public static let bgCobaltLighter = BezierColor(functionalColorToken: .bgCobaltLighter)
  public static let bgCobaltLightest = BezierColor(functionalColorToken: .bgCobaltLightest)
  public static let bgCobaltDark = BezierColor(functionalColorToken: .bgCobaltDark)
  public static let bgCobaltShadeLighter = BezierColor(functionalColorToken: .bgCobaltShadeLighter)
  public static let bgCobaltShadeNormal = BezierColor(functionalColorToken: .bgCobaltShadeNormal)
  public static let bgCobaltTransparent = BezierColor(functionalColorToken: .bgCobaltTransparent)

  // MARK: BackgroundRed
  public static let bgRedNormal = BezierColor(functionalColorToken: .bgRedNormal)
  public static let bgRedLight = BezierColor(functionalColorToken: .bgRedLight)
  public static let bgRedLighter = BezierColor(functionalColorToken: .bgRedLighter)
  public static let bgRedLightest = BezierColor(functionalColorToken: .bgRedLightest)
  public static let bgRedDark = BezierColor(functionalColorToken: .bgRedDark)
  public static let bgRedShadeLighter = BezierColor(functionalColorToken: .bgRedShadeLighter)
  public static let bgRedShadeNormal = BezierColor(functionalColorToken: .bgRedShadeNormal)
  public static let bgRedTransparent = BezierColor(functionalColorToken: .bgRedTransparent)

  // MARK: BackgroundOrange
  public static let bgOrangeNormal = BezierColor(functionalColorToken: .bgOrangeNormal)
  public static let bgOrangeLight = BezierColor(functionalColorToken: .bgOrangeLight)
  public static let bgOrangeLighter = BezierColor(functionalColorToken: .bgOrangeLighter)
  public static let bgOrangeLightest = BezierColor(functionalColorToken: .bgOrangeLightest)
  public static let bgOrangeDark = BezierColor(functionalColorToken: .bgOrangeDark)
  public static let bgOrangeShadeLighter = BezierColor(functionalColorToken: .bgOrangeShadeLighter)
  public static let bgOrangeShadeNormal = BezierColor(functionalColorToken: .bgOrangeShadeNormal)
  public static let bgOrangeTransparent = BezierColor(functionalColorToken: .bgOrangeTransparent)

  // MARK: BackgroundGreen
  public static let bgGreenNormal = BezierColor(functionalColorToken: .bgGreenNormal)
  public static let bgGreenLight = BezierColor(functionalColorToken: .bgGreenLight)
  public static let bgGreenLighter = BezierColor(functionalColorToken: .bgGreenLighter)
  public static let bgGreenLightest = BezierColor(functionalColorToken: .bgGreenLightest)
  public static let bgGreenDark = BezierColor(functionalColorToken: .bgGreenDark)
  public static let bgGreenShadeLighter = BezierColor(functionalColorToken: .bgGreenShadeLighter)
  public static let bgGreenShadeNormal = BezierColor(functionalColorToken: .bgGreenShadeNormal)
  public static let bgGreenTransparent = BezierColor(functionalColorToken: .bgGreenTransparent)

  // MARK: BackgroundTeal
  public static let bgTealNormal = BezierColor(functionalColorToken: .bgTealNormal)
  public static let bgTealLight = BezierColor(functionalColorToken: .bgTealLight)
  public static let bgTealLighter = BezierColor(functionalColorToken: .bgTealLighter)
  public static let bgTealLightest = BezierColor(functionalColorToken: .bgTealLightest)
  public static let bgTealDark = BezierColor(functionalColorToken: .bgTealDark)
  public static let bgTealShadeLighter = BezierColor(functionalColorToken: .bgTealShadeLighter)
  public static let bgTealShadeNormal = BezierColor(functionalColorToken: .bgTealShadeNormal)
  public static let bgTealTransparent = BezierColor(functionalColorToken: .bgTealTransparent)

  // MARK: BackgroundOlive
  public static let bgOliveNormal = BezierColor(functionalColorToken: .bgOliveNormal)
  public static let bgOliveLight = BezierColor(functionalColorToken: .bgOliveLight)
  public static let bgOliveLighter = BezierColor(functionalColorToken: .bgOliveLighter)
  public static let bgOliveLightest = BezierColor(functionalColorToken: .bgOliveLightest)
  public static let bgOliveDark = BezierColor(functionalColorToken: .bgOliveDark)
  public static let bgOliveShadeLighter = BezierColor(functionalColorToken: .bgOliveShadeLighter)
  public static let bgOliveShadeNormal = BezierColor(functionalColorToken: .bgOliveShadeNormal)
  public static let bgOliveTransparent = BezierColor(functionalColorToken: .bgOliveTransparent)

  // MARK: BackgroundYellow
  public static let bgYellowNormal = BezierColor(functionalColorToken: .bgYellowNormal)
  public static let bgYellowLight = BezierColor(functionalColorToken: .bgYellowLight)
  public static let bgYellowLighter = BezierColor(functionalColorToken: .bgYellowLighter)
  public static let bgYellowLightest = BezierColor(functionalColorToken: .bgYellowLightest)
  public static let bgYellowDark = BezierColor(functionalColorToken: .bgYellowDark)
  public static let bgYellowShadeLighter = BezierColor(functionalColorToken: .bgYellowShadeLighter)
  public static let bgYellowShadeNormal = BezierColor(functionalColorToken: .bgYellowShadeNormal)
  public static let bgYellowTransparent = BezierColor(functionalColorToken: .bgYellowTransparent)

  // MARK: BackgroundPink
  public static let bgPinkNormal = BezierColor(functionalColorToken: .bgPinkNormal)
  public static let bgPinkLight = BezierColor(functionalColorToken: .bgPinkLight)
  public static let bgPinkLighter = BezierColor(functionalColorToken: .bgPinkLighter)
  public static let bgPinkLightest = BezierColor(functionalColorToken: .bgPinkLightest)
  public static let bgPinkDark = BezierColor(functionalColorToken: .bgPinkDark)
  public static let bgPinkShadeLighter = BezierColor(functionalColorToken: .bgPinkShadeLighter)
  public static let bgPinkShadeNormal = BezierColor(functionalColorToken: .bgPinkShadeNormal)
  public static let bgPinkTransparent = BezierColor(functionalColorToken: .bgPinkTransparent)

  // MARK: BackgroundPurple
  public static let bgPurpleNormal = BezierColor(functionalColorToken: .bgPurpleNormal)
  public static let bgPurpleLight = BezierColor(functionalColorToken: .bgPurpleLight)
  public static let bgPurpleLighter = BezierColor(functionalColorToken: .bgPurpleLighter)
  public static let bgPurpleLightest = BezierColor(functionalColorToken: .bgPurpleLightest)
  public static let bgPurpleDark = BezierColor(functionalColorToken: .bgPurpleDark)
  public static let bgPurpleShadeLighter = BezierColor(functionalColorToken: .bgPurpleShadeLighter)
  public static let bgPurpleShadeNormal = BezierColor(functionalColorToken: .bgPurpleShadeNormal)
  public static let bgPurpleTransparent = BezierColor(functionalColorToken: .bgPurpleTransparent)

  // MARK: - BackgroundNavy
  public static let bgNavyNormal = BezierColor(functionalColorToken: .bgNavyNormal)
  public static let bgNavyLight = BezierColor(functionalColorToken: .bgNavyLight)
  public static let bgNavyLighter = BezierColor(functionalColorToken: .bgNavyLighter)
  public static let bgNavyLightest = BezierColor(functionalColorToken: .bgNavyLightest)
  public static let bgNavyDark = BezierColor(functionalColorToken: .bgNavyDark)
  public static let bgNavyShadeLighter = BezierColor(functionalColorToken: .bgNavyShadeLighter)
  public static let bgNavyShadeNormal = BezierColor(functionalColorToken: .bgNavyShadeNormal)
  public static let bgNavyTransparent = BezierColor(functionalColorToken: .bgNavyTransparent)

  // MARK: BackgroundGrey
  public static let bgGreyDarkest = BezierColor(functionalColorToken: .bgGreyDarkest)
  public static let bgGreyDark = BezierColor(functionalColorToken: .bgGreyDark)
  public static let bgGreyNormal = BezierColor(functionalColorToken: .bgGreyNormal)
  public static let bgGreyLight = BezierColor(functionalColorToken: .bgGreyLight)
  public static let bgGreyLighter = BezierColor(functionalColorToken: .bgGreyLighter)
  public static let bgGreyLightest = BezierColor(functionalColorToken: .bgGreyLightest)
  public static let bgGreyTransparent = BezierColor(functionalColorToken: .bgGreyTransparent)

  // MARK: BackgroundGreyAlpha
  public static let bgGreyAlphaDarkest = BezierColor(functionalColorToken: .bgGreyAlphaDarkest)
  public static let bgGreyAlphaDarker = BezierColor(functionalColorToken: .bgGreyAlphaDarker)
  public static let bgGreyAlphaDark = BezierColor(functionalColorToken: .bgGreyAlphaDark)
  public static let bgGreyAlphaLight = BezierColor(functionalColorToken: .bgGreyAlphaLight)

  // MARK: BackgroundBlack
  public static let bgBlackDarkest = BezierColor(functionalColorToken: .bgBlackDarkest)
  public static let bgBlackDarker = BezierColor(functionalColorToken: .bgBlackDarker)
  public static let bgBlackDark = BezierColor(functionalColorToken: .bgBlackDark)
  public static let bgBlackLight = BezierColor(functionalColorToken: .bgBlackLight)
  public static let bgBlackLighter = BezierColor(functionalColorToken: .bgBlackLighter)
  public static let bgBlackLightest = BezierColor(functionalColorToken: .bgBlackLightest)
  public static let bgBlackTransparent = BezierColor(functionalColorToken: .bgBlackTransparent)

  // MARK: BackgroundWhite
  public static let bgWhiteHighest = BezierColor(functionalColorToken: .bgWhiteHighest)
  public static let bgWhiteHigher = BezierColor(functionalColorToken: .bgWhiteHigher)
  public static let bgWhiteNormal = BezierColor(functionalColorToken: .bgWhiteNormal)
  public static let bgWhiteTransparent = BezierColor(functionalColorToken: .bgWhiteTransparent)

  // MARK: BackgroundWhiteAlpha
  public static let bgWhiteAlphaLightest = BezierColor(functionalColorToken: .bgWhiteAlphaLightest)
  public static let bgWhiteAlphaLighter = BezierColor(functionalColorToken: .bgWhiteAlphaLighter)
  public static let bgWhiteAlphaLight = BezierColor(functionalColorToken: .bgWhiteAlphaLight)
  public static let bgWhiteAlphaTransparent = BezierColor(functionalColorToken: .bgWhiteAlphaTransparent)

  // MARK: BackgroundAbsoluteBlack
  public static let bgAbsoluteBlackDark = BezierColor(functionalColorToken: .bgAbsoluteBlackDark)
  public static let bgAbsoluteBlackNormal = BezierColor(functionalColorToken: .bgAbsoluteBlackNormal)
  public static let bgAbsoluteBlackLight = BezierColor(functionalColorToken: .bgAbsoluteBlackLight)
  public static let bgAbsoluteBlackLighter = BezierColor(functionalColorToken: .bgAbsoluteBlackLighter)
  public static let bgAbsoluteBlackLightest = BezierColor(functionalColorToken: .bgAbsoluteBlackLightest)
  public static let bgAbsoluteBlackTransparent = BezierColor(functionalColorToken: .bgAbsoluteBlackTransparent)

  // MARK: BackgroundAbsoluteWhite
  public static let bgAbsoluteWhiteDark = BezierColor(functionalColorToken: .bgAbsoluteWhiteDark)
  public static let bgAbsoluteWhiteNormal = BezierColor(functionalColorToken: .bgAbsoluteWhiteNormal)
  public static let bgAbsoluteWhiteLight = BezierColor(functionalColorToken: .bgAbsoluteWhiteLight)
  public static let bgAbsoluteWhiteLighter = BezierColor(functionalColorToken: .bgAbsoluteWhiteLighter)
  public static let bgAbsoluteWhiteLightest = BezierColor(functionalColorToken: .bgAbsoluteWhiteLightest)
  public static let bgAbsoluteWhiteTransparent = BezierColor(functionalColorToken: .bgAbsoluteWhiteTransparent)

  // MARK: Surface
  public static let surfaceLowest = BezierColor(functionalColorToken: .surfaceLowest)
  public static let surfaceLower = BezierColor(functionalColorToken: .surfaceLower)
  public static let surfaceNormal = BezierColor(functionalColorToken: .surfaceNormal)

  // MARK: Shadow
  public static let shadowXlarge = BezierColor(functionalColorToken: .shadowXlarge)
  public static let shadowLarge = BezierColor(functionalColorToken: .shadowLarge)
  public static let shadowMedium = BezierColor(functionalColorToken: .shadowMedium)
  public static let shadowSmall = BezierColor(functionalColorToken: .shadowSmall)
  public static let shadowBase = BezierColor(functionalColorToken: .shadowBase)
  public static let shadowBaseInner = BezierColor(functionalColorToken: .shadowBaseInner)
  
  // MARK: Dim
  public static let dimBlackNormal = BezierColor(functionalColorToken: .dimBlackNormal)
  public static let dimBlackLight = BezierColor(functionalColorToken: .dimBlackLight)
}

//MARK: - SemanticColorToken
extension BezierColor {
  // MARK: PrimaryBackground
  public static let primaryBgNormal = BezierColor(semanticToken: .primaryBgNormal)
  public static let primaryBgLight = BezierColor(semanticToken: .primaryBgLight)
  public static let primaryBgLighter = BezierColor(semanticToken: .primaryBgLighter)
  public static let primaryBgLightest = BezierColor(semanticToken: .primaryBgLightest)
  public static let primaryBgDark = BezierColor(semanticToken: .primaryBgDark)
  public static let primaryBgTransparent = BezierColor(semanticToken: .primaryBgTransparent)

  // MARK: PrimaryForeground
  public static let primaryFgNormal = BezierColor(semanticToken: .primaryFgNormal)
  public static let primaryFgLight = BezierColor(semanticToken: .primaryFgLight)
  public static let primaryFgDark = BezierColor(semanticToken: .primaryFgDark)

  // MARK: CriticalBackground
  public static let criticalBgDark = BezierColor(semanticToken: .criticalBgDark)
  public static let criticalBgNormal = BezierColor(semanticToken: .criticalBgNormal)
  public static let criticalBgLight = BezierColor(semanticToken: .criticalBgLight)
  public static let criticalBgLighter = BezierColor(semanticToken: .criticalBgLighter)
  public static let criticalBgLightest = BezierColor(semanticToken: .criticalBgLightest)
  public static let criticalBgTransparent = BezierColor(semanticToken: .criticalBgTransparent)

  // MARK: CriticalForeground
  public static let criticalFgNormal = BezierColor(semanticToken: .criticalFgNormal)
  public static let criticalFgLight = BezierColor(semanticToken: .criticalFgLight)
  public static let criticalFgDark = BezierColor(semanticToken: .criticalFgDark)

  // MARK: WarningBackground
  public static let warningBgDark = BezierColor(semanticToken: .warningBgDark)
  public static let warningBgNormal = BezierColor(semanticToken: .warningBgNormal)
  public static let warningBgLight = BezierColor(semanticToken: .warningBgLight)
  public static let warningBgLighter = BezierColor(semanticToken: .warningBgLighter)
  public static let warningBgLightest = BezierColor(semanticToken: .warningBgLightest)
  public static let warningBgTransparent = BezierColor(semanticToken: .warningBgTransparent)

  // MARK: WarningForeground
  public static let warningFgNormal = BezierColor(semanticToken: .warningFgNormal)
  public static let warningFgLight = BezierColor(semanticToken: .warningFgLight)
  public static let warningFgDark = BezierColor(semanticToken: .warningFgDark)

  // MARK: AccentBackground
  public static let accentBgDark = BezierColor(semanticToken: .accentBgDark)
  public static let accentBgNormal = BezierColor(semanticToken: .accentBgNormal)
  public static let accentBgLight = BezierColor(semanticToken: .accentBgLight)
  public static let accentBgLighter = BezierColor(semanticToken: .accentBgLighter)
  public static let accentBgLightest = BezierColor(semanticToken: .accentBgLightest)
  public static let accentBgTransparent = BezierColor(semanticToken: .accentBgTransparent)

  // MARK: AccentForeground
  public static let accentFgNormal = BezierColor(semanticToken: .accentFgNormal)
  public static let accentFgLight = BezierColor(semanticToken: .accentFgLight)
  public static let accentFgDark = BezierColor(semanticToken: .accentFgDark)

  // MARK: SuccessBackground
  public static let successBgDark = BezierColor(semanticToken: .successBgDark)
  public static let successBgNormal = BezierColor(semanticToken: .successBgNormal)
  public static let successBgLight = BezierColor(semanticToken: .successBgLight)
  public static let successBgLighter = BezierColor(semanticToken: .successBgLighter)
  public static let successBgLightest = BezierColor(semanticToken: .successBgLightest)
  public static let successBgTransparent = BezierColor(semanticToken: .successBgTransparent)

  // MARK: SuccessForeground
  public static let successFgNormal = BezierColor(semanticToken: .successFgNormal)
  public static let successFgLight = BezierColor(semanticToken: .successFgLight)
  public static let successFgDark = BezierColor(semanticToken: .successFgDark)
}

// MARK: - Bezier V1 SemanticColor Support
extension BezierColor {
  // MARK: - Background
  @available(*, deprecated, renamed: "bgWhiteAlphaTransparent", message: "Use `bgWhiteAlphaTransparent` instead.")
  public static let bgTransparent = BezierColor(functionalColorToken: .bgWhiteAlphaTransparent)
  
  @available(*, deprecated, renamed: "bgWhiteHighest", message: "Use `bgWhiteHighest` instead.")
  public static let bgWhiteHigh = BezierColor(functionalColorToken: .bgWhiteHighest)
  
  @available(*, deprecated, renamed: "bgWhiteHigher", message: "Use `bgWhiteHigher` instead.")
  public static let bgWhiteLow = BezierColor(functionalColorToken: .bgWhiteHigher)

  @available(*, deprecated, renamed: "bgWhiteAlphaLighter", message: "Use `bgWhiteAlphaLighter` instead.")
  public static let bgWhiteDimDark = BezierColor(functionalColorToken: .bgWhiteAlphaLighter)
  
  @available(*, deprecated, renamed: "bgWhiteAlphaLight", message: "Use `bgWhiteAlphaLight` instead.")
  public static let bgWhiteDimLight = BezierColor(functionalColorToken: .bgWhiteAlphaLight)

  @available(*, deprecated, renamed: "bgGreyAlphaLight", message: "Use `bgGreyAlphaLight` instead.")
  public static let bgGreyDimLightest = BezierColor(functionalColorToken: .bgGreyAlphaLight)
  
  @available(*, deprecated, renamed: "bgGreyAlphaDarkest", message: "Use `bgGreyAlphaDarkest` instead.")
  public static let bgGnb = BezierColor(functionalColorToken: .bgGreyAlphaDarkest)
  
  @available(*, deprecated, renamed: "bgGreyAlphaDark", message: "Use `bgGreyAlphaDark` instead.")
  public static let bgNavi = BezierColor(functionalColorToken: .bgGreyAlphaDark)
  
  @available(*, deprecated, renamed: "bgWhiteAlphaLightest", message: "Use `bgWhiteAlphaLightest` instead.")
  public static let bgHeaderFloat = BezierColor(functionalColorToken: .bgWhiteAlphaLightest)
  
  @available(*, deprecated, renamed: "bgWhiteHigher", message: "Use `bgWhiteHigher` instead.")
  public static let bgHeader = BezierColor(functionalColorToken: .bgWhiteHigher)
  
  @available(*, deprecated, renamed: "bgGreyAlphaDarker", message: "Use `bgGreyAlphaDarker` instead.")
  public static let bgLounge = BezierColor(functionalColorToken: .bgGreyAlphaDarker)
  
  // MARK: - Text
  @available(*, deprecated, renamed: "fgBlackDarkest", message: "Use `fgBlackDarkest` instead.")
  public static let txtBlackDarkest = BezierColor(functionalColorToken: .fgBlackDarkest)
  
  @available(*, deprecated, renamed: "fgBlackDarker", message: "Use `fgBlackDarker` instead.")
  public static let txtBlackDarker = BezierColor(functionalColorToken: .fgBlackDarker)
  
  @available(*, deprecated, renamed: "fgBlackDark", message: "Use `fgBlackDark` instead.")
  public static let txtBlackDark = BezierColor(functionalColorToken: .fgBlackDark)
  
  @available(*, deprecated, renamed: "fgWhiteNormal", message: "Use `fgWhiteNormal` instead.")
  public static let txtWhiteNormal = BezierColor(functionalColorToken: .fgWhiteNormal)
  
  @available(*, deprecated, renamed: "fgBlackPure", message: "Use `fgBlackPure` instead.")
  public static let txtBlackPure = BezierColor(functionalColorToken: .fgBlackPure)
  
  // MARK: - Background & Text - Absolute
  @available(*, deprecated, message: "Use `fgAbsoluteBlackDark` for icon and text colors, and `bgAbsoluteBlackDark` for background color instead.")
  public static let bgtxtAbsoluteBlackDark = BezierColor(functionalColorToken: .bgAbsoluteBlackDark)
  
  @available(*, deprecated, message: "Use `fgAbsoluteBlackNormal` for icon and text colors, and `bgAbsoluteBlackNormal` for background color instead.")
  public static let bgtxtAbsoluteBlackNormal = BezierColor(functionalColorToken: .bgAbsoluteBlackNormal)
  
  @available(*, deprecated, message: "Use `fgAbsoluteBlackLight` for icon and text colors, and `bgAbsoluteBlackLight` for background color instead.")
  public static let bgtxtAbsoluteBlackLight = BezierColor(functionalColorToken: .bgAbsoluteBlackLight)
  
  @available(*, deprecated, message: "Use `fgAbsoluteBlackLighter` for icon and text colors, and `bgAbsoluteBlackLighter` for background color instead.")
  public static let bgtxtAbsoluteBlackLighter = BezierColor(functionalColorToken: .bgAbsoluteBlackLighter)
  
  @available(*, deprecated, message: "Use `fgAbsoluteBlackLightest` for icon and text colors, and `bgAbsoluteBlackLightest` for background color instead.")
  public static let bgtxtAbsoluteBlackLightest = BezierColor(functionalColorToken: .bgAbsoluteBlackLightest)
  
  @available(*, deprecated, message: "Use `fgAbsoluteWhiteDark` for icon and text colors, and `bgAbsoluteWhiteDark` for background color instead.")
  public static let bgtxtAbsoluteWhiteDark = BezierColor(functionalColorToken: .bgAbsoluteWhiteDark)
  
  @available(*, deprecated, message: "Use `fgAbsoluteWhiteNormal` for icon and text colors, and `bgAbsoluteWhiteNormal` for background color instead.")
  public static let bgtxtAbsoluteWhiteNormal = BezierColor(functionalColorToken: .bgAbsoluteWhiteNormal)
  
  @available(*, deprecated, message: "Use `fgAbsoluteWhiteLight` for icon and text colors, and `bgAbsoluteWhiteLight` for background color instead.")
  public static let bgtxtAbsoluteWhiteLight = BezierColor(functionalColorToken: .bgAbsoluteWhiteLight)
  
  @available(*, deprecated, message: "Use `fgAbsoluteWhiteLighter` for icon and text colors, and `bgAbsoluteWhiteLighter` for background color instead.")
  public static let bgtxtAbsoluteWhiteLighter = BezierColor(functionalColorToken: .bgAbsoluteWhiteLighter)
  
  @available(*, deprecated, message: "Use `fgAbsoluteWhiteLightest` for icon and text colors, and `bgAbsoluteWhiteLightest` for background color instead.")
  public static let bgtxtAbsoluteWhiteLightest = BezierColor(functionalColorToken: .bgAbsoluteWhiteLightest)
  
  // MARK: - Shadow for elevation
  @available(*, deprecated, renamed: "shadowXlarge", message: "Use `shadowXlarge` instead.")
  public static let shdwXlarge = BezierColor(functionalColorToken: .shadowXlarge)
  
  @available(*, deprecated, renamed: "shadowLarge", message: "Use `shadowLarge` instead.")
  public static let shdwLarge = BezierColor(functionalColorToken: .shadowLarge)
  
  @available(*, deprecated, renamed: "shadowMedium", message: "Use `shadowMedium` instead.")
  public static let shdwMedium = BezierColor(functionalColorToken: .shadowMedium)
  
  @available(*, deprecated, renamed: "shadowSmall", message: "Use `shadowSmall` instead.")
  public static let shdwSmall = BezierColor(functionalColorToken: .shadowSmall)
  
  @available(*, deprecated, renamed: "shadowBase", message: "Use `shadowBase` instead.")
  public static let shdwBase = BezierColor(functionalColorToken: .shadowBase)
  
  @available(*, deprecated, renamed: "shadowBaseInner", message: "Use `shadowBaseInner` instead.")
  public static let shdwBaseInner = BezierColor(functionalColorToken: .shadowBaseInner)
  
  // MARK: - Border & Divider
  @available(*, deprecated, renamed: "bgBlackDark", message: "Use `bgBlackDark` instead.")
  public static let bdrBlackDark = BezierColor(functionalColorToken: .bgBlackDark)
  
  @available(*, deprecated, renamed: "bgBlackLight", message: "Use `bgBlackLight` instead.")
  public static let bdrBlackLight = BezierColor(functionalColorToken: .bgBlackLight)
  
  @available(*, deprecated, renamed: "bgBlackLightest", message: "Use `bgBlackLightest` instead.")
  public static let bdrBlackLightest = BezierColor(functionalColorToken: .bgBlackLightest)
  
  @available(*, deprecated, renamed: "bgGreyLight", message: "Use `bgGreyLight` instead.")
  public static let bdrGreyLight = BezierColor(functionalColorToken: .bgGreyLight)
  
  @available(*, deprecated, renamed: "bgWhiteHighest", message: "Use `bgWhiteHighest` instead.")
  public static let bdrWhite = BezierColor(functionalColorToken: .bgWhiteHighest)
  
  // MARK: - Appendix, Blue
  @available(*, deprecated, renamed: "bgBlueLightest", message: "Use `bgBlueLightest` instead.")
  public static let bgtxtBlueLightest = BezierColor(functionalColorToken: .bgBlueLightest)
  
  @available(*, deprecated, renamed: "bgBlueLighter", message: "Use `bgBlueLighter` instead.")
  public static let bgtxtBlueLighter = BezierColor(functionalColorToken: .bgBlueLighter)
  
  @available(*, deprecated, message: "Use `fgBlueLight` for icon and text colors, and `bgBlueLight` for background color instead.")
  public static let bgtxtBlueLight = BezierColor(functionalColorToken: .bgBlueLight)
  
  @available(*, deprecated, message: "Use `fgBlueNormal` for icon and text colors, and `bgBlueNormal` for background color instead.")
  public static let bgtxtBlueNormal = BezierColor(functionalColorToken: .bgBlueNormal)
  
  @available(*, deprecated, message: "Use `fgBlueDark` for icon and text colors, and `bgBlueDark` for background color instead.")
  public static let bgtxtBlueDark = BezierColor(functionalColorToken: .bgBlueDark)
  
  // MARK: - Appendix, Cobalt
  @available(*, deprecated, renamed: "bgCobaltLightest", message: "Use `bgCobaltLightest` instead.")
  public static let bgtxtCobaltLightest = BezierColor(functionalColorToken: .bgCobaltLightest)
  
  @available(*, deprecated, renamed: "bgCobaltLighter", message: "Use `bgCobaltLighter` instead.")
  public static let bgtxtCobaltLighter = BezierColor(functionalColorToken: .bgCobaltLighter)
  
  @available(*, deprecated, message: "Use `fgCobaltLight` for icon and text colors, and `bgCobaltLight` for background color instead.")
  public static let bgtxtCobaltLight = BezierColor(functionalColorToken: .bgCobaltLight)
  
  @available(*, deprecated, message: "Use `fgCobaltNormal` for icon and text colors, and `bgCobaltNormal` for background color instead.")
  public static let bgtxtCobaltNormal = BezierColor(functionalColorToken: .bgCobaltNormal)
  
  @available(*, deprecated, message: "Use `fgCobaltDark` for icon and text colors, and `bgCobaltDark` for background color instead.")
  public static let bgtxtCobaltDark = BezierColor(functionalColorToken: .bgCobaltDark)
  
  // MARK: - Appendix, Teal
  @available(*, deprecated, renamed: "bgTealLightest", message: "Use `bgTealLightest` instead.")
  public static let bgtxtTealLightest = BezierColor(functionalColorToken: .bgTealLightest)
  
  @available(*, deprecated, renamed: "bgTealLighter", message: "Use `bgTealLighter` instead.")
  public static let bgtxtTealLighter = BezierColor(functionalColorToken: .bgTealLighter)
  
  @available(*, deprecated, message: "Use `fgTealLight` for icon and text colors, and `bgTealLight` for background color instead.")
  public static let bgtxtTealLight = BezierColor(functionalColorToken: .bgTealLight)
  
  @available(*, deprecated, message: "Use `fgTealNormal` for icon and text colors, and `bgTealNormal` for background color instead.")
  public static let bgtxtTealNormal = BezierColor(functionalColorToken: .bgTealNormal)
  
  @available(*, deprecated, message: "Use `fgTealDark` for icon and text colors, and `bgTealDark` for background color instead.")
  public static let bgtxtTealDark = BezierColor(functionalColorToken: .bgTealDark)
  
  // MARK: - Appendix, Green
  @available(*, deprecated, renamed: "bgGreenLightest", message: "Use `bgGreenLightest` instead.")
  public static let bgtxtGreenLightest = BezierColor(functionalColorToken: .bgGreenLightest)
  
  @available(*, deprecated, renamed: "bgGreenLighter", message: "Use `bgGreenLighter` instead.")
  public static let bgtxtGreenLighter = BezierColor(functionalColorToken: .bgGreenLighter)
  
  @available(*, deprecated, message: "Use `fgGreenLight` for icon and text colors, and `bgGreenLight` for background color instead.")
  public static let bgtxtGreenLight = BezierColor(functionalColorToken: .bgGreenLight)
  
  @available(*, deprecated, message: "Use `fgGreenNormal` for icon and text colors, and `bgGreenNormal` for background color instead.")
  public static let bgtxtGreenNormal = BezierColor(functionalColorToken: .bgGreenNormal)
  
  @available(*, deprecated, message: "Use `fgGreenDark` for icon and text colors, and `bgGreenDark` for background color instead.")
  public static let bgtxtGreenDark = BezierColor(functionalColorToken: .bgGreenDark)
  
  // MARK: - Appendix, Olive
  @available(*, deprecated, renamed: "bgOliveLightest", message: "Use `bgOliveLightest` instead.")
  public static let bgtxtOliveLightest = BezierColor(functionalColorToken: .bgOliveLightest)
  
  @available(*, deprecated, renamed: "bgOliveLighter", message: "Use `bgOliveLighter` instead.")
  public static let bgtxtOliveLighter = BezierColor(functionalColorToken: .bgOliveLighter)
  
  @available(*, deprecated, message: "Use `fgOliveLight` for icon and text colors, and `bgOliveLight` for background color instead.")
  public static let bgtxtOliveLight = BezierColor(functionalColorToken: .bgOliveLight)
  
  @available(*, deprecated, message: "Use `fgOliveNormal` for icon and text colors, and `bgOliveNormal` for background color instead.")
  public static let bgtxtOliveNormal = BezierColor(functionalColorToken: .bgOliveNormal)
  
  @available(*, deprecated, message: "Use `fgOliveDark` for icon and text colors, and `bgOliveDark` for background color instead.")
  public static let bgtxtOliveDark = BezierColor(functionalColorToken: .bgOliveDark)
  
  // MARK: - Appendix, Yellow
  @available(*, deprecated, renamed: "bgYellowLightest", message: "Use `bgYellowLightest` instead.")
  public static let bgtxtYellowLightest = BezierColor(functionalColorToken: .bgYellowLightest)
  
  @available(*, deprecated, renamed: "bgYellowLighter", message: "Use `bgYellowLighter` instead.")
  public static let bgtxtYellowLighter = BezierColor(functionalColorToken: .bgYellowLighter)
  
  @available(*, deprecated, message: "Use `fgYellowLight` for icon and text colors, and `bgYellowLight` for background color instead.")
  public static let bgtxtYellowLight = BezierColor(functionalColorToken: .bgYellowLight)
  
  @available(*, deprecated, message: "Use `fgYellowNormal` for icon and text colors, and `bgYellowNormal` for background color instead.")
  public static let bgtxtYellowNormal = BezierColor(functionalColorToken: .bgYellowNormal)
  
  @available(*, deprecated, message: "Use `fgYellowDark` for icon and text colors, and `bgYellowDark` for background color instead.")
  public static let bgtxtYellowDark = BezierColor(functionalColorToken: .bgYellowDark)
  
  // MARK: - Appendix, Orange
  @available(*, deprecated, renamed: "bgOrangeLightest", message: "Use `bgOrangeLightest` instead.")
  public static let bgtxtOrangeLightest = BezierColor(functionalColorToken: .bgOrangeLightest)
  
  @available(*, deprecated, renamed: "bgOrangeLighter", message: "Use `bgOrangeLighter` instead.")
  public static let bgtxtOrangeLighter = BezierColor(functionalColorToken: .bgOrangeLighter)
  
  @available(*, deprecated, message: "Use `fgOrangeLight` for icon and text colors, and `bgOrangeLight` for background color instead.")
  public static let bgtxtOrangeLight = BezierColor(functionalColorToken: .bgOrangeLight)
  
  @available(*, deprecated, message: "Use `fgOrangeNormal` for icon and text colors, and `bgOrangeNormal` for background color instead.")
  public static let bgtxtOrangeNormal = BezierColor(functionalColorToken: .bgOrangeNormal)
  
  @available(*, deprecated, message: "Use `fgOrangeDark` for icon and text colors, and `bgOrangeDark` for background color instead.")
  public static let bgtxtOrangeDark = BezierColor(functionalColorToken: .bgOrangeDark)
  
  // MARK: - Appendix, Red
  @available(*, deprecated, renamed: "bgRedLightest", message: "Use `bgRedLightest` instead.")
  public static let bgtxtRedLightest = BezierColor(functionalColorToken: .bgRedLightest)
  
  @available(*, deprecated, renamed: "bgRedLighter", message: "Use `bgRedLighter` instead.")
  public static let bgtxtRedLighter = BezierColor(functionalColorToken: .bgRedLighter)
  
  @available(*, deprecated, message: "Use `fgRedLight` for icon and text colors, and `bgRedLight` for background color instead.")
  public static let bgtxtRedLight = BezierColor(functionalColorToken: .bgRedLight)
  
  @available(*, deprecated, message: "Use `fgRedNormal` for icon and text colors, and `bgRedNormal` for background color instead.")
  public static let bgtxtRedNormal = BezierColor(functionalColorToken: .bgRedNormal)
  
  @available(*, deprecated, message: "Use `fgRedDark` for icon and text colors, and `bgRedDark` for background color instead.")
  public static let bgtxtRedDark = BezierColor(functionalColorToken: .bgRedDark)
  
  // MARK: - Appendix, Pink
  @available(*, deprecated, renamed: "bgPinkLightest", message: "Use `bgPinkLightest` instead.")
  public static let bgtxtPinkLightest = BezierColor(functionalColorToken: .bgPinkLightest)
  
  @available(*, deprecated, renamed: "bgPinkLighter", message: "Use `bgPinkLighter` instead.")
  public static let bgtxtPinkLighter = BezierColor(functionalColorToken: .bgPinkLighter)
  
  @available(*, deprecated, message: "Use `fgPinkLight` for icon and text colors, and `bgPinkLight` for background color instead.")
  public static let bgtxtPinkLight = BezierColor(functionalColorToken: .bgPinkLight)
  
  @available(*, deprecated, message: "Use `fgPinkNormal` for icon and text colors, and `bgPinkNormal` for background color instead.")
  public static let bgtxtPinkNormal = BezierColor(functionalColorToken: .bgPinkNormal)
  
  @available(*, deprecated, message: "Use `fgPinkDark` for icon and text colors, and `bgPinkDark` for background color instead.")
  public static let bgtxtPinkDark = BezierColor(functionalColorToken: .bgPinkDark)
  
  // MARK: - Appendix, Purple
  @available(*, deprecated, renamed: "bgPurpleLightest", message: "Use `bgPurpleLightest` instead.")
  public static let bgtxtPurpleLightest = BezierColor(functionalColorToken: .bgPurpleLightest)
  
  @available(*, deprecated, renamed: "bgPurpleLighter", message: "Use `bgPurpleLighter` instead.")
  public static let bgtxtPurpleLighter = BezierColor(functionalColorToken: .bgPurpleLighter)
  
  @available(*, deprecated, message: "Use `fgPurpleLight` for icon and text colors, and `bgPurpleLight` for background color instead.")
  public static let bgtxtPurpleLight = BezierColor(functionalColorToken: .bgPurpleLight)
  
  @available(*, deprecated, message: "Use `fgPurpleNormal` for icon and text colors, and `bgPurpleNormal` for background color instead.")
  public static let bgtxtPurpleNormal = BezierColor(functionalColorToken: .bgPurpleNormal)
  
  @available(*, deprecated, message: "Use `fgPurpleDark` for icon and text colors, and `bgPurpleDark` for background color instead.")
  public static let bgtxtPurpleDark = BezierColor(functionalColorToken: .bgPurpleDark)
  
  // MARK: - Appendix, Navy
  @available(*, deprecated, renamed: "bgNavyLightest", message: "Use `bgNavyLightest` instead.")
  public static let bgtxtNavyLightest = BezierColor(functionalColorToken: .bgNavyLightest)
  
  @available(*, deprecated, renamed: "bgNavyLighter", message: "Use `bgNavyLighter` instead.")
  public static let bgtxtNavyLighter = BezierColor(functionalColorToken: .bgNavyLighter)
  
  @available(*, deprecated, message: "Use `fgNavyLight` for icon and text colors, and `bgNavyLight` for background color instead.")
  public static let bgtxtNavyLight = BezierColor(functionalColorToken: .bgNavyLight)
  
  @available(*, deprecated, message: "Use `fgNavyNormal` for icon and text colors, and `bgNavyNormal` for background color instead.")
  public static let bgtxtNavyNormal = BezierColor(functionalColorToken: .bgNavyNormal)
  
  @available(*, deprecated, message: "Use `fgNavyDark` for icon and text colors, and `bgNavyDark` for background color instead.")
  public static let bgtxtNavyDark = BezierColor(functionalColorToken: .bgNavyDark)
}

@_spi(color) public extension BezierColor {
  var lightColorTokenHex: String {
    self.bezierColor.lightColorToken.hex
  }
  
  var darkColorTokenHex: String {
    self.bezierColor.darkColorToken.hex
  }
}
