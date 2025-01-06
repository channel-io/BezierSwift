//
//  PressedColorToken.swift
//
//
//  Created by Tom on 11/14/24.
//

import Foundation

internal struct PressedColorToken: ThemeableColorTokenType {
  let lightColorHex: String
  let darkColorHex: String
  
  init(lightColorHex: String, darkColorHex: String) {
    self.lightColorHex = lightColorHex
    self.darkColorHex = darkColorHex
  }
}

// MARK: - ForegroundBlue
extension PressedColorToken {
  static let fgBlueNormal = PressedColorToken(lightColorHex: "#5551FC", darkColorHex: "#93AEFB")
  static let fgBlueLight = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB73")
  static let fgBlueDark = PressedColorToken(lightColorHex: "#4B42D5", darkColorHex: "#93AEFB")
}

// MARK: - ForegroundCobalt
extension PressedColorToken {
  static let fgCobaltNormal = PressedColorToken(lightColorHex: "#4088DF", darkColorHex: "#83C4FA")
  static let fgCobaltLight = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA73")
  static let fgCobaltDark = PressedColorToken(lightColorHex: "#3268C4", darkColorHex: "#83C4FA")
}

// MARK: - ForegroundRed
extension PressedColorToken {
  static let fgRedNormal = PressedColorToken(lightColorHex: "#DF4C4C", darkColorHex: "#FFA2A2")
  static let fgRedLight = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A273")
  static let fgRedDark = PressedColorToken(lightColorHex: "#AB3940", darkColorHex: "#FFA2A2")
}

// MARK: - ForegroundOrange
extension PressedColorToken {
  static let fgOrangeNormal = PressedColorToken(lightColorHex: "#DF751F", darkColorHex: "#FFAE74")
  static let fgOrangeLight = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE7473")
  static let fgOrangeDark = PressedColorToken(lightColorHex: "#B15C0F", darkColorHex: "#FFAE74")
}

// MARK: - ForegroundGreen
extension PressedColorToken {
  static let fgGreenNormal = PressedColorToken(lightColorHex: "#3F9E61", darkColorHex: "#74D68B")
  static let fgGreenLight = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B73")
  static let fgGreenDark = PressedColorToken(lightColorHex: "#347B5A", darkColorHex: "#74D68B")
}

// MARK: - ForegroundTeal
extension PressedColorToken {
  static let fgTealNormal = PressedColorToken(lightColorHex: "#08A5A0", darkColorHex: "#4CDCCF")
  static let fgTealLight = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF73")
  static let fgTealDark = PressedColorToken(lightColorHex: "#06848B", darkColorHex: "#4CDCCF")
}

// MARK: - ForegroundOlive
extension PressedColorToken {
  static let fgOliveNormal = PressedColorToken(lightColorHex: "#9BA212", darkColorHex: "#D2DF3D")
  static let fgOliveLight = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D73")
  static let fgOliveDark = PressedColorToken(lightColorHex: "#70751C", darkColorHex: "#D2DF3D")
}

// MARK: - ForegroundYellow
extension PressedColorToken {
  static let fgYellowNormal = PressedColorToken(lightColorHex: "#D9A010", darkColorHex: "#FACE4A")
  static let fgYellowLight = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A73")
  static let fgYellowDark = PressedColorToken(lightColorHex: "#B58500", darkColorHex: "#FACE4A")
}

// MARK: - ForegroundPink
extension PressedColorToken {
  static let fgPinkNormal = PressedColorToken(lightColorHex: "#CF3EAC", darkColorHex: "#F27FDB")
  static let fgPinkLight = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB73")
  static let fgPinkDark = PressedColorToken(lightColorHex: "#A03591", darkColorHex: "#F27FDB")
}

// MARK: - ForegroundPurple
extension PressedColorToken {
  static let fgPurpleNormal = PressedColorToken(lightColorHex: "#8247E1", darkColorHex: "#BF9AFF")
  static let fgPurpleLight = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF73")
  static let fgPurpleDark = PressedColorToken(lightColorHex: "#6135A6", darkColorHex: "#BF9AFF")
}

// MARK: - ForegroundNavy
extension PressedColorToken {
  static let fgNavyNormal = PressedColorToken(lightColorHex: "#414C9C", darkColorHex: "#838FDC")
  static let fgNavyLight = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC73")
  static let fgNavyDark = PressedColorToken(lightColorHex: "#34377C", darkColorHex: "#838FDC")
}

