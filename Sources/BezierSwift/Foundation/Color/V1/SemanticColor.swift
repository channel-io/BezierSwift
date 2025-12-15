//
//  SemanticColor.swift
//  
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

public enum SemanticColor {
  case bgTransparent
  
  // MARK: - Background
  case bgWhiteHigh
  case bgWhiteLow
  case bgWhiteNormal
  case bgWhiteDimDark
  case bgWhiteDimLight
  case bgBlackDark
  case bgBlackDarker
  case bgBlackDarkest
  case bgBlackLight
  case bgBlackLighter
  case bgBlackLightest
  case bgGreyDarkest
  case bgGreyDark
  case bgGreyLight
  case bgGreyLighter
  case bgGreyLightest
  case bgGreyDimLightest
  case bgGnb
  case bgNavi
  case bgHeaderFloat
  case bgHeader
  case bgLounge
  
  // MARK: - Text
  case txtBlackDarkest
  case txtBlackDarker
  case txtBlackDark
  case txtWhiteNormal
  case txtBlackPure
  
  // MARK: - Background & Text - Absolute
  case bgtxtAbsoluteBlackDark
  case bgtxtAbsoluteBlackNormal
  case bgtxtAbsoluteBlackLight
  case bgtxtAbsoluteBlackLighter
  case bgtxtAbsoluteBlackLightest
  case bgtxtAbsoluteWhiteDark
  case bgtxtAbsoluteWhiteNormal
  case bgtxtAbsoluteWhiteLight
  case bgtxtAbsoluteWhiteLighter
  case bgtxtAbsoluteWhiteLightest
  
  // MARK: - Shadow for elevation
  case shdwXlarge
  case shdwLarge
  case shdwMedium
  case shdwSmall
  case shdwBase
  case shdwBaseInner
  
  // MARK: - Border & Divider
  case bdrBlackDark
  case bdrBlackLight
  case bdrBlackLightest
  case bdrGreyLight
  case bdrWhite
  
  // MARK: - Appendix, Blue
  case bgtxtBlueLightest
  case bgtxtBlueLighter
  case bgtxtBlueLight
  case bgtxtBlueNormal
  case bgtxtBlueDark
  
  // MARK: - Appendix, Cobalt
  case bgtxtCobaltLightest
  case bgtxtCobaltLighter
  case bgtxtCobaltLight
  case bgtxtCobaltNormal
  case bgtxtCobaltDark
  
  // MARK: - Appendix, Teal
  case bgtxtTealLightest
  case bgtxtTealLighter
  case bgtxtTealLight
  case bgtxtTealNormal
  case bgtxtTealDark
  
  // MARK: - Appendix, Green
  case bgtxtGreenLightest
  case bgtxtGreenLighter
  case bgtxtGreenLight
  case bgtxtGreenNormal
  case bgtxtGreenDark
  
  // MARK: - Appendix, Olive
  case bgtxtOliveLightest
  case bgtxtOliveLighter
  case bgtxtOliveLight
  case bgtxtOliveNormal
  case bgtxtOliveDark
  
  // MARK: - Appendix, Yellow
  case bgtxtYellowLightest
  case bgtxtYellowLighter
  case bgtxtYellowLight
  case bgtxtYellowNormal
  case bgtxtYellowDark
  
  // MARK: - Appendix, Orange
  case bgtxtOrangeLightest
  case bgtxtOrangeLighter
  case bgtxtOrangeLight
  case bgtxtOrangeNormal
  case bgtxtOrangeDark
  
  // MARK: - Appendix, Red
  case bgtxtRedLightest
  case bgtxtRedLighter
  case bgtxtRedLight
  case bgtxtRedNormal
  case bgtxtRedDark
  
  // MARK: - Appendix, Pink
  case bgtxtPinkLightest
  case bgtxtPinkLighter
  case bgtxtPinkLight
  case bgtxtPinkNormal
  case bgtxtPinkDark
  
  // MARK: - Appendix, Purple
  case bgtxtPurpleLightest
  case bgtxtPurpleLighter
  case bgtxtPurpleLight
  case bgtxtPurpleNormal
  case bgtxtPurpleDark
  
  // MARK: - Appendix, Navy
  case bgtxtNavyLightest
  case bgtxtNavyLighter
  case bgtxtNavyLight
  case bgtxtNavyNormal
  case bgtxtNavyDark
  case custom(PaletteSet)
}

// MARK: Light, Dark Color
extension SemanticColor: SemanticColorProtocol {
  public var light: ColorComponentsWithAlpha { self.paletteSet.light }
  public var dark: ColorComponentsWithAlpha { self.paletteSet.dark }
}

// MARK: Palette Set
extension SemanticColor {
  public typealias PaletteSet = (light: ColorComponentsWithAlpha, dark: ColorComponentsWithAlpha)
  
