import UIKit

// core-bezier-system 의 specs/tokens 에서 자동 생성된 파일입니다. 직접 수정하지 마세요.

public enum BCSemanticToken: Equatable {
  case borderAbsoluteWhite
  case borderDetach
  case borderDetachHigh
  case borderDetachHigher
  case borderDetachHighest
  case borderDetachLow
  case borderNeutral
  case borderNeutralHeavier
  case borderNeutralHeavy
  case chartThemeDefault01
  case chartThemeDefault02
  case chartThemeDefault03
  case chartThemeDefault04
  case chartThemeDefault05
  case chartThemeDefault06
  case chartThemeDefault07
  case chartThemeDefault08
  case chartThemeDefault09
  case chartThemeDefault10
  case dimAbsoluteBlack
  case dimAbsoluteBlackHeavy
  case dimAbsoluteWhite
  case dimAbsoluteWhiteHeavy
  case elevationBase
  case elevationBaseInner
  case elevationLarge
  case elevationMedium
  case elevationSmall
  case elevationXlarge
  case fillAbsoluteBlack
  case fillAbsoluteBlackLight
  case fillAbsoluteBlackTransparent
  case fillAbsoluteWhite
  case fillAbsoluteWhiteLight
  case fillAbsoluteWhiteTransparent
  case fillAccentBlue
  case fillAccentBlueHeavier
  case fillAccentBlueHeavy
  case fillAccentBlueTransparent
  case fillAccentCobalt
  case fillAccentCobaltHeavier
  case fillAccentCobaltHeavy
  case fillAccentCobaltTransparent
  case fillAccentGreen
  case fillAccentGreenHeavier
  case fillAccentGreenHeavy
  case fillAccentGreenTransparent
  case fillAccentNavy
  case fillAccentNavyHeavier
  case fillAccentNavyHeavy
  case fillAccentNavyTransparent
  case fillAccentOlive
  case fillAccentOliveHeavier
  case fillAccentOliveHeavy
  case fillAccentOliveTransparent
  case fillAccentOrange
  case fillAccentOrangeHeavier
  case fillAccentOrangeHeavy
  case fillAccentOrangeTransparent
  case fillAccentPink
  case fillAccentPinkHeavier
  case fillAccentPinkHeavy
  case fillAccentPinkTransparent
  case fillAccentPurple
  case fillAccentPurpleHeavier
  case fillAccentPurpleHeavy
  case fillAccentPurpleTransparent
  case fillAccentRed
  case fillAccentRedHeavier
  case fillAccentRedHeavy
  case fillAccentRedTransparent
  case fillAccentTeal
  case fillAccentTealHeavier
  case fillAccentTealHeavy
  case fillAccentTealTransparent
  case fillAccentYellow
  case fillAccentYellowHeavier
  case fillAccentYellowHeavy
  case fillAccentYellowTransparent
  case fillAction
  case fillActionLight
  case fillActionLighter
  case fillActionTransparent
  case fillBright
  case fillCritical
  case fillCriticalLight
  case fillCriticalLighter
  case fillCriticalTransparent
  case fillGrey
  case fillGreyHeavier
  case fillGreyHeavy
  case fillGreyLight
  case fillHighlight
  case fillHighlightLight
  case fillHighlightLighter
  case fillHighlightTransparent
  case fillNeutral
  case fillNeutralHeavier
  case fillNeutralHeaviest
  case fillNeutralHeavy
  case fillNeutralLight
  case fillNeutralLighter
  case fillNeutralLightest
  case fillNeutralTransparent
  case fillSuccess
  case fillSuccessLight
  case fillSuccessLighter
  case fillSuccessTransparent
  case fillWarning
  case fillWarningLight
  case fillWarningLighter
  case fillWarningTransparent
  case iconAbsoluteBlack
  case iconAbsoluteWhite
  case iconAccentBlue
  case iconAccentCobalt
  case iconAccentGreen
  case iconAccentNavy
  case iconAccentOlive
  case iconAccentOrange
  case iconAccentPink
  case iconAccentPurple
  case iconAccentRed
  case iconAccentTeal
  case iconAccentYellow
  case iconAction
  case iconCritical
  case iconHighlight
  case iconInverseHeavier
  case iconNeutral
  case iconNeutralHeavier
  case iconNeutralHeavy
  case iconSuccess
  case iconWarning
  case stateActive
  case stateDefault
  case stateFocus
  case stateWarning
  case surface
  case surfaceGlass
  case surfaceGlassHigh
  case surfaceGlassHigher
  case surfaceGlassHighest
  case surfaceHigh
  case surfaceHigher
  case surfaceHighest
  case surfaceLow
  case textAbsoluteBlack
  case textAbsoluteWhite
  case textAccentBlue
  case textAccentCobalt
  case textAccentGreen
  case textAccentNavy
  case textAccentOlive
  case textAccentOrange
  case textAccentPink
  case textAccentPurple
  case textAccentRed
  case textAccentTeal
  case textAccentYellow
  case textAction
  case textCritical
  case textHighlight
  case textInverse
  case textNeutral
  case textNeutralHeaviest
  case textNeutralLight
  case textNeutralLighter
  case textSuccess
  case textWarning

