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
  static let blue600 = GlobalColorToken(hex: "#4941BC")
  static let blue500 = GlobalColorToken(hex: "#5950DC")
  static let blue400 = GlobalColorToken(hex: "#6D6AFC")
  static let blue400_30 = GlobalColorToken(hex: "#6D6AFC4D")
  static let blue400_20 = GlobalColorToken(hex: "#6D6AFC33")
  static let blue400_10 = GlobalColorToken(hex: "#6D6AFC1A")
  static let blue400_0 = GlobalColorToken(hex: "#6D6AFC00")
  static let blue300 = GlobalColorToken(hex: "#7D9EFA")
  static let blue300_45 = GlobalColorToken(hex: "#7D9EFA73")
  static let blue300_30 = GlobalColorToken(hex: "#7D9EFA4D")
  static let blue300_15 = GlobalColorToken(hex: "#7D9EFA26")
  static let blue300_0 = GlobalColorToken(hex: "#7D9EFA00")
  static let blue200 = GlobalColorToken(hex: "#96B7FF")
  static let blue100 = GlobalColorToken(hex: "#A9C6FF")
}

// MARK: - Cobalt
extension GlobalColorToken {
  static let cobalt600 = GlobalColorToken(hex: "#2B59B5")
  static let cobalt500 = GlobalColorToken(hex: "#3870D1")
  static let cobalt400 = GlobalColorToken(hex: "#5093E5")
  static let cobalt400_30 = GlobalColorToken(hex: "#5093E54D")
  static let cobalt400_20 = GlobalColorToken(hex: "#5093E533")
  static let cobalt400_10 = GlobalColorToken(hex: "#5093E51A")
  static let cobalt400_0 = GlobalColorToken(hex: "#5093E500")
  static let cobalt300 = GlobalColorToken(hex: "#71B9F5")
  static let cobalt300_45 = GlobalColorToken(hex: "#71B9F573")
  static let cobalt300_30 = GlobalColorToken(hex: "#71B9F54D")
  static let cobalt300_15 = GlobalColorToken(hex: "#71B9F526")
  static let cobalt300_0 = GlobalColorToken(hex: "#71B9F500")
  static let cobalt200 = GlobalColorToken(hex: "#8DCAFC")
  static let cobalt100 = GlobalColorToken(hex: "#A1D5FF")
}

// MARK: - Green
extension GlobalColorToken {
  static let green600 = GlobalColorToken(hex: "#327055")
  static let green500 = GlobalColorToken(hex: "#358761")
  static let green400 = GlobalColorToken(hex: "#40AD67")
  static let green400_30 = GlobalColorToken(hex: "#40AD674D")
  static let green400_20 = GlobalColorToken(hex: "#40AD6733")
  static let green400_10 = GlobalColorToken(hex: "#40AD671A")
  static let green400_0 = GlobalColorToken(hex: "#40AD6700")
  static let green300 = GlobalColorToken(hex: "#68CC7F")
  static let green300_45 = GlobalColorToken(hex: "#68CC7F73")
  static let green300_30 = GlobalColorToken(hex: "#68CC7F4D")
  static let green300_15 = GlobalColorToken(hex: "#68CC7F26")
  static let green300_0 = GlobalColorToken(hex: "#68CC7F00")
  static let green200 = GlobalColorToken(hex: "#84E09A")
  static let green100 = GlobalColorToken(hex: "#A4ECB3")
}

// MARK: - Red
extension GlobalColorToken {
  static let red600 = GlobalColorToken(hex: "#992C34")
  static let red500 = GlobalColorToken(hex: "#BC3A42")
  static let red400 = GlobalColorToken(hex: "#E55C5C")
  static let red400_30 = GlobalColorToken(hex: "#E55C5C4D")
  static let red400_20 = GlobalColorToken(hex: "#E55C5C33")
  static let red400_10 = GlobalColorToken(hex: "#E55C5C1A")
  static let red400_0 = GlobalColorToken(hex: "#E55C5C00")
  static let red300 = GlobalColorToken(hex: "#FF8C8C")
  static let red300_45 = GlobalColorToken(hex: "#FF8C8C73")
  static let red300_30 = GlobalColorToken(hex: "#FF8C8C4D")
  static let red300_15 = GlobalColorToken(hex: "#FF8C8C26")
  static let red300_0 = GlobalColorToken(hex: "#FF8C8C00")
  static let red200 = GlobalColorToken(hex: "#FFA6A6")
  static let red100 = GlobalColorToken(hex: "#FFB8B8")
}

