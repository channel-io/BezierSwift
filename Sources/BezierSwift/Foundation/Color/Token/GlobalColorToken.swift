//
//  GlobalColorToken.swift
//
//
//  Created by Tom on 3/20/24.
//

import Foundation

struct GlobalColorToken: ColorTokenType {
  var hex: String
  
  init(hex: String) {
    self.hex = hex
  }
}

// MARK: - Blue
extension GlobalColorToken {
  static var blue600: GlobalColorToken { GlobalColorToken(hex: "#4941BC") }
  static var blue500: GlobalColorToken { GlobalColorToken(hex: "#5950DC") }
  static var blue400: GlobalColorToken { GlobalColorToken(hex: "#6D6AFC") }
  static var blue400_30: GlobalColorToken { GlobalColorToken(hex: "#6D6AFC4D") }
  static var blue400_20: GlobalColorToken { GlobalColorToken(hex: "#6D6AFC33") }
  static var blue400_10: GlobalColorToken { GlobalColorToken(hex: "#6D6AFC1A") }
  static var blue400_0: GlobalColorToken { GlobalColorToken(hex: "#6D6AFC00") }
  static var blue300: GlobalColorToken { GlobalColorToken(hex: "#7D9EFA") }
  static var blue300_45: GlobalColorToken { GlobalColorToken(hex: "#7D9EFA73") }
  static var blue300_30: GlobalColorToken { GlobalColorToken(hex: "#7D9EFA4D") }
  static var blue300_15: GlobalColorToken { GlobalColorToken(hex: "#7D9EFA26") }
  static var blue300_0: GlobalColorToken { GlobalColorToken(hex: "#7D9EFA00") }
  static var blue200: GlobalColorToken { GlobalColorToken(hex: "#96B7FF") }
  static var blue100: GlobalColorToken { GlobalColorToken(hex: "#A9C6FF") }
}

// MARK: - Cobalt
extension GlobalColorToken {
  static var cobalt600: GlobalColorToken { GlobalColorToken(hex: "#2B59B5") }
  static var cobalt500: GlobalColorToken { GlobalColorToken(hex: "#3870D1") }
  static var cobalt400: GlobalColorToken { GlobalColorToken(hex: "#5093E5") }
  static var cobalt400_30: GlobalColorToken { GlobalColorToken(hex: "#5093E54D") }
  static var cobalt400_20: GlobalColorToken { GlobalColorToken(hex: "#5093E533") }
  static var cobalt400_10: GlobalColorToken { GlobalColorToken(hex: "#5093E51A") }
  static var cobalt400_0: GlobalColorToken { GlobalColorToken(hex: "#5093E500") }
  static var cobalt300: GlobalColorToken { GlobalColorToken(hex: "#71B9F5") }
  static var cobalt300_45: GlobalColorToken { GlobalColorToken(hex: "#71B9F573") }
  static var cobalt300_30: GlobalColorToken { GlobalColorToken(hex: "#71B9F54D") }
  static var cobalt300_15: GlobalColorToken { GlobalColorToken(hex: "#71B9F526") }
  static var cobalt300_0: GlobalColorToken { GlobalColorToken(hex: "#71B9F500") }
  static var cobalt200: GlobalColorToken { GlobalColorToken(hex: "#8DCAFC") }
  static var cobalt100: GlobalColorToken { GlobalColorToken(hex: "#A1D5FF") }
}

// MARK: - Green
extension GlobalColorToken {
  static var green600: GlobalColorToken { GlobalColorToken(hex: "#327055") }
  static var green500: GlobalColorToken { GlobalColorToken(hex: "#358761") }
  static var green400: GlobalColorToken { GlobalColorToken(hex: "#40AD67") }
  static var green400_30: GlobalColorToken { GlobalColorToken(hex: "#40AD674D") }
  static var green400_20: GlobalColorToken { GlobalColorToken(hex: "#40AD6733") }
  static var green400_10: GlobalColorToken { GlobalColorToken(hex: "#40AD671A") }
  static var green400_0: GlobalColorToken { GlobalColorToken(hex: "#40AD6700") }
  static var green300: GlobalColorToken { GlobalColorToken(hex: "#68CC7F") }
  static var green300_45: GlobalColorToken { GlobalColorToken(hex: "#68CC7F73") }
  static var green300_30: GlobalColorToken { GlobalColorToken(hex: "#68CC7F4D") }
  static var green300_15: GlobalColorToken { GlobalColorToken(hex: "#68CC7F26") }
  static var green300_0: GlobalColorToken { GlobalColorToken(hex: "#68CC7F00") }
  static var green200: GlobalColorToken { GlobalColorToken(hex: "#84E09A") }
  static var green100: GlobalColorToken { GlobalColorToken(hex: "#A4ECB3") }
}

