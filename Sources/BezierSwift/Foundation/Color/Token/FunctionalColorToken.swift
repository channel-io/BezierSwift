//
//  FunctionalColorToken.swift
//
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

internal struct FunctionalColorToken: BezierColorType {
  let lightColorToken: ColorTokenType
  let darkColorToken: ColorTokenType
  let pressedColorToken: ThemeableColorTokenType
  
  init(
    lightGlobalColorToken: GlobalColorToken,
    darkGlobalColorToken: GlobalColorToken,
    pressedColorToken: ThemeableColorTokenType
  ) {
    self.lightColorToken = lightGlobalColorToken
    self.darkColorToken = darkGlobalColorToken
    self.pressedColorToken = pressedColorToken
  }
}

// MARK: - ForegroundBlue
extension FunctionalColorToken {
  static let fgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.fgBlueNormal)
  static let fgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45, pressedColorToken: PressedColorToken.fgBlueLight)
  static let fgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.fgBlueDark)
}

// MARK: - ForegroundCobalt
extension FunctionalColorToken {
  static let fgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.fgCobaltNormal)
  static let fgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45, pressedColorToken: PressedColorToken.fgCobaltLight)
  static let fgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.fgCobaltDark)
}

// MARK: - ForegroundRed
extension FunctionalColorToken {
  static let fgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.fgRedNormal)
  static let fgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45, pressedColorToken: PressedColorToken.fgRedLight)
  static let fgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.fgRedDark)
}

// MARK: - ForegroundOrange
extension FunctionalColorToken {
  static let fgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.fgOrangeNormal)
  static let fgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45, pressedColorToken: PressedColorToken.fgOrangeLight)
  static let fgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.fgOrangeDark)
}

// MARK: - ForegroundGreen
extension FunctionalColorToken {
  static let fgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.fgGreenNormal)
  static let fgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45, pressedColorToken: PressedColorToken.fgGreenLight)
  static let fgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.fgGreenDark)
}

// MARK: - ForegroundTeal
extension FunctionalColorToken {
  static let fgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.fgTealNormal)
  static let fgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45, pressedColorToken: PressedColorToken.fgTealLight)
  static let fgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.fgTealDark)
}

// MARK: - ForegroundOlive
extension FunctionalColorToken {
  static let fgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.fgOliveNormal)
  static let fgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45, pressedColorToken: PressedColorToken.fgOliveLight)
  static let fgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.fgOliveDark)
}

// MARK: - ForegroundYellow
extension FunctionalColorToken {
  static let fgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.fgYellowNormal)
  static let fgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45, pressedColorToken: PressedColorToken.fgYellowLight)
  static let fgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.fgYellowDark)
}

// MARK: - ForegroundPink
extension FunctionalColorToken {
  static let fgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.fgPinkNormal)
  static let fgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45, pressedColorToken: PressedColorToken.fgPinkLight)
  static let fgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.fgPinkDark)
}

// MARK: - ForegroundPurple
extension FunctionalColorToken {
  static let fgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.fgPurpleNormal)
  static let fgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45, pressedColorToken: PressedColorToken.fgPurpleLight)
  static let fgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.fgPurpleDark)
}

// MARK: - ForegroundNavy
extension FunctionalColorToken {
  static let fgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.fgNavyNormal)
  static let fgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45, pressedColorToken: PressedColorToken.fgNavyLight)
  static let fgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.fgNavyDark)
}

// MARK: - ForegroundGrey
extension FunctionalColorToken {
  static let fgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .grey100, pressedColorToken: PressedColorToken.fgGreyDarkest)
  static let fgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500, pressedColorToken: PressedColorToken.fgGreyDark)
  static let fgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600, pressedColorToken: PressedColorToken.fgGreyNormal)
  static let fgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.fgGreyLight)
  static let fgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.fgGreyLighter)
  static let fgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.fgGreyLightest)
}

