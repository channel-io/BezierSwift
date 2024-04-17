//
//  GlobalToken.swift
//
//
//  Created by Tom on 3/20/24.
//

import Foundation

struct GlobalToken {
  var hex: String
  
  init(hex: String) {
    self.hex = hex
  }
}

// MARK: - Blue
extension GlobalToken {
  static var blue600: GlobalToken { GlobalToken(hex: "#4941BC") }
  static var blue500: GlobalToken { GlobalToken(hex: "#5950DC") }
  static var blue400: GlobalToken { GlobalToken(hex: "#6D6AFC") }
  static var blue400_30: GlobalToken { GlobalToken(hex: "#6D6AFC4D") }
  static var blue400_20: GlobalToken { GlobalToken(hex: "#6D6AFC33") }
  static var blue400_10: GlobalToken { GlobalToken(hex: "#6D6AFC1A") }
  static var blue300: GlobalToken { GlobalToken(hex: "#84A5FF") }
  static var blue300_45: GlobalToken { GlobalToken(hex: "#84A5FF73") }
  static var blue300_30: GlobalToken { GlobalToken(hex: "#84A5FF4D") }
  static var blue300_15: GlobalToken { GlobalToken(hex: "#84A5FF26") }
  static var blue200: GlobalToken { GlobalToken(hex: "#96B7FF") }
  static var blue100: GlobalToken { GlobalToken(hex: "#A9C6FF") }
}

// MARK: - Cobalt
extension GlobalToken {
  static var cobalt600: GlobalToken { GlobalToken(hex: "#2B59B5") }
  static var cobalt500: GlobalToken { GlobalToken(hex: "#3870D1") }
  static var cobalt400: GlobalToken { GlobalToken(hex: "#5093E5") }
  static var cobalt400_30: GlobalToken { GlobalToken(hex: "#5093E54D") }
  static var cobalt400_20: GlobalToken { GlobalToken(hex: "#5093E533") }
  static var cobalt400_10: GlobalToken { GlobalToken(hex: "#5093E51A") }
  static var cobalt300: GlobalToken { GlobalToken(hex: "#7DC2FA") }
  static var cobalt300_45: GlobalToken { GlobalToken(hex: "#77C0FB73") }
  static var cobalt300_30: GlobalToken { GlobalToken(hex: "#77C0FB4D") }
  static var cobalt300_15: GlobalToken { GlobalToken(hex: "#77C0FB26") }
  static var cobalt200: GlobalToken { GlobalToken(hex: "#9AD1FF") }
  static var cobalt100: GlobalToken { GlobalToken(hex: "#AFDAFF") }
}

// MARK: - Green
extension GlobalToken {
  static var green600: GlobalToken { GlobalToken(hex: "#327055") }
  static var green500: GlobalToken { GlobalToken(hex: "#358761") }
  static var green400: GlobalToken { GlobalToken(hex: "#40AD67") }
  static var green400_30: GlobalToken { GlobalToken(hex: "#40AD674D") }
  static var green400_20: GlobalToken { GlobalToken(hex: "#40AD6733") }
  static var green400_10: GlobalToken { GlobalToken(hex: "#40AD671A") }
  static var green300: GlobalToken { GlobalToken(hex: "#7AD890") }
  static var green300_45: GlobalToken { GlobalToken(hex: "#7AD89073") }
  static var green300_30: GlobalToken { GlobalToken(hex: "#7AD8904D") }
  static var green300_15: GlobalToken { GlobalToken(hex: "#7AD89026") }
  static var green200: GlobalToken { GlobalToken(hex: "#91E5A4") }
  static var green100: GlobalToken { GlobalToken(hex: "#A4ECB3") }
}

// MARK: - Red
extension GlobalToken {
  static var red600: GlobalToken { GlobalToken(hex: "#992C34") }
  static var red500: GlobalToken { GlobalToken(hex: "#BC3A42") }
  static var red400: GlobalToken { GlobalToken(hex: "#E55C5C") }
  static var red400_30: GlobalToken { GlobalToken(hex: "#E55C5C4D") }
  static var red400_20: GlobalToken { GlobalToken(hex: "#E55C5C33") }
  static var red400_10: GlobalToken { GlobalToken(hex: "#E55C5C1A") }
  static var red300: GlobalToken { GlobalToken(hex: "#FF8C8C") }
  static var red300_45: GlobalToken { GlobalToken(hex: "#FF8C8C73") }
  static var red300_30: GlobalToken { GlobalToken(hex: "#FF8C8C4D") }
  static var red300_15: GlobalToken { GlobalToken(hex: "#FF8C8C26") }
  static var red200: GlobalToken { GlobalToken(hex: "#FFA6A6") }
  static var red100: GlobalToken { GlobalToken(hex: "#FFB8B8") }
}