// MARK: - Orange
extension GlobalColorToken {
  static let orange600 = GlobalColorToken(hex: "#A1540C")
  static let orange500 = GlobalColorToken(hex: "#C1630D")
  static let orange400 = GlobalColorToken(hex: "#E67F2B")
  static let orange400_30 = GlobalColorToken(hex: "#E67F2B4D")
  static let orange400_20 = GlobalColorToken(hex: "#E67F2B33")
  static let orange400_10 = GlobalColorToken(hex: "#E67F2B1A")
  static let orange400_0 = GlobalColorToken(hex: "#E67F2B00")
  static let orange300 = GlobalColorToken(hex: "#FFA15E")
  static let orange300_45 = GlobalColorToken(hex: "#FFA15E73")
  static let orange300_30 = GlobalColorToken(hex: "#FFA15E4D")
  static let orange300_15 = GlobalColorToken(hex: "#FFA15E26")
  static let orange300_0 = GlobalColorToken(hex: "#FFA15E00")
  static let orange200 = GlobalColorToken(hex: "#FFB070")
  static let orange100 = GlobalColorToken(hex: "#FFC38F")
}

// MARK: - Yellow
extension GlobalColorToken {
  static let yellow600 = GlobalColorToken(hex: "#9E7504")
  static let yellow500 = GlobalColorToken(hex: "#C38F00")
  static let yellow400 = GlobalColorToken(hex: "#EDAE0D")
  static let yellow400_30 = GlobalColorToken(hex: "#EDAE0D4D")
  static let yellow400_20 = GlobalColorToken(hex: "#EDAE0D33")
  static let yellow400_10 = GlobalColorToken(hex: "#EDAE0D1A")
  static let yellow400_0 = GlobalColorToken(hex: "#EDAE0D00")
  static let yellow300 = GlobalColorToken(hex: "#F9C835")
  static let yellow300_45 = GlobalColorToken(hex: "#F9C83573")
  static let yellow300_30 = GlobalColorToken(hex: "#F9C8354D")
  static let yellow300_15 = GlobalColorToken(hex: "#F9C83526")
  static let yellow300_0 = GlobalColorToken(hex: "#F9C83500")
  static let yellow200 = GlobalColorToken(hex: "#FED968")
  static let yellow100 = GlobalColorToken(hex: "#FFE38F")
}

// MARK: - Olive
extension GlobalColorToken {
  static let olive600 = GlobalColorToken(hex: "#65691C")
  static let olive500 = GlobalColorToken(hex: "#7B801C")
  static let olive400 = GlobalColorToken(hex: "#A9B110")
  static let olive400_30 = GlobalColorToken(hex: "#A9B1104D")
  static let olive400_20 = GlobalColorToken(hex: "#A9B11033")
  static let olive400_10 = GlobalColorToken(hex: "#A9B1101A")
  static let olive400_0 = GlobalColorToken(hex: "#A9B11000")
  static let olive300 = GlobalColorToken(hex: "#C8D630")
  static let olive300_45 = GlobalColorToken(hex: "#C8D63073")
  static let olive300_30 = GlobalColorToken(hex: "#C8D6304D")
  static let olive300_15 = GlobalColorToken(hex: "#C8D63026")
  static let olive300_0 = GlobalColorToken(hex: "#C8D63000")
  static let olive200 = GlobalColorToken(hex: "#DBE56E")
  static let olive100 = GlobalColorToken(hex: "#E7F17C")
}

