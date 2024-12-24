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
  static var fgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.fgBlueNormal)
  static var fgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45, pressedColorToken: PressedColorToken.fgBlueLight)
  static var fgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.fgBlueDark)
}

// MARK: - ForegroundCobalt
extension FunctionalColorToken {
  static var fgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.fgCobaltNormal)
  static var fgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45, pressedColorToken: PressedColorToken.fgCobaltLight)
  static var fgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.fgCobaltDark)
}

// MARK: - ForegroundRed
extension FunctionalColorToken {
  static var fgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.fgRedNormal)
  static var fgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45, pressedColorToken: PressedColorToken.fgRedLight)
  static var fgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.fgRedDark)
}

// MARK: - ForegroundOrange
extension FunctionalColorToken {
  static var fgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.fgOrangeNormal)
  static var fgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45, pressedColorToken: PressedColorToken.fgOrangeLight)
  static var fgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.fgOrangeDark)
}

// MARK: - ForegroundGreen
extension FunctionalColorToken {
  static var fgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.fgGreenNormal)
  static var fgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45, pressedColorToken: PressedColorToken.fgGreenLight)
  static var fgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.fgGreenDark)
}

// MARK: - ForegroundTeal
extension FunctionalColorToken {
  static var fgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.fgTealNormal)
  static var fgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45, pressedColorToken: PressedColorToken.fgTealLight)
  static var fgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.fgTealDark)
}

// MARK: - ForegroundOlive
extension FunctionalColorToken {
  static var fgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.fgOliveNormal)
  static var fgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45, pressedColorToken: PressedColorToken.fgOliveLight)
  static var fgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.fgOliveDark)
}

// MARK: - ForegroundYellow
extension FunctionalColorToken {
  static var fgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.fgYellowNormal)
  static var fgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45, pressedColorToken: PressedColorToken.fgYellowLight)
  static var fgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.fgYellowDark)
}

// MARK: - ForegroundPink
extension FunctionalColorToken {
  static var fgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.fgPinkNormal)
  static var fgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45, pressedColorToken: PressedColorToken.fgPinkLight)
  static var fgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.fgPinkDark)
}

// MARK: - ForegroundPurple
extension FunctionalColorToken {
  static var fgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.fgPurpleNormal)
  static var fgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45, pressedColorToken: PressedColorToken.fgPurpleLight)
  static var fgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.fgPurpleDark)
}

// MARK: - ForegroundNavy
extension FunctionalColorToken {
  static var fgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.fgNavyNormal)
  static var fgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45, pressedColorToken: PressedColorToken.fgNavyLight)
  static var fgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.fgNavyDark)
}

// MARK: - ForegroundGrey
extension FunctionalColorToken {
  static var fgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .grey100, pressedColorToken: PressedColorToken.fgGreyDarkest)
  static var fgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500, pressedColorToken: PressedColorToken.fgGreyDark)
  static var fgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600, pressedColorToken: PressedColorToken.fgGreyNormal)
  static var fgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.fgGreyLight)
  static var fgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.fgGreyLighter)
  static var fgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.fgGreyLightest)
}

// MARK: - ForegroundGreyAlpha
extension FunctionalColorToken {
  static var fgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80, pressedColorToken: PressedColorToken.fgGreyAlphaDarkest)
  static var fgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90, pressedColorToken: PressedColorToken.fgGreyAlphaDarker)
  static var fgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.fgGreyAlphaDark)
  static var fgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80, pressedColorToken: PressedColorToken.fgGreyAlphaLight)
}

// MARK: - ForegroundWhite
extension FunctionalColorToken {
  static var fgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.fgWhiteNormal)
}

// MARK: - ForegroundBlack
extension FunctionalColorToken {
  static var fgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .white_12, pressedColorToken: PressedColorToken.fgBlackLightest)
  static var fgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.fgBlackLight)
  static var fgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.fgBlackDark)
  static var fgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.fgBlackDarker)
  static var fgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .white_80, pressedColorToken: PressedColorToken.fgBlackDarkest)
  static var fgBlackPure = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.fgBlackPure)
}