// MARK: - ForegroundGreyAlpha
extension FunctionalColorToken {
  static let fgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80, pressedColorToken: PressedColorToken.fgGreyAlphaDarkest)
  static let fgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90, pressedColorToken: PressedColorToken.fgGreyAlphaDarker)
  static let fgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.fgGreyAlphaDark)
  static let fgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80, pressedColorToken: PressedColorToken.fgGreyAlphaLight)
}

// MARK: - ForegroundWhite
extension FunctionalColorToken {
  static let fgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.fgWhiteNormal)
}

// MARK: - ForegroundBlack
extension FunctionalColorToken {
  static let fgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .white_12, pressedColorToken: PressedColorToken.fgBlackLightest)
  static let fgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.fgBlackLight)
  static let fgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.fgBlackDark)
  static let fgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.fgBlackDarker)
  static let fgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .white_80, pressedColorToken: PressedColorToken.fgBlackDarkest)
  static let fgBlackPure = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.fgBlackPure)
}

// MARK: - ForegroundAbsoluteWhite
extension FunctionalColorToken {
  static let fgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLightest)
  static let fgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLighter)
  static let fgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLight)
  static let fgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .white_90, pressedColorToken: PressedColorToken.fgAbsoluteWhiteNormal)
  static let fgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.fgAbsoluteWhiteDark)
}

// MARK: - ForegroundAbsoluteBlack
extension FunctionalColorToken {
  static let fgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.fgAbsoluteBlackLightest)
  static let fgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.fgAbsoluteBlackLighter)
  static let fgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.fgAbsoluteBlackLight)
  static let fgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .black_85, pressedColorToken: PressedColorToken.fgAbsoluteBlackNormal)
  static let fgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .black_100, pressedColorToken: PressedColorToken.fgAbsoluteBlackDark)
}

// MARK: - BackgroundBlue
extension FunctionalColorToken {
  static let bgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.bgBlueNormal)
  static let bgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45, pressedColorToken: PressedColorToken.bgBlueLight)
  static let bgBlueLighter = FunctionalColorToken(lightGlobalColorToken: .blue400_20, darkGlobalColorToken: .blue300_30, pressedColorToken: PressedColorToken.bgBlueLighter)
  static let bgBlueLightest = FunctionalColorToken(lightGlobalColorToken: .blue400_10, darkGlobalColorToken: .blue300_15, pressedColorToken: PressedColorToken.bgBlueLightest)
  static let bgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue400, pressedColorToken: PressedColorToken.bgBlueDark)
  static let bgBlueShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400_20, darkGlobalColorToken: .shadeBlue600_40, pressedColorToken: PressedColorToken.bgBlueShadeLighter)
  static let bgBlueShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400, darkGlobalColorToken: .shadeBlue600, pressedColorToken: PressedColorToken.bgBlueShadeNormal)
  static let bgBlueTransparent = FunctionalColorToken(lightGlobalColorToken: .blue400_0, darkGlobalColorToken: .blue300_0, pressedColorToken: PressedColorToken.bgBlueTransparent)
}

// MARK: - BackgroundCobalt
extension FunctionalColorToken {
  static let bgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.bgCobaltNormal)
  static let bgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45, pressedColorToken: PressedColorToken.bgCobaltLight)
  static let bgCobaltLighter = FunctionalColorToken(lightGlobalColorToken: .cobalt400_20, darkGlobalColorToken: .cobalt300_30, pressedColorToken: PressedColorToken.bgCobaltLighter)
  static let bgCobaltLightest = FunctionalColorToken(lightGlobalColorToken: .cobalt400_10, darkGlobalColorToken: .cobalt300_15, pressedColorToken: PressedColorToken.bgCobaltLightest)
  static let bgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt400, pressedColorToken: PressedColorToken.bgCobaltDark)
  static let bgCobaltShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400_20, darkGlobalColorToken: .shadeCobalt600_40, pressedColorToken: PressedColorToken.bgCobaltShadeLighter)
  static let bgCobaltShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400, darkGlobalColorToken: .shadeCobalt600, pressedColorToken: PressedColorToken.bgCobaltShadeNormal)
  static let bgCobaltTransparent = FunctionalColorToken(lightGlobalColorToken: .cobalt400_0, darkGlobalColorToken: .cobalt300_0, pressedColorToken: PressedColorToken.bgCobaltTransparent)
}

