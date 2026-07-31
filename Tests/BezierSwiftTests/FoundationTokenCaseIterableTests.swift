//
//  FoundationTokenCaseIterableTests.swift
//  BezierSwift
//

import Testing
import CoreGraphics
@testable import BezierSwift

// 아래 `shouldBeEnumerated`는 전부 default 없는 exhaustive switch다. 이 세 enum은 associated
// value case(`custom`, `weight:`, `roundHalf(length:)`)를 가져 컴파일러가 `allCases`를 합성하지
// 못하고 수동 배열에 의존하므로, 이 장치 없이는 새 토큰이 추가돼도 배열에서 조용히 빠진다.
// 새 case가 생기면 이 파일이 컴파일되지 않아 `allCases` 갱신이 강제된다.
//
// `BezierElevation`은 단순 case만 있어 컴파일러가 합성한다. 갱신 누락이 불가능하므로 제외했다.

private extension BCSemanticToken {
  var shouldBeEnumerated: Bool {
    switch self {
    case .borderAbsoluteWhite, .borderDetach, .borderDetachHigh, .borderDetachHigher,
         .borderDetachHighest, .borderDetachLow, .borderNeutral, .borderNeutralHeavier,
         .borderNeutralHeavy, .chartThemeDefault01, .chartThemeDefault02,
         .chartThemeDefault03, .chartThemeDefault04, .chartThemeDefault05,
         .chartThemeDefault06, .chartThemeDefault07, .chartThemeDefault08,
         .chartThemeDefault09, .chartThemeDefault10, .dimAbsoluteBlack,
         .dimAbsoluteBlackHeavy, .dimAbsoluteWhite, .dimAbsoluteWhiteHeavy, .elevationBase,
         .elevationBaseInner, .elevationLarge, .elevationMedium, .elevationSmall,
         .elevationXlarge, .fillAbsoluteBlack, .fillAbsoluteBlackLight,
         .fillAbsoluteBlackTransparent, .fillAbsoluteWhite, .fillAbsoluteWhiteLight,
         .fillAbsoluteWhiteTransparent, .fillAccentBlue, .fillAccentBlueHeavier,
         .fillAccentBlueHeavy, .fillAccentBlueTransparent, .fillAccentCobalt,
         .fillAccentCobaltHeavier, .fillAccentCobaltHeavy, .fillAccentCobaltTransparent,
         .fillAccentGreen, .fillAccentGreenHeavier, .fillAccentGreenHeavy,
         .fillAccentGreenTransparent, .fillAccentNavy, .fillAccentNavyHeavier,
         .fillAccentNavyHeavy, .fillAccentNavyTransparent, .fillAccentOlive,
         .fillAccentOliveHeavier, .fillAccentOliveHeavy, .fillAccentOliveTransparent,
         .fillAccentOrange, .fillAccentOrangeHeavier, .fillAccentOrangeHeavy,
         .fillAccentOrangeTransparent, .fillAccentPink, .fillAccentPinkHeavier,
         .fillAccentPinkHeavy, .fillAccentPinkTransparent, .fillAccentPurple,
         .fillAccentPurpleHeavier, .fillAccentPurpleHeavy, .fillAccentPurpleTransparent,
         .fillAccentRed, .fillAccentRedHeavier, .fillAccentRedHeavy,
         .fillAccentRedTransparent, .fillAccentTeal, .fillAccentTealHeavier,
         .fillAccentTealHeavy, .fillAccentTealTransparent, .fillAccentYellow,
         .fillAccentYellowHeavier, .fillAccentYellowHeavy, .fillAccentYellowTransparent,
         .fillAction, .fillActionLight, .fillActionLighter, .fillActionTransparent,
         .fillBright, .fillCritical, .fillCriticalLight, .fillCriticalLighter,
         .fillCriticalTransparent, .fillGrey, .fillGreyHeavier, .fillGreyHeavy,
         .fillGreyLight, .fillHighlight, .fillHighlightLight, .fillHighlightLighter,
         .fillHighlightTransparent, .fillNeutral, .fillNeutralHeavier, .fillNeutralHeaviest,
         .fillNeutralHeavy, .fillNeutralLight, .fillNeutralLighter, .fillNeutralLightest,
         .fillNeutralTransparent, .fillSuccess, .fillSuccessLight, .fillSuccessLighter,
         .fillSuccessTransparent, .fillWarning, .fillWarningLight, .fillWarningLighter,
         .fillWarningTransparent, .iconAbsoluteBlack, .iconAbsoluteWhite, .iconAccentBlue,
         .iconAccentCobalt, .iconAccentGreen, .iconAccentNavy, .iconAccentOlive,
         .iconAccentOrange, .iconAccentPink, .iconAccentPurple, .iconAccentRed,
         .iconAccentTeal, .iconAccentYellow, .iconAction, .iconCritical, .iconHighlight,
         .iconInverseHeavier, .iconNeutral, .iconNeutralHeavier, .iconNeutralHeavy,
         .iconSuccess, .iconWarning, .stateActive, .stateDefault, .stateFocus, .stateWarning,
         .surface, .surfaceGlass, .surfaceGlassHigh, .surfaceGlassHigher,
         .surfaceGlassHighest, .surfaceHigh, .surfaceHigher, .surfaceHighest, .surfaceLow,
         .textAbsoluteBlack, .textAbsoluteWhite, .textAccentBlue, .textAccentCobalt,
         .textAccentGreen, .textAccentNavy, .textAccentOlive, .textAccentOrange,
         .textAccentPink, .textAccentPurple, .textAccentRed, .textAccentTeal,
         .textAccentYellow, .textAction, .textCritical, .textHighlight, .textInverse,
         .textNeutral, .textNeutralHeaviest, .textNeutralLight, .textNeutralLighter,
         .textSuccess, .textWarning:
      return true

    case .custom:
      return false
    }
  }
}