// MARK: - ForegroundGrey
extension PressedColorToken {
  static let fgGreyDarkest = PressedColorToken(lightColorHex: "#42424A", darkColorHex: "#E5E5E8")
  static let fgGreyDark = PressedColorToken(lightColorHex: "#9B9B9E", darkColorHex: "#B2B2B5")
  static let fgGreyNormal = PressedColorToken(lightColorHex: "#C0C0C3", darkColorHex: "#868686")
  static let fgGreyLight = PressedColorToken(lightColorHex: "#DEDEE0", darkColorHex: "#505253")
  static let fgGreyLighter = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static let fgGreyLightest = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
}

// MARK: - ForegroundGreyAlpha
extension PressedColorToken {
  static let fgGreyAlphaDarkest = PressedColorToken(lightColorHex: "#DEDEE0CC", darkColorHex: "#505253CC")
  static let fgGreyAlphaDarker = PressedColorToken(lightColorHex: "#E5E5E8E6", darkColorHex: "#3B3C3FE6")
  static let fgGreyAlphaDark = PressedColorToken(lightColorHex: "#E5E5E8CC", darkColorHex: "#3B3C3FCC")
  static let fgGreyAlphaLight = PressedColorToken(lightColorHex: "#EAEAEACC", darkColorHex: "#343538CC")
}

// MARK: - ForegroundWhite
extension PressedColorToken {
  static let fgWhiteNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
}

// MARK: - ForegroundBlack
extension PressedColorToken {
  static let fgBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#EDEDED2F")
  static let fgBlackLight = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#EDEDED4D")
  static let fgBlackDark = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#EDEDED66")
  static let fgBlackDarker = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#EDEDED99")
  static let fgBlackDarkest = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#EDEDEDCC")
  static let fgBlackPure = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#EDEDED")
}

// MARK: - ForegroundAbsoluteWhite
extension PressedColorToken {
  static let fgAbsoluteWhiteLightest = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#EDEDED4D")
  static let fgAbsoluteWhiteLighter = PressedColorToken(lightColorHex: "#EDEDED66", darkColorHex: "#EDEDED66")
  static let fgAbsoluteWhiteLight = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#EDEDED99")
  static let fgAbsoluteWhiteNormal = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#EDEDEDE6")
  static let fgAbsoluteWhiteDark = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#EDEDED")
}

// MARK: - ForegroundAbsoluteBlack
extension PressedColorToken {
  static let fgAbsoluteBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
  static let fgAbsoluteBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static let fgAbsoluteBlackLight = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static let fgAbsoluteBlackNormal = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#0A0A0AD9")
  static let fgAbsoluteBlackDark = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#0A0A0A")
}

// MARK: - BackgroundBlue
extension PressedColorToken {
  static let bgBlueNormal = PressedColorToken(lightColorHex: "#5551FC", darkColorHex: "#93AEFB")
  static let bgBlueLight = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB73")
  static let bgBlueLighter = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB4D")
  static let bgBlueLightest = PressedColorToken(lightColorHex: "#5551FC27", darkColorHex: "#93AEFB39")
  static let bgBlueDark = PressedColorToken(lightColorHex: "#4B42D5", darkColorHex: "#8280FC")
  static let bgBlueShadeLighter = PressedColorToken(lightColorHex: "#6165D94D", darkColorHex: "#4E569D66")
  static let bgBlueShadeNormal = PressedColorToken(lightColorHex: "#6165D9", darkColorHex: "#4E569D")
  static let bgBlueTransparent = PressedColorToken(lightColorHex: "#6D6AFC1A", darkColorHex: "#7D9EFA1A")
}

// MARK: - BackgroundCobalt
extension PressedColorToken {
  static let bgCobaltNormal = PressedColorToken(lightColorHex: "#4088DF", darkColorHex: "#83C4FA")
  static let bgCobaltLight = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA73")
  static let bgCobaltLighter = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA4D")
  static let bgCobaltLightest = PressedColorToken(lightColorHex: "#4088DF27", darkColorHex: "#83C4FA39")
  static let bgCobaltDark = PressedColorToken(lightColorHex: "#3268C4", darkColorHex: "#5F9EEC")
  static let bgCobaltShadeLighter = PressedColorToken(lightColorHex: "#47A2E24D", darkColorHex: "#4C6A9966")
  static let bgCobaltShadeNormal = PressedColorToken(lightColorHex: "#47A2E2", darkColorHex: "#4C6A99")
  static let bgCobaltTransparent = PressedColorToken(lightColorHex: "#5093E51A", darkColorHex: "#71B9F51A")
}

