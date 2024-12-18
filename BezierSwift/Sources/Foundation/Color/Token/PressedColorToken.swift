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
  static var fgBlueNormal = PressedColorToken(lightColorHex: "#5551FC", darkColorHex: "#93AEFB")
  static var fgBlueLight = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB73")
  static var fgBlueDark = PressedColorToken(lightColorHex: "#4B42D5", darkColorHex: "#93AEFB")
}

// MARK: - ForegroundCobalt
extension PressedColorToken {
  static var fgCobaltNormal = PressedColorToken(lightColorHex: "#4088DF", darkColorHex: "#83C4FA")
  static var fgCobaltLight = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA73")
  static var fgCobaltDark = PressedColorToken(lightColorHex: "#3268C4", darkColorHex: "#83C4FA")
}

// MARK: - ForegroundRed
extension PressedColorToken {
  static var fgRedNormal = PressedColorToken(lightColorHex: "#DF4C4C", darkColorHex: "#FFA2A2")
  static var fgRedLight = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A273")
  static var fgRedDark = PressedColorToken(lightColorHex: "#AB3940", darkColorHex: "#FFA2A2")
}

// MARK: - ForegroundOrange
extension PressedColorToken {
  static var fgOrangeNormal = PressedColorToken(lightColorHex: "#DF751F", darkColorHex: "#FFAE74")
  static var fgOrangeLight = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE7473")
  static var fgOrangeDark = PressedColorToken(lightColorHex: "#B15C0F", darkColorHex: "#FFAE74")
}

// MARK: - ForegroundGreen
extension PressedColorToken {
  static var fgGreenNormal = PressedColorToken(lightColorHex: "#3F9E61", darkColorHex: "#74D68B")
  static var fgGreenLight = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B73")
  static var fgGreenDark = PressedColorToken(lightColorHex: "#347B5A", darkColorHex: "#74D68B")
}

// MARK: - ForegroundTeal
extension PressedColorToken {
  static var fgTealNormal = PressedColorToken(lightColorHex: "#08A5A0", darkColorHex: "#4CDCCF")
  static var fgTealLight = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF73")
  static var fgTealDark = PressedColorToken(lightColorHex: "#06848B", darkColorHex: "#4CDCCF")
}

// MARK: - ForegroundOlive
extension PressedColorToken {
  static var fgOliveNormal = PressedColorToken(lightColorHex: "#9BA212", darkColorHex: "#D2DF3D")
  static var fgOliveLight = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D73")
  static var fgOliveDark = PressedColorToken(lightColorHex: "#70751C", darkColorHex: "#D2DF3D")
}

// MARK: - ForegroundYellow
extension PressedColorToken {
  static var fgYellowNormal = PressedColorToken(lightColorHex: "#D9A010", darkColorHex: "#FACE4A")
  static var fgYellowLight = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A73")
  static var fgYellowDark = PressedColorToken(lightColorHex: "#B58500", darkColorHex: "#FACE4A")
}

// MARK: - ForegroundPink
extension PressedColorToken {
  static var fgPinkNormal = PressedColorToken(lightColorHex: "#CF3EAC", darkColorHex: "#F27FDB")
  static var fgPinkLight = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB73")
  static var fgPinkDark = PressedColorToken(lightColorHex: "#A03591", darkColorHex: "#F27FDB")
}

// MARK: - ForegroundPurple
extension PressedColorToken {
  static var fgPurpleNormal = PressedColorToken(lightColorHex: "#8247E1", darkColorHex: "#BF9AFF")
  static var fgPurpleLight = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF73")
  static var fgPurpleDark = PressedColorToken(lightColorHex: "#6135A6", darkColorHex: "#BF9AFF")
}

// MARK: - ForegroundNavy
extension PressedColorToken {
  static var fgNavyNormal = PressedColorToken(lightColorHex: "#414C9C", darkColorHex: "#838FDC")
  static var fgNavyLight = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC73")
  static var fgNavyDark = PressedColorToken(lightColorHex: "#34377C", darkColorHex: "#838FDC")
}