// MARK: - Teal
extension GlobalColorToken {
  static let teal600 = GlobalColorToken(hex: "#06687D")
  static let teal500 = GlobalColorToken(hex: "#068E95")
  static let teal400 = GlobalColorToken(hex: "#09B2AC")
  static let teal400_30 = GlobalColorToken(hex: "#09B2AC4D")
  static let teal400_20 = GlobalColorToken(hex: "#09B2AC33")
  static let teal400_10 = GlobalColorToken(hex: "#09B2AC1A")
  static let teal400_0 = GlobalColorToken(hex: "#09B2AC00")
  static let teal300 = GlobalColorToken(hex: "#40D3C5")
  static let teal300_45 = GlobalColorToken(hex: "#40D3C573")
  static let teal300_30 = GlobalColorToken(hex: "#40D3C54D")
  static let teal300_15 = GlobalColorToken(hex: "#40D3C526")
  static let teal300_0 = GlobalColorToken(hex: "#40D3C500")
  static let teal200 = GlobalColorToken(hex: "#72E0D5")
  static let teal100 = GlobalColorToken(hex: "#9BEEE6")
}

// MARK: - Navy
extension GlobalColorToken {
  static let navy600 = GlobalColorToken(hex: "#22245B")
  static let navy500 = GlobalColorToken(hex: "#353888")
  static let navy400 = GlobalColorToken(hex: "#424FAB")
  static let navy400_30 = GlobalColorToken(hex: "#424FAB4D")
  static let navy400_20 = GlobalColorToken(hex: "#424FAB33")
  static let navy400_10 = GlobalColorToken(hex: "#424FAB1A")
  static let navy400_0 = GlobalColorToken(hex: "#424FAB00")
  static let navy300 = GlobalColorToken(hex: "#7683D3")
  static let navy300_45 = GlobalColorToken(hex: "#7683D373")
  static let navy300_30 = GlobalColorToken(hex: "#7683D34D")
  static let navy300_15 = GlobalColorToken(hex: "#7683D326")
  static let navy300_0 = GlobalColorToken(hex: "#7683D300")
  static let navy200 = GlobalColorToken(hex: "#8B99D9")
  static let navy100 = GlobalColorToken(hex: "#A5B2EE")
}

// MARK: - Purple
extension GlobalColorToken {
  static let purple600 = GlobalColorToken(hex: "#54278F")
  static let purple500 = GlobalColorToken(hex: "#6735B6")
  static let purple400 = GlobalColorToken(hex: "#8E57E7")
  static let purple400_30 = GlobalColorToken(hex: "#8E57E74D")
  static let purple400_20 = GlobalColorToken(hex: "#8E57E733")
  static let purple400_10 = GlobalColorToken(hex: "#8E57E71A")
  static let purple400_0 = GlobalColorToken(hex: "#8E57E700")
  static let purple300 = GlobalColorToken(hex: "#B184FF")
  static let purple300_45 = GlobalColorToken(hex: "#B184FF73")
  static let purple300_30 = GlobalColorToken(hex: "#B184FF4D")
  static let purple300_15 = GlobalColorToken(hex: "#B184FF26")
  static let purple300_0 = GlobalColorToken(hex: "#B184FF00")
  static let purple200 = GlobalColorToken(hex: "#C19AFF")
  static let purple100 = GlobalColorToken(hex: "#D1B5FF")
}

// MARK: - Pink
extension GlobalColorToken {
  static let pink600 = GlobalColorToken(hex: "#962C86")
  static let pink500 = GlobalColorToken(hex: "#B0369E")
  static let pink400 = GlobalColorToken(hex: "#D64BB5")
  static let pink400_30 = GlobalColorToken(hex: "#D64BB54D")
  static let pink400_20 = GlobalColorToken(hex: "#D64BB533")
  static let pink400_10 = GlobalColorToken(hex: "#D64BB51A")
  static let pink400_0 = GlobalColorToken(hex: "#D64BB500")
  static let pink300 = GlobalColorToken(hex: "#EC6FD3")
  static let pink300_45 = GlobalColorToken(hex: "#EC6FD373")
  static let pink300_30 = GlobalColorToken(hex: "#EC6FD34D")
  static let pink300_15 = GlobalColorToken(hex: "#EC6FD326")
  static let pink300_0 = GlobalColorToken(hex: "#EC6FD300")
  static let pink200 = GlobalColorToken(hex: "#F896E5")
  static let pink100 = GlobalColorToken(hex: "#FFAFEF")
}