// MARK: - BackgroundRed
extension PressedColorToken {
  static let bgRedNormal = PressedColorToken(lightColorHex: "#DF4C4C", darkColorHex: "#FFA2A2")
  static let bgRedLight = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A273")
  static let bgRedLighter = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A24D")
  static let bgRedLightest = PressedColorToken(lightColorHex: "#DF4C4C27", darkColorHex: "#FFA2A239")
  static let bgRedDark = PressedColorToken(lightColorHex: "#AB3940", darkColorHex: "#EC6B6B")
  static let bgRedShadeLighter = PressedColorToken(lightColorHex: "#D758614D", darkColorHex: "#A5434A66")
  static let bgRedShadeNormal = PressedColorToken(lightColorHex: "#D75861", darkColorHex: "#A5434A")
  static let bgRedTransparent = PressedColorToken(lightColorHex: "#E55C5C1A", darkColorHex: "#FF8C8C1A")
}

// MARK: - BackgroundOrange
extension PressedColorToken {
  static let bgOrangeNormal = PressedColorToken(lightColorHex: "#DF751F", darkColorHex: "#FFAE74")
  static let bgOrangeLight = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE7473")
  static let bgOrangeLighter = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE744D")
  static let bgOrangeLightest = PressedColorToken(lightColorHex: "#DF751F27", darkColorHex: "#FFAE7439")
  static let bgOrangeDark = PressedColorToken(lightColorHex: "#B15C0F", darkColorHex: "#EE8A39")
  static let bgOrangeShadeLighter = PressedColorToken(lightColorHex: "#D9813A4D", darkColorHex: "#9E643566")
  static let bgOrangeShadeNormal = PressedColorToken(lightColorHex: "#D9813A", darkColorHex: "#9E6435")
  static let bgOrangeTransparent = PressedColorToken(lightColorHex: "#E67F2B1A", darkColorHex: "#FFA15E1A")
}

// MARK: - BackgroundGreen
extension PressedColorToken {
  static let bgGreenNormal = PressedColorToken(lightColorHex: "#3F9E61", darkColorHex: "#74D68B")
  static let bgGreenLight = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B73")
  static let bgGreenLighter = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B4D")
  static let bgGreenLightest = PressedColorToken(lightColorHex: "#3F9E6127", darkColorHex: "#74D68B39")
  static let bgGreenDark = PressedColorToken(lightColorHex: "#347B5A", darkColorHex: "#41C16F")
  static let bgGreenShadeLighter = PressedColorToken(lightColorHex: "#5AA4734D", darkColorHex: "#4F8D6766")
  static let bgGreenShadeNormal = PressedColorToken(lightColorHex: "#5AA473", darkColorHex: "#4F8D67")
  static let bgGreenTransparent = PressedColorToken(lightColorHex: "#40AD671A", darkColorHex: "#68CC7F1A")
}

// MARK: - BackgroundTeal
extension PressedColorToken {
  static let bgTealNormal = PressedColorToken(lightColorHex: "#08A5A0", darkColorHex: "#4CDCCF")
  static let bgTealLight = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF73")
  static let bgTealLighter = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF4D")
  static let bgTealLightest = PressedColorToken(lightColorHex: "#08A5A027", darkColorHex: "#4CDCCF39")
  static let bgTealDark = PressedColorToken(lightColorHex: "#06848B", darkColorHex: "#0AC6C0")
  static let bgTealShadeLighter = PressedColorToken(lightColorHex: "#539B984D", darkColorHex: "#49839066")
  static let bgTealShadeNormal = PressedColorToken(lightColorHex: "#539B98", darkColorHex: "#498390")
  static let bgTealTransparent = PressedColorToken(lightColorHex: "#09B2AC1A", darkColorHex: "#40D3C51A")
}

// MARK: - BackgroundOlive
extension PressedColorToken {
  static let bgOliveNormal = PressedColorToken(lightColorHex: "#9BA212", darkColorHex: "#D2DF3D")
  static let bgOliveLight = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D73")
  static let bgOliveLighter = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D4D")
  static let bgOliveLightest = PressedColorToken(lightColorHex: "#9BA21227", darkColorHex: "#D2DF3D39")
  static let bgOliveDark = PressedColorToken(lightColorHex: "#70751C", darkColorHex: "#C1CA0C")
  static let bgOliveShadeLighter = PressedColorToken(lightColorHex: "#969A514D", darkColorHex: "#86893A66")
  static let bgOliveShadeNormal = PressedColorToken(lightColorHex: "#969A51", darkColorHex: "#86893A")
  static let bgOliveTransparent = PressedColorToken(lightColorHex: "#A9B1101A", darkColorHex: "#C8D6301A")
}