// MARK: - ForegroundAbsoluteWhite
extension FunctionalColorToken {
  static var fgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLightest)
  static var fgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLighter)
  static var fgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.fgAbsoluteWhiteLight)
  static var fgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .white_90, pressedColorToken: PressedColorToken.fgAbsoluteWhiteNormal)
  static var fgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.fgAbsoluteWhiteDark)
}

// MARK: - ForegroundAbsoluteBlack
extension FunctionalColorToken {
  static var fgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.fgAbsoluteBlackLightest)
  static var fgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.fgAbsoluteBlackLighter)
  static var fgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.fgAbsoluteBlackLight)
  static var fgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .black_85, pressedColorToken: PressedColorToken.fgAbsoluteBlackNormal)
  static var fgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .black_100, pressedColorToken: PressedColorToken.fgAbsoluteBlackDark)
}

// MARK: - BackgroundBlue
extension FunctionalColorToken {
  static var bgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300, pressedColorToken: PressedColorToken.bgBlueNormal)
  static var bgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45, pressedColorToken: PressedColorToken.bgBlueLight)
  static var bgBlueLighter = FunctionalColorToken(lightGlobalColorToken: .blue400_20, darkGlobalColorToken: .blue300_30, pressedColorToken: PressedColorToken.bgBlueLighter)
  static var bgBlueLightest = FunctionalColorToken(lightGlobalColorToken: .blue400_10, darkGlobalColorToken: .blue300_15, pressedColorToken: PressedColorToken.bgBlueLightest)
  static var bgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue400, pressedColorToken: PressedColorToken.bgBlueDark)
  static var bgBlueShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400_20, darkGlobalColorToken: .shadeBlue600_40, pressedColorToken: PressedColorToken.bgBlueShadeLighter)
  static var bgBlueShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400, darkGlobalColorToken: .shadeBlue600, pressedColorToken: PressedColorToken.bgBlueShadeNormal)
  static var bgBlueTransparent = FunctionalColorToken(lightGlobalColorToken: .blue400_0, darkGlobalColorToken: .blue300_0, pressedColorToken: PressedColorToken.bgBlueTransparent)
}

// MARK: - BackgroundCobalt
extension FunctionalColorToken {
  static var bgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300, pressedColorToken: PressedColorToken.bgCobaltNormal)
  static var bgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45, pressedColorToken: PressedColorToken.bgCobaltLight)
  static var bgCobaltLighter = FunctionalColorToken(lightGlobalColorToken: .cobalt400_20, darkGlobalColorToken: .cobalt300_30, pressedColorToken: PressedColorToken.bgCobaltLighter)
  static var bgCobaltLightest = FunctionalColorToken(lightGlobalColorToken: .cobalt400_10, darkGlobalColorToken: .cobalt300_15, pressedColorToken: PressedColorToken.bgCobaltLightest)
  static var bgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt400, pressedColorToken: PressedColorToken.bgCobaltDark)
  static var bgCobaltShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400_20, darkGlobalColorToken: .shadeCobalt600_40, pressedColorToken: PressedColorToken.bgCobaltShadeLighter)
  static var bgCobaltShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400, darkGlobalColorToken: .shadeCobalt600, pressedColorToken: PressedColorToken.bgCobaltShadeNormal)
  static var bgCobaltTransparent = FunctionalColorToken(lightGlobalColorToken: .cobalt400_0, darkGlobalColorToken: .cobalt300_0, pressedColorToken: PressedColorToken.bgCobaltTransparent)
}

// MARK: - BackgroundRed
extension FunctionalColorToken {
  static var bgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300, pressedColorToken: PressedColorToken.bgRedNormal)
  static var bgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45, pressedColorToken: PressedColorToken.bgRedLight)
  static var bgRedLighter = FunctionalColorToken(lightGlobalColorToken: .red400_20, darkGlobalColorToken: .red300_30, pressedColorToken: PressedColorToken.bgRedLighter)
  static var bgRedLightest = FunctionalColorToken(lightGlobalColorToken: .red400_10, darkGlobalColorToken: .red300_15, pressedColorToken: PressedColorToken.bgRedLightest)
  static var bgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red400, pressedColorToken: PressedColorToken.bgRedDark)
  static var bgRedShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeRed400_20, darkGlobalColorToken: .shadeRed600_40, pressedColorToken: PressedColorToken.bgRedShadeLighter)
  static var bgRedShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeRed400, darkGlobalColorToken: .shadeRed600, pressedColorToken: PressedColorToken.bgRedShadeNormal)
  static var bgRedTransparent = FunctionalColorToken(lightGlobalColorToken: .red400_0, darkGlobalColorToken: .red300_0, pressedColorToken: PressedColorToken.bgRedTransparent)
}