// MARK: - Orange
extension GlobalToken {
  static var orange600: GlobalToken { GlobalToken(hex: "#A1540C") }
  static var orange500: GlobalToken { GlobalToken(hex: "#C1630D") }
  static var orange400: GlobalToken { GlobalToken(hex: "#E67F2B") }
  static var orange400_30: GlobalToken { GlobalToken(hex: "#E67F2B4D") }
  static var orange400_20: GlobalToken { GlobalToken(hex: "#E67F2B33") }
  static var orange400_10: GlobalToken { GlobalToken(hex: "#E67F2B1A") }
  static var orange300: GlobalToken { GlobalToken(hex: "#FFA15E") }
  static var orange300_45: GlobalToken { GlobalToken(hex: "#FFA15E73") }
  static var orange300_30: GlobalToken { GlobalToken(hex: "#FFA15E4D") }
  static var orange300_15: GlobalToken { GlobalToken(hex: "#FFA15E26") }
  static var orange200: GlobalToken { GlobalToken(hex: "#FFB77D") }
  static var orange100: GlobalToken { GlobalToken(hex: "#FFC38F") }
}

// MARK: - Yellow
extension GlobalToken {
  static var yellow600: GlobalToken { GlobalToken(hex: "#9E7504") }
  static var yellow500: GlobalToken { GlobalToken(hex: "#C38F00") }
  static var yellow400: GlobalToken { GlobalToken(hex: "#EDAE0D") }
  static var yellow400_30: GlobalToken { GlobalToken(hex: "#EDAE0D4D") }
  static var yellow400_20: GlobalToken { GlobalToken(hex: "#EDAE0D33") }
  static var yellow400_10: GlobalToken { GlobalToken(hex: "#EDAE0D1A") }
  static var yellow300: GlobalToken { GlobalToken(hex: "#F9C835") }
  static var yellow300_45: GlobalToken { GlobalToken(hex: "#F9C83573") }
  static var yellow300_30: GlobalToken { GlobalToken(hex: "#F9C8354D") }
  static var yellow300_15: GlobalToken { GlobalToken(hex: "#F9C83526") }
  static var yellow200: GlobalToken { GlobalToken(hex: "#FED968") }
  static var yellow100: GlobalToken { GlobalToken(hex: "#FFE38F") }
}

// MARK: - Olive
extension GlobalToken {
  static var olive600: GlobalToken { GlobalToken(hex: "#65691C") }
  static var olive500: GlobalToken { GlobalToken(hex: "#7B801C") }
  static var olive400: GlobalToken { GlobalToken(hex: "#A9B110") }
  static var olive400_30: GlobalToken { GlobalToken(hex: "#A9B1104D") }
  static var olive400_20: GlobalToken { GlobalToken(hex: "#A9B11033") }
  static var olive400_10: GlobalToken { GlobalToken(hex: "#A9B1101A") }
  static var olive300: GlobalToken { GlobalToken(hex: "#C8D630") }
  static var olive300_45: GlobalToken { GlobalToken(hex: "#C8D63073") }
  static var olive300_30: GlobalToken { GlobalToken(hex: "#C8D6304D") }
  static var olive300_15: GlobalToken { GlobalToken(hex: "#C8D63026") }
  static var olive200: GlobalToken { GlobalToken(hex: "#DBE56E") }
  static var olive100: GlobalToken { GlobalToken(hex: "#E7F17C") }
}