// MARK: - BackgroundRed
extension FunctionalColorToken {
  static let bgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.bgRedNormal)
  static let bgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45, pressedColorToken: PressedColorToken.bgRedLight)
  static let bgRedLighter = FunctionalColorToken(lightGlobalColorToken: .red400_20, darkGlobalColorToken: .red300_30, pressedColorToken: PressedColorToken.bgRedLighter)
  static let bgRedLightest = FunctionalColorToken(lightGlobalColorToken: .red400_10, darkGlobalColorToken: .red300_15, pressedColorToken: PressedColorToken.bgRedLightest)
  static let bgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red400, pressedColorToken: PressedColorToken.bgRedDark)
  static let bgRedShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeRed400_20, darkGlobalColorToken: .shadeRed600_40, pressedColorToken: PressedColorToken.bgRedShadeLighter)
  static let bgRedShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeRed400, darkGlobalColorToken: .shadeRed600, pressedColorToken: PressedColorToken.bgRedShadeNormal)
  static let bgRedTransparent = FunctionalColorToken(lightGlobalColorToken: .red400_0, darkGlobalColorToken: .red300_0, pressedColorToken: PressedColorToken.bgRedTransparent)
}

// MARK: - BackgroundOrange
extension FunctionalColorToken {
  static let bgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.bgOrangeNormal)
  static let bgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45, pressedColorToken: PressedColorToken.bgOrangeLight)
  static let bgOrangeLighter = FunctionalColorToken(lightGlobalColorToken: .orange400_20, darkGlobalColorToken: .orange300_30, pressedColorToken: PressedColorToken.bgOrangeLighter)
  static let bgOrangeLightest = FunctionalColorToken(lightGlobalColorToken: .orange400_10, darkGlobalColorToken: .orange300_15, pressedColorToken: PressedColorToken.bgOrangeLightest)
  static let bgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange400, pressedColorToken: PressedColorToken.bgOrangeDark)
  static let bgOrangeShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400_20, darkGlobalColorToken: .shadeOrange600_40, pressedColorToken: PressedColorToken.bgOrangeShadeLighter)
  static let bgOrangeShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400, darkGlobalColorToken: .shadeOrange600, pressedColorToken: PressedColorToken.bgOrangeShadeNormal)
  static let bgOrangeTransparent = FunctionalColorToken(lightGlobalColorToken: .orange400_0, darkGlobalColorToken: .orange300_0, pressedColorToken: PressedColorToken.bgOrangeTransparent)
}

// MARK: - BackgroundGreen
extension FunctionalColorToken {
  static let bgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.bgGreenNormal)
  static let bgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45, pressedColorToken: PressedColorToken.bgGreenLight)
  static let bgGreenLighter = FunctionalColorToken(lightGlobalColorToken: .green400_20, darkGlobalColorToken: .green300_30, pressedColorToken: PressedColorToken.bgGreenLighter)
  static let bgGreenLightest = FunctionalColorToken(lightGlobalColorToken: .green400_10, darkGlobalColorToken: .green300_15, pressedColorToken: PressedColorToken.bgGreenLightest)
  static let bgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green400, pressedColorToken: PressedColorToken.bgGreenDark)
  static let bgGreenShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400_20, darkGlobalColorToken: .shadeGreen600_40, pressedColorToken: PressedColorToken.bgGreenShadeLighter)
  static let bgGreenShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400, darkGlobalColorToken: .shadeGreen600, pressedColorToken: PressedColorToken.bgGreenShadeNormal)
  static let bgGreenTransparent = FunctionalColorToken(lightGlobalColorToken: .green400_0, darkGlobalColorToken: .green300_0, pressedColorToken: PressedColorToken.bgGreenTransparent)
}