  private var paletteSet: PaletteSet {
    switch self {
    case .bgTransparent: return (Palette.white_0, Palette.white_0)
      // MARK: - Background
    case .bgWhiteHigh: return (Palette.white, Palette.grey700)
    case .bgWhiteLow: return (Palette.white, Palette.grey800)
    case .bgWhiteNormal: return (Palette.white, Palette.grey900)
    case .bgWhiteDimDark: return (Palette.white_60, Palette.black_60)
    case .bgWhiteDimLight: return (Palette.white_20, Palette.black_20)
    case .bgBlackDark: return (Palette.black_15, Palette.white_20)
    case .bgBlackDarker: return (Palette.black_40, Palette.white_40)
    case .bgBlackDarkest: return (Palette.black_60, Palette.white_60)
    case .bgBlackLight: return (Palette.black_8, Palette.white_12)
    case .bgBlackLighter: return (Palette.black_5, Palette.white_8)
    case .bgBlackLightest: return (Palette.black_3, Palette.white_5)
    case .bgGreyDarkest: return (Palette.grey900, Palette.white)
    case .bgGreyDark: return (Palette.grey500, Palette.grey50)
    case .bgGreyLight: return (Palette.grey200, Palette.grey700)
    case .bgGreyLighter: return (Palette.grey100, Palette.grey800)
    case .bgGreyLightest: return (Palette.grey50, Palette.grey850)
    case .bgGreyDimLightest: return (Palette.grey50_80, Palette.grey850_80)
    case .bgGnb: return (Palette.grey200_80, Palette.grey700_80)
    case .bgNavi: return (Palette.grey100_80, Palette.grey800_80)
    case .bgHeaderFloat: return (Palette.white_90, Palette.grey800_80)
    case .bgHeader: return (Palette.white, Palette.grey800)
    case .bgLounge: return (Palette.grey100_90, Palette.grey800_90)
      
      // MARK: - Text
    case .txtBlackDarkest: return (Palette.black_85, Palette.white_80)
    case .txtBlackDarker: return (Palette.black_60, Palette.white_60)
    case .txtBlackDark: return (Palette.black_40, Palette.white_40)
    case .txtWhiteNormal: return (Palette.white, Palette.grey800)
    case .txtBlackPure: return (Palette.black, Palette.white)
      
      // MARK: - Background & Text - Absolute
    case .bgtxtAbsoluteBlackDark: return (Palette.black, Palette.black)
    case .bgtxtAbsoluteBlackNormal: return (Palette.black_85, Palette.black_85)
    case .bgtxtAbsoluteBlackLight: return (Palette.black_60, Palette.black_60)
    case .bgtxtAbsoluteBlackLighter: return (Palette.black_40, Palette.black_40)
    case .bgtxtAbsoluteBlackLightest: return (Palette.black_20, Palette.black_20)
    case .bgtxtAbsoluteWhiteDark: return (Palette.white, Palette.white)
    case .bgtxtAbsoluteWhiteNormal: return (Palette.white_90, Palette.white_90)
    case .bgtxtAbsoluteWhiteLight: return (Palette.white_60, Palette.white_60)
    case .bgtxtAbsoluteWhiteLighter: return (Palette.white_40, Palette.white_40)
    case .bgtxtAbsoluteWhiteLightest: return (Palette.white_20, Palette.white_20)
      
      // MARK: - Shadow for elevation
    case .shdwXlarge: return (Palette.black_30, Palette.black_60)
    case .shdwLarge: return (Palette.black_22, Palette.black_40)
    case .shdwMedium: return (Palette.black_15, Palette.black_20)
    case .shdwSmall: return (Palette.black_8, Palette.black_15)
    case .shdwBase: return (Palette.black_5, Palette.black_8)
    case .shdwBaseInner: return (Palette.white_12, Palette.white_8)
      
      // MARK: - Border & Divider
    case .bdrBlackDark: return (Palette.black_15, Palette.white_20)
    case .bdrBlackLight: return (Palette.black_8, Palette.white_12)
    case .bdrBlackLightest: return (Palette.black_3, Palette.white_5)
    case .bdrGreyLight: return (Palette.grey200, Palette.grey700)
    case .bdrWhite: return (Palette.white, Palette.grey700)
      
      // MARK: - Appendix, Blue
    case .bgtxtBlueLightest: return (Palette.blue400_10, Palette.blue300_20)
    case .bgtxtBlueLighter: return (Palette.blue400_20, Palette.blue300_30)
    case .bgtxtBlueLight: return (Palette.blue400_30, Palette.blue300_40)
    case .bgtxtBlueNormal: return (Palette.blue400, Palette.blue300)
    case .bgtxtBlueDark: return (Palette.blue500, Palette.blue400)
      
      // MARK: - Appendix, Cobalt
    case .bgtxtCobaltLightest: return (Palette.cobalt400_10, Palette.cobalt300_20)
    case .bgtxtCobaltLighter: return (Palette.cobalt400_20, Palette.cobalt300_30)
    case .bgtxtCobaltLight: return (Palette.cobalt400_30, Palette.cobalt300_40)
    case .bgtxtCobaltNormal: return (Palette.cobalt400, Palette.cobalt300)
    case .bgtxtCobaltDark: return (Palette.cobalt500, Palette.cobalt400)
      
      // MARK: - Appendix, Teal
    case .bgtxtTealLightest: return (Palette.teal400_10, Palette.teal300_20)
    case .bgtxtTealLighter: return (Palette.teal400_20, Palette.teal300_30)
    case .bgtxtTealLight: return (Palette.teal400_30, Palette.teal300_40)
    case .bgtxtTealNormal: return (Palette.teal400, Palette.teal300)
    case .bgtxtTealDark: return (Palette.teal500, Palette.teal400)
      
      // MARK: - Appendix, Green
    case .bgtxtGreenLightest: return (Palette.green400_10, Palette.green300_20)
    case .bgtxtGreenLighter: return (Palette.green400_20, Palette.green300_30)
    case .bgtxtGreenLight: return (Palette.green400_30, Palette.green300_40)
    case .bgtxtGreenNormal: return (Palette.green400, Palette.green300)
    case .bgtxtGreenDark: return (Palette.green500, Palette.green400)
      
      // MARK: - Appendix, Olive
    case .bgtxtOliveLightest: return (Palette.olive400_10, Palette.olive300_20)
    case .bgtxtOliveLighter: return (Palette.olive400_20, Palette.olive300_30)
    case .bgtxtOliveLight: return (Palette.olive400_30, Palette.olive300_40)
    case .bgtxtOliveNormal: return (Palette.olive400, Palette.olive300)
    case .bgtxtOliveDark: return (Palette.olive500, Palette.olive400)
      
      // MARK: - Appendix, Yellow
    case .bgtxtYellowLightest: return (Palette.yellow400_10, Palette.yellow300_20)
    case .bgtxtYellowLighter: return (Palette.yellow400_20, Palette.yellow300_30)
    case .bgtxtYellowLight: return (Palette.yellow400_30, Palette.yellow300_40)
    case .bgtxtYellowNormal: return (Palette.yellow400, Palette.yellow300)
    case .bgtxtYellowDark: return (Palette.yellow500, Palette.yellow400)
      
      // MARK: - Appendix, Orange
    case .bgtxtOrangeLightest: return (Palette.orange400_10, Palette.orange300_20)
    case .bgtxtOrangeLighter: return (Palette.orange400_20, Palette.orange300_30)
    case .bgtxtOrangeLight: return (Palette.orange400_30, Palette.orange300_40)
    case .bgtxtOrangeNormal: return (Palette.orange400, Palette.orange300)
    case .bgtxtOrangeDark: return (Palette.orange500, Palette.orange400)
      
      // MARK: - Appendix, Red
    case .bgtxtRedLightest: return (Palette.red400_10, Palette.red300_20)
    case .bgtxtRedLighter: return (Palette.red400_20, Palette.red300_30)
    case .bgtxtRedLight: return (Palette.red400_30, Palette.red300_40)
    case .bgtxtRedNormal: return (Palette.red400, Palette.red300)
    case .bgtxtRedDark: return (Palette.red500, Palette.red400)
      
      // MARK: - Appendix, Pink
    case .bgtxtPinkLightest: return (Palette.pink400_10, Palette.pink300_20)
    case .bgtxtPinkLighter: return (Palette.pink400_20, Palette.pink300_30)
    case .bgtxtPinkLight: return (Palette.pink400_30, Palette.pink300_40)
    case .bgtxtPinkNormal: return (Palette.pink400, Palette.pink300)
    case .bgtxtPinkDark: return (Palette.pink500, Palette.pink400)
      
      // MARK: - Appendix, Purple
    case .bgtxtPurpleLightest: return (Palette.purple400_10, Palette.purple300_20)
    case .bgtxtPurpleLighter: return (Palette.purple400_20, Palette.purple300_30)
    case .bgtxtPurpleLight: return (Palette.purple400_30, Palette.purple300_40)
    case .bgtxtPurpleNormal: return (Palette.purple400, Palette.purple300)
    case .bgtxtPurpleDark: return (Palette.purple500, Palette.purple400)
      
      // MARK: - Appendix, Navy
    case .bgtxtNavyLightest: return (Palette.navy400_10, Palette.navy300_20)
    case .bgtxtNavyLighter: return (Palette.navy400_20, Palette.navy300_30)
    case .bgtxtNavyLight: return (Palette.navy400_30, Palette.navy300_40)
    case .bgtxtNavyNormal: return (Palette.navy400, Palette.navy300)
    case .bgtxtNavyDark: return (Palette.navy500, Palette.navy400)
    case .custom(let paletteSet): return (paletteSet.light, paletteSet.dark)
    }
  }
}
