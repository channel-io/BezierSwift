//
//  FunctionalColorToken.swift
//
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

public struct FunctionalColorToken: BezierColorType {
  let lightGlobalColorToken: GlobalColorToken
  let darkGlobalColorToken: GlobalColorToken
  
  public func color(for bezierTheme: BezierTheme) -> Color {
    switch bezierTheme {
    case .light:
      return Color(globalColorToken: self.lightGlobalColorToken)
    case .dark:
      return Color(globalColorToken: self.darkGlobalColorToken)
    }
  }
  
  public func uiColor(for bezierTheme: BezierTheme) -> UIColor {
    switch bezierTheme {
    case .light:
      return UIColor(globalColorToken: self.lightGlobalColorToken)
    case .dark:
      return UIColor(globalColorToken: self.darkGlobalColorToken)
    }
  }
}

extension BezierColorType where Self == FunctionalColorToken {
  // MARK: - ForegroundBlue
  public static var fgBlueNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300) }
  public static var fgBlueLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45) }
  public static var fgBlueDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue300) }
  
  // MARK: - ForegroundCobalt
  public static var fgCobaltNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300) }
  public static var fgCobaltLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45) }
  public static var fgCobaltDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt300) }
  
  // MARK: - ForegroundRed
  public static var fgRedNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300) }
  public static var fgRedLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45) }
  public static var fgRedDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red300) }
  
  // MARK: - ForegroundOrange
  public static var fgOrangeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300) }
  public static var fgOrangeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45) }
  public static var fgOrangeDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange300) }
  
  // MARK: - ForegroundGreen
  public static var fgGreenNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300) }
  public static var fgGreenLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45) }
  public static var fgGreenDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green300) }
  
  // MARK: - ForegroundTeal
  public static var fgTealNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300) }
  public static var fgTealLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45) }
  public static var fgTealDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal300) }
  
  // MARK: - ForegroundOlive
  public static var fgOliveNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300) }
  public static var fgOliveLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45) }
  public static var fgOliveDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive300) }
  
  // MARK: - ForegroundYellow 
  public static var fgYellowNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300) }
  public static var fgYellowLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45) }
  public static var fgYellowDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow300) }
  
  // MARK: - ForegroundPink 
  public static var fgPinkNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300) }
  public static var fgPinkLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45) }
  public static var fgPinkDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink300) }
  
  // MARK: - ForegroundPurple 
  public static var fgPurpleNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300) }
  public static var fgPurpleLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45) }
  public static var fgPurpleDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple300) }
  
  // MARK: - ForegroundNavy 
  public static var fgNavyNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300) }
  public static var fgNavyLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45) }
  public static var fgNavyDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy300) }
  
  // MARK: - ForegroundGrey 
  public static var fgGreyDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .grey100) }
  public static var fgGreyDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500) }
  public static var fgGreyNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600) }
  public static var fgGreyLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700) }
  public static var fgGreyLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800) }
  public static var fgGreyLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850) }
  
  // MARK: - ForegroundGreyAlpha 
  public static var fgGreyAlphaDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80) }
  public static var fgGreyAlphaDarker: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90) }
  public static var fgGreyAlphaDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80) }
  public static var fgGreyAlphaLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80) }
  
  // MARK: - ForegroundWhite 
  public static var fgWhiteNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900) }
  
  // MARK: - ForegroundBlack 
  public static var fgBlackLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .white12) }
  public static var fgBlackLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .white20) }
  public static var fgBlackDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .white40) }
  public static var fgBlackDarker: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .white60) }
  public static var fgBlackDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .white80) }
  public static var fgBlackPure: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .white100) }
  
  // MARK: - ForegroundAbsoluteWhite 
  public static var fgAbsoluteWhiteLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .white20) }
  public static var fgAbsoluteWhiteLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white40, darkGlobalColorToken: .white40) }
  public static var fgAbsoluteWhiteLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .white60) }
  public static var fgAbsoluteWhiteNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .white90) }
  public static var fgAbsoluteWhiteDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .white100) }
  
  // MARK: - ForegroundAbsoluteBlack 
  public static var fgAbsoluteBlackLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black20, darkGlobalColorToken: .black20) }
  public static var fgAbsoluteBlackLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .black40) }
  public static var fgAbsoluteBlackLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60) }
  public static var fgAbsoluteBlackNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .black85) }
  public static var fgAbsoluteBlackDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .black100) }
  
  // MARK: - BackgroundBlue 
  public static var bgBlueNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400, darkGlobalColorToken: .blue300) }
  public static var bgBlueLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400_30, darkGlobalColorToken: .blue300_45) }
  public static var bgBlueLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400_20, darkGlobalColorToken: .blue300_30) }
  public static var bgBlueLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue400_10, darkGlobalColorToken: .blue300_15) }
  public static var bgBlueDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .blue500, darkGlobalColorToken: .blue400) }
  public static var bgBlueShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeBlue400_20, darkGlobalColorToken: .shadeBlue600_40) }
  public static var bgBlueShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeBlue400, darkGlobalColorToken: .shadeBlue600) }
  
  // MARK: - BackgroundCobalt 
  public static var bgCobaltNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400, darkGlobalColorToken: .cobalt300) }
  public static var bgCobaltLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400_30, darkGlobalColorToken: .cobalt300_45) }
  public static var bgCobaltLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400_20, darkGlobalColorToken: .cobalt300_30) }
  public static var bgCobaltLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt400_10, darkGlobalColorToken: .cobalt300_15) }
  public static var bgCobaltDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .cobalt500, darkGlobalColorToken: .cobalt400) }
  public static var bgCobaltShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400_20, darkGlobalColorToken: .shadeCobalt600_40) }
  public static var bgCobaltShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeCobalt400, darkGlobalColorToken: .shadeCobalt600) }
  
  // MARK: - BackgroundRed 
  public static var bgRedNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400, darkGlobalColorToken: .red300) }
  public static var bgRedLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400_30, darkGlobalColorToken: .red300_45) }
  public static var bgRedLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400_20, darkGlobalColorToken: .red300_30) }
  public static var bgRedLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red400_10, darkGlobalColorToken: .red300_15) }
  public static var bgRedDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .red500, darkGlobalColorToken: .red400) }
  public static var bgRedShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeRed400_20, darkGlobalColorToken: .shadeRed600_40) }
  public static var bgRedShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeRed400, darkGlobalColorToken: .shadeRed600) }
  
  // MARK: - BackgroundOrange 
  public static var bgOrangeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400, darkGlobalColorToken: .orange300) }
  public static var bgOrangeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400_30, darkGlobalColorToken: .orange300_45) }
  public static var bgOrangeLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400_20, darkGlobalColorToken: .orange300_30) }
  public static var bgOrangeLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange400_10, darkGlobalColorToken: .orange300_15) }
  public static var bgOrangeDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .orange500, darkGlobalColorToken: .orange400) }
  public static var bgOrangeShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeOrange400_20, darkGlobalColorToken: .shadeOrange600_40) }
  public static var bgOrangeShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeOrange400, darkGlobalColorToken: .shadeOrange600) }
  
  // MARK: - BackgroundGreen 
  public static var bgGreenNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400, darkGlobalColorToken: .green300) }
  public static var bgGreenLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400_30, darkGlobalColorToken: .green300_45) }
  public static var bgGreenLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400_20, darkGlobalColorToken: .green300_30) }
  public static var bgGreenLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green400_10, darkGlobalColorToken: .green300_15) }
  public static var bgGreenDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .green500, darkGlobalColorToken: .green400) }
  public static var bgGreenShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeGreen400_20, darkGlobalColorToken: .shadeGreen600_40) }
  public static var bgGreenShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeGreen400, darkGlobalColorToken: .shadeGreen600) }
  
  // MARK: - BackgroundTeal 
  public static var bgTealNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400, darkGlobalColorToken: .teal300) }
  public static var bgTealLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400_30, darkGlobalColorToken: .teal300_45) }
  public static var bgTealLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400_20, darkGlobalColorToken: .teal300_30) }
  public static var bgTealLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal400_10, darkGlobalColorToken: .teal300_15) }
  public static var bgTealDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .teal500, darkGlobalColorToken: .teal400) }
  public static var bgTealShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeTeal400_20, darkGlobalColorToken: .shadeTeal600_40) }
  public static var bgTealShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeTeal400, darkGlobalColorToken: .shadeTeal600) }
  
  // MARK: - BackgroundOlive 
  public static var bgOliveNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400, darkGlobalColorToken: .olive300) }
  public static var bgOliveLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400_30, darkGlobalColorToken: .olive300_45) }
  public static var bgOliveLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400_20, darkGlobalColorToken: .olive300_30) }
  public static var bgOliveLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive400_10, darkGlobalColorToken: .olive300_15) }
  public static var bgOliveDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .olive500, darkGlobalColorToken: .olive400) }
  public static var bgOliveShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeOlive400_20, darkGlobalColorToken: .shadeOlive600_40) }
  public static var bgOliveShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeOlive400, darkGlobalColorToken: .shadeOlive600) }
  
  // MARK: - BackgroundYellow 
  public static var bgYellowNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400, darkGlobalColorToken: .yellow300) }
  public static var bgYellowLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400_30, darkGlobalColorToken: .yellow300_45) }
  public static var bgYellowLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400_20, darkGlobalColorToken: .yellow300_30) }
  public static var bgYellowLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow400_10, darkGlobalColorToken: .yellow300_15) }
  public static var bgYellowDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .yellow500, darkGlobalColorToken: .yellow400) }
  public static var bgYellowShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeYellow400_20, darkGlobalColorToken: .shadeYellow600_40) }
  public static var bgYellowShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeYellow400, darkGlobalColorToken: .shadeYellow600) }
  
  // MARK: - BackgroundPink 
  public static var bgPinkNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400, darkGlobalColorToken: .pink300) }
  public static var bgPinkLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400_30, darkGlobalColorToken: .pink300_45) }
  public static var bgPinkLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400_20, darkGlobalColorToken: .pink300_30) }
  public static var bgPinkLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink400_10, darkGlobalColorToken: .pink300_15) }
  public static var bgPinkDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .pink500, darkGlobalColorToken: .pink400) }
  public static var bgPinkShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadePink400_20, darkGlobalColorToken: .shadePink600_40) }
  public static var bgPinkShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadePink400, darkGlobalColorToken: .shadePink600) }
  
  // MARK: - BackgroundPurple 
  public static var bgPurpleNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400, darkGlobalColorToken: .purple300) }
  public static var bgPurpleLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400_30, darkGlobalColorToken: .purple300_45) }
  public static var bgPurpleLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400_20, darkGlobalColorToken: .purple300_30) }
  public static var bgPurpleLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple400_10, darkGlobalColorToken: .purple300_15) }
  public static var bgPurpleDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .purple500, darkGlobalColorToken: .purple400) }
  public static var bgPurpleShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadePurple400_20, darkGlobalColorToken: .shadePurple600_40) }
  public static var bgPurpleShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadePurple400, darkGlobalColorToken: .shadePurple600) }
  
  // MARK: - BackgroundNavy 
  public static var bgNavyNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400, darkGlobalColorToken: .navy300) }
  public static var bgNavyLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400_30, darkGlobalColorToken: .navy300_45) }
  public static var bgNavyLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400_20, darkGlobalColorToken: .navy300_30) }
  public static var bgNavyLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy400_10, darkGlobalColorToken: .navy300_15) }
  public static var bgNavyDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .navy500, darkGlobalColorToken: .navy400) }
  public static var bgNavyShadeLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeNavy400_20, darkGlobalColorToken: .shadeNavy600_40) }
  public static var bgNavyShadeNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .shadeNavy400, darkGlobalColorToken: .shadeNavy600) }
  
  // MARK: - BackgroundGrey 
  public static var bgGreyDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey900, darkGlobalColorToken: .white100) }
  public static var bgGreyDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey500, darkGlobalColorToken: .grey500) }
  public static var bgGreyNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey400, darkGlobalColorToken: .grey600) }
  public static var bgGreyLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200, darkGlobalColorToken: .grey700) }
  public static var bgGreyLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800) }
  public static var bgGreyLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850) }
  
  // MARK: - BackgroundGreyAlpha 
  public static var bgGreyAlphaDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey700_80) }
  public static var bgGreyAlphaDarker: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey200_80, darkGlobalColorToken: .grey800_90) }
  public static var bgGreyAlphaDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey100_80, darkGlobalColorToken: .grey800_80) }
  public static var bgGreyAlphaLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey50_80, darkGlobalColorToken: .grey850_80) }
  
  // MARK: - BackgroundBlack 
  public static var bgBlackDarkest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60) }
  public static var bgBlackDarker: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .white40) }
  public static var bgBlackDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .white20) }
  public static var bgBlackLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .white12) }
  public static var bgBlackLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black5, darkGlobalColorToken: .white8) }
  public static var bgBlackLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black3, darkGlobalColorToken: .white5) }
  
  // MARK: - BackgroundWhite 
  public static var bgWhiteHighest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey700) }
  public static var bgWhiteHigher: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey800) }
  public static var bgWhiteNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900) }
  
  // MARK: - BackgroundWhiteAlpha 
  public static var bgWhiteAlphaLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .grey800_80) }
  public static var bgWhiteAlphaLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .black60) }
  public static var bgWhiteAlphaLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .black20) }
  public static var bgWhiteAlphaTransparent: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white0, darkGlobalColorToken: .white0) }
  
  // MARK: - BackgroundAbsoluteBlack 
  public static var bgAbsoluteBlackDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black100, darkGlobalColorToken: .black100) }
  public static var bgAbsoluteBlackNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black85, darkGlobalColorToken: .black85) }
  public static var bgAbsoluteBlackLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black60, darkGlobalColorToken: .black60) }
  public static var bgAbsoluteBlackLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black40, darkGlobalColorToken: .black40) }
  public static var bgAbsoluteBlackLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black20, darkGlobalColorToken: .black20) }
  
  // MARK: - BackgroundAbsoluteWhite 
  public static var bgAbsoluteWhiteDark: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .white100) }
  public static var bgAbsoluteWhiteNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white90, darkGlobalColorToken: .white90) }
  public static var bgAbsoluteWhiteLight: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white60, darkGlobalColorToken: .white60) }
  public static var bgAbsoluteWhiteLighter: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white40, darkGlobalColorToken: .white40) }
  public static var bgAbsoluteWhiteLightest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white20, darkGlobalColorToken: .white20) }
  
  // MARK: - Surface 
  public static var surfaceLowest: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey100, darkGlobalColorToken: .grey800) }
  public static var surfaceLower: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .grey50, darkGlobalColorToken: .grey850) }
  public static var surfaceNormal: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white100, darkGlobalColorToken: .grey900) }
  
  // MARK: - Shadow 
  public static var shadowXlarge: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black30, darkGlobalColorToken: .black60) }
  public static var shadowLarge: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black22, darkGlobalColorToken: .black40) }
  public static var shadowMedium: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black15, darkGlobalColorToken: .black20) }
  public static var shadowSmall: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black8, darkGlobalColorToken: .black15) }
  public static var shadowBase: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .black5, darkGlobalColorToken: .black8) }
  public static var shadowBaseInner: FunctionalColorToken { FunctionalColorToken(lightGlobalColorToken: .white12, darkGlobalColorToken: .white8) }
}