// MARK: - BackgroundOrange
extension FunctionalColorToken {
  static var bgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300, pressedColorToken: PressedColorToken.bgOrangeNormal)
  static var bgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45, pressedColorToken: PressedColorToken.bgOrangeLight)
  static var bgOrangeLighter = FunctionalColorToken(lightGlobalColorToken: .orange400_20, darkGlobalColorToken: .orange300_30, pressedColorToken: PressedColorToken.bgOrangeLighter)
  static var bgOrangeLightest = FunctionalColorToken(lightGlobalColorToken: .orange400_10, darkGlobalColorToken: .orange300_15, pressedColorToken: PressedColorToken.bgOrangeLightest)
  static var bgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange400, pressedColorToken: PressedColorToken.bgOrangeDark)
  static var bgOrangeShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400_20, darkGlobalColorToken: .shadeOrange600_40, pressedColorToken: PressedColorToken.bgOrangeShadeLighter)
  static var bgOrangeShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400, darkGlobalColorToken: .shadeOrange600, pressedColorToken: PressedColorToken.bgOrangeShadeNormal)
  static var bgOrangeTransparent = FunctionalColorToken(lightGlobalColorToken: .orange400_0, darkGlobalColorToken: .orange300_0, pressedColorToken: PressedColorToken.bgOrangeTransparent)
}

// MARK: - BackgroundGreen
extension FunctionalColorToken {
  static var bgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300, pressedColorToken: PressedColorToken.bgGreenNormal)
  static var bgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45, pressedColorToken: PressedColorToken.bgGreenLight)
  static var bgGreenLighter = FunctionalColorToken(lightGlobalColorToken: .green400_20, darkGlobalColorToken: .green300_30, pressedColorToken: PressedColorToken.bgGreenLighter)
  static var bgGreenLightest = FunctionalColorToken(lightGlobalColorToken: .green400_10, darkGlobalColorToken: .green300_15, pressedColorToken: PressedColorToken.bgGreenLightest)
  static var bgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green400, pressedColorToken: PressedColorToken.bgGreenDark)
  static var bgGreenShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400_20, darkGlobalColorToken: .shadeGreen600_40, pressedColorToken: PressedColorToken.bgGreenShadeLighter)
  static var bgGreenShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400, darkGlobalColorToken: .shadeGreen600, pressedColorToken: PressedColorToken.bgGreenShadeNormal)
  static var bgGreenTransparent = FunctionalColorToken(lightGlobalColorToken: .green400_0, darkGlobalColorToken: .green300_0, pressedColorToken: PressedColorToken.bgGreenTransparent)
}

// MARK: - BackgroundTeal
extension FunctionalColorToken {
  static var bgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300, pressedColorToken: PressedColorToken.bgTealNormal)
  static var bgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45, pressedColorToken: PressedColorToken.bgTealLight)
  static var bgTealLighter = FunctionalColorToken(lightGlobalColorToken: .teal400_20, darkGlobalColorToken: .teal300_30, pressedColorToken: PressedColorToken.bgTealLighter)
  static var bgTealLightest = FunctionalColorToken(lightGlobalColorToken: .teal400_10, darkGlobalColorToken: .teal300_15, pressedColorToken: PressedColorToken.bgTealLightest)
  static var bgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal400, pressedColorToken: PressedColorToken.bgTealDark)
  static var bgTealShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400_20, darkGlobalColorToken: .shadeTeal600_40, pressedColorToken: PressedColorToken.bgTealShadeLighter)
  static var bgTealShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400, darkGlobalColorToken: .shadeTeal600, pressedColorToken: PressedColorToken.bgTealShadeNormal)
  static var bgTealTransparent = FunctionalColorToken(lightGlobalColorToken: .teal400_0, darkGlobalColorToken: .teal300_0, pressedColorToken: PressedColorToken.bgTealTransparent)
}

