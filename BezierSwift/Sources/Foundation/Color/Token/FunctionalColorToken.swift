//
//  FunctionalColorToken.swift
//
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

internal struct FunctionalColorToken: BezierColorType {
  let lightColorToken: ColorToken
  let darkColorToken: ColorToken
  
  init(lightGlobalColorToken: GlobalColorToken, darkGlobalColorToken: GlobalColorToken) {
    self.lightColorToken = lightGlobalColorToken
    self.darkColorToken = darkGlobalColorToken
  }
}

// MARK: - ForegroundBlue
extension FunctionalColorToken {
  static var fgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300)
  static var fgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45)
  static var fgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue300)
}

// MARK: - ForegroundCobalt
extension FunctionalColorToken {
  static var fgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300)
  static var fgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45)
  static var fgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt300)
}

// MARK: - ForegroundRed
extension FunctionalColorToken {
  static var fgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300)
  static var fgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45)
  static var fgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red300)
}

// MARK: - ForegroundOrange
extension FunctionalColorToken {
  static var fgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300)
  static var fgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45)
  static var fgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange300)
}

// MARK: - ForegroundGreen
extension FunctionalColorToken {
  static var fgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300)
  static var fgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45)
  static var fgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green300)
}

// MARK: - ForegroundTeal
extension FunctionalColorToken {
  static var fgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300)
  static var fgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45)
  static var fgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal300)
}

// MARK: - ForegroundOlive
extension FunctionalColorToken {
  static var fgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300)
  static var fgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45)
  static var fgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive300)
}

// MARK: - ForegroundYellow
extension FunctionalColorToken {
  static var fgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300)
  static var fgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45)
  static var fgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow300)
}

// MARK: - ForegroundPink
extension FunctionalColorToken {
  static var fgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300)
  static var fgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45)
  static var fgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink300)
}

// MARK: - ForegroundPurple
extension FunctionalColorToken {
  static var fgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300)
  static var fgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45)
  static var fgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple300)
}

// MARK: - ForegroundNavy
extension FunctionalColorToken {
  static var fgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300)
  static var fgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45)
  static var fgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy300)
}

// MARK: - ForegroundGrey
extension FunctionalColorToken {
  static var fgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .grey100)
  static var fgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500)
  static var fgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600)
  static var fgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700)
  static var fgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800)
  static var fgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850)
}

// MARK: - ForegroundGreyAlpha
extension FunctionalColorToken {
  static var fgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80)
  static var fgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90)
  static var fgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80)
  static var fgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80)
}

// MARK: - ForegroundWhite
extension FunctionalColorToken {
  static var fgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900)
}

// MARK: - ForegroundBlack
extension FunctionalColorToken {
  static var fgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .white12)
  static var fgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .white20)
  static var fgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .white40)
  static var fgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .white60)
  static var fgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .white80)
  static var fgBlackPure = FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .white100)
}

// MARK: - ForegroundAbsoluteWhite
extension FunctionalColorToken {
  static var fgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .white20)
  static var fgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white40, darkGlobalColorToken: .white40)
  static var fgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .white60)
  static var fgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .white90)
  static var fgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .white100)
}

// MARK: - ForegroundAbsoluteBlack
extension FunctionalColorToken {
  static var fgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black20, darkGlobalColorToken: .black20)
  static var fgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .black40)
  static var fgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60)
  static var fgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .black85)
  static var fgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .black100)
}

// MARK: - BackgroundBlue
extension FunctionalColorToken {
  static var bgBlueNormal = FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300)
  static var bgBlueLight = FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45)
  static var bgBlueLighter = FunctionalColorToken(lightGlobalColorToken: .blue400_20, darkGlobalColorToken: .blue300_30)
  static var bgBlueLightest = FunctionalColorToken(lightGlobalColorToken: .blue400_10, darkGlobalColorToken: .blue300_15)
  static var bgBlueDark = FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue400)
  static var bgBlueShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400_20, darkGlobalColorToken: .shadeBlue600_40)
  static var bgBlueShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeBlue400, darkGlobalColorToken: .shadeBlue600)
}

// MARK: - BackgroundCobalt
extension FunctionalColorToken {
  static var bgCobaltNormal = FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300)
  static var bgCobaltLight = FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45)
  static var bgCobaltLighter = FunctionalColorToken(lightGlobalColorToken: .cobalt400_20, darkGlobalColorToken: .cobalt300_30)
  static var bgCobaltLightest = FunctionalColorToken(lightGlobalColorToken: .cobalt400_10, darkGlobalColorToken: .cobalt300_15)
  static var bgCobaltDark = FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt400)
  static var bgCobaltShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400_20, darkGlobalColorToken: .shadeCobalt600_40)
  static var bgCobaltShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400, darkGlobalColorToken: .shadeCobalt600)
}

