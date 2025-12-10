//
//  SemanticColorToken.swift
//  BezierSwift
//
//  Created by 구본욱 on 12/10/25.
//

import UIKit

public enum SemanticColorToken {
  // MARK: - Border
  case borderAbsoluteWhite
  case borderDetachHigh
  case borderDetachHigher
  case borderDetachHighest
  case borderNeutral
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

  // MARK: - Fill Accent
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

  // MARK: - Icon
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

extension SemanticColorToken {
  typealias PaletteSet = (light: ColorComponentsWithAlpha, dark: ColorComponentsWithAlpha)

  public var light: ColorComponentsWithAlpha { self.paletteSet.light }
  public var dark: ColorComponentsWithAlpha { self.paletteSet.dark }

  private var paletteSet: PaletteSet {
    switch self {
    // MARK: - Border
    case .borderAbsoluteWhite:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.white100.value)
    case .borderDetachHigh:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey850.value)
    case .borderDetachHigher:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey800.value)
    case .borderDetachHighest:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey700.value)
    case .borderNeutral:
      return (light: GlobalColorToken.black8.value, dark: GlobalColorToken.white12.value)
    case .borderNeutralHeavy:
      return (light: GlobalColorToken.black40.value, dark: GlobalColorToken.white40.value)

    // MARK: - Dim
    case .dimAbsoluteBlack:
      return (light: GlobalColorToken.black40.value, dark: GlobalColorToken.black40.value)
    case .dimAbsoluteBlackHeavy:
      return (light: GlobalColorToken.black60.value, dark: GlobalColorToken.black60.value)
    case .dimAbsoluteWhite:
      return (light: GlobalColorToken.white40.value, dark: GlobalColorToken.white40.value)
    case .dimAbsoluteWhiteHeavy:
      return (light: GlobalColorToken.white60.value, dark: GlobalColorToken.white60.value)

    // MARK: - Elevation
    case .elevationBase:
      return (light: GlobalColorToken.black5.value, dark: GlobalColorToken.black5.value)
    case .elevationBaseInner:
      return (light: GlobalColorToken.white12.value, dark: GlobalColorToken.white12.value)
    case .elevationLarge:
      return (light: GlobalColorToken.black22.value, dark: GlobalColorToken.black22.value)
    case .elevationMedium:
      return (light: GlobalColorToken.black15.value, dark: GlobalColorToken.black15.value)
    case .elevationSmall:
      return (light: GlobalColorToken.black8.value, dark: GlobalColorToken.black8.value)
    case .elevationXlarge:
      return (light: GlobalColorToken.black30.value, dark: GlobalColorToken.black30.value)

    // MARK: - Fill Absolute
    case .fillAbsoluteBlack:
      return (light: GlobalColorToken.black100.value, dark: GlobalColorToken.black100.value)
    case .fillAbsoluteBlackLight:
      return (light: GlobalColorToken.black20.value, dark: GlobalColorToken.black20.value)
    case .fillAbsoluteBlackTransparent:
      return (light: GlobalColorToken.black0.value, dark: GlobalColorToken.black0.value)
    case .fillAbsoluteWhite:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.white100.value)
    case .fillAbsoluteWhiteLight:
      return (light: GlobalColorToken.white20.value, dark: GlobalColorToken.white20.value)
    case .fillAbsoluteWhiteTransparent:
      return (light: GlobalColorToken.white0.value, dark: GlobalColorToken.white0.value)

    // MARK: - Fill Accent Blue
    case .fillAccentBlue:
      return (light: GlobalColorToken.blue400_10.value, dark: GlobalColorToken.blue300_18.value)
    case .fillAccentBlueHeavier:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .fillAccentBlueHeavy:
      return (light: GlobalColorToken.blue400_20.value, dark: GlobalColorToken.blue300_30.value)
    case .fillAccentBlueTransparent:
      return (light: GlobalColorToken.blue400_0.value, dark: GlobalColorToken.blue300_0.value)

    // MARK: - Fill Accent Cobalt
    case .fillAccentCobalt:
      return (light: GlobalColorToken.cobalt400_10.value, dark: GlobalColorToken.cobalt300_18.value)
    case .fillAccentCobaltHeavier:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .fillAccentCobaltHeavy:
      return (light: GlobalColorToken.cobalt400_20.value, dark: GlobalColorToken.cobalt300_30.value)
    case .fillAccentCobaltTransparent:
      return (light: GlobalColorToken.cobalt400_0.value, dark: GlobalColorToken.cobalt300_0.value)

    // MARK: - Fill Accent Green
    case .fillAccentGreen:
      return (light: GlobalColorToken.green400_10.value, dark: GlobalColorToken.green300_18.value)
    case .fillAccentGreenHeavier:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .fillAccentGreenHeavy:
      return (light: GlobalColorToken.green400_20.value, dark: GlobalColorToken.green300_30.value)
    case .fillAccentGreenTransparent:
      return (light: GlobalColorToken.green400_0.value, dark: GlobalColorToken.green300_0.value)

    // MARK: - Fill Accent Navy
    case .fillAccentNavy:
      return (light: GlobalColorToken.navy400_10.value, dark: GlobalColorToken.navy300_18.value)
    case .fillAccentNavyHeavier:
      return (light: GlobalColorToken.navy400.value, dark: GlobalColorToken.navy300.value)
    case .fillAccentNavyHeavy:
      return (light: GlobalColorToken.navy400_20.value, dark: GlobalColorToken.navy300_30.value)
    case .fillAccentNavyTransparent:
      return (light: GlobalColorToken.navy400_0.value, dark: GlobalColorToken.navy300_0.value)

    // MARK: - Fill Accent Olive
    case .fillAccentOlive:
      return (light: GlobalColorToken.olive400_10.value, dark: GlobalColorToken.olive300_18.value)
    case .fillAccentOliveHeavier:
      return (light: GlobalColorToken.olive400.value, dark: GlobalColorToken.olive300.value)
    case .fillAccentOliveHeavy:
      return (light: GlobalColorToken.olive400_20.value, dark: GlobalColorToken.olive300_30.value)
    case .fillAccentOliveTransparent:
      return (light: GlobalColorToken.olive400_0.value, dark: GlobalColorToken.olive300_0.value)

    // MARK: - Fill Accent Orange
    case .fillAccentOrange:
      return (light: GlobalColorToken.orange400_10.value, dark: GlobalColorToken.orange300_18.value)
    case .fillAccentOrangeHeavier:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .fillAccentOrangeHeavy:
      return (light: GlobalColorToken.orange400_20.value, dark: GlobalColorToken.orange300_30.value)
    case .fillAccentOrangeTransparent:
      return (light: GlobalColorToken.orange400_0.value, dark: GlobalColorToken.orange300_0.value)

    // MARK: - Fill Accent Pink
    case .fillAccentPink:
      return (light: GlobalColorToken.pink400_10.value, dark: GlobalColorToken.pink300_18.value)
    case .fillAccentPinkHeavier:
      return (light: GlobalColorToken.pink400.value, dark: GlobalColorToken.pink300.value)
    case .fillAccentPinkHeavy:
      return (light: GlobalColorToken.pink400_20.value, dark: GlobalColorToken.pink300_30.value)
    case .fillAccentPinkTransparent:
      return (light: GlobalColorToken.pink400_0.value, dark: GlobalColorToken.pink300_0.value)

    // MARK: - Fill Accent Purple
    case .fillAccentPurple:
      return (light: GlobalColorToken.purple400_10.value, dark: GlobalColorToken.purple300_18.value)
    case .fillAccentPurpleHeavier:
      return (light: GlobalColorToken.purple400.value, dark: GlobalColorToken.purple300.value)
    case .fillAccentPurpleHeavy:
      return (light: GlobalColorToken.purple400_20.value, dark: GlobalColorToken.purple300_30.value)
    case .fillAccentPurpleTransparent:
      return (light: GlobalColorToken.purple400_0.value, dark: GlobalColorToken.purple300_0.value)

    // MARK: - Fill Accent Red
    case .fillAccentRed:
      return (light: GlobalColorToken.red400_10.value, dark: GlobalColorToken.red300_18.value)
    case .fillAccentRedHeavier:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .fillAccentRedHeavy:
      return (light: GlobalColorToken.red400_20.value, dark: GlobalColorToken.red300_30.value)
    case .fillAccentRedTransparent:
      return (light: GlobalColorToken.red400_0.value, dark: GlobalColorToken.red300_0.value)

    // MARK: - Fill Accent Teal
    case .fillAccentTeal:
      return (light: GlobalColorToken.teal400_10.value, dark: GlobalColorToken.teal300_18.value)
    case .fillAccentTealHeavier:
      return (light: GlobalColorToken.teal400.value, dark: GlobalColorToken.teal300.value)
    case .fillAccentTealHeavy:
      return (light: GlobalColorToken.teal400_20.value, dark: GlobalColorToken.teal300_30.value)
    case .fillAccentTealTransparent:
      return (light: GlobalColorToken.teal400_0.value, dark: GlobalColorToken.teal300_0.value)

    // MARK: - Fill Accent Yellow
    case .fillAccentYellow:
      return (light: GlobalColorToken.yellow400_10.value, dark: GlobalColorToken.yellow300_18.value)
    case .fillAccentYellowHeavier:
      return (light: GlobalColorToken.yellow400.value, dark: GlobalColorToken.yellow300.value)
    case .fillAccentYellowHeavy:
      return (light: GlobalColorToken.yellow400_20.value, dark: GlobalColorToken.yellow300_30.value)
    case .fillAccentYellowTransparent:
      return (light: GlobalColorToken.yellow400_0.value, dark: GlobalColorToken.yellow300_0.value)

    // MARK: - Fill Semantic
    case .fillAction:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .fillActionLight:
      return (light: GlobalColorToken.blue400_20.value, dark: GlobalColorToken.blue300_30.value)
    case .fillActionLighter:
      return (light: GlobalColorToken.blue400_10.value, dark: GlobalColorToken.blue300_18.value)
    case .fillActionTransparent:
      return (light: GlobalColorToken.blue400_0.value, dark: GlobalColorToken.blue300_0.value)
    case .fillCritical:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .fillCriticalLight:
      return (light: GlobalColorToken.red400_20.value, dark: GlobalColorToken.red300_30.value)
    case .fillCriticalLighter:
      return (light: GlobalColorToken.red400_10.value, dark: GlobalColorToken.red300_18.value)
    case .fillCriticalTransparent:
      return (light: GlobalColorToken.red400_0.value, dark: GlobalColorToken.red300_0.value)
    case .fillHighlight:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .fillHighlightLight:
      return (light: GlobalColorToken.cobalt400_20.value, dark: GlobalColorToken.cobalt300_30.value)
    case .fillHighlightLighter:
      return (light: GlobalColorToken.cobalt400_10.value, dark: GlobalColorToken.cobalt300_18.value)
    case .fillHighlightTransparent:
      return (light: GlobalColorToken.cobalt400_0.value, dark: GlobalColorToken.cobalt300_0.value)
    case .fillNeutralHeavier:
      return (light: GlobalColorToken.black40.value, dark: GlobalColorToken.white40.value)
    case .fillNeutralHeaviest:
      return (light: GlobalColorToken.black85.value, dark: GlobalColorToken.white90.value)
    case .fillNeutralHeavy:
      return (light: GlobalColorToken.black15.value, dark: GlobalColorToken.white20.value)
    case .fillNeutralLight:
      return (light: GlobalColorToken.black5.value, dark: GlobalColorToken.white8.value)
    case .fillNeutralLighter:
      return (light: GlobalColorToken.black3.value, dark: GlobalColorToken.white5.value)
    case .fillNeutralLightest:
      return (light: GlobalColorToken.black1.value, dark: GlobalColorToken.white3.value)
    case .fillNeutralTransparent:
      return (light: GlobalColorToken.black0.value, dark: GlobalColorToken.white0.value)
    case .fillSuccess:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .fillSuccessLight:
      return (light: GlobalColorToken.green400_20.value, dark: GlobalColorToken.green300_30.value)
    case .fillSuccessLighter:
      return (light: GlobalColorToken.green400_10.value, dark: GlobalColorToken.green300_18.value)
    case .fillSuccessTransparent:
      return (light: GlobalColorToken.green400_0.value, dark: GlobalColorToken.green300_0.value)
    case .fillWarning:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .fillWarningLight:
      return (light: GlobalColorToken.orange400_20.value, dark: GlobalColorToken.orange300_30.value)
    case .fillWarningLighter:
      return (light: GlobalColorToken.orange400_10.value, dark: GlobalColorToken.orange300_18.value)
    case .fillWarningTransparent:
      return (light: GlobalColorToken.orange400_0.value, dark: GlobalColorToken.orange300_0.value)

    // MARK: - Icon
    case .iconAbsoluteWhite:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.white100.value)
    case .iconAccentBlue:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .iconAccentCobalt:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .iconAccentGreen:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .iconAccentNavy:
      return (light: GlobalColorToken.navy400.value, dark: GlobalColorToken.navy300.value)
    case .iconAccentOlive:
      return (light: GlobalColorToken.olive400.value, dark: GlobalColorToken.olive300.value)
    case .iconAccentOrange:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .iconAccentPink:
      return (light: GlobalColorToken.pink400.value, dark: GlobalColorToken.pink300.value)
    case .iconAccentPurple:
      return (light: GlobalColorToken.purple400.value, dark: GlobalColorToken.purple300.value)
    case .iconAccentRed:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .iconAccentTeal:
      return (light: GlobalColorToken.teal400.value, dark: GlobalColorToken.teal300.value)
    case .iconAccentYellow:
      return (light: GlobalColorToken.yellow400.value, dark: GlobalColorToken.yellow300.value)
    case .iconAction:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .iconCritical:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .iconHighlight:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .iconNeutral:
      return (light: GlobalColorToken.black40.value, dark: GlobalColorToken.white40.value)
    case .iconNeutralHeavier:
      return (light: GlobalColorToken.black85.value, dark: GlobalColorToken.white80.value)
    case .iconNeutralHeavy:
      return (light: GlobalColorToken.black60.value, dark: GlobalColorToken.white60.value)
    case .iconSuccess:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .iconWarning:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)

    // MARK: - State
    case .stateAction:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .stateActionLight:
      return (light: GlobalColorToken.blue400_30.value, dark: GlobalColorToken.blue300_30.value)
    case .stateDefault:
      return (light: GlobalColorToken.black15.value, dark: GlobalColorToken.white20.value)
    case .stateWarning:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .stateWarningLight:
      return (light: GlobalColorToken.orange400_30.value, dark: GlobalColorToken.orange300_30.value)

    // MARK: - Surface
    case .surface:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey900.value)
    case .surfaceAccentBlue:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .surfaceAccentCobalt:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .surfaceAccentGreen:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .surfaceAccentNavy:
      return (light: GlobalColorToken.navy400.value, dark: GlobalColorToken.navy300.value)
    case .surfaceAccentOlive:
      return (light: GlobalColorToken.olive400.value, dark: GlobalColorToken.olive300.value)
    case .surfaceAccentOrange:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .surfaceAccentPink:
      return (light: GlobalColorToken.pink400.value, dark: GlobalColorToken.pink300.value)
    case .surfaceAccentPurple:
      return (light: GlobalColorToken.purple400.value, dark: GlobalColorToken.purple300.value)
    case .surfaceAccentRed:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .surfaceAccentTeal:
      return (light: GlobalColorToken.teal400.value, dark: GlobalColorToken.teal300.value)
    case .surfaceAccentYellow:
      return (light: GlobalColorToken.yellow400.value, dark: GlobalColorToken.yellow300.value)
    case .surfaceGlass:
      return (light: GlobalColorToken.white90.value, dark: GlobalColorToken.greyAlpha800_90.value)
    case .surfaceGlassHigh:
      return (light: GlobalColorToken.white90.value, dark: GlobalColorToken.greyAlpha850_90.value)
    case .surfaceGlassHigher:
      return (light: GlobalColorToken.greyAlpha100_90.value, dark: GlobalColorToken.greyAlpha800_90.value)
    case .surfaceGlassHighest:
      return (light: GlobalColorToken.greyAlpha200_90.value, dark: GlobalColorToken.greyAlpha700_90.value)
    case .surfaceHigh:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey850.value)
    case .surfaceHigher:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey800.value)
    case .surfaceHighest:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.grey700.value)
    case .surfaceLow:
      return (light: GlobalColorToken.grey50.value, dark: GlobalColorToken.grey950.value)
    case .surfaceLower:
      return (light: GlobalColorToken.grey100.value, dark: GlobalColorToken.black100.value)

    // MARK: - Text
    case .textAbsoluteBlack:
      return (light: GlobalColorToken.black100.value, dark: GlobalColorToken.black100.value)
    case .textAbsoluteWhite:
      return (light: GlobalColorToken.white100.value, dark: GlobalColorToken.white100.value)
    case .textAccentBlue:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .textAccentCobalt:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .textAccentGreen:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .textAccentNavy:
      return (light: GlobalColorToken.navy400.value, dark: GlobalColorToken.navy300.value)
    case .textAccentOlive:
      return (light: GlobalColorToken.olive400.value, dark: GlobalColorToken.olive300.value)
    case .textAccentOrange:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    case .textAccentPink:
      return (light: GlobalColorToken.pink400.value, dark: GlobalColorToken.pink300.value)
    case .textAccentPurple:
      return (light: GlobalColorToken.purple400.value, dark: GlobalColorToken.purple300.value)
    case .textAccentRed:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .textAccentTeal:
      return (light: GlobalColorToken.teal400.value, dark: GlobalColorToken.teal300.value)
    case .textAccentYellow:
      return (light: GlobalColorToken.yellow400.value, dark: GlobalColorToken.yellow300.value)
    case .textAction:
      return (light: GlobalColorToken.blue400.value, dark: GlobalColorToken.blue300.value)
    case .textCritical:
      return (light: GlobalColorToken.red400.value, dark: GlobalColorToken.red300.value)
    case .textHighlight:
      return (light: GlobalColorToken.cobalt400.value, dark: GlobalColorToken.cobalt300.value)
    case .textNeutral:
      return (light: GlobalColorToken.black85.value, dark: GlobalColorToken.white80.value)
    case .textNeutralHeaviest:
      return (light: GlobalColorToken.black100.value, dark: GlobalColorToken.white100.value)
    case .textNeutralLight:
      return (light: GlobalColorToken.black60.value, dark: GlobalColorToken.white60.value)
    case .textNeutralLighter:
      return (light: GlobalColorToken.black40.value, dark: GlobalColorToken.white40.value)
    case .textSuccess:
      return (light: GlobalColorToken.green400.value, dark: GlobalColorToken.green300.value)
    case .textWarning:
      return (light: GlobalColorToken.orange400.value, dark: GlobalColorToken.orange300.value)
    }
  }
}

extension SemanticColorToken {
  public func palette(_ component: BezierComponentable) -> UIColor {
    UIColor { [weak component] _ in
      let component = component ?? TempBezierComponent()
      let colorTheme = component.colorTheme
      let componentTheme = component.componentTheme
      switch componentTheme {
      case .normal:
        switch colorTheme {
        case .light:
          return paletteSet.light.uiColor
        case .dark:
          return paletteSet.dark.uiColor
        }
      case .inverted:
        switch colorTheme {
        case .light:
          return paletteSet.dark.uiColor
        case .dark:
          return paletteSet.light.uiColor
        }
      }
    }
  }
}
