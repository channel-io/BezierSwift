//
//  BCSemanticToken+CaseIterable.swift
//  BezierSwift
//

import Foundation

// `custom(light:dark:)`이 associated value를 가져 컴파일러가 `allCases`를 합성하지 못한다.
// 게다가 `BCSemanticToken.swift`는 자동 생성 파일이라 배열을 그쪽에 둘 수도 없다(다음 토큰
// sync가 덮어쓴다). 그래서 배열을 손으로 쓰고, 선언과의 정합성은 테스트가 지킨다.
extension BCSemanticToken: CaseIterable {
  /// 열거 가능한 semantic 색 토큰 전체. 선언 순서(Border → Dim → Elevation → Fill → …)를 따른다.
  ///
  /// `custom(light:dark:)`은 제외한다. `pressedColor`가 HSL 계산 결과를 담아 반환하는 동적
  /// case이므로 값이 연속적이고, 따라서 열거 대상이 아니다.
  public static let allCases: [BCSemanticToken] = [
    .borderAbsoluteWhite, .borderDetach, .borderDetachHigh, .borderDetachHigher,
    .borderDetachHighest, .borderDetachLow, .borderNeutral, .borderNeutralHeavier,
    .borderNeutralHeavy,
    .dimAbsoluteBlack, .dimAbsoluteBlackHeavy, .dimAbsoluteWhite, .dimAbsoluteWhiteHeavy,
    .elevationBase, .elevationBaseInner, .elevationLarge, .elevationMedium, .elevationSmall,
    .elevationXlarge,
    .fillAbsoluteBlack, .fillAbsoluteBlackLight, .fillAbsoluteBlackTransparent,
    .fillAbsoluteWhite, .fillAbsoluteWhiteLight, .fillAbsoluteWhiteTransparent,
    .fillAccentBlue, .fillAccentBlueHeavier, .fillAccentBlueHeavy, .fillAccentBlueTransparent,
    .fillAccentCobalt, .fillAccentCobaltHeavier, .fillAccentCobaltHeavy,
    .fillAccentCobaltTransparent,
    .fillAccentGreen, .fillAccentGreenHeavier, .fillAccentGreenHeavy, .fillAccentGreenTransparent,
    .fillAccentNavy, .fillAccentNavyHeavier, .fillAccentNavyHeavy, .fillAccentNavyTransparent,
    .fillAccentOlive, .fillAccentOliveHeavier, .fillAccentOliveHeavy, .fillAccentOliveTransparent,
    .fillAccentOrange, .fillAccentOrangeHeavier, .fillAccentOrangeHeavy,
    .fillAccentOrangeTransparent,
    .fillAccentPink, .fillAccentPinkHeavier, .fillAccentPinkHeavy, .fillAccentPinkTransparent,
    .fillAccentPurple, .fillAccentPurpleHeavier, .fillAccentPurpleHeavy,
    .fillAccentPurpleTransparent,
    .fillAccentRed, .fillAccentRedHeavier, .fillAccentRedHeavy, .fillAccentRedTransparent,
    .fillAccentTeal, .fillAccentTealHeavier, .fillAccentTealHeavy, .fillAccentTealTransparent,
    .fillAccentYellow, .fillAccentYellowHeavier, .fillAccentYellowHeavy,
    .fillAccentYellowTransparent,
    .fillAction, .fillActionLight, .fillActionLighter, .fillActionTransparent, .fillCritical,
    .fillCriticalLight, .fillCriticalLighter, .fillCriticalTransparent, .fillHighlight,
    .fillHighlightLight, .fillHighlightLighter, .fillHighlightTransparent, .fillNeutral,
    .fillNeutralHeavier, .fillNeutralHeaviest, .fillNeutralHeavy, .fillNeutralLight,
    .fillNeutralLighter, .fillNeutralLightest, .fillNeutralTransparent, .fillSuccess,
    .fillSuccessLight, .fillSuccessLighter, .fillSuccessTransparent, .fillWarning,
    .fillWarningLight, .fillWarningLighter, .fillWarningTransparent,
    .fillBright, .fillGrey, .fillGreyHeavier, .fillGreyHeavy, .fillGreyLight,
    .gradientAccentGreen, .gradientAccentGreenLight,
    .iconAbsoluteBlack, .iconAbsoluteWhite, .iconAccentBlue, .iconAccentCobalt, .iconAccentGreen,
    .iconAccentNavy, .iconAccentOlive, .iconAccentOrange, .iconAccentPink, .iconAccentPurple,
    .iconAccentRed, .iconAccentTeal, .iconAccentYellow, .iconAction, .iconCritical,
    .iconHighlight, .iconNeutral, .iconNeutralHeavier, .iconNeutralHeavy, .iconSuccess,
    .iconWarning, .iconInverseHeavier,
    .stateAction, .stateActionLight, .stateActive, .stateDefault, .stateWarning,
    .stateWarningLight,
    .surface, .surfaceGlass, .surfaceGlassHigh, .surfaceGlassHigher, .surfaceGlassHighest,
    .surfaceHigh, .surfaceHigher, .surfaceHighest, .surfaceLow,
    .textAbsoluteBlack, .textAbsoluteWhite, .textAccentBlue, .textAccentCobalt, .textAccentGreen,
    .textAccentNavy, .textAccentOlive, .textAccentOrange, .textAccentPink, .textAccentPurple,
    .textAccentRed, .textAccentTeal, .textAccentYellow, .textAction, .textCritical,
    .textHighlight, .textNeutral, .textNeutralHeaviest, .textNeutralLight, .textNeutralLighter,
    .textSuccess, .textWarning, .textInverse,
    .chartThemeDefault01, .chartThemeDefault02, .chartThemeDefault03, .chartThemeDefault04,
    .chartThemeDefault05, .chartThemeDefault06, .chartThemeDefault07, .chartThemeDefault08,
    .chartThemeDefault09, .chartThemeDefault10,
  ]
}