// MARK: - BackgroundYellow
extension PressedColorToken {
  static let bgYellowNormal = PressedColorToken(lightColorHex: "#D9A010", darkColorHex: "#FACE4A")
  static let bgYellowLight = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A73")
  static let bgYellowLighter = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A4D")
  static let bgYellowLightest = PressedColorToken(lightColorHex: "#D9A01027", darkColorHex: "#FACE4A39")
  static let bgYellowDark = PressedColorToken(lightColorHex: "#B58500", darkColorHex: "#F9B917")
  static let bgYellowShadeLighter = PressedColorToken(lightColorHex: "#E2A52D4D", darkColorHex: "#927A2666")
  static let bgYellowShadeNormal = PressedColorToken(lightColorHex: "#E2A52D", darkColorHex: "#927A26")
  static let bgYellowTransparent = PressedColorToken(lightColorHex: "#EDAE0D1A", darkColorHex: "#F9C8351A")
}

// MARK: - BackgroundPink
extension PressedColorToken {
  static let bgPinkNormal = PressedColorToken(lightColorHex: "#CF3EAC", darkColorHex: "#F27FDB")
  static let bgPinkLight = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB73")
  static let bgPinkLighter = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB4D")
  static let bgPinkLightest = PressedColorToken(lightColorHex: "#CF3EAC27", darkColorHex: "#F27FDB39")
  static let bgPinkDark = PressedColorToken(lightColorHex: "#A03591", darkColorHex: "#DF58BF")
  static let bgPinkShadeLighter = PressedColorToken(lightColorHex: "#CB5BB04D", darkColorHex: "#99428566")
  static let bgPinkShadeNormal = PressedColorToken(lightColorHex: "#CB5BB0", darkColorHex: "#994285")
  static let bgPinkTransparent = PressedColorToken(lightColorHex: "#D64BB51A", darkColorHex: "#EC6FD31A")
}

// MARK: - BackgroundPurple
extension PressedColorToken {
  static let bgPurpleNormal = PressedColorToken(lightColorHex: "#8247E1", darkColorHex: "#BF9AFF")
  static let bgPurpleLight = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF73")
  static let bgPurpleLighter = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF4D")
  static let bgPurpleLightest = PressedColorToken(lightColorHex: "#8247E127", darkColorHex: "#BF9AFF39")
  static let bgPurpleDark = PressedColorToken(lightColorHex: "#6135A6", darkColorHex: "#9A66EE")
  static let bgPurpleShadeLighter = PressedColorToken(lightColorHex: "#905EDE4D", darkColorHex: "#64489066")
  static let bgPurpleShadeNormal = PressedColorToken(lightColorHex: "#905EDE", darkColorHex: "#644890")
  static let bgPurpleTransparent = PressedColorToken(lightColorHex: "#8E57E71A", darkColorHex: "#B184FF1A")
}

// MARK: - BackgroundNavy
extension PressedColorToken {
  static let bgNavyNormal = PressedColorToken(lightColorHex: "#414C9C", darkColorHex: "#838FDC")
  static let bgNavyLight = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC73")
  static let bgNavyLighter = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC4D")
  static let bgNavyLightest = PressedColorToken(lightColorHex: "#414C9C27", darkColorHex: "#838FDC39")
  static let bgNavyDark = PressedColorToken(lightColorHex: "#34377C", darkColorHex: "#4353BF")
  static let bgNavyShadeLighter = PressedColorToken(lightColorHex: "#5761A54D", darkColorHex: "#3B416766")
  static let bgNavyShadeNormal = PressedColorToken(lightColorHex: "#5761A5", darkColorHex: "#3B4167")
  static let bgNavyTransparent = PressedColorToken(lightColorHex: "#424FAB1A", darkColorHex: "#7683D31A")
}