// MARK: - Red
extension GlobalColorToken {
  static var red600: GlobalColorToken { GlobalColorToken(hex: "#992C34") }
  static var red500: GlobalColorToken { GlobalColorToken(hex: "#BC3A42") }
  static var red400: GlobalColorToken { GlobalColorToken(hex: "#E55C5C") }
  static var red400_30: GlobalColorToken { GlobalColorToken(hex: "#E55C5C4D") }
  static var red400_20: GlobalColorToken { GlobalColorToken(hex: "#E55C5C33") }
  static var red400_10: GlobalColorToken { GlobalColorToken(hex: "#E55C5C1A") }
  static var red400_0: GlobalColorToken { GlobalColorToken(hex: "#E55C5C00") }
  static var red300: GlobalColorToken { GlobalColorToken(hex: "#FF8C8C") }
  static var red300_45: GlobalColorToken { GlobalColorToken(hex: "#FF8C8C73") }
  static var red300_30: GlobalColorToken { GlobalColorToken(hex: "#FF8C8C4D") }
  static var red300_15: GlobalColorToken { GlobalColorToken(hex: "#FF8C8C26") }
  static var red300_0: GlobalColorToken { GlobalColorToken(hex: "#FF8C8C00") }
  static var red200: GlobalColorToken { GlobalColorToken(hex: "#FFA6A6") }
  static var red100: GlobalColorToken { GlobalColorToken(hex: "#FFB8B8") }
}

// MARK: - Orange
extension GlobalColorToken {
  static var orange600: GlobalColorToken { GlobalColorToken(hex: "#A1540C") }
  static var orange500: GlobalColorToken { GlobalColorToken(hex: "#C1630D") }
  static var orange400: GlobalColorToken { GlobalColorToken(hex: "#E67F2B") }
  static var orange400_30: GlobalColorToken { GlobalColorToken(hex: "#E67F2B4D") }
  static var orange400_20: GlobalColorToken { GlobalColorToken(hex: "#E67F2B33") }
  static var orange400_10: GlobalColorToken { GlobalColorToken(hex: "#E67F2B1A") }
  static var orange400_0: GlobalColorToken { GlobalColorToken(hex: "#E67F2B00") }
  static var orange300: GlobalColorToken { GlobalColorToken(hex: "#FFA15E") }
  static var orange300_45: GlobalColorToken { GlobalColorToken(hex: "#FFA15E73") }
  static var orange300_30: GlobalColorToken { GlobalColorToken(hex: "#FFA15E4D") }
  static var orange300_15: GlobalColorToken { GlobalColorToken(hex: "#FFA15E26") }
  static var orange300_0: GlobalColorToken { GlobalColorToken(hex: "#FFA15E00") }
  static var orange200: GlobalColorToken { GlobalColorToken(hex: "#FFB070") }
  static var orange100: GlobalColorToken { GlobalColorToken(hex: "#FFC38F") }
}

// MARK: - Yellow
extension GlobalColorToken {
  static var yellow600: GlobalColorToken { GlobalColorToken(hex: "#9E7504") }
  static var yellow500: GlobalColorToken { GlobalColorToken(hex: "#C38F00") }
  static var yellow400: GlobalColorToken { GlobalColorToken(hex: "#EDAE0D") }
  static var yellow400_30: GlobalColorToken { GlobalColorToken(hex: "#EDAE0D4D") }
  static var yellow400_20: GlobalColorToken { GlobalColorToken(hex: "#EDAE0D33") }
  static var yellow400_10: GlobalColorToken { GlobalColorToken(hex: "#EDAE0D1A") }
  static var yellow400_0: GlobalColorToken { GlobalColorToken(hex: "#EDAE0D00") }
  static var yellow300: GlobalColorToken { GlobalColorToken(hex: "#F9C835") }
  static var yellow300_45: GlobalColorToken { GlobalColorToken(hex: "#F9C83573") }
  static var yellow300_30: GlobalColorToken { GlobalColorToken(hex: "#F9C8354D") }
  static var yellow300_15: GlobalColorToken { GlobalColorToken(hex: "#F9C83526") }
  static var yellow300_0: GlobalColorToken { GlobalColorToken(hex: "#F9C83500") }
  static var yellow200: GlobalColorToken { GlobalColorToken(hex: "#FED968") }
  static var yellow100: GlobalColorToken { GlobalColorToken(hex: "#FFE38F") }
}