// MARK: - BackgroundTeal
extension FunctionalColorToken {
  static let bgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.bgTealNormal)
  static let bgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45, pressedColorToken: PressedColorToken.bgTealLight)
  static let bgTealLighter = FunctionalColorToken(lightGlobalColorToken: .teal400_20, darkGlobalColorToken: .teal300_30, pressedColorToken: PressedColorToken.bgTealLighter)
  static let bgTealLightest = FunctionalColorToken(lightGlobalColorToken: .teal400_10, darkGlobalColorToken: .teal300_15, pressedColorToken: PressedColorToken.bgTealLightest)
  static let bgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal400, pressedColorToken: PressedColorToken.bgTealDark)
  static let bgTealShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400_20, darkGlobalColorToken: .shadeTeal600_40, pressedColorToken: PressedColorToken.bgTealShadeLighter)
  static let bgTealShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400, darkGlobalColorToken: .shadeTeal600, pressedColorToken: PressedColorToken.bgTealShadeNormal)
  static let bgTealTransparent = FunctionalColorToken(lightGlobalColorToken: .teal400_0, darkGlobalColorToken: .teal300_0, pressedColorToken: PressedColorToken.bgTealTransparent)
}

// MARK: - BackgroundOlive
extension FunctionalColorToken {
  static let bgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.bgOliveNormal)
  static let bgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45, pressedColorToken: PressedColorToken.bgOliveLight)
  static let bgOliveLighter = FunctionalColorToken(lightGlobalColorToken: .olive400_20, darkGlobalColorToken: .olive300_30, pressedColorToken: PressedColorToken.bgOliveLighter)
  static let bgOliveLightest = FunctionalColorToken(lightGlobalColorToken: .olive400_10, darkGlobalColorToken: .olive300_15, pressedColorToken: PressedColorToken.bgOliveLightest)
  static let bgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive400, pressedColorToken: PressedColorToken.bgOliveDark)
  static let bgOliveShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400_20, darkGlobalColorToken: .shadeOlive600_40, pressedColorToken: PressedColorToken.bgOliveShadeLighter)
  static let bgOliveShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400, darkGlobalColorToken: .shadeOlive600, pressedColorToken: PressedColorToken.bgOliveShadeNormal)
  static let bgOliveTransparent = FunctionalColorToken(lightGlobalColorToken: .olive400_0, darkGlobalColorToken: .olive300_0, pressedColorToken: PressedColorToken.bgOliveTransparent)
}

// MARK: - BackgroundYellow
extension FunctionalColorToken {
  static let bgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.bgYellowNormal)
  static let bgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45, pressedColorToken: PressedColorToken.bgYellowLight)
  static let bgYellowLighter = FunctionalColorToken(lightGlobalColorToken: .yellow400_20, darkGlobalColorToken: .yellow300_30, pressedColorToken: PressedColorToken.bgYellowLighter)
  static let bgYellowLightest = FunctionalColorToken(lightGlobalColorToken: .yellow400_10, darkGlobalColorToken: .yellow300_15, pressedColorToken: PressedColorToken.bgYellowLightest)
  static let bgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow400, pressedColorToken: PressedColorToken.bgYellowDark)
  static let bgYellowShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400_20, darkGlobalColorToken: .shadeYellow600_40, pressedColorToken: PressedColorToken.bgYellowShadeLighter)
  static let bgYellowShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400, darkGlobalColorToken: .shadeYellow600, pressedColorToken: PressedColorToken.bgYellowShadeNormal)
  static let bgYellowTransparent = FunctionalColorToken(lightGlobalColorToken: .yellow400_0, darkGlobalColorToken: .yellow300_0, pressedColorToken: PressedColorToken.bgYellowTransparent)
}