// MARK: - BackgroundGrey
extension PressedColorToken {
  static let bgGreyDarkest = PressedColorToken(lightColorHex: "#42424A", darkColorHex: "#EDEDED")
  static let bgGreyDark = PressedColorToken(lightColorHex: "#9B9B9E", darkColorHex: "#B2B2B5")
  static let bgGreyNormal = PressedColorToken(lightColorHex: "#C0C0C3", darkColorHex: "#868686")
  static let bgGreyLight = PressedColorToken(lightColorHex: "#DEDEE0", darkColorHex: "#505253")
  static let bgGreyLighter = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static let bgGreyLightest = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
  static let bgGreyTransparent = PressedColorToken(lightColorHex: "#2424280D", darkColorHex: "#FFFFFF0D")
}

// MARK: - BackgroundGreyAlpha
extension PressedColorToken {
  static let bgGreyAlphaDarkest = PressedColorToken(lightColorHex: "#DEDEE0CC", darkColorHex: "#505253CC")
  static let bgGreyAlphaDarker = PressedColorToken(lightColorHex: "#E5E5E8E6", darkColorHex: "#3B3C3FE6")
  static let bgGreyAlphaDark = PressedColorToken(lightColorHex: "#E5E5E8CC", darkColorHex: "#3B3C3FCC")
  static let bgGreyAlphaLight = PressedColorToken(lightColorHex: "#EAEAEACC", darkColorHex: "#343538CC")
}

// MARK: - BackgroundBlack
extension PressedColorToken {
  static let bgBlackDarkest = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static let bgBlackDarker = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#EDEDED66")
  static let bgBlackDark = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#EDEDED4D")
  static let bgBlackLight = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#EDEDED2F")
  static let bgBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C14", darkColorHex: "#EDEDED1E")
  static let bgBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C0C", darkColorHex: "#EDEDED14")
  static let bgBlackTransparent = PressedColorToken(lightColorHex: "#0000000D", darkColorHex: "#FFFFFF0D")
}

// MARK: - BackgroundWhite
extension PressedColorToken {
  static let bgWhiteHighest = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#505253")
  static let bgWhiteHigher = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#3B3C3F")
  static let bgWhiteNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
  // TODO: bgWhiteTransparent의 darkColorHex 가 달라서 체크 요청 함. 확인 후 변경 필요 by Tom 2024.11.18
  static let bgWhiteTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#")
}

// MARK: - BackgroundWhiteAlpha
extension PressedColorToken {
  static let bgWhiteAlphaLightest = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#3B3C3FCC")
  static let bgWhiteAlphaLighter = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#0A0A0A99")
  static let bgWhiteAlphaLight = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#0A0A0A4D")
  static let bgWhiteAlphaTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#0000000D")
}

// MARK: - BackgroundAbsoluteBlack
extension PressedColorToken {
  static let bgAbsoluteBlackDark = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#0A0A0A")
  static let bgAbsoluteBlackNormal = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#0A0A0AD9")
  static let bgAbsoluteBlackLight = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static let bgAbsoluteBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static let bgAbsoluteBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
  static let bgAbsoluteBlackTransparent = PressedColorToken(lightColorHex: "#0000000D", darkColorHex: "#0000000D")
}

// MARK: - BackgroundAbsoluteWhite
extension PressedColorToken {
  static let bgAbsoluteWhiteDark = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#EDEDED")
  static let bgAbsoluteWhiteNormal = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#EDEDEDE6")
  static let bgAbsoluteWhiteLight = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#EDEDED99")
  static let bgAbsoluteWhiteLighter = PressedColorToken(lightColorHex: "#EDEDED66", darkColorHex: "#EDEDED66")
  static let bgAbsoluteWhiteLightest = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#EDEDED4D")
  static let bgAbsoluteWhiteTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#FFFFFF0D")
}

// MARK: - Surface
extension PressedColorToken {
  static let surfaceLowest = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static let surfaceLower = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
  static let surfaceNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
}

// MARK: - Shadow
extension PressedColorToken {
  static let shadowXlarge = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A99")
  static let shadowLarge = PressedColorToken(lightColorHex: "#1C1C1C38", darkColorHex: "#0A0A0A66")
  static let shadowMedium = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#0A0A0A4D")
  static let shadowSmall = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#0A0A0A39")
  static let shadowBase = PressedColorToken(lightColorHex: "#1C1C1C14", darkColorHex: "#0A0A0A1E")
  static let shadowBaseInner = PressedColorToken(lightColorHex: "#EDEDED2F", darkColorHex: "#EDEDED1E")
}

// MARK: - Dim
extension PressedColorToken {
  static let dimBlackNormal = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static let dimBlackLight = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
}