// MARK: - Olive
extension GlobalColorToken {
  static var olive600: GlobalColorToken { GlobalColorToken(hex: "#65691C") }
  static var olive500: GlobalColorToken { GlobalColorToken(hex: "#7B801C") }
  static var olive400: GlobalColorToken { GlobalColorToken(hex: "#A9B110") }
  static var olive400_30: GlobalColorToken { GlobalColorToken(hex: "#A9B1104D") }
  static var olive400_20: GlobalColorToken { GlobalColorToken(hex: "#A9B11033") }
  static var olive400_10: GlobalColorToken { GlobalColorToken(hex: "#A9B1101A") }
  static var olive400_0: GlobalColorToken { GlobalColorToken(hex: "#A9B11000") }
  static var olive300: GlobalColorToken { GlobalColorToken(hex: "#C8D630") }
  static var olive300_45: GlobalColorToken { GlobalColorToken(hex: "#C8D63073") }
  static var olive300_30: GlobalColorToken { GlobalColorToken(hex: "#C8D6304D") }
  static var olive300_15: GlobalColorToken { GlobalColorToken(hex: "#C8D63026") }
  static var olive300_0: GlobalColorToken { GlobalColorToken(hex: "#C8D63000") }
  static var olive200: GlobalColorToken { GlobalColorToken(hex: "#DBE56E") }
  static var olive100: GlobalColorToken { GlobalColorToken(hex: "#E7F17C") }
}

// MARK: - Teal
extension GlobalColorToken {
  static var teal600: GlobalColorToken { GlobalColorToken(hex: "#06687D") }
  static var teal500: GlobalColorToken { GlobalColorToken(hex: "#068E95") }
  static var teal400: GlobalColorToken { GlobalColorToken(hex: "#09B2AC") }
  static var teal400_30: GlobalColorToken { GlobalColorToken(hex: "#09B2AC4D") }
  static var teal400_20: GlobalColorToken { GlobalColorToken(hex: "#09B2AC33") }
  static var teal400_10: GlobalColorToken { GlobalColorToken(hex: "#09B2AC1A") }
  static var teal400_0: GlobalColorToken { GlobalColorToken(hex: "#09B2AC00") }
  static var teal300: GlobalColorToken { GlobalColorToken(hex: "#40D3C5") }
  static var teal300_45: GlobalColorToken { GlobalColorToken(hex: "#40D3C573") }
  static var teal300_30: GlobalColorToken { GlobalColorToken(hex: "#40D3C54D") }
  static var teal300_15: GlobalColorToken { GlobalColorToken(hex: "#40D3C526") }
  static var teal300_0: GlobalColorToken { GlobalColorToken(hex: "#40D3C500") }
  static var teal200: GlobalColorToken { GlobalColorToken(hex: "#72E0D5") }
  static var teal100: GlobalColorToken { GlobalColorToken(hex: "#9BEEE6") }
}

// MARK: - Navy
extension GlobalColorToken {
  static var navy600: GlobalColorToken { GlobalColorToken(hex: "#22245B") }
  static var navy500: GlobalColorToken { GlobalColorToken(hex: "#353888") }
  static var navy400: GlobalColorToken { GlobalColorToken(hex: "#424FAB") }
  static var navy400_30: GlobalColorToken { GlobalColorToken(hex: "#424FAB4D") }
  static var navy400_20: GlobalColorToken { GlobalColorToken(hex: "#424FAB33") }
  static var navy400_10: GlobalColorToken { GlobalColorToken(hex: "#424FAB1A") }
  static var navy400_0: GlobalColorToken { GlobalColorToken(hex: "#424FAB00") }
  static var navy300: GlobalColorToken { GlobalColorToken(hex: "#7683D3") }
  static var navy300_45: GlobalColorToken { GlobalColorToken(hex: "#7683D373") }
  static var navy300_30: GlobalColorToken { GlobalColorToken(hex: "#7683D34D") }
  static var navy300_15: GlobalColorToken { GlobalColorToken(hex: "#7683D326") }
  static var navy300_0: GlobalColorToken { GlobalColorToken(hex: "#7683D300") }
  static var navy200: GlobalColorToken { GlobalColorToken(hex: "#8B99D9") }
  static var navy100: GlobalColorToken { GlobalColorToken(hex: "#A5B2EE") }
}