// MARK: - BackgroundOlive
extension FunctionalColorToken {
  static var bgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300, pressedColorToken: PressedColorToken.bgOliveNormal)
  static var bgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45, pressedColorToken: PressedColorToken.bgOliveLight)
  static var bgOliveLighter = FunctionalColorToken(lightGlobalColorToken: .olive400_20, darkGlobalColorToken: .olive300_30, pressedColorToken: PressedColorToken.bgOliveLighter)
  static var bgOliveLightest = FunctionalColorToken(lightGlobalColorToken: .olive400_10, darkGlobalColorToken: .olive300_15, pressedColorToken: PressedColorToken.bgOliveLightest)
  static var bgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive400, pressedColorToken: PressedColorToken.bgOliveDark)
  static var bgOliveShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400_20, darkGlobalColorToken: .shadeOlive600_40, pressedColorToken: PressedColorToken.bgOliveShadeLighter)
  static var bgOliveShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400, darkGlobalColorToken: .shadeOlive600, pressedColorToken: PressedColorToken.bgOliveShadeNormal)
  static var bgOliveTransparent = FunctionalColorToken(lightGlobalColorToken: .olive400_0, darkGlobalColorToken: .olive300_0, pressedColorToken: PressedColorToken.bgOliveTransparent)
}

// MARK: - BackgroundYellow
extension FunctionalColorToken {
  static var bgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300, pressedColorToken: PressedColorToken.bgYellowNormal)
  static var bgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45, pressedColorToken: PressedColorToken.bgYellowLight)
  static var bgYellowLighter = FunctionalColorToken(lightGlobalColorToken: .yellow400_20, darkGlobalColorToken: .yellow300_30, pressedColorToken: PressedColorToken.bgYellowLighter)
  static var bgYellowLightest = FunctionalColorToken(lightGlobalColorToken: .yellow400_10, darkGlobalColorToken: .yellow300_15, pressedColorToken: PressedColorToken.bgYellowLightest)
  static var bgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow400, pressedColorToken: PressedColorToken.bgYellowDark)
  static var bgYellowShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400_20, darkGlobalColorToken: .shadeYellow600_40, pressedColorToken: PressedColorToken.bgYellowShadeLighter)
  static var bgYellowShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400, darkGlobalColorToken: .shadeYellow600, pressedColorToken: PressedColorToken.bgYellowShadeNormal)
  static var bgYellowTransparent = FunctionalColorToken(lightGlobalColorToken: .yellow400_0, darkGlobalColorToken: .yellow300_0, pressedColorToken: PressedColorToken.bgYellowTransparent)
}

// MARK: - BackgroundPink
extension FunctionalColorToken {
  static var bgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300, pressedColorToken: PressedColorToken.bgPinkNormal)
  static var bgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45, pressedColorToken: PressedColorToken.bgPinkLight)
  static var bgPinkLighter = FunctionalColorToken(lightGlobalColorToken: .pink400_20, darkGlobalColorToken: .pink300_30, pressedColorToken: PressedColorToken.bgPinkLighter)
  static var bgPinkLightest = FunctionalColorToken(lightGlobalColorToken: .pink400_10, darkGlobalColorToken: .pink300_15, pressedColorToken: PressedColorToken.bgPinkLightest)
  static var bgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink400, pressedColorToken: PressedColorToken.bgPinkDark)
  static var bgPinkShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadePink400_20, darkGlobalColorToken: .shadePink600_40, pressedColorToken: PressedColorToken.bgPinkShadeLighter)
  static var bgPinkShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePink400, darkGlobalColorToken: .shadePink600, pressedColorToken: PressedColorToken.bgPinkShadeNormal)
  static var bgPinkTransparent = FunctionalColorToken(lightGlobalColorToken: .pink400_0, darkGlobalColorToken: .pink300_0, pressedColorToken: PressedColorToken.bgPinkTransparent)
}