// MARK: - ForegroundGrey
extension PressedColorToken {
  static var fgGreyDarkest = PressedColorToken(lightColorHex: "#42424A", darkColorHex: "#E5E5E8")
  static var fgGreyDark = PressedColorToken(lightColorHex: "#9B9B9E", darkColorHex: "#B2B2B5")
  static var fgGreyNormal = PressedColorToken(lightColorHex: "#C0C0C3", darkColorHex: "#868686")
  static var fgGreyLight = PressedColorToken(lightColorHex: "#DEDEE0", darkColorHex: "#505253")
  static var fgGreyLighter = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static var fgGreyLightest = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
}

// MARK: - ForegroundGreyAlpha
extension PressedColorToken {
  static var fgGreyAlphaDarkest = PressedColorToken(lightColorHex: "#DEDEE0CC", darkColorHex: "#505253CC")
  static var fgGreyAlphaDarker = PressedColorToken(lightColorHex: "#E5E5E8E6", darkColorHex: "#3B3C3FE6")
  static var fgGreyAlphaDark = PressedColorToken(lightColorHex: "#E5E5E8CC", darkColorHex: "#3B3C3FCC")
  static var fgGreyAlphaLight = PressedColorToken(lightColorHex: "#EAEAEACC", darkColorHex: "#343538CC")
}

// MARK: - ForegroundWhite
extension PressedColorToken {
  static var fgWhiteNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
}

// MARK: - ForegroundBlack
extension PressedColorToken {
  static var fgBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#EDEDED2F")
  static var fgBlackLight = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#EDEDED4D")
  static var fgBlackDark = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#EDEDED66")
  static var fgBlackDarker = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#EDEDED99")
  static var fgBlackDarkest = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#EDEDEDCC")
  static var fgBlackPure = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#EDEDED")
}

// MARK: - ForegroundAbsoluteWhite
extension PressedColorToken {
  static var fgAbsoluteWhiteLightest = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#EDEDED4D")
  static var fgAbsoluteWhiteLighter = PressedColorToken(lightColorHex: "#EDEDED66", darkColorHex: "#EDEDED66")
  static var fgAbsoluteWhiteLight = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#EDEDED99")
  static var fgAbsoluteWhiteNormal = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#EDEDEDE6")
  static var fgAbsoluteWhiteDark = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#EDEDED")
}

// MARK: - ForegroundAbsoluteBlack
extension PressedColorToken {
  static var fgAbsoluteBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
  static var fgAbsoluteBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static var fgAbsoluteBlackLight = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static var fgAbsoluteBlackNormal = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#0A0A0AD9")
  static var fgAbsoluteBlackDark = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#0A0A0A")
}

// MARK: - BackgroundBlue
extension PressedColorToken {
  static var bgBlueNormal = PressedColorToken(lightColorHex: "#5551FC", darkColorHex: "#93AEFB")
  static var bgBlueLight = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB73")
  static var bgBlueLighter = PressedColorToken(lightColorHex: "#5551FC4D", darkColorHex: "#93AEFB4D")
  static var bgBlueLightest = PressedColorToken(lightColorHex: "#5551FC27", darkColorHex: "#93AEFB39")
  static var bgBlueDark = PressedColorToken(lightColorHex: "#4B42D5", darkColorHex: "#8280FC")
  static var bgBlueShadeLighter = PressedColorToken(lightColorHex: "#6165D94D", darkColorHex: "#4E569D66")
  static var bgBlueShadeNormal = PressedColorToken(lightColorHex: "#6165D9", darkColorHex: "#4E569D")
  static var bgBlueTransparent = PressedColorToken(lightColorHex: "#6D6AFC1A", darkColorHex: "#7D9EFA1A")
}

