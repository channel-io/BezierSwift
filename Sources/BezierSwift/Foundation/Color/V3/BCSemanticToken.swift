//
//  BCSemanticToken.swift
//  BezierSwift
//
//  Generated from BezierColorV3SemanticToken-Light.js and BezierColorV3SemanticToken-Dark.js
//

import UIKit

public enum BCSemanticToken {
  // MARK: - Border
  case borderAbsoluteWhite
  case borderDetachHigh
  case borderDetachHigher
  case borderDetachHighest
  case borderNeutral
  case borderNeutralHeavier
  case borderNeutralHeavy

  // MARK: - Dim
  case dimAbsoluteBlack
  case dimAbsoluteBlackHeavy
  case dimAbsoluteWhite
  case dimAbsoluteWhiteHeavy

  // MARK: - Elevation
  case elevationBase
  case elevationBaseInner
  case elevationLarge
  case elevationMedium
  case elevationSmall
  case elevationXlarge

  // MARK: - Fill Absolute
  case fillAbsoluteBlack
  case fillAbsoluteBlackLight
  case fillAbsoluteBlackTransparent
  case fillAbsoluteWhite
  case fillAbsoluteWhiteLight
  case fillAbsoluteWhiteTransparent

  // MARK: - Fill Accent Blue
  case fillAccentBlue
  case fillAccentBlueHeavier
  case fillAccentBlueHeavy
  case fillAccentBlueTransparent

  // MARK: - Fill Accent Cobalt
  case fillAccentCobalt
  case fillAccentCobaltHeavier
  case fillAccentCobaltHeavy
  case fillAccentCobaltTransparent

  // MARK: - Fill Accent Green
  case fillAccentGreen
  case fillAccentGreenHeavier
  case fillAccentGreenHeavy
  case fillAccentGreenTransparent

  // MARK: - Fill Accent Navy
  case fillAccentNavy
  case fillAccentNavyHeavier
  case fillAccentNavyHeavy
  case fillAccentNavyTransparent

  // MARK: - Fill Accent Olive
  case fillAccentOlive
  case fillAccentOliveHeavier
  case fillAccentOliveHeavy
  case fillAccentOliveTransparent

  // MARK: - Fill Accent Orange
  case fillAccentOrange
  case fillAccentOrangeHeavier
  case fillAccentOrangeHeavy
  case fillAccentOrangeTransparent

  // MARK: - Fill Accent Pink
  case fillAccentPink
  case fillAccentPinkHeavier
  case fillAccentPinkHeavy
  case fillAccentPinkTransparent

  // MARK: - Fill Accent Purple
  case fillAccentPurple
  case fillAccentPurpleHeavier
  case fillAccentPurpleHeavy
  case fillAccentPurpleTransparent

  // MARK: - Fill Accent Red
  case fillAccentRed
  case fillAccentRedHeavier
  case fillAccentRedHeavy
  case fillAccentRedTransparent

  // MARK: - Fill Accent Teal
  case fillAccentTeal
  case fillAccentTealHeavier
  case fillAccentTealHeavy
  case fillAccentTealTransparent

  // MARK: - Fill Accent Yellow
  case fillAccentYellow
  case fillAccentYellowHeavier
  case fillAccentYellowHeavy
  case fillAccentYellowTransparent

  // MARK: - Fill Semantic
  case fillAction
  case fillActionLight
  case fillActionLighter
  case fillActionTransparent
  case fillCritical
  case fillCriticalLight
  case fillCriticalLighter
  case fillCriticalTransparent
  case fillHighlight
  case fillHighlightLight
  case fillHighlightLighter
  case fillHighlightTransparent
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

  // MARK: - Fill Grey
  case fillGrey
  case fillGreyHeavier
  case fillGreyHeavy

  // MARK: - Icon
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
  case iconNeutral
  case iconNeutralHeavier
  case iconNeutralHeavy
  case iconSuccess
  case iconWarning

  // MARK: - State
  case stateAction
  case stateActionLight
  case stateDefault
  case stateWarning
  case stateWarningLight

  // MARK: - Surface
  case surface
  case surfaceAccentBlue
  case surfaceAccentCobalt
  case surfaceAccentGreen
  case surfaceAccentNavy
  case surfaceAccentOlive
  case surfaceAccentOrange
  case surfaceAccentPink
  case surfaceAccentPurple
  case surfaceAccentRed
  case surfaceAccentTeal
  case surfaceAccentYellow
  case surfaceGlass
  case surfaceGlassHigh
  case surfaceGlassHigher
  case surfaceGlassHighest
  case surfaceHigh
  case surfaceHigher
  case surfaceHighest
  case surfaceLow
  case surfaceLower