  typealias PaletteSet = (light: ColorComponentsWithAlpha, dark: ColorComponentsWithAlpha)

  var paletteSet: PaletteSet {
    switch self {
    case .borderAbsoluteWhite:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.white100.value)
    case .borderDetach:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey900.value)
    case .borderDetachHigh:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey850.value)
    case .borderDetachHigher:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey800.value)
    case .borderDetachHighest:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey750.value)
    case .borderDetachLow:
      return (light: BCGlobalToken.grey50.value, dark: BCGlobalToken.grey950.value)
    case .borderNeutral:
      return (light: BCGlobalToken.black8.value, dark: BCGlobalToken.white12.value)
    case .borderNeutralHeavier:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .borderNeutralHeavy:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.white20.value)
    case .chartThemeDefault01:
      return (light: ColorComponentsWithAlpha(red: 0x7C, green: 0x72, blue: 0xFD, alpha: 1), dark: ColorComponentsWithAlpha(red: 0x7C, green: 0x72, blue: 0xFD, alpha: 1))
    case .chartThemeDefault02:
      return (light: ColorComponentsWithAlpha(red: 0x81, green: 0xDF, blue: 0xDD, alpha: 1), dark: ColorComponentsWithAlpha(red: 0x81, green: 0xDF, blue: 0xDD, alpha: 1))
    case .chartThemeDefault03:
      return (light: ColorComponentsWithAlpha(red: 0xFC, green: 0x97, blue: 0x83, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xFC, green: 0x97, blue: 0x83, alpha: 1))
    case .chartThemeDefault04:
      return (light: ColorComponentsWithAlpha(red: 0xB1, green: 0x59, blue: 0x6A, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xB1, green: 0x59, blue: 0x6A, alpha: 1))
    case .chartThemeDefault05:
      return (light: ColorComponentsWithAlpha(red: 0xFE, green: 0x71, blue: 0xBA, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xFE, green: 0x71, blue: 0xBA, alpha: 1))
    case .chartThemeDefault06:
      return (light: ColorComponentsWithAlpha(red: 0xC9, green: 0x71, blue: 0xEC, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xC9, green: 0x71, blue: 0xEC, alpha: 1))
    case .chartThemeDefault07:
      return (light: ColorComponentsWithAlpha(red: 0x4A, green: 0x75, blue: 0xE3, alpha: 1), dark: ColorComponentsWithAlpha(red: 0x4A, green: 0x75, blue: 0xE3, alpha: 1))
    case .chartThemeDefault08:
      return (light: ColorComponentsWithAlpha(red: 0x80, green: 0xB6, blue: 0xFD, alpha: 1), dark: ColorComponentsWithAlpha(red: 0x80, green: 0xB6, blue: 0xFD, alpha: 1))
    case .chartThemeDefault09:
      return (light: ColorComponentsWithAlpha(red: 0xFB, green: 0x90, blue: 0xF1, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xFB, green: 0x90, blue: 0xF1, alpha: 1))
    case .chartThemeDefault10:
      return (light: ColorComponentsWithAlpha(red: 0xB4, green: 0xD6, blue: 0xE5, alpha: 1), dark: ColorComponentsWithAlpha(red: 0xB4, green: 0xD6, blue: 0xE5, alpha: 1))
    case .dimAbsoluteBlack:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.black40.value)
    case .dimAbsoluteBlackHeavy:
      return (light: BCGlobalToken.black60.value, dark: BCGlobalToken.black60.value)
    case .dimAbsoluteWhite:
      return (light: BCGlobalToken.white40.value, dark: BCGlobalToken.white40.value)
    case .dimAbsoluteWhiteHeavy:
      return (light: BCGlobalToken.white60.value, dark: BCGlobalToken.white80.value)
    case .elevationBase:
      return (light: BCGlobalToken.black5.value, dark: BCGlobalToken.black5.value)
    case .elevationBaseInner:
      return (light: BCGlobalToken.white12.value, dark: BCGlobalToken.white12.value)
    case .elevationLarge:
      return (light: BCGlobalToken.black22.value, dark: BCGlobalToken.black22.value)
    case .elevationMedium:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.black15.value)
    case .elevationSmall:
      return (light: BCGlobalToken.black8.value, dark: BCGlobalToken.black8.value)
    case .elevationXlarge:
      return (light: BCGlobalToken.black30.value, dark: BCGlobalToken.black30.value)
    case .fillAbsoluteBlack:
      return (light: BCGlobalToken.black100.value, dark: BCGlobalToken.black100.value)
    case .fillAbsoluteBlackLight:
      return (light: BCGlobalToken.black20.value, dark: BCGlobalToken.black20.value)
    case .fillAbsoluteBlackTransparent:
      return (light: BCGlobalToken.black0.value, dark: BCGlobalToken.black0.value)
    case .fillAbsoluteWhite:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.white100.value)
    case .fillAbsoluteWhiteLight:
      return (light: BCGlobalToken.white20.value, dark: BCGlobalToken.white20.value)
    case .fillAbsoluteWhiteTransparent:
      return (light: BCGlobalToken.white0.value, dark: BCGlobalToken.white0.value)
    case .fillAccentBlue:
      return (light: BCGlobalToken.blue400_10.value, dark: BCGlobalToken.blue300_18.value)
    case .fillAccentBlueHeavier:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .fillAccentBlueHeavy:
      return (light: BCGlobalToken.blue400_20.value, dark: BCGlobalToken.blue300_30.value)
    case .fillAccentBlueTransparent:
      return (light: BCGlobalToken.blue400_0.value, dark: BCGlobalToken.blue300_0.value)
    case .fillAccentCobalt:
      return (light: BCGlobalToken.cobalt400_10.value, dark: BCGlobalToken.cobalt300_18.value)
    case .fillAccentCobaltHeavier:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .fillAccentCobaltHeavy:
      return (light: BCGlobalToken.cobalt400_20.value, dark: BCGlobalToken.cobalt300_30.value)
    case .fillAccentCobaltTransparent:
      return (light: BCGlobalToken.cobalt400_0.value, dark: BCGlobalToken.cobalt300_0.value)
    case .fillAccentGreen:
      return (light: BCGlobalToken.green400_10.value, dark: BCGlobalToken.green300_18.value)
    case .fillAccentGreenHeavier:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .fillAccentGreenHeavy:
      return (light: BCGlobalToken.green400_20.value, dark: BCGlobalToken.green300_30.value)
    case .fillAccentGreenTransparent:
      return (light: BCGlobalToken.green400_0.value, dark: BCGlobalToken.green300_0.value)
    case .fillAccentNavy:
      return (light: BCGlobalToken.navy400_10.value, dark: BCGlobalToken.navy300_18.value)
    case .fillAccentNavyHeavier:
      return (light: BCGlobalToken.navy400.value, dark: BCGlobalToken.navy300.value)
    case .fillAccentNavyHeavy:
      return (light: BCGlobalToken.navy400_20.value, dark: BCGlobalToken.navy300_30.value)
    case .fillAccentNavyTransparent:
      return (light: BCGlobalToken.navy400_0.value, dark: BCGlobalToken.navy300_0.value)
    case .fillAccentOlive:
      return (light: BCGlobalToken.olive400_10.value, dark: BCGlobalToken.olive300_18.value)
    case .fillAccentOliveHeavier:
      return (light: BCGlobalToken.olive400.value, dark: BCGlobalToken.olive300.value)
    case .fillAccentOliveHeavy:
      return (light: BCGlobalToken.olive400_20.value, dark: BCGlobalToken.olive300_30.value)
    case .fillAccentOliveTransparent:
      return (light: BCGlobalToken.olive400_0.value, dark: BCGlobalToken.olive300_0.value)
    case .fillAccentOrange:
      return (light: BCGlobalToken.orange400_10.value, dark: BCGlobalToken.orange300_18.value)
    case .fillAccentOrangeHeavier:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .fillAccentOrangeHeavy:
      return (light: BCGlobalToken.orange400_20.value, dark: BCGlobalToken.orange300_30.value)
    case .fillAccentOrangeTransparent:
      return (light: BCGlobalToken.orange400_0.value, dark: BCGlobalToken.orange300_0.value)
    case .fillAccentPink:
      return (light: BCGlobalToken.pink400_10.value, dark: BCGlobalToken.pink300_18.value)
    case .fillAccentPinkHeavier:
      return (light: BCGlobalToken.pink400.value, dark: BCGlobalToken.pink300.value)
    case .fillAccentPinkHeavy:
      return (light: BCGlobalToken.pink400_20.value, dark: BCGlobalToken.pink300_30.value)
    case .fillAccentPinkTransparent:
      return (light: BCGlobalToken.pink400_0.value, dark: BCGlobalToken.pink300_0.value)
    case .fillAccentPurple:
      return (light: BCGlobalToken.purple400_10.value, dark: BCGlobalToken.purple300_18.value)
    case .fillAccentPurpleHeavier:
      return (light: BCGlobalToken.purple400.value, dark: BCGlobalToken.purple300.value)
    case .fillAccentPurpleHeavy:
      return (light: BCGlobalToken.purple400_20.value, dark: BCGlobalToken.purple300_30.value)
    case .fillAccentPurpleTransparent:
      return (light: BCGlobalToken.purple400_0.value, dark: BCGlobalToken.purple300_0.value)
    case .fillAccentRed:
      return (light: BCGlobalToken.red400_10.value, dark: BCGlobalToken.red300_18.value)
    case .fillAccentRedHeavier:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .fillAccentRedHeavy:
      return (light: BCGlobalToken.red400_20.value, dark: BCGlobalToken.red300_30.value)
    case .fillAccentRedTransparent:
      return (light: BCGlobalToken.red400_0.value, dark: BCGlobalToken.red300_0.value)
    case .fillAccentTeal:
      return (light: BCGlobalToken.teal400_10.value, dark: BCGlobalToken.teal300_18.value)
    case .fillAccentTealHeavier:
      return (light: BCGlobalToken.teal400.value, dark: BCGlobalToken.teal300.value)
    case .fillAccentTealHeavy:
      return (light: BCGlobalToken.teal400_20.value, dark: BCGlobalToken.teal300_30.value)
    case .fillAccentTealTransparent:
      return (light: BCGlobalToken.teal400_0.value, dark: BCGlobalToken.teal300_0.value)
    case .fillAccentYellow:
      return (light: BCGlobalToken.yellow400_10.value, dark: BCGlobalToken.yellow300_18.value)
    case .fillAccentYellowHeavier:
      return (light: BCGlobalToken.yellow400.value, dark: BCGlobalToken.yellow300.value)
    case .fillAccentYellowHeavy:
      return (light: BCGlobalToken.yellow400_20.value, dark: BCGlobalToken.yellow300_30.value)
    case .fillAccentYellowTransparent:
      return (light: BCGlobalToken.yellow400_0.value, dark: BCGlobalToken.yellow300_0.value)
    case .fillAction:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .fillActionLight:
      return (light: BCGlobalToken.blue400_20.value, dark: BCGlobalToken.blue300_30.value)
    case .fillActionLighter:
      return (light: BCGlobalToken.blue400_10.value, dark: BCGlobalToken.blue300_18.value)
    case .fillActionTransparent:
      return (light: BCGlobalToken.blue400_0.value, dark: BCGlobalToken.blue300_0.value)
    case .fillBright:
      return (light: BCGlobalToken.grey25.value, dark: BCGlobalToken.grey650.value)
    case .fillCritical:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .fillCriticalLight:
      return (light: BCGlobalToken.red400_20.value, dark: BCGlobalToken.red300_30.value)
    case .fillCriticalLighter:
      return (light: BCGlobalToken.red400_10.value, dark: BCGlobalToken.red300_18.value)
    case .fillCriticalTransparent:
      return (light: BCGlobalToken.red400_0.value, dark: BCGlobalToken.red300_0.value)
    case .fillGrey:
      return (light: BCGlobalToken.grey50.value, dark: BCGlobalToken.grey850.value)
    case .fillGreyHeavier:
      return (light: BCGlobalToken.grey200.value, dark: BCGlobalToken.grey750.value)
    case .fillGreyHeavy:
      return (light: BCGlobalToken.grey100.value, dark: BCGlobalToken.grey800.value)
    case .fillGreyLight:
      return (light: BCGlobalToken.grey25.value, dark: BCGlobalToken.grey900.value)
    case .fillHighlight:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .fillHighlightLight:
      return (light: BCGlobalToken.cobalt400_20.value, dark: BCGlobalToken.cobalt300_30.value)
    case .fillHighlightLighter:
      return (light: BCGlobalToken.cobalt400_10.value, dark: BCGlobalToken.cobalt300_18.value)
    case .fillHighlightTransparent:
      return (light: BCGlobalToken.cobalt400_0.value, dark: BCGlobalToken.cobalt300_0.value)
    case .fillNeutral:
      return (light: BCGlobalToken.black8.value, dark: BCGlobalToken.white12.value)
    case .fillNeutralHeavier:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .fillNeutralHeaviest:
      return (light: BCGlobalToken.black85.value, dark: BCGlobalToken.white100.value)
    case .fillNeutralHeavy:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.white20.value)
    case .fillNeutralLight:
      return (light: BCGlobalToken.black5.value, dark: BCGlobalToken.white8.value)
    case .fillNeutralLighter:
      return (light: BCGlobalToken.black3.value, dark: BCGlobalToken.white5.value)
    case .fillNeutralLightest:
      return (light: BCGlobalToken.black1.value, dark: BCGlobalToken.white3.value)
    case .fillNeutralTransparent:
      return (light: BCGlobalToken.black0.value, dark: BCGlobalToken.white0.value)
    case .fillSuccess:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .fillSuccessLight:
      return (light: BCGlobalToken.green400_20.value, dark: BCGlobalToken.green300_30.value)
    case .fillSuccessLighter:
      return (light: BCGlobalToken.green400_10.value, dark: BCGlobalToken.green300_18.value)
    case .fillSuccessTransparent:
      return (light: BCGlobalToken.green400_0.value, dark: BCGlobalToken.green300_0.value)
    case .fillWarning:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .fillWarningLight:
      return (light: BCGlobalToken.orange400_20.value, dark: BCGlobalToken.orange300_30.value)
    case .fillWarningLighter:
      return (light: BCGlobalToken.orange400_10.value, dark: BCGlobalToken.orange300_18.value)
    case .fillWarningTransparent:
      return (light: BCGlobalToken.orange400_0.value, dark: BCGlobalToken.orange300_0.value)
    case .iconAbsoluteBlack:
      return (light: BCGlobalToken.black100.value, dark: BCGlobalToken.black100.value)
    case .iconAbsoluteWhite:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.white100.value)
    case .iconAccentBlue:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .iconAccentCobalt:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .iconAccentGreen:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .iconAccentNavy:
      return (light: BCGlobalToken.navy400.value, dark: BCGlobalToken.navy300.value)
    case .iconAccentOlive:
      return (light: BCGlobalToken.olive400.value, dark: BCGlobalToken.olive300.value)
    case .iconAccentOrange:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .iconAccentPink:
      return (light: BCGlobalToken.pink400.value, dark: BCGlobalToken.pink300.value)
    case .iconAccentPurple:
      return (light: BCGlobalToken.purple400.value, dark: BCGlobalToken.purple300.value)
    case .iconAccentRed:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .iconAccentTeal:
      return (light: BCGlobalToken.teal400.value, dark: BCGlobalToken.teal300.value)
    case .iconAccentYellow:
      return (light: BCGlobalToken.yellow400.value, dark: BCGlobalToken.yellow300.value)
    case .iconAction:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .iconCritical:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .iconHighlight:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .iconInverseHeavier:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.black85.value)
    case .iconNeutral:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .iconNeutralHeavier:
      return (light: BCGlobalToken.black85.value, dark: BCGlobalToken.white80.value)
    case .iconNeutralHeavy:
      return (light: BCGlobalToken.black60.value, dark: BCGlobalToken.white60.value)
    case .iconSuccess:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .iconWarning:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .stateActive:
      return (light: BCGlobalToken.black85.value, dark: BCGlobalToken.white40.value)
    case .stateDefault:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.white20.value)
    case .stateFocus:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .stateWarning:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .surface:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey900.value)
    case .surfaceGlass:
      return (light: BCGlobalToken.white90.value, dark: BCGlobalToken.grey800_90.value)
    case .surfaceGlassHigh:
      return (light: BCGlobalToken.white90.value, dark: BCGlobalToken.grey850_90.value)
    case .surfaceGlassHigher:
      return (light: BCGlobalToken.grey100_90.value, dark: BCGlobalToken.grey800_90.value)
    case .surfaceGlassHighest:
      return (light: BCGlobalToken.grey200_90.value, dark: BCGlobalToken.grey750_90.value)
    case .surfaceHigh:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey850.value)
    case .surfaceHigher:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey800.value)
    case .surfaceHighest:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey750.value)
    case .surfaceLow:
      return (light: BCGlobalToken.grey50.value, dark: BCGlobalToken.grey950.value)
    case .textAbsoluteBlack:
      return (light: BCGlobalToken.black100.value, dark: BCGlobalToken.black100.value)
    case .textAbsoluteWhite:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.white100.value)
    case .textAccentBlue:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .textAccentCobalt:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .textAccentGreen:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .textAccentNavy:
      return (light: BCGlobalToken.navy400.value, dark: BCGlobalToken.navy300.value)
    case .textAccentOlive:
      return (light: BCGlobalToken.olive400.value, dark: BCGlobalToken.olive300.value)
    case .textAccentOrange:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .textAccentPink:
      return (light: BCGlobalToken.pink400.value, dark: BCGlobalToken.pink300.value)
    case .textAccentPurple:
      return (light: BCGlobalToken.purple400.value, dark: BCGlobalToken.purple300.value)
    case .textAccentRed:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .textAccentTeal:
      return (light: BCGlobalToken.teal400.value, dark: BCGlobalToken.teal300.value)
    case .textAccentYellow:
      return (light: BCGlobalToken.yellow400.value, dark: BCGlobalToken.yellow300.value)
    case .textAction:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .textCritical:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .textHighlight:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .textInverse:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.black85.value)
    case .textNeutral:
      return (light: BCGlobalToken.black85.value, dark: BCGlobalToken.white80.value)
    case .textNeutralHeaviest:
      return (light: BCGlobalToken.black100.value, dark: BCGlobalToken.white100.value)
    case .textNeutralLight:
      return (light: BCGlobalToken.black60.value, dark: BCGlobalToken.white60.value)
    case .textNeutralLighter:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .textSuccess:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .textWarning:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    }
  }
}