// MARK: - BackgroundCobalt
extension PressedColorToken {
  static var bgCobaltNormal = PressedColorToken(lightColorHex: "#4088DF", darkColorHex: "#83C4FA")
  static var bgCobaltLight = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA73")
  static var bgCobaltLighter = PressedColorToken(lightColorHex: "#4088DF4D", darkColorHex: "#83C4FA4D")
  static var bgCobaltLightest = PressedColorToken(lightColorHex: "#4088DF27", darkColorHex: "#83C4FA39")
  static var bgCobaltDark = PressedColorToken(lightColorHex: "#3268C4", darkColorHex: "#5F9EEC")
  static var bgCobaltShadeLighter = PressedColorToken(lightColorHex: "#47A2E24D", darkColorHex: "#4C6A9966")
  static var bgCobaltShadeNormal = PressedColorToken(lightColorHex: "#47A2E2", darkColorHex: "#4C6A99")
  static var bgCobaltTransparent = PressedColorToken(lightColorHex: "#5093E51A", darkColorHex: "#71B9F51A")
}

// MARK: - BackgroundRed
extension PressedColorToken {
  static var bgRedNormal = PressedColorToken(lightColorHex: "#DF4C4C", darkColorHex: "#FFA2A2")
  static var bgRedLight = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A273")
  static var bgRedLighter = PressedColorToken(lightColorHex: "#DF4C4C4D", darkColorHex: "#FFA2A24D")
  static var bgRedLightest = PressedColorToken(lightColorHex: "#DF4C4C27", darkColorHex: "#FFA2A239")
  static var bgRedDark = PressedColorToken(lightColorHex: "#AB3940", darkColorHex: "#EC6B6B")
  static var bgRedShadeLighter = PressedColorToken(lightColorHex: "#D758614D", darkColorHex: "#A5434A66")
  static var bgRedShadeNormal = PressedColorToken(lightColorHex: "#D75861", darkColorHex: "#A5434A")
  static var bgRedTransparent = PressedColorToken(lightColorHex: "#E55C5C1A", darkColorHex: "#FF8C8C1A")
}

// MARK: - BackgroundOrange
extension PressedColorToken {
  static var bgOrangeNormal = PressedColorToken(lightColorHex: "#DF751F", darkColorHex: "#FFAE74")
  static var bgOrangeLight = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE7473")
  static var bgOrangeLighter = PressedColorToken(lightColorHex: "#DF751F4D", darkColorHex: "#FFAE744D")
  static var bgOrangeLightest = PressedColorToken(lightColorHex: "#DF751F27", darkColorHex: "#FFAE7439")
  static var bgOrangeDark = PressedColorToken(lightColorHex: "#B15C0F", darkColorHex: "#EE8A39")
  static var bgOrangeShadeLighter = PressedColorToken(lightColorHex: "#D9813A4D", darkColorHex: "#9E643566")
  static var bgOrangeShadeNormal = PressedColorToken(lightColorHex: "#D9813A", darkColorHex: "#9E6435")
  static var bgOrangeTransparent = PressedColorToken(lightColorHex: "#E67F2B1A", darkColorHex: "#FFA15E1A")
}

// MARK: - BackgroundGreen
extension PressedColorToken {
  static var bgGreenNormal = PressedColorToken(lightColorHex: "#3F9E61", darkColorHex: "#74D68B")
  static var bgGreenLight = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B73")
  static var bgGreenLighter = PressedColorToken(lightColorHex: "#3F9E614D", darkColorHex: "#74D68B4D")
  static var bgGreenLightest = PressedColorToken(lightColorHex: "#3F9E6127", darkColorHex: "#74D68B39")
  static var bgGreenDark = PressedColorToken(lightColorHex: "#347B5A", darkColorHex: "#41C16F")
  static var bgGreenShadeLighter = PressedColorToken(lightColorHex: "#5AA4734D", darkColorHex: "#4F8D6766")
  static var bgGreenShadeNormal = PressedColorToken(lightColorHex: "#5AA473", darkColorHex: "#4F8D67")
  static var bgGreenTransparent = PressedColorToken(lightColorHex: "#40AD671A", darkColorHex: "#68CC7F1A")
}