// MARK: - Purple
extension GlobalColorToken {
  static var purple600: GlobalColorToken { GlobalColorToken(hex: "#54278F") }
  static var purple500: GlobalColorToken { GlobalColorToken(hex: "#6735B6") }
  static var purple400: GlobalColorToken { GlobalColorToken(hex: "#8E57E7") }
  static var purple400_30: GlobalColorToken { GlobalColorToken(hex: "#8E57E74D") }
  static var purple400_20: GlobalColorToken { GlobalColorToken(hex: "#8E57E733") }
  static var purple400_10: GlobalColorToken { GlobalColorToken(hex: "#8E57E71A") }
  static var purple400_0: GlobalColorToken { GlobalColorToken(hex: "#8E57E700") }
  static var purple300: GlobalColorToken { GlobalColorToken(hex: "#B184FF") }
  static var purple300_45: GlobalColorToken { GlobalColorToken(hex: "#B184FF73") }
  static var purple300_30: GlobalColorToken { GlobalColorToken(hex: "#B184FF4D") }
  static var purple300_15: GlobalColorToken { GlobalColorToken(hex: "#B184FF26") }
  static var purple300_0: GlobalColorToken { GlobalColorToken(hex: "#B184FF00") }
  static var purple200: GlobalColorToken { GlobalColorToken(hex: "#C19AFF") }
  static var purple100: GlobalColorToken { GlobalColorToken(hex: "#D1B5FF") }
}

// MARK: - Pink
extension GlobalColorToken {
  static var pink600: GlobalColorToken { GlobalColorToken(hex: "#962C86") }
  static var pink500: GlobalColorToken { GlobalColorToken(hex: "#B0369E") }
  static var pink400: GlobalColorToken { GlobalColorToken(hex: "#D64BB5") }
  static var pink400_30: GlobalColorToken { GlobalColorToken(hex: "#D64BB54D") }
  static var pink400_20: GlobalColorToken { GlobalColorToken(hex: "#D64BB533") }
  static var pink400_10: GlobalColorToken { GlobalColorToken(hex: "#D64BB51A") }
  static var pink400_0: GlobalColorToken { GlobalColorToken(hex: "#D64BB500") }
  static var pink300: GlobalColorToken { GlobalColorToken(hex: "#EC6FD3") }
  static var pink300_45: GlobalColorToken { GlobalColorToken(hex: "#EC6FD373") }
  static var pink300_30: GlobalColorToken { GlobalColorToken(hex: "#EC6FD34D") }
  static var pink300_15: GlobalColorToken { GlobalColorToken(hex: "#EC6FD326") }
  static var pink300_0: GlobalColorToken { GlobalColorToken(hex: "#EC6FD300") }
  static var pink200: GlobalColorToken { GlobalColorToken(hex: "#F896E5") }
  static var pink100: GlobalColorToken { GlobalColorToken(hex: "#FFAFEF") }
}

// MARK: - ShadeBlue
extension GlobalColorToken {
  static var shadeBlue600: GlobalColorToken { GlobalColorToken(hex: "#4C5289") }
  static var shadeBlue600_40: GlobalColorToken { GlobalColorToken(hex: "#4C528966") }
  static var shadeBlue400: GlobalColorToken { GlobalColorToken(hex: "#7175E0") }
  static var shadeBlue400_20: GlobalColorToken { GlobalColorToken(hex: "#7175E033") }
}

// MARK: - ShadeCobalt
extension GlobalColorToken {
  static var shadeCobalt600: GlobalColorToken { GlobalColorToken(hex: "#4A6185") }
  static var shadeCobalt600_40: GlobalColorToken { GlobalColorToken(hex: "#4A618566") }
  static var shadeCobalt400: GlobalColorToken { GlobalColorToken(hex: "#57ACE8") }
  static var shadeCobalt400_20: GlobalColorToken { GlobalColorToken(hex: "#57ACE833") }
}