// MARK: - Teal
extension GlobalToken {
  static var teal600: GlobalToken { GlobalToken(hex: "#06687D") }
  static var teal500: GlobalToken { GlobalToken(hex: "#068E95") }
  static var teal400: GlobalToken { GlobalToken(hex: "#09B2AC") }
  static var teal400_30: GlobalToken { GlobalToken(hex: "#09B2AC4D") }
  static var teal400_20: GlobalToken { GlobalToken(hex: "#09B2AC33") }
  static var teal400_10: GlobalToken { GlobalToken(hex: "#09B2AC1A") }
  static var teal300: GlobalToken { GlobalToken(hex: "#40D3C5") }
  static var teal300_45: GlobalToken { GlobalToken(hex: "#40D3C573") }
  static var teal300_30: GlobalToken { GlobalToken(hex: "#40D3C54D") }
  static var teal300_15: GlobalToken { GlobalToken(hex: "#40D3C526") }
  static var teal200: GlobalToken { GlobalToken(hex: "#72E0D5") }
  static var teal100: GlobalToken { GlobalToken(hex: "#9BEEE6") }
}

// MARK: - Navy
extension GlobalToken {
  static var navy600: GlobalToken { GlobalToken(hex: "#22245B") }
  static var navy500: GlobalToken { GlobalToken(hex: "#353888") }
  static var navy400: GlobalToken { GlobalToken(hex: "#424FAB") }
  static var navy400_30: GlobalToken { GlobalToken(hex: "#424FAB4D") }
  static var navy400_20: GlobalToken { GlobalToken(hex: "#424FAB33") }
  static var navy400_10: GlobalToken { GlobalToken(hex: "#424FAB1A") }
  static var navy300: GlobalToken { GlobalToken(hex: "#7683D3") }
  static var navy300_45: GlobalToken { GlobalToken(hex: "#7683D373") }
  static var navy300_30: GlobalToken { GlobalToken(hex: "#7683D34D") }
  static var navy300_15: GlobalToken { GlobalToken(hex: "#7683D326") }
  static var navy200: GlobalToken { GlobalToken(hex: "#8B99D9") }
  static var navy100: GlobalToken { GlobalToken(hex: "#A5B2EE") }
}

// MARK: - Purple
extension GlobalToken {
  static var purple600: GlobalToken { GlobalToken(hex: "#54278F") }
  static var purple500: GlobalToken { GlobalToken(hex: "#6735B6") }
  static var purple400: GlobalToken { GlobalToken(hex: "#8E57E7") }
  static var purple400_30: GlobalToken { GlobalToken(hex: "#8E57E74D") }
  static var purple400_20: GlobalToken { GlobalToken(hex: "#8E57E733") }
  static var purple400_10: GlobalToken { GlobalToken(hex: "#8E57E71A") }
  static var purple300: GlobalToken { GlobalToken(hex: "#B184FF") }
  static var purple300_45: GlobalToken { GlobalToken(hex: "#B184FF73") }
  static var purple300_30: GlobalToken { GlobalToken(hex: "#B184FF4D") }
  static var purple300_15: GlobalToken { GlobalToken(hex: "#B184FF26") }
  static var purple200: GlobalToken { GlobalToken(hex: "#C19AFF") }
  static var purple100: GlobalToken { GlobalToken(hex: "#D1B5FF") }
}

// MARK: - Pink
extension GlobalToken {
  static var pink600: GlobalToken { GlobalToken(hex: "#962C86") }
  static var pink500: GlobalToken { GlobalToken(hex: "#B0369E") }
  static var pink400: GlobalToken { GlobalToken(hex: "#D64BB5") }
  static var pink400_30: GlobalToken { GlobalToken(hex: "#D64BB54D") }
  static var pink400_20: GlobalToken { GlobalToken(hex: "#D64BB533") }
  static var pink400_10: GlobalToken { GlobalToken(hex: "#D64BB51A") }
  static var pink300: GlobalToken { GlobalToken(hex: "#EC6FD3") }
  static var pink300_45: GlobalToken { GlobalToken(hex: "#EC6FD373") }
  static var pink300_30: GlobalToken { GlobalToken(hex: "#EC6FD34D") }
  static var pink300_15: GlobalToken { GlobalToken(hex: "#EC6FD326") }
  static var pink200: GlobalToken { GlobalToken(hex: "#F896E5") }
  static var pink100: GlobalToken { GlobalToken(hex: "#FFAFEF") }
}

// MARK: - ShadeBlue
extension GlobalToken {
  static var shadeBlue600: GlobalToken { GlobalToken(hex: "#4C5289") }
  static var shadeBlue600_40: GlobalToken { GlobalToken(hex: "#4C528966") }
  static var shadeBlue400: GlobalToken { GlobalToken(hex: "#7175E0") }
  static var shadeBlue400_20: GlobalToken { GlobalToken(hex: "#7175E033") }
}