// MARK: - BackgroundTeal
extension PressedColorToken {
  static var bgTealNormal = PressedColorToken(lightColorHex: "#08A5A0", darkColorHex: "#4CDCCF")
  static var bgTealLight = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF73")
  static var bgTealLighter = PressedColorToken(lightColorHex: "#08A5A04D", darkColorHex: "#4CDCCF4D")
  static var bgTealLightest = PressedColorToken(lightColorHex: "#08A5A027", darkColorHex: "#4CDCCF39")
  static var bgTealDark = PressedColorToken(lightColorHex: "#06848B", darkColorHex: "#0AC6C0")
  static var bgTealShadeLighter = PressedColorToken(lightColorHex: "#539B984D", darkColorHex: "#49839066")
  static var bgTealShadeNormal = PressedColorToken(lightColorHex: "#539B98", darkColorHex: "#498390")
  static var bgTealTransparent = PressedColorToken(lightColorHex: "#09B2AC1A", darkColorHex: "#40D3C51A")
}

// MARK: - BackgroundOlive
extension PressedColorToken {
  static var bgOliveNormal = PressedColorToken(lightColorHex: "#9BA212", darkColorHex: "#D2DF3D")
  static var bgOliveLight = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D73")
  static var bgOliveLighter = PressedColorToken(lightColorHex: "#9BA2124D", darkColorHex: "#D2DF3D4D")
  static var bgOliveLightest = PressedColorToken(lightColorHex: "#9BA21227", darkColorHex: "#D2DF3D39")
  static var bgOliveDark = PressedColorToken(lightColorHex: "#70751C", darkColorHex: "#C1CA0C")
  static var bgOliveShadeLighter = PressedColorToken(lightColorHex: "#969A514D", darkColorHex: "#86893A66")
  static var bgOliveShadeNormal = PressedColorToken(lightColorHex: "#969A51", darkColorHex: "#86893A")
  static var bgOliveTransparent = PressedColorToken(lightColorHex: "#A9B1101A", darkColorHex: "#C8D6301A")
}

// MARK: - BackgroundYellow
extension PressedColorToken {
  static var bgYellowNormal = PressedColorToken(lightColorHex: "#D9A010", darkColorHex: "#FACE4A")
  static var bgYellowLight = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A73")
  static var bgYellowLighter = PressedColorToken(lightColorHex: "#D9A0104D", darkColorHex: "#FACE4A4D")
  static var bgYellowLightest = PressedColorToken(lightColorHex: "#D9A01027", darkColorHex: "#FACE4A39")
  static var bgYellowDark = PressedColorToken(lightColorHex: "#B58500", darkColorHex: "#F9B917")
  static var bgYellowShadeLighter = PressedColorToken(lightColorHex: "#E2A52D4D", darkColorHex: "#927A2666")
  static var bgYellowShadeNormal = PressedColorToken(lightColorHex: "#E2A52D", darkColorHex: "#927A26")
  static var bgYellowTransparent = PressedColorToken(lightColorHex: "#EDAE0D1A", darkColorHex: "#F9C8351A")
}

// MARK: - BackgroundPink
extension PressedColorToken {
  static var bgPinkNormal = PressedColorToken(lightColorHex: "#CF3EAC", darkColorHex: "#F27FDB")
  static var bgPinkLight = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB73")
  static var bgPinkLighter = PressedColorToken(lightColorHex: "#CF3EAC4D", darkColorHex: "#F27FDB4D")
  static var bgPinkLightest = PressedColorToken(lightColorHex: "#CF3EAC27", darkColorHex: "#F27FDB39")
  static var bgPinkDark = PressedColorToken(lightColorHex: "#A03591", darkColorHex: "#DF58BF")
  static var bgPinkShadeLighter = PressedColorToken(lightColorHex: "#CB5BB04D", darkColorHex: "#99428566")
  static var bgPinkShadeNormal = PressedColorToken(lightColorHex: "#CB5BB0", darkColorHex: "#994285")
  static var bgPinkTransparent = PressedColorToken(lightColorHex: "#D64BB51A", darkColorHex: "#EC6FD31A")
}