// MARK: - ShadeGreen
extension GlobalColorToken {
  static var shadeGreen600: GlobalColorToken { GlobalColorToken(hex: "#4C7A5E") }
  static var shadeGreen600_40: GlobalColorToken { GlobalColorToken(hex: "#4C7A5E66") }
  static var shadeGreen400: GlobalColorToken { GlobalColorToken(hex: "#62AF7C") }
  static var shadeGreen400_20: GlobalColorToken { GlobalColorToken(hex: "#62AF7C33") }
}

// MARK: - ShadeRed
extension GlobalColorToken {
  static var shadeRed600: GlobalColorToken { GlobalColorToken(hex: "#904248") }
  static var shadeRed600_40: GlobalColorToken { GlobalColorToken(hex: "#90424866") }
  static var shadeRed400: GlobalColorToken { GlobalColorToken(hex: "#DE6870") }
  static var shadeRed400_20: GlobalColorToken { GlobalColorToken(hex: "#DE687033") }
}

// MARK: - ShadeOrange
extension GlobalColorToken {
  static var shadeOrange600: GlobalColorToken { GlobalColorToken(hex: "#895A34") }
  static var shadeOrange600_40: GlobalColorToken { GlobalColorToken(hex: "#895A3466") }
  static var shadeOrange400: GlobalColorToken { GlobalColorToken(hex: "#E08C48") }
  static var shadeOrange400_20: GlobalColorToken { GlobalColorToken(hex: "#E08C4833") }
}

// MARK: - ShadeYellow
extension GlobalColorToken {
  static var shadeYellow600: GlobalColorToken { GlobalColorToken(hex: "#7D6A26") }
  static var shadeYellow600_40: GlobalColorToken { GlobalColorToken(hex: "#7D6A2666") }
  static var shadeYellow400: GlobalColorToken { GlobalColorToken(hex: "#E8AE3C") }
  static var shadeYellow400_20: GlobalColorToken { GlobalColorToken(hex: "#E8AE3C33") }
}

// MARK: - ShadeOlive
extension GlobalColorToken {
  static var shadeOlive600: GlobalColorToken { GlobalColorToken(hex: "#737638") }
  static var shadeOlive600_40: GlobalColorToken { GlobalColorToken(hex: "#73763866") }
  static var shadeOlive400: GlobalColorToken { GlobalColorToken(hex: "#A5A953") }
  static var shadeOlive400_20: GlobalColorToken { GlobalColorToken(hex: "#A5A95333") }
}

// MARK: - ShadeTeal
extension GlobalColorToken {
  static var shadeTeal600: GlobalColorToken { GlobalColorToken(hex: "#47737D") }
  static var shadeTeal600_40: GlobalColorToken { GlobalColorToken(hex: "#47737D66") }
  static var shadeTeal400: GlobalColorToken { GlobalColorToken(hex: "#55AAA7") }
  static var shadeTeal400_20: GlobalColorToken { GlobalColorToken(hex: "#55AAA733") }
}

// MARK: - ShadeNavy
extension GlobalColorToken {
  static var shadeNavy600: GlobalColorToken { GlobalColorToken(hex: "#373B56") }
  static var shadeNavy600_40: GlobalColorToken { GlobalColorToken(hex: "#373B5666") }
  static var shadeNavy400: GlobalColorToken { GlobalColorToken(hex: "#5F69B0") }
  static var shadeNavy400_20: GlobalColorToken { GlobalColorToken(hex: "#5F69B033") }
}

// MARK: - ShadePurple
extension GlobalColorToken {
  static var shadePurple600: GlobalColorToken { GlobalColorToken(hex: "#5B467D") }
  static var shadePurple600_40: GlobalColorToken { GlobalColorToken(hex: "#5B467D66") }
  static var shadePurple400: GlobalColorToken { GlobalColorToken(hex: "#9D6FE5") }
  static var shadePurple400_20: GlobalColorToken { GlobalColorToken(hex: "#9D6FE533") }
}

// MARK: - ShadePink
extension GlobalColorToken {
  static var shadePink600: GlobalColorToken { GlobalColorToken(hex: "#854075") }
  static var shadePink600_40: GlobalColorToken { GlobalColorToken(hex: "#85407566") }
  static var shadePink400: GlobalColorToken { GlobalColorToken(hex: "#D369BA") }
  static var shadePink400_20: GlobalColorToken { GlobalColorToken(hex: "#D369BA33") }
}