// MARK: - BackgroundRed
extension FunctionalColorToken {
  static var bgRedNormal = FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300)
  static var bgRedLight = FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45)
  static var bgRedLighter = FunctionalColorToken(lightGlobalColorToken: .red400_20, darkGlobalColorToken: .red300_30)
  static var bgRedLightest = FunctionalColorToken(lightGlobalColorToken: .red400_10, darkGlobalColorToken: .red300_15)
  static var bgRedDark = FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red400)
  static var bgRedShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeRed400_20, darkGlobalColorToken: .shadeRed600_40)
  static var bgRedShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeRed400, darkGlobalColorToken: .shadeRed600)
}

// MARK: - BackgroundOrange
extension FunctionalColorToken {
  static var bgOrangeNormal = FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300)
  static var bgOrangeLight = FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45)
  static var bgOrangeLighter = FunctionalColorToken(lightGlobalColorToken: .orange400_20, darkGlobalColorToken: .orange300_30)
  static var bgOrangeLightest = FunctionalColorToken(lightGlobalColorToken: .orange400_10, darkGlobalColorToken: .orange300_15)
  static var bgOrangeDark = FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange400)
  static var bgOrangeShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400_20, darkGlobalColorToken: .shadeOrange600_40)
  static var bgOrangeShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOrange400, darkGlobalColorToken: .shadeOrange600)
}

// MARK: - BackgroundGreen
extension FunctionalColorToken {
  static var bgGreenNormal = FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300)
  static var bgGreenLight = FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45)
  static var bgGreenLighter = FunctionalColorToken(lightGlobalColorToken: .green400_20, darkGlobalColorToken: .green300_30)
  static var bgGreenLightest = FunctionalColorToken(lightGlobalColorToken: .green400_10, darkGlobalColorToken: .green300_15)
  static var bgGreenDark = FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green400)
  static var bgGreenShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400_20, darkGlobalColorToken: .shadeGreen600_40)
  static var bgGreenShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeGreen400, darkGlobalColorToken: .shadeGreen600)
}

// MARK: - BackgroundTeal
extension FunctionalColorToken {
  static var bgTealNormal = FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300)
  static var bgTealLight = FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45)
  static var bgTealLighter = FunctionalColorToken(lightGlobalColorToken: .teal400_20, darkGlobalColorToken: .teal300_30)
  static var bgTealLightest = FunctionalColorToken(lightGlobalColorToken: .teal400_10, darkGlobalColorToken: .teal300_15)
  static var bgTealDark = FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal400)
  static var bgTealShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400_20, darkGlobalColorToken: .shadeTeal600_40)
  static var bgTealShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeTeal400, darkGlobalColorToken: .shadeTeal600)
}

// MARK: - BackgroundOlive
extension FunctionalColorToken {
  static var bgOliveNormal = FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300)
  static var bgOliveLight = FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45)
  static var bgOliveLighter = FunctionalColorToken(lightGlobalColorToken: .olive400_20, darkGlobalColorToken: .olive300_30)
  static var bgOliveLightest = FunctionalColorToken(lightGlobalColorToken: .olive400_10, darkGlobalColorToken: .olive300_15)
  static var bgOliveDark = FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive400)
  static var bgOliveShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400_20, darkGlobalColorToken: .shadeOlive600_40)
  static var bgOliveShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeOlive400, darkGlobalColorToken: .shadeOlive600)
}

// MARK: - BackgroundYellow
extension FunctionalColorToken {
  static var bgYellowNormal = FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300)
  static var bgYellowLight = FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45)
  static var bgYellowLighter = FunctionalColorToken(lightGlobalColorToken: .yellow400_20, darkGlobalColorToken: .yellow300_30)
  static var bgYellowLightest = FunctionalColorToken(lightGlobalColorToken: .yellow400_10, darkGlobalColorToken: .yellow300_15)
  static var bgYellowDark = FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow400)
  static var bgYellowShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400_20, darkGlobalColorToken: .shadeYellow600_40)
  static var bgYellowShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeYellow400, darkGlobalColorToken: .shadeYellow600)
}

// MARK: - BackgroundPink
extension FunctionalColorToken {
  static var bgPinkNormal = FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300)
  static var bgPinkLight = FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45)
  static var bgPinkLighter = FunctionalColorToken(lightGlobalColorToken: .pink400_20, darkGlobalColorToken: .pink300_30)
  static var bgPinkLightest = FunctionalColorToken(lightGlobalColorToken: .pink400_10, darkGlobalColorToken: .pink300_15)
  static var bgPinkDark = FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink400)
  static var bgPinkShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadePink400_20, darkGlobalColorToken: .shadePink600_40)
  static var bgPinkShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePink400, darkGlobalColorToken: .shadePink600)
}