// MARK: - BackgroundPurple
extension PressedColorToken {
  static var bgPurpleNormal = PressedColorToken(lightColorHex: "#8247E1", darkColorHex: "#BF9AFF")
  static var bgPurpleLight = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF73")
  static var bgPurpleLighter = PressedColorToken(lightColorHex: "#8247E14D", darkColorHex: "#BF9AFF4D")
  static var bgPurpleLightest = PressedColorToken(lightColorHex: "#8247E127", darkColorHex: "#BF9AFF39")
  static var bgPurpleDark = PressedColorToken(lightColorHex: "#6135A6", darkColorHex: "#9A66EE")
  static var bgPurpleShadeLighter = PressedColorToken(lightColorHex: "#905EDE4D", darkColorHex: "#64489066")
  static var bgPurpleShadeNormal = PressedColorToken(lightColorHex: "#905EDE", darkColorHex: "#644890")
  static var bgPurpleTransparent = PressedColorToken(lightColorHex: "#8E57E71A", darkColorHex: "#B184FF1A")
}

// MARK: - BackgroundNavy
extension PressedColorToken {
  static var bgNavyNormal = PressedColorToken(lightColorHex: "#414C9C", darkColorHex: "#838FDC")
  static var bgNavyLight = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC73")
  static var bgNavyLighter = PressedColorToken(lightColorHex: "#414C9C4D", darkColorHex: "#838FDC4D")
  static var bgNavyLightest = PressedColorToken(lightColorHex: "#414C9C27", darkColorHex: "#838FDC39")
  static var bgNavyDark = PressedColorToken(lightColorHex: "#34377C", darkColorHex: "#4353BF")
  static var bgNavyShadeLighter = PressedColorToken(lightColorHex: "#5761A54D", darkColorHex: "#3B416766")
  static var bgNavyShadeNormal = PressedColorToken(lightColorHex: "#5761A5", darkColorHex: "#3B4167")
  static var bgNavyTransparent = PressedColorToken(lightColorHex: "#424FAB1A", darkColorHex: "#7683D31A")
}

// MARK: - BackgroundGrey
extension PressedColorToken {
  static var bgGreyDarkest = PressedColorToken(lightColorHex: "#42424A", darkColorHex: "#EDEDED")
  static var bgGreyDark = PressedColorToken(lightColorHex: "#9B9B9E", darkColorHex: "#B2B2B5")
  static var bgGreyNormal = PressedColorToken(lightColorHex: "#C0C0C3", darkColorHex: "#868686")
  static var bgGreyLight = PressedColorToken(lightColorHex: "#DEDEE0", darkColorHex: "#505253")
  static var bgGreyLighter = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static var bgGreyLightest = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
  static var bgGreyTransparent = PressedColorToken(lightColorHex: "#2424280D", darkColorHex: "#FFFFFF0D")
}

// MARK: - BackgroundGreyAlpha
extension PressedColorToken {
  static var bgGreyAlphaDarkest = PressedColorToken(lightColorHex: "#DEDEE0CC", darkColorHex: "#505253CC")
  static var bgGreyAlphaDarker = PressedColorToken(lightColorHex: "#E5E5E8E6", darkColorHex: "#3B3C3FE6")
  static var bgGreyAlphaDark = PressedColorToken(lightColorHex: "#E5E5E8CC", darkColorHex: "#3B3C3FCC")
  static var bgGreyAlphaLight = PressedColorToken(lightColorHex: "#EAEAEACC", darkColorHex: "#343538CC")
}

// MARK: - BackgroundBlack
extension PressedColorToken {
  static var bgBlackDarkest = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static var bgBlackDarker = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#EDEDED66")
  static var bgBlackDark = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#EDEDED4D")
  static var bgBlackLight = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#EDEDED2F")
  static var bgBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C14", darkColorHex: "#EDEDED1E")
  static var bgBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C0C", darkColorHex: "#EDEDED14")
  static var bgBlackTransparent = PressedColorToken(lightColorHex: "#0000000D", darkColorHex: "#FFFFFF0D")
}