// MARK: - ShadeCobalt
extension GlobalToken {
  static var shadeCobalt600: GlobalToken { GlobalToken(hex: "#4A6185") }
  static var shadeCobalt600_40: GlobalToken { GlobalToken(hex: "#4A618566") }
  static var shadeCobalt400: GlobalToken { GlobalToken(hex: "#57ACE8") }
  static var shadeCobalt400_20: GlobalToken { GlobalToken(hex: "#57ACE833") }
}

// MARK: - ShadeGreen
extension GlobalToken {
  static var shadeGreen600: GlobalToken { GlobalToken(hex: "#4C7A5E") }
  static var shadeGreen600_40: GlobalToken { GlobalToken(hex: "#4C7A5E66") }
  static var shadeGreen400: GlobalToken { GlobalToken(hex: "#62AF7C") }
  static var shadeGreen400_20: GlobalToken { GlobalToken(hex: "#62AF7C33") }
}

// MARK: - ShadeRed
extension GlobalToken {
  static var shadeRed600: GlobalToken { GlobalToken(hex: "#904248") }
  static var shadeRed600_40: GlobalToken { GlobalToken(hex: "#90424866") }
  static var shadeRed400: GlobalToken { GlobalToken(hex: "#DE6870") }
  static var shadeRed400_20: GlobalToken { GlobalToken(hex: "#DE687033") }
}

// MARK: - ShadeOrange
extension GlobalToken {
  static var shadeOrange600: GlobalToken { GlobalToken(hex: "#895A34") }
  static var shadeOrange600_40: GlobalToken { GlobalToken(hex: "#895A3466") }
  static var shadeOrange400: GlobalToken { GlobalToken(hex: "#E08C48") }
  static var shadeOrange400_20: GlobalToken { GlobalToken(hex: "#E08C4833") }
}

// MARK: - ShadeYellow
extension GlobalToken {
  static var shadeYellow600: GlobalToken { GlobalToken(hex: "#7D6A26") }
  static var shadeYellow600_40: GlobalToken { GlobalToken(hex: "#7D6A2666") }
  static var shadeYellow400: GlobalToken { GlobalToken(hex: "#E8AE3C") }
  static var shadeYellow400_20: GlobalToken { GlobalToken(hex: "#E8AE3C33") }
}

// MARK: - ShadeOlive
extension GlobalToken {
  static var shadeOlive600: GlobalToken { GlobalToken(hex: "#737638") }
  static var shadeOlive600_40: GlobalToken { GlobalToken(hex: "#73763866") }
  static var shadeOlive400: GlobalToken { GlobalToken(hex: "#A5A953") }
  static var shadeOlive400_20: GlobalToken { GlobalToken(hex: "#A5A95333") }
}

// MARK: - ShadeTeal
extension GlobalToken {
  static var shadeTeal600: GlobalToken { GlobalToken(hex: "#47737D") }
  static var shadeTeal600_40: GlobalToken { GlobalToken(hex: "#47737D66") }
  static var shadeTeal400: GlobalToken { GlobalToken(hex: "#55AAA7") }
  static var shadeTeal400_20: GlobalToken { GlobalToken(hex: "#55AAA733") }
}

// MARK: - ShadeNavy
extension GlobalToken {
  static var shadeNavy600: GlobalToken { GlobalToken(hex: "#373B56") }
  static var shadeNavy600_40: GlobalToken { GlobalToken(hex: "#373B5666") }
  static var shadeNavy400: GlobalToken { GlobalToken(hex: "#5F69B0") }
  static var shadeNavy400_20: GlobalToken { GlobalToken(hex: "#5F69B033") }
}

// MARK: - ShadePurple
extension GlobalToken {
  static var shadePurple600: GlobalToken { GlobalToken(hex: "#5B467D") }
  static var shadePurple600_40: GlobalToken { GlobalToken(hex: "#5B467D66") }
  static var shadePurple400: GlobalToken { GlobalToken(hex: "#9D6FE5") }
  static var shadePurple400_20: GlobalToken { GlobalToken(hex: "#9D6FE533") }
}