// MARK: - BackgroundPurple
extension FunctionalColorToken {
  static var bgPurpleNormal = FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300)
  static var bgPurpleLight = FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45)
  static var bgPurpleLighter = FunctionalColorToken(lightGlobalColorToken: .purple400_20, darkGlobalColorToken: .purple300_30)
  static var bgPurpleLightest = FunctionalColorToken(lightGlobalColorToken: .purple400_10, darkGlobalColorToken: .purple300_15)
  static var bgPurpleDark = FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple400)
  static var bgPurpleShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadePurple400_20, darkGlobalColorToken: .shadePurple600_40)
  static var bgPurpleShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadePurple400, darkGlobalColorToken: .shadePurple600)
}

// MARK: - BackgroundNavy
extension FunctionalColorToken {
  static var bgNavyNormal = FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300)
  static var bgNavyLight = FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45)
  static var bgNavyLighter = FunctionalColorToken(lightGlobalColorToken: .navy400_20, darkGlobalColorToken: .navy300_30)
  static var bgNavyLightest = FunctionalColorToken(lightGlobalColorToken: .navy400_10, darkGlobalColorToken: .navy300_15)
  static var bgNavyDark = FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy400)
  static var bgNavyShadeLight = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400_20, darkGlobalColorToken: .shadeNavy600_40)
  static var bgNavyShadeNormal = FunctionalColorToken(lightGlobalColorToken: .shadeNavy400, darkGlobalColorToken: .shadeNavy600)
}

// MARK: - BackgroundGrey
extension FunctionalColorToken {
  static var bgGreyDarkest = FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .white100)
  static var bgGreyDark = FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500)
  static var bgGreyNormal = FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600)
  static var bgGreyLight = FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700)
  static var bgGreyLighter = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800)
  static var bgGreyLightest = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850)
}

// MARK: - BackgroundGreyAlpha
extension FunctionalColorToken {
  static var bgGreyAlphaDarkest = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80)
  static var bgGreyAlphaDarker = FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90)
  static var bgGreyAlphaDark = FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80)
  static var bgGreyAlphaLight = FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80)
}

// MARK: - BackgroundBlack
extension FunctionalColorToken {
  static var bgBlackDarkest = FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60)
  static var bgBlackDarker = FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .white40)
  static var bgBlackDark = FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .white20)
  static var bgBlackLight = FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .white12)
  static var bgBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black5, darkGlobalColorToken: .white8)
  static var bgBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black3, darkGlobalColorToken: .white5)
}

// MARK: - BackgroundWhite
extension FunctionalColorToken {
  static var bgWhiteHighest = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey700)
  static var bgWhiteHigher = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey800)
  static var bgWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900)
}

// MARK: - BackgroundWhiteAlpha
extension FunctionalColorToken {
  static var bgWhiteAlphaLightest = FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .grey800_80)
  static var bgWhiteAlphaLighter = FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .black60)
  static var bgWhiteAlphaLight = FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .black20)
  static var bgWhiteAlphaTransparent = FunctionalColorToken(lightGlobalColorToken: .white0, darkGlobalColorToken: .white0)
}

// MARK: - BackgroundAbsoluteBlack
extension FunctionalColorToken {
  static var bgAbsoluteBlackDark = FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .black100)
  static var bgAbsoluteBlackNormal = FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .black85)
  static var bgAbsoluteBlackLight = FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60)
  static var bgAbsoluteBlackLighter = FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .black40)
  static var bgAbsoluteBlackLightest = FunctionalColorToken(lightGlobalColorToken: .black20, darkGlobalColorToken: .black20)
}

// MARK: - BackgroundAbsoluteWhite
extension FunctionalColorToken {
  static var bgAbsoluteWhiteDark = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .white100)
  static var bgAbsoluteWhiteNormal = FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .white90)
  static var bgAbsoluteWhiteLight = FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .white60)
  static var bgAbsoluteWhiteLighter = FunctionalColorToken(lightGlobalColorToken: .white40, darkGlobalColorToken: .white40)
  static var bgAbsoluteWhiteLightest = FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .white20)
}

// MARK: - Surface
extension FunctionalColorToken {
  static var surfaceLowest = FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800)
  static var surfaceLower = FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850)
  static var surfaceNormal = FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900)
}

// MARK: - Shadow
extension FunctionalColorToken {
  static var shadowXlarge = FunctionalColorToken(lightGlobalColorToken: .black30, darkGlobalColorToken: .black60)
  static var shadowLarge = FunctionalColorToken(lightGlobalColorToken: .black22, darkGlobalColorToken: .black40)
  static var shadowMedium = FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .black20)
  static var shadowSmall = FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .black15)
  static var shadowBase = FunctionalColorToken(lightGlobalColorToken: .black5, darkGlobalColorToken: .black8)
  static var shadowBaseInner = FunctionalColorToken(lightGlobalColorToken: .white12, darkGlobalColorToken: .white8)
}