// MARK: - BackgroundWhite
extension PressedColorToken {
  static var bgWhiteHighest = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#505253")
  static var bgWhiteHigher = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#3B3C3F")
  static var bgWhiteNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
  // TODO: bgWhiteTransparent의 darkColorHex 가 달라서 체크 요청 함. 확인 후 변경 필요 by Tom 2024.11.18
  static var bgWhiteTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#")
}

// MARK: - BackgroundWhiteAlpha
extension PressedColorToken {
  static var bgWhiteAlphaLightest = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#3B3C3FCC")
  static var bgWhiteAlphaLighter = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#0A0A0A99")
  static var bgWhiteAlphaLight = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#0A0A0A4D")
  static var bgWhiteAlphaTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#0000000D")
}

// MARK: - BackgroundAbsoluteBlack
extension PressedColorToken {
  static var bgAbsoluteBlackDark = PressedColorToken(lightColorHex: "#1C1C1C", darkColorHex: "#0A0A0A")
  static var bgAbsoluteBlackNormal = PressedColorToken(lightColorHex: "#1C1C1CD9", darkColorHex: "#0A0A0AD9")
  static var bgAbsoluteBlackLight = PressedColorToken(lightColorHex: "#1C1C1C99", darkColorHex: "#0A0A0A99")
  static var bgAbsoluteBlackLighter = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static var bgAbsoluteBlackLightest = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
  static var bgAbsoluteBlackTransparent = PressedColorToken(lightColorHex: "#0000000D", darkColorHex: "#0000000D")
}

// MARK: - BackgroundAbsoluteWhite
extension PressedColorToken {
  static var bgAbsoluteWhiteDark = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#EDEDED")
  static var bgAbsoluteWhiteNormal = PressedColorToken(lightColorHex: "#EDEDEDE6", darkColorHex: "#EDEDEDE6")
  static var bgAbsoluteWhiteLight = PressedColorToken(lightColorHex: "#EDEDED99", darkColorHex: "#EDEDED99")
  static var bgAbsoluteWhiteLighter = PressedColorToken(lightColorHex: "#EDEDED66", darkColorHex: "#EDEDED66")
  static var bgAbsoluteWhiteLightest = PressedColorToken(lightColorHex: "#EDEDED4D", darkColorHex: "#EDEDED4D")
  static var bgAbsoluteWhiteTransparent = PressedColorToken(lightColorHex: "#FFFFFF0D", darkColorHex: "#FFFFFF0D")
}

// MARK: - Surface
extension PressedColorToken {
  static var surfaceLowest = PressedColorToken(lightColorHex: "#E5E5E8", darkColorHex: "#3B3C3F")
  static var surfaceLower = PressedColorToken(lightColorHex: "#EAEAEA", darkColorHex: "#343538")
  static var surfaceNormal = PressedColorToken(lightColorHex: "#EDEDED", darkColorHex: "#2E2E33")
}

// MARK: - Shadow
extension PressedColorToken {
  static var shadowXlarge = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A99")
  static var shadowLarge = PressedColorToken(lightColorHex: "#1C1C1C38", darkColorHex: "#0A0A0A66")
  static var shadowMedium = PressedColorToken(lightColorHex: "#1C1C1C39", darkColorHex: "#0A0A0A4D")
  static var shadowSmall = PressedColorToken(lightColorHex: "#1C1C1C1E", darkColorHex: "#0A0A0A39")
  static var shadowBase = PressedColorToken(lightColorHex: "#1C1C1C14", darkColorHex: "#0A0A0A1E")
  static var shadowBaseInner = PressedColorToken(lightColorHex: "#EDEDED2F", darkColorHex: "#EDEDED1E")
}

// MARK: - Dim
extension PressedColorToken {
  static var dimBlackNormal = PressedColorToken(lightColorHex: "#1C1C1C66", darkColorHex: "#0A0A0A66")
  static var dimBlackLight = PressedColorToken(lightColorHex: "#1C1C1C4D", darkColorHex: "#0A0A0A4D")
}