// MARK: - ShadeBlue
extension GlobalColorToken {
  static let shadeBlue600 = GlobalColorToken(hex: "#4C5289")
  static let shadeBlue600_40 = GlobalColorToken(hex: "#4C528966")
  static let shadeBlue400 = GlobalColorToken(hex: "#7175E0")
  static let shadeBlue400_20 = GlobalColorToken(hex: "#7175E033")
}

// MARK: - ShadeCobalt
extension GlobalColorToken {
  static let shadeCobalt600 = GlobalColorToken(hex: "#4A6185")
  static let shadeCobalt600_40 = GlobalColorToken(hex: "#4A618566")
  static let shadeCobalt400 = GlobalColorToken(hex: "#57ACE8")
  static let shadeCobalt400_20 = GlobalColorToken(hex: "#57ACE833")
}

// MARK: - ShadeGreen
extension GlobalColorToken {
  static let shadeGreen600 = GlobalColorToken(hex: "#4C7A5E")
  static let shadeGreen600_40 = GlobalColorToken(hex: "#4C7A5E66")
  static let shadeGreen400 = GlobalColorToken(hex: "#62AF7C")
  static let shadeGreen400_20 = GlobalColorToken(hex: "#62AF7C33")
}

// MARK: - ShadeRed
extension GlobalColorToken {
  static let shadeRed600 = GlobalColorToken(hex: "#904248")
  static let shadeRed600_40 = GlobalColorToken(hex: "#90424866")
  static let shadeRed400 = GlobalColorToken(hex: "#DE6870")
  static let shadeRed400_20 = GlobalColorToken(hex: "#DE687033")
}

// MARK: - ShadeOrange
extension GlobalColorToken {
  static let shadeOrange600 = GlobalColorToken(hex: "#895A34")
  static let shadeOrange600_40 = GlobalColorToken(hex: "#895A3466")
  static let shadeOrange400 = GlobalColorToken(hex: "#E08C48")
  static let shadeOrange400_20 = GlobalColorToken(hex: "#E08C4833")
}

// MARK: - ShadeYellow
extension GlobalColorToken {
  static let shadeYellow600 = GlobalColorToken(hex: "#7D6A26")
  static let shadeYellow600_40 = GlobalColorToken(hex: "#7D6A2666")
  static let shadeYellow400 = GlobalColorToken(hex: "#E8AE3C")
  static let shadeYellow400_20 = GlobalColorToken(hex: "#E8AE3C33")
}

// MARK: - ShadeOlive
extension GlobalColorToken {
  static let shadeOlive600 = GlobalColorToken(hex: "#737638")
  static let shadeOlive600_40 = GlobalColorToken(hex: "#73763866")
  static let shadeOlive400 = GlobalColorToken(hex: "#A5A953")
  static let shadeOlive400_20 = GlobalColorToken(hex: "#A5A95333")
}

// MARK: - ShadeTeal
extension GlobalColorToken {
  static let shadeTeal600 = GlobalColorToken(hex: "#47737D")
  static let shadeTeal600_40 = GlobalColorToken(hex: "#47737D66")
  static let shadeTeal400 = GlobalColorToken(hex: "#55AAA7")
  static let shadeTeal400_20 = GlobalColorToken(hex: "#55AAA733")
}

// MARK: - ShadeNavy
extension GlobalColorToken {
  static let shadeNavy600 = GlobalColorToken(hex: "#373B56")
  static let shadeNavy600_40 = GlobalColorToken(hex: "#373B5666")
  static let shadeNavy400 = GlobalColorToken(hex: "#5F69B0")
  static let shadeNavy400_20 = GlobalColorToken(hex: "#5F69B033")
}

// MARK: - ShadePurple
extension GlobalColorToken {
  static let shadePurple600 = GlobalColorToken(hex: "#5B467D")
  static let shadePurple600_40 = GlobalColorToken(hex: "#5B467D66")
  static let shadePurple400 = GlobalColorToken(hex: "#9D6FE5")
  static let shadePurple400_20 = GlobalColorToken(hex: "#9D6FE533")
}