// MARK: - White
extension GlobalColorToken {
  static var white_100: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF") }
  static var white_90: GlobalColorToken { GlobalColorToken(hex: "#FFFFFFE6") }
  static var white_80: GlobalColorToken { GlobalColorToken(hex: "#FFFFFFCC") }
  static var white_60: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF99") }
  static var white_40: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF66") }
  static var white_20: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF33") }
  static var white_12: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF1F") }
  static var white_8: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF14") }
  static var white_5: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF0D") }
  static var white_0: GlobalColorToken { GlobalColorToken(hex: "#FFFFFF00") }
}

// MARK: - Black
extension GlobalColorToken {
  static var black_100: GlobalColorToken { GlobalColorToken(hex: "#000000") }
  static var black_85: GlobalColorToken { GlobalColorToken(hex: "#000000D9") }
  static var black_70: GlobalColorToken { GlobalColorToken(hex: "#000000B3") }
  static var black_60: GlobalColorToken { GlobalColorToken(hex: "#00000099") }
  static var black_50: GlobalColorToken { GlobalColorToken(hex: "#00000080") }
  static var black_40: GlobalColorToken { GlobalColorToken(hex: "#00000066") }
  static var black_30: GlobalColorToken { GlobalColorToken(hex: "#0000004D") }
  static var black_22: GlobalColorToken { GlobalColorToken(hex: "#00000038") }
  static var black_20: GlobalColorToken { GlobalColorToken(hex: "#00000033") }
  static var black_15: GlobalColorToken { GlobalColorToken(hex: "#00000026") }
  static var black_8: GlobalColorToken { GlobalColorToken(hex: "#00000014") }
  static var black_5: GlobalColorToken { GlobalColorToken(hex: "#0000000D") }
  static var black_3: GlobalColorToken { GlobalColorToken(hex: "#00000008") }
  static var black_0: GlobalColorToken { GlobalColorToken(hex: "#00000000") }
}

// MARK: - Grey(Solid)
extension GlobalColorToken {
  static var grey900: GlobalColorToken { GlobalColorToken(hex: "#242428") }
  static var grey850: GlobalColorToken { GlobalColorToken(hex: "#2A2B2D") }
  static var grey800: GlobalColorToken { GlobalColorToken(hex: "#313234") }
  static var grey700: GlobalColorToken { GlobalColorToken(hex: "#464748") }
  static var grey600: GlobalColorToken { GlobalColorToken(hex: "#7B7B7B") }
  static var grey500: GlobalColorToken { GlobalColorToken(hex: "#A7A7AA") }
  static var grey400: GlobalColorToken { GlobalColorToken(hex: "#CFCFD1") }
  static var grey300: GlobalColorToken { GlobalColorToken(hex: "#E2E2E4") }
  static var grey200: GlobalColorToken { GlobalColorToken(hex: "#EFEFF0") }
  static var grey100: GlobalColorToken { GlobalColorToken(hex: "#F7F7F8") }
  static var grey50: GlobalColorToken { GlobalColorToken(hex: "#FCFCFC") }
}

// MARK: - Grey(Alpha)
extension GlobalColorToken {
  static var grey900_90: GlobalColorToken { GlobalColorToken(hex: "#242428E6") }
  static var grey900_0: GlobalColorToken { GlobalColorToken(hex: "#24242800") }
  static var grey800_90: GlobalColorToken { GlobalColorToken(hex: "#313234E6") }
  static var grey850_80: GlobalColorToken { GlobalColorToken(hex: "#2A2B2DCC") }
  static var grey800_80: GlobalColorToken { GlobalColorToken(hex: "#313234CC") }
  static var grey700_80: GlobalColorToken { GlobalColorToken(hex: "#464748CC") }
  static var grey200_80: GlobalColorToken { GlobalColorToken(hex: "#EFEFF0CC") }
  static var grey100_90: GlobalColorToken { GlobalColorToken(hex: "#F7F7F8E6") }
  static var grey100_80: GlobalColorToken { GlobalColorToken(hex: "#F7F7F8CC") }
  static var grey50_80: GlobalColorToken { GlobalColorToken(hex: "#FCFCFCCC") }
}