// MARK: - BackgroundPurple
extension FunctionalColorToken {
  static var bgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300, pressedColorToken: PressedColorToken.bgPurpleNormal)
  static var bgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45, pressedColorToken: PressedColorToken.bgPurpleLight)
  static var bgPurpleLighter = FunctionalColorToken(lightGlobalColorToken: .purple400_20, darkGlobalColorToken: .purple300_30, pressedColorToken: PressedColorToken.bgPurpleLighter)
  static var bgPurpleLightest = FunctionalColorToken(lightGlobalColorToken: .purple400_10, darkGlobalColorToken: .purple300_15, pressedColorToken: PressedColorToken.bgPurpleLightest)
  static var bgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple400, pressedColorToken: PressedColorToken.bgPurpleDark)
  static var bgPurpleShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadePurple400_20, darkGlobalColorToken: .shadePurple600_40, pressedColorToken: PressedColorToken.bgPurpleShadeLighter)
  static var bgPurpleShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePurple400, darkGlobalColorToken: .shadePurple600, pressedColorToken: PressedColorToken.bgPurpleShadeNormal)
  static var bgPurpleTransparent = FunctionalColorToken(lightGlobalColorToken: .purple400_0, darkGlobalColorToken: .purple300_0, pressedColorToken: PressedColorToken.bgPurpleTransparent)
}

// MARK: - BackgroundNavy
extension FunctionalColorToken {
  static var bgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300, pressedColorToken: PressedColorToken.bgNavyNormal)
  static var bgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45, pressedColorToken: PressedColorToken.bgNavyLight)
  static var bgNavyLighter = FunctionalColorToken(lightGlobalColorToken: .navy400_20, darkGlobalColorToken: .navy300_30, pressedColorToken: PressedColorToken.bgNavyLighter)
  static var bgNavyLightest = FunctionalColorToken(lightGlobalColorToken: .navy400_10, darkGlobalColorToken: .navy300_15, pressedColorToken: PressedColorToken.bgNavyLightest)
  static var bgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy400, pressedColorToken: PressedColorToken.bgNavyDark)
  static var bgNavyShadeLighter = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400_20, darkGlobalColorToken: .shadeNavy600_40, pressedColorToken: PressedColorToken.bgNavyShadeLighter)
  static var bgNavyShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400, darkGlobalColorToken: .shadeNavy600, pressedColorToken: PressedColorToken.bgNavyShadeNormal)
  static var bgNavyTransparent = FunctionalColorToken(lightGlobalColorToken: .navy400_0, darkGlobalColorToken: .navy300_0, pressedColorToken: PressedColorToken.bgNavyTransparent)
}

// MARK: - BackgroundGrey
extension FunctionalColorToken {
  static var bgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.bgGreyDarkest)
  static var bgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500, pressedColorToken: PressedColorToken.bgGreyDark)
  static var bgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600, pressedColorToken: PressedColorToken.bgGreyNormal)
  static var bgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.bgGreyLight)
  static var bgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.bgGreyLighter)
  static var bgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.bgGreyLightest)
  static var bgGreyTransparent = FunctionalColorToken(lightGlobalColorToken: .grey900_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgGreyTransparent)
}

// MARK: - BackgroundGreyAlpha
extension FunctionalColorToken {
  static var bgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80, pressedColorToken: PressedColorToken.bgGreyAlphaDarkest)
  static var bgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90, pressedColorToken: PressedColorToken.bgGreyAlphaDarker)
  static var bgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.bgGreyAlphaDark)
  static var bgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80, pressedColorToken: PressedColorToken.bgGreyAlphaLight)
}

// MARK: - BackgroundBlack
extension FunctionalColorToken {
  static var bgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgBlackDarkest)
  static var bgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.bgBlackDarker)
  static var bgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.bgBlackDark)
  static var bgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .white_12, pressedColorToken: PressedColorToken.bgBlackLight)
  static var bgBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_5, darkGlobalColorToken: .white_8, pressedColorToken: PressedColorToken.bgBlackLighter)
  static var bgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_3, darkGlobalColorToken: .white_5, pressedColorToken: PressedColorToken.bgBlackLightest)
  static var bgBlackTransparent = FunctionalColorToken(lightGlobalColorToken: .black_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgBlackTransparent)
}

// MARK: - BackgroundWhite
extension FunctionalColorToken {
  static var bgWhiteHighest = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey700, pressedColorToken: PressedColorToken.bgWhiteHighest)
  static var bgWhiteHigher = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.bgWhiteHigher)
  static var bgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.bgWhiteNormal)
  static var bgWhiteTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .grey900_0, pressedColorToken: PressedColorToken.bgWhiteTransparent)
}