private extension BTSemanticToken {
  var shouldBeEnumerated: Bool {
    switch self {
    case .displayLarge, .displayMedium,
         .headingXLarge, .headingLarge, .headingMedium, .headingSmall, .headingXSmall,
         .headingXXSmall,
         .textXXLarge, .textXLarge, .textLarge, .textMedium, .textSmall, .textXSmall,
         .textXXSmall,
         .labelLarge, .labelMedium, .labelSmall,
         .captionMedium, .captionSmall,
         .codeMedium, .codeSmall:
      return true
    }
  }
}

private extension BezierCornerRadius {
  var shouldBeEnumerated: Bool {
    switch self {
    case .round2, .round3, .round4, .round6, .round8, .round12,
         .round16, .round20, .round22, .round32, .round44:
      return true

    case .roundHalf, .roundAvatar:
      return false
    }
  }
}

// MARK: - Color

@Suite("BCSemanticToken.allCases")
struct BCSemanticTokenCaseIterableTests {
  @Test("열거 대상 170개를 담고 custom은 제외한다")
  func containsEveryEnumerableCase() {
    #expect(BCSemanticToken.allCases.count == 170)
    #expect(BCSemanticToken.allCases.allSatisfy { $0.shouldBeEnumerated })
  }

  @Test("중복된 토큰이 없다")
  func hasNoDuplicates() {
    let names = BCSemanticToken.allCases.map { String(describing: $0) }
    #expect(Set(names).count == names.count)
  }
}

// MARK: - Typography

@Suite("BTSemanticToken.allCases")
struct BTSemanticTokenCaseIterableTests {
  @Test("22개 토큰 전체를 담는다")
  func containsEveryCase() {
    #expect(BTSemanticToken.allCases.count == 22)
    #expect(BTSemanticToken.allCases.allSatisfy { $0.shouldBeEnumerated })
  }

  @Test("가변 weight 토큰 9개는 기본값 regular로 담긴다")
  func variableWeightTokensUseRegular() {
    let variableWeightTokens = BTSemanticToken.allCases.filter { $0.boldPair != $0 }
    #expect(variableWeightTokens.count == 9)
    #expect(variableWeightTokens.allSatisfy { $0.resolvedWeight == .regular })
  }
}

// MARK: - Corner Radius

@Suite("BezierCornerRadius.allCases")
struct BezierCornerRadiusCaseIterableTests {
  @Test("고정 토큰 11개를 담고 length 의존 토큰은 제외한다")
  func containsEveryFixedCase() {
    #expect(BezierCornerRadius.allCases.count == 11)
    #expect(BezierCornerRadius.allCases.allSatisfy { $0.shouldBeEnumerated })
  }

  @Test("pointValue는 토큰 이름의 pt 값과 일치한다")
  func pointValueMatchesTokenName() {
    for radius in BezierCornerRadius.allCases {
      let digits = String(describing: radius).filter(\.isNumber)
      #expect(CGFloat(Int(digits) ?? -1) == radius.pointValue)
    }
  }
}

// MARK: - Elevation

@Suite("BezierElevation.allCases")
struct BezierElevationCaseIterableTests {
  @Test("단계가 오를수록 그림자가 커진다")
  func shadowGrowsWithLevel() {
    let blurs = BezierElevation.allCases.map { $0.shadow.blur }
    let offsetsY = BezierElevation.allCases.map { $0.shadow.offsetY }
    #expect(blurs == blurs.sorted())
    #expect(offsetsY == offsetsY.sorted())
    #expect(BezierElevation.allCases.allSatisfy { $0.shadow.offsetX == 0 })
  }

  @Test("그림자 색은 elevation 계열 semantic 토큰이다")
  func shadowUsesElevationToken() {
    #expect(BezierElevation.allCases.allSatisfy {
      String(describing: $0.shadow.color).hasPrefix("elevation")
    })
  }
}