// MARK: - ShadePink
extension GlobalColorToken {
  static let shadePink600 = GlobalColorToken(hex: "#854075")
  static let shadePink600_40 = GlobalColorToken(hex: "#85407566")
  static let shadePink400 = GlobalColorToken(hex: "#D369BA")
  static let shadePink400_20 = GlobalColorToken(hex: "#D369BA33")
}

// MARK: - White
extension GlobalColorToken {
  static let white_100 = GlobalColorToken(hex: "#FFFFFF")
  static let white_90 = GlobalColorToken(hex: "#FFFFFFE6")
  static let white_80 = GlobalColorToken(hex: "#FFFFFFCC")
  static let white_60 = GlobalColorToken(hex: "#FFFFFF99")
  static let white_40 = GlobalColorToken(hex: "#FFFFFF66")
  static let white_20 = GlobalColorToken(hex: "#FFFFFF33")
  static let white_12 = GlobalColorToken(hex: "#FFFFFF1F")
  static let white_8 = GlobalColorToken(hex: "#FFFFFF14")
  static let white_5 = GlobalColorToken(hex: "#FFFFFF0D")
  static let white_0 = GlobalColorToken(hex: "#FFFFFF00")
}

// MARK: - Black
extension GlobalColorToken {
  static let black_100 = GlobalColorToken(hex: "#000000")
  static let black_85 = GlobalColorToken(hex: "#000000D9")
  static let black_70 = GlobalColorToken(hex: "#000000B3")
  static let black_60 = GlobalColorToken(hex: "#00000099")
  static let black_50 = GlobalColorToken(hex: "#00000080")
  static let black_40 = GlobalColorToken(hex: "#00000066")
  static let black_30 = GlobalColorToken(hex: "#0000004D")
  static let black_22 = GlobalColorToken(hex: "#00000038")
  static let black_20 = GlobalColorToken(hex: "#00000033")
  static let black_15 = GlobalColorToken(hex: "#00000026")
  static let black_8 = GlobalColorToken(hex: "#00000014")
  static let black_5 = GlobalColorToken(hex: "#0000000D")
  static let black_3 = GlobalColorToken(hex: "#00000008")
  static let black_0 = GlobalColorToken(hex: "#00000000")
}

// MARK: - Grey(Solid)
extension GlobalColorToken {
  static let grey900 = GlobalColorToken(hex: "#242428")
  static let grey850 = GlobalColorToken(hex: "#2A2B2D")
  static let grey800 = GlobalColorToken(hex: "#313234")
  static let grey700 = GlobalColorToken(hex: "#464748")
  static let grey600 = GlobalColorToken(hex: "#7B7B7B")
  static let grey500 = GlobalColorToken(hex: "#A7A7AA")
  static let grey400 = GlobalColorToken(hex: "#CFCFD1")
  static let grey300 = GlobalColorToken(hex: "#E2E2E4")
  static let grey200 = GlobalColorToken(hex: "#EFEFF0")
  static let grey100 = GlobalColorToken(hex: "#F7F7F8")
  static let grey50 = GlobalColorToken(hex: "#FCFCFC")
}

// MARK: - Grey(Alpha)
extension GlobalColorToken {
  static let grey900_90 = GlobalColorToken(hex: "#242428E6")
  static let grey900_0 = GlobalColorToken(hex: "#24242800")
  static let grey800_90 = GlobalColorToken(hex: "#313234E6")
  static let grey850_80 = GlobalColorToken(hex: "#2A2B2DCC")
  static let grey800_80 = GlobalColorToken(hex: "#313234CC")
  static let grey700_80 = GlobalColorToken(hex: "#464748CC")
  static let grey200_80 = GlobalColorToken(hex: "#EFEFF0CC")
  static let grey100_90 = GlobalColorToken(hex: "#F7F7F8E6")
  static let grey100_80 = GlobalColorToken(hex: "#F7F7F8CC")
  static let grey50_80 = GlobalColorToken(hex: "#FCFCFCCC")
}