// MARK: - BackgroundPink
extension FunctionalColorToken {
  static let bgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.bgPinkNormal)
  static let bgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45, pressedColorToken: PressedColorToken.bgPinkLight)
  static let bgPinkLighter = FunctionalColorToken(lightGlobalColorToken: .pink400_20, darkGlobalColorToken: .pink300_30, pressedColorToken: PressedColorToken.bgPinkLighter)
  static let bgPinkLightest = FunctionalColorToken(lightGlobalColorToken: .pink400_10, darkGlobalColorToken: .pink300_15, pressedColorToken: PressedColorToken.bgPinkLightest)
  static let bgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink400, pressedColorToken: PressedColorToken.bgPinkDark)
  static let bgPinkShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadePink400_20, darkGlobalColorToken: .shadePink600_40, pressedColorToken: PressedColorToken.bgPinkShadeLighter)
  static let bgPinkShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePink400, darkGlobalColorToken: .shadePink600, pressedColorToken: PressedColorToken.bgPinkShadeNormal)
  static let bgPinkTransparent = FunctionalColorToken(lightGlobalColorToken: .pink400_0, darkGlobalColorToken: .pink300_0, pressedColorToken: PressedColorToken.bgPinkTransparent)
}

// MARK: - BackgroundPurple
extension FunctionalColorToken {
  static let bgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.bgPurpleNormal)
  static let bgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45, pressedColorToken: PressedColorToken.bgPurpleLight)
  static let bgPurpleLighter = FunctionalColorToken(lightGlobalColorToken: .purple400_20, darkGlobalColorToken: .purple300_30, pressedColorToken: PressedColorToken.bgPurpleLighter)
  static let bgPurpleLightest = FunctionalColorToken(lightGlobalColorToken: .purple400_10, darkGlobalColorToken: .purple300_15, pressedColorToken: PressedColorToken.bgPurpleLightest)
  static let bgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple400, pressedColorToken: PressedColorToken.bgPurpleDark)
  static let bgPurpleShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadePurple400_20, darkGlobalColorToken: .shadePurple600_40, pressedColorToken: PressedColorToken.bgPurpleShadeLighter)
  static let bgPurpleShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePurple400, darkGlobalColorToken: .shadePurple600, pressedColorToken: PressedColorToken.bgPurpleShadeNormal)
  static let bgPurpleTransparent = FunctionalColorToken(lightGlobalColorToken: .purple400_0, darkGlobalColorToken: .purple300_0, pressedColorToken: PressedColorToken.bgPurpleTransparent)
}

// MARK: - BackgroundNavy
extension FunctionalColorToken {
  static let bgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.bgNavyNormal)
  static let bgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45, pressedColorToken: PressedColorToken.bgNavyLight)
  static let bgNavyLighter = FunctionalColorToken(lightGlobalColorToken: .navy400_20, darkGlobalColorToken: .navy300_30, pressedColorToken: PressedColorToken.bgNavyLighter)
  static let bgNavyLightest = FunctionalColorToken(lightGlobalColorToken: .navy400_10, darkGlobalColorToken: .navy300_15, pressedColorToken: PressedColorToken.bgNavyLightest)
  static let bgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy400, pressedColorToken: PressedColorToken.bgNavyDark)
  static let bgNavyShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400_20, darkGlobalColorToken: .shadeNavy600_40, pressedColorToken: PressedColorToken.bgNavyShadeLighter)
  static let bgNavyShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400, darkGlobalColorToken: .shadeNavy600, pressedColorToken: PressedColorToken.bgNavyShadeNormal)
  static let bgNavyTransparent = FunctionalColorToken(lightGlobalColorToken: .navy400_0, darkGlobalColorToken: .navy300_0, pressedColorToken: PressedColorToken.bgNavyTransparent)
}

// MARK: - BackgroundGrey
extension FunctionalColorToken {
  static let bgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.bgGreyDarkest)
  static let bgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500, pressedColorToken: PressedColorToken.bgGreyDark)
  static let bgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600, pressedColorToken: PressedColorToken.bgGreyNormal)
  static let bgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.bgGreyLight)
  static let bgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.bgGreyLighter)
  static let bgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.bgGreyLightest)
  static let bgGreyTransparent = FunctionalColorToken(lightGlobalColorToken: .grey900_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgGreyTransparent)
}