// MARK: - ShadePink
extension GlobalToken {
  static var shadePink600: GlobalToken { GlobalToken(hex: "#854075") }
  static var shadePink600_40: GlobalToken { GlobalToken(hex: "#85407566") }
  static var shadePink400: GlobalToken { GlobalToken(hex: "#D369BA") }
  static var shadePink400_20: GlobalToken { GlobalToken(hex: "#D369BA33") }
}

// MARK: - White
extension GlobalToken {
  static var white100: GlobalToken { GlobalToken(hex: "#FFFFFF") }
  static var white90: GlobalToken { GlobalToken(hex: "#FFFFFFE6") }
  static var white80: GlobalToken { GlobalToken(hex: "#FFFFFFCC") }
  static var white60: GlobalToken { GlobalToken(hex: "#FFFFFF99") }
  static var white40: GlobalToken { GlobalToken(hex: "#FFFFFF66") }
  static var white20: GlobalToken { GlobalToken(hex: "#FFFFFF33") }
  static var white12: GlobalToken { GlobalToken(hex: "#FFFFFF1F") }
  static var white8: GlobalToken { GlobalToken(hex: "#FFFFFF14") }
  static var white5: GlobalToken { GlobalToken(hex: "#FFFFFF0D") }
  static var white0: GlobalToken { GlobalToken(hex: "#FFFFFF00") }
}

// MARK: - Black
extension GlobalToken {
  static var black100: GlobalToken { GlobalToken(hex: "#000000") }
  static var black85: GlobalToken { GlobalToken(hex: "#000000D9") }
  static var black70: GlobalToken { GlobalToken(hex: "#000000B3") }
  static var black60: GlobalToken { GlobalToken(hex: "#00000099") }
  static var black50: GlobalToken { GlobalToken(hex: "#00000080") }
  static var black40: GlobalToken { GlobalToken(hex: "#00000066") }
  static var black30: GlobalToken { GlobalToken(hex: "#0000004D") }
  static var black22: GlobalToken { GlobalToken(hex: "#00000038") }
  static var black20: GlobalToken { GlobalToken(hex: "#00000033") }
  static var black15: GlobalToken { GlobalToken(hex: "#00000026") }
  static var black8: GlobalToken { GlobalToken(hex: "#00000014") }
  static var black5: GlobalToken { GlobalToken(hex: "#0000000D") }
  static var black3: GlobalToken { GlobalToken(hex: "#00000008") }
}

// MARK: - Grey(Solid)
extension GlobalToken {
  static var grey900: GlobalToken { GlobalToken(hex: "#242428") }
  static var grey850: GlobalToken { GlobalToken(hex: "#2A2B2D") }
  static var grey800: GlobalToken { GlobalToken(hex: "#313234") }
  static var grey700: GlobalToken { GlobalToken(hex: "#464748") }
  static var grey600: GlobalToken { GlobalToken(hex: "#7B7B7B") }
  static var grey500: GlobalToken { GlobalToken(hex: "#A7A7AA") }
  static var grey400: GlobalToken { GlobalToken(hex: "#CFCFD1") }
  static var grey300: GlobalToken { GlobalToken(hex: "#E2E2E4") }
  static var grey200: GlobalToken { GlobalToken(hex: "#EFEFF0") }
  static var grey100: GlobalToken { GlobalToken(hex: "#F7F7F8") }
  static var grey50: GlobalToken { GlobalToken(hex: "#FCFCFC") }
}

// MARK: - Grey(Alpha)
extension GlobalToken {
  static var grey900_90: GlobalToken { GlobalToken(hex: "#242428E6") }
  static var grey800_90: GlobalToken { GlobalToken(hex: "#313234E6") }
  static var grey850_80: GlobalToken { GlobalToken(hex: "#2A2B2DCC") }
  static var grey800_80: GlobalToken { GlobalToken(hex: "#313234CC") }
  static var grey700_80: GlobalToken { GlobalToken(hex: "#464748CC") }
  static var grey200_80: GlobalToken { GlobalToken(hex: "#EFEFF0CC") }
  static var grey100_90: GlobalToken { GlobalToken(hex: "#F7F7F8E6") }
  static var grey100_80: GlobalToken { GlobalToken(hex: "#F7F7F8CC") }
  static var grey50_80: GlobalToken { GlobalToken(hex: "#FCFCFCCC") }
}