// MARK: - BackgroundWhiteAlpha
extension FunctionalColorToken {
  static var bgWhiteAlphaLightest = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .grey800_80, pressedColorToken: PressedColorToken.bgWhiteAlphaLightest)
  static var bgWhiteAlphaLighter = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgWhiteAlphaLighter)
  static var bgWhiteAlphaLight = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.bgWhiteAlphaLight)
  static var bgWhiteAlphaTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgWhiteAlphaTransparent)
}

// MARK: - BackgroundAbsoluteBlack
extension FunctionalColorToken {
  static var bgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black_100, darkGlobalColorToken: .black_100, pressedColorToken: PressedColorToken.bgAbsoluteBlackDark)
  static var bgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_85, darkGlobalColorToken: .black_85, pressedColorToken: PressedColorToken.bgAbsoluteBlackNormal)
  static var bgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_60, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.bgAbsoluteBlackLight)
  static var bgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.bgAbsoluteBlackLighter)
  static var bgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.bgAbsoluteBlackLightest)
  static var bgAbsoluteBlackTransparent = FunctionalColorToken(lightGlobalColorToken: .black_0, darkGlobalColorToken: .black_0, pressedColorToken: PressedColorToken.bgAbsoluteBlackTransparent)
}

// MARK: - BackgroundAbsoluteWhite
extension FunctionalColorToken {
  static var bgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .white_100, pressedColorToken: PressedColorToken.bgAbsoluteWhiteDark)
  static var bgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white_90, darkGlobalColorToken: .white_90, pressedColorToken: PressedColorToken.bgAbsoluteWhiteNormal)
  static var bgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white_60, darkGlobalColorToken: .white_60, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLight)
  static var bgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white_40, darkGlobalColorToken: .white_40, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLighter)
  static var bgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white_20, darkGlobalColorToken: .white_20, pressedColorToken: PressedColorToken.bgAbsoluteWhiteLightest)
  static var bgAbsoluteWhiteTransparent = FunctionalColorToken(lightGlobalColorToken: .white_0, darkGlobalColorToken: .white_0, pressedColorToken: PressedColorToken.bgAbsoluteWhiteTransparent)
}

// MARK: - Surface
extension FunctionalColorToken {
  static var surfaceLowest = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800, pressedColorToken: PressedColorToken.surfaceLowest)
  static var surfaceLower = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850, pressedColorToken: PressedColorToken.surfaceLower)
  static var surfaceNormal = FunctionalColorToken(lightGlobalColorToken: .white_100, darkGlobalColorToken: .grey900, pressedColorToken: PressedColorToken.surfaceNormal)
}

// MARK: - Shadow
extension FunctionalColorToken {
  static var shadowXlarge = FunctionalColorToken(lightGlobalColorToken: .black_30, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.shadowXlarge)
  static var shadowLarge = FunctionalColorToken(lightGlobalColorToken: .black_22, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.shadowLarge)
  static var shadowMedium = FunctionalColorToken(lightGlobalColorToken: .black_15, darkGlobalColorToken: .black_20, pressedColorToken: PressedColorToken.shadowMedium)
  static var shadowSmall = FunctionalColorToken(lightGlobalColorToken: .black_8, darkGlobalColorToken: .black_15, pressedColorToken: PressedColorToken.shadowSmall)
  static var shadowBase = FunctionalColorToken(lightGlobalColorToken: .black_5, darkGlobalColorToken: .black_8, pressedColorToken: PressedColorToken.shadowBase)
  static var shadowBaseInner = FunctionalColorToken(lightGlobalColorToken: .white_12, darkGlobalColorToken: .white_8, pressedColorToken: PressedColorToken.shadowBaseInner)
}

// MARK: - Dim
extension FunctionalColorToken {
  static var dimBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black_40, darkGlobalColorToken: .black_60, pressedColorToken: PressedColorToken.dimBlackNormal)
  static var dimBlackLight = FunctionalColorToken(lightGlobalColorToken: .black_20, darkGlobalColorToken: .black_40, pressedColorToken: PressedColorToken.dimBlackLight)
}