// MARK: - BackgroundGreyAlpha
extension FunctionalColorToken {
  static let bgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80, pressedColorToken: PressedColorToken.bgGreyAlphaDarkest)
  static let bgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90, pressedColorToken: PressedColorToken.bgGreyAlphaDarker)
  static let bgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.bgGreyAlphaDark)
  static let bgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80, pressedColorToken: PressedColorToken.bgGreyAlphaLight)
}

// MARK: - BackgroundBlack
extension FunctionalColorToken {
  static let bgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgBlackDarkest)
  static let bgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.bgBlackDarker)
  static let bgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.bgBlackDark)
  static let bgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .white_12, pressedColorToken: PressedColorToken.bgBlackLight)
  static let bgBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_5, darkGlobalColorToken: .white_8, pressedColorToken: PressedColorToken.bgBlackLighter)
  static let bgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_3, darkGlobalColorToken: .white_5, pressedColorToken: PressedColorToken.bgBlackLightest)
  static let bgBlackTransparent = FunctionalColorToken(lightGlobalColorToken: .black_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgBlackTransparent)
}

// MARK: - BackgroundWhite
extension FunctionalColorToken {
  static let bgWhiteHighest = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.bgWhiteHighest)
  static let bgWhiteHigher = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.bgWhiteHigher)
  static let bgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.bgWhiteNormal)
  static let bgWhiteTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .grey900_0, pressedColorToken: PressedColorToken.bgWhiteTransparent)
}

// MARK: - BackgroundWhiteAlpha
extension FunctionalColorToken {
  static let bgWhiteAlphaLightest = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.bgWhiteAlphaLightest)
  static let bgWhiteAlphaLighter = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgWhiteAlphaLighter)
  static let bgWhiteAlphaLight = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.bgWhiteAlphaLight)
  static let bgWhiteAlphaTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgWhiteAlphaTransparent)
}

// MARK: - BackgroundAbsoluteBlack
extension FunctionalColorToken {
  static let bgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .black_100, pressedColorToken: PressedColorToken.bgAbsoluteBlackDark)
  static let bgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .black_85, pressedColorToken: PressedColorToken.bgAbsoluteBlackNormal)
  static let bgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgAbsoluteBlackLight)
  static let bgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.bgAbsoluteBlackLighter)
  static let bgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.bgAbsoluteBlackLightest)
  static let bgAbsoluteBlackTransparent = FunctionalColorToken(lightGlobalColorToken: .black_0, darkGlobalColorToken: .black_0, pressedColorToken: PressedColorToken.bgAbsoluteBlackTransparent)
}

// MARK: - BackgroundAbsoluteWhite
extension FunctionalColorToken {
  static let bgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.bgAbsoluteWhiteDark)
  static let bgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .white_90, pressedColorToken: PressedColorToken.bgAbsoluteWhiteNormal)
  static let bgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLight)
  static let bgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLighter)
  static let bgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLightest)
  static let bgAbsoluteWhiteTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgAbsoluteWhiteTransparent)
}

// MARK: - Surface
extension FunctionalColorToken {
  static let surfaceLowest = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.surfaceLowest)
  static let surfaceLower = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.surfaceLower)
  static let surfaceNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.surfaceNormal)
}

// MARK: - Shadow
extension FunctionalColorToken {
  static let shadowXlarge = FunctionalColorToken(lightGlobalColorToken: .black_30, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.shadowXlarge)
  static let shadowLarge = FunctionalColorToken(lightGlobalColorToken: .black_22, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.shadowLarge)
  static let shadowMedium = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.shadowMedium)
  static let shadowSmall = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .black_15, pressedColorToken: PressedColorToken.shadowSmall)
  static let shadowBase = FunctionalColorToken(lightGlobalColorToken: .black_5, darkGlobalColorToken: .black_8, pressedColorToken: PressedColorToken.shadowBase)
  static let shadowBaseInner = FunctionalColorToken(lightGlobalColorToken: .white_12, darkGlobalColorToken: .white_8, pressedColorToken: PressedColorToken.shadowBaseInner)
}

// MARK: - Dim
extension FunctionalColorToken {
  static let dimBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.dimBlackNormal)
  static let dimBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.dimBlackLight)
}