  // MARK: - Text
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
  case textNeutral
  case textNeutralHeaviest
  case textNeutralLight
  case textNeutralLighter
  case textSuccess
  case textWarning
}

extension BCSemanticToken: SemanticColorProtocol {
  public var light: ColorComponentsWithAlpha { self.paletteSet.light }
  public var dark: ColorComponentsWithAlpha { self.paletteSet.dark }
}

extension BCSemanticToken {
  typealias PaletteSet = (light: ColorComponentsWithAlpha, dark: ColorComponentsWithAlpha)

  private var paletteSet: PaletteSet {
    switch self {
    // MARK: - Border
    case .borderAbsoluteWhite:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.white100.value)
    case .borderDetachHigh:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey850.value)
    case .borderDetachHigher:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey800.value)
    case .borderDetachHighest:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey700.value)
    case .borderNeutral:
      return (light: BCGlobalToken.black8.value, dark: BCGlobalToken.white12.value)
    case .borderNeutralHeavier:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .borderNeutralHeavy:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.white20.value)

    // MARK: - Dim
    case .dimAbsoluteBlack:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.black40.value)
    case .dimAbsoluteBlackHeavy:
      return (light: BCGlobalToken.black60.value, dark: BCGlobalToken.black60.value)
    case .dimAbsoluteWhite:
      return (light: BCGlobalToken.white40.value, dark: BCGlobalToken.white40.value)
    case .dimAbsoluteWhiteHeavy:
      return (light: BCGlobalToken.white60.value, dark: BCGlobalToken.white80.value)

    // MARK: - Elevation
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

    // MARK: - Fill Absolute
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

    // MARK: - Fill Accent Blue
    case .fillAccentBlue:
      return (light: BCGlobalToken.blue400_10.value, dark: BCGlobalToken.blue300_18.value)
    case .fillAccentBlueHeavier:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .fillAccentBlueHeavy:
      return (light: BCGlobalToken.blue400_20.value, dark: BCGlobalToken.blue300_30.value)
    case .fillAccentBlueTransparent:
      return (light: BCGlobalToken.blue400_0.value, dark: BCGlobalToken.blue300_0.value)

    // MARK: - Fill Accent Cobalt
    case .fillAccentCobalt:
      return (light: BCGlobalToken.cobalt400_10.value, dark: BCGlobalToken.cobalt300_18.value)
    case .fillAccentCobaltHeavier:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .fillAccentCobaltHeavy:
      return (light: BCGlobalToken.cobalt400_20.value, dark: BCGlobalToken.cobalt300_30.value)
    case .fillAccentCobaltTransparent:
      return (light: BCGlobalToken.cobalt400_0.value, dark: BCGlobalToken.cobalt300_0.value)

    // MARK: - Fill Accent Green
    case .fillAccentGreen:
      return (light: BCGlobalToken.green400_10.value, dark: BCGlobalToken.green300_18.value)
    case .fillAccentGreenHeavier:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .fillAccentGreenHeavy:
      return (light: BCGlobalToken.green400_20.value, dark: BCGlobalToken.green300_30.value)
    case .fillAccentGreenTransparent:
      return (light: BCGlobalToken.green400_0.value, dark: BCGlobalToken.green300_0.value)

    // MARK: - Fill Accent Navy
    case .fillAccentNavy:
      return (light: BCGlobalToken.navy400_10.value, dark: BCGlobalToken.navy300_18.value)
    case .fillAccentNavyHeavier:
      return (light: BCGlobalToken.navy400.value, dark: BCGlobalToken.navy300.value)
    case .fillAccentNavyHeavy:
      return (light: BCGlobalToken.navy400_20.value, dark: BCGlobalToken.navy300_30.value)
    case .fillAccentNavyTransparent:
      return (light: BCGlobalToken.navy400_0.value, dark: BCGlobalToken.navy300_0.value)

    // MARK: - Fill Accent Olive
    case .fillAccentOlive:
      return (light: BCGlobalToken.olive400_10.value, dark: BCGlobalToken.olive300_18.value)
    case .fillAccentOliveHeavier:
      return (light: BCGlobalToken.olive400.value, dark: BCGlobalToken.olive300.value)
    case .fillAccentOliveHeavy:
      return (light: BCGlobalToken.olive400_20.value, dark: BCGlobalToken.olive300_30.value)
    case .fillAccentOliveTransparent:
      return (light: BCGlobalToken.olive400_0.value, dark: BCGlobalToken.olive300_0.value)

    // MARK: - Fill Accent Orange
    case .fillAccentOrange:
      return (light: BCGlobalToken.orange400_10.value, dark: BCGlobalToken.orange300_18.value)
    case .fillAccentOrangeHeavier:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .fillAccentOrangeHeavy:
      return (light: BCGlobalToken.orange400_20.value, dark: BCGlobalToken.orange300_30.value)
    case .fillAccentOrangeTransparent:
      return (light: BCGlobalToken.orange400_0.value, dark: BCGlobalToken.orange300_0.value)

    // MARK: - Fill Accent Pink
    case .fillAccentPink:
      return (light: BCGlobalToken.pink400_10.value, dark: BCGlobalToken.pink300_18.value)
    case .fillAccentPinkHeavier:
      return (light: BCGlobalToken.pink400.value, dark: BCGlobalToken.pink300.value)
    case .fillAccentPinkHeavy:
      return (light: BCGlobalToken.pink400_20.value, dark: BCGlobalToken.pink300_30.value)
    case .fillAccentPinkTransparent:
      return (light: BCGlobalToken.pink400_0.value, dark: BCGlobalToken.pink300_0.value)

    // MARK: - Fill Accent Purple
    case .fillAccentPurple:
      return (light: BCGlobalToken.purple400_10.value, dark: BCGlobalToken.purple300_18.value)
    case .fillAccentPurpleHeavier:
      return (light: BCGlobalToken.purple400.value, dark: BCGlobalToken.purple300.value)
    case .fillAccentPurpleHeavy:
      return (light: BCGlobalToken.purple400_20.value, dark: BCGlobalToken.purple300_30.value)
    case .fillAccentPurpleTransparent:
      return (light: BCGlobalToken.purple400_0.value, dark: BCGlobalToken.purple300_0.value)

    // MARK: - Fill Accent Red
    case .fillAccentRed:
      return (light: BCGlobalToken.red400_10.value, dark: BCGlobalToken.red300_18.value)
    case .fillAccentRedHeavier:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .fillAccentRedHeavy:
      return (light: BCGlobalToken.red400_20.value, dark: BCGlobalToken.red300_30.value)
    case .fillAccentRedTransparent:
      return (light: BCGlobalToken.red400_0.value, dark: BCGlobalToken.red300_0.value)

    // MARK: - Fill Accent Teal
    case .fillAccentTeal:
      return (light: BCGlobalToken.teal400_10.value, dark: BCGlobalToken.teal300_18.value)
    case .fillAccentTealHeavier:
      return (light: BCGlobalToken.teal400.value, dark: BCGlobalToken.teal300.value)
    case .fillAccentTealHeavy:
      return (light: BCGlobalToken.teal400_20.value, dark: BCGlobalToken.teal300_30.value)
    case .fillAccentTealTransparent:
      return (light: BCGlobalToken.teal400_0.value, dark: BCGlobalToken.teal300_0.value)

    // MARK: - Fill Accent Yellow
    case .fillAccentYellow:
      return (light: BCGlobalToken.yellow400_10.value, dark: BCGlobalToken.yellow300_18.value)
    case .fillAccentYellowHeavier:
      return (light: BCGlobalToken.yellow400.value, dark: BCGlobalToken.yellow300.value)
    case .fillAccentYellowHeavy:
      return (light: BCGlobalToken.yellow400_20.value, dark: BCGlobalToken.yellow300_30.value)
    case .fillAccentYellowTransparent:
      return (light: BCGlobalToken.yellow400_0.value, dark: BCGlobalToken.yellow300_0.value)

    // MARK: - Fill Semantic
    case .fillAction:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .fillActionLight:
      return (light: BCGlobalToken.blue400_20.value, dark: BCGlobalToken.blue300_30.value)
    case .fillActionLighter:
      return (light: BCGlobalToken.blue400_10.value, dark: BCGlobalToken.blue300_18.value)
    case .fillActionTransparent:
      return (light: BCGlobalToken.blue400_0.value, dark: BCGlobalToken.blue300_0.value)
    case .fillCritical:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .fillCriticalLight:
      return (light: BCGlobalToken.red400_20.value, dark: BCGlobalToken.red300_30.value)
    case .fillCriticalLighter:
      return (light: BCGlobalToken.red400_10.value, dark: BCGlobalToken.red300_18.value)
    case .fillCriticalTransparent:
      return (light: BCGlobalToken.red400_0.value, dark: BCGlobalToken.red300_0.value)
    case .fillHighlight:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .fillHighlightLight:
      return (light: BCGlobalToken.cobalt400_20.value, dark: BCGlobalToken.cobalt300_30.value)
    case .fillHighlightLighter:
      return (light: BCGlobalToken.cobalt400_10.value, dark: BCGlobalToken.cobalt300_18.value)
    case .fillHighlightTransparent:
      return (light: BCGlobalToken.cobalt400_0.value, dark: BCGlobalToken.cobalt300_0.value)
    case .fillNeutralHeavier:
      return (light: BCGlobalToken.black40.value, dark: BCGlobalToken.white40.value)
    case .fillNeutralHeaviest:
      return (light: BCGlobalToken.black85.value, dark: BCGlobalToken.white90.value)
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
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300_0.value)

    // MARK: - Fill Grey
    case .fillGrey:
      return (light: BCGlobalToken.grey50.value, dark: BCGlobalToken.grey850.value)
    case .fillGreyHeavier:
      return (light: BCGlobalToken.grey200.value, dark: BCGlobalToken.grey750.value)
    case .fillGreyHeavy:
      return (light: BCGlobalToken.grey100.value, dark: BCGlobalToken.grey800.value)

    // MARK: - Icon
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

    // MARK: - State
    case .stateAction:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .stateActionLight:
      return (light: BCGlobalToken.blue400_30.value, dark: BCGlobalToken.blue300_30.value)
    case .stateDefault:
      return (light: BCGlobalToken.black15.value, dark: BCGlobalToken.white20.value)
    case .stateWarning:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .stateWarningLight:
      return (light: BCGlobalToken.orange400_30.value, dark: BCGlobalToken.orange300.value)

    // MARK: - Surface
    case .surface:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey900.value)
    case .surfaceAccentBlue:
      return (light: BCGlobalToken.blue400.value, dark: BCGlobalToken.blue300.value)
    case .surfaceAccentCobalt:
      return (light: BCGlobalToken.cobalt400.value, dark: BCGlobalToken.cobalt300.value)
    case .surfaceAccentGreen:
      return (light: BCGlobalToken.green400.value, dark: BCGlobalToken.green300.value)
    case .surfaceAccentNavy:
      return (light: BCGlobalToken.navy400.value, dark: BCGlobalToken.navy300.value)
    case .surfaceAccentOlive:
      return (light: BCGlobalToken.olive400.value, dark: BCGlobalToken.olive300.value)
    case .surfaceAccentOrange:
      return (light: BCGlobalToken.orange400.value, dark: BCGlobalToken.orange300.value)
    case .surfaceAccentPink:
      return (light: BCGlobalToken.pink400.value, dark: BCGlobalToken.pink300.value)
    case .surfaceAccentPurple:
      return (light: BCGlobalToken.purple400.value, dark: BCGlobalToken.purple300.value)
    case .surfaceAccentRed:
      return (light: BCGlobalToken.red400.value, dark: BCGlobalToken.red300.value)
    case .surfaceAccentTeal:
      return (light: BCGlobalToken.teal400.value, dark: BCGlobalToken.teal300.value)
    case .surfaceAccentYellow:
      return (light: BCGlobalToken.yellow400.value, dark: BCGlobalToken.yellow300.value)
    case .surfaceGlass:
      return (light: BCGlobalToken.white90.value, dark: BCGlobalToken.greyAlpha800_90.value)
    case .surfaceGlassHigh:
      return (light: BCGlobalToken.white90.value, dark: BCGlobalToken.greyAlpha850_90.value)
    case .surfaceGlassHigher:
      return (light: BCGlobalToken.greyAlpha100_90.value, dark: BCGlobalToken.greyAlpha800_90.value)
    case .surfaceGlassHighest:
      return (light: BCGlobalToken.greyAlpha200_90.value, dark: BCGlobalToken.greyAlpha700_90.value)
    case .surfaceHigh:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey850.value)
    case .surfaceHigher:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey800.value)
    case .surfaceHighest:
      return (light: BCGlobalToken.white100.value, dark: BCGlobalToken.grey750.value)
    case .surfaceLow:
      return (light: BCGlobalToken.grey50.value, dark: BCGlobalToken.grey950.value)
    case .surfaceLower:
      return (light: BCGlobalToken.grey100.value, dark: BCGlobalToken.black100.value)

    // MARK: - Text
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
