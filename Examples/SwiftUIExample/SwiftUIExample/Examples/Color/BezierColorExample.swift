//
//  BezierColorExample.swift
//  SwiftUIExample
//
//  Created by Tom on 11/14/24.
//

import SwiftUI

import BezierSwift

struct BezierColorExample: View {
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 20) {
        Text("FunctionalToken").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarkest)
        Text("ForegroundBlue").applyBezierFontStyle(.title2Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgBlueNormal", BezierColor.fgBlueNormal)
        ColorChip(title: "fgBlueLight", BezierColor.fgBlueLight)
        ColorChip(title: "fgBlueDark", BezierColor.fgBlueDark)

        Text("ForegroundCobalt").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgCobaltNormal", BezierColor.fgCobaltNormal)
        ColorChip(title: "fgCobaltLight", BezierColor.fgCobaltLight)
        ColorChip(title: "fgCobaltDark", BezierColor.fgCobaltDark)

        Text("ForegroundRed").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgRedNormal", BezierColor.fgRedNormal)
        ColorChip(title: "fgRedLight", BezierColor.fgRedLight)
        ColorChip(title: "fgRedDark", BezierColor.fgRedDark)

        Text("ForegroundOrange").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgOrangeNormal", BezierColor.fgOrangeNormal)
        ColorChip(title: "fgOrangeLight", BezierColor.fgOrangeLight)
        ColorChip(title: "fgOrangeDark", BezierColor.fgOrangeDark)

        Text("ForegroundGreen").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgGreenNormal", BezierColor.fgGreenNormal)
        ColorChip(title: "fgGreenLight", BezierColor.fgGreenLight)
        ColorChip(title: "fgGreenDark", BezierColor.fgGreenDark)

        Text("ForegroundTeal").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgTealNormal", BezierColor.fgTealNormal)
        ColorChip(title: "fgTealLight", BezierColor.fgTealLight)
        ColorChip(title: "fgTealDark", BezierColor.fgTealDark)

        Text("ForegroundOlive").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgOliveNormal", BezierColor.fgOliveNormal)
        ColorChip(title: "fgOliveLight", BezierColor.fgOliveLight)
        ColorChip(title: "fgOliveDark", BezierColor.fgOliveDark)

        Text("ForegroundYellow").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgYellowNormal", BezierColor.fgYellowNormal)
        ColorChip(title: "fgYellowLight", BezierColor.fgYellowLight)
        ColorChip(title: "fgYellowDark", BezierColor.fgYellowDark)

        Text("ForegroundPink").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgPinkNormal", BezierColor.fgPinkNormal)
        ColorChip(title: "fgPinkLight", BezierColor.fgPinkLight)
        ColorChip(title: "fgPinkDark", BezierColor.fgPinkDark)

        Text("ForegroundPurple").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgPurpleNormal", BezierColor.fgPurpleNormal)
        ColorChip(title: "fgPurpleLight", BezierColor.fgPurpleLight)
        ColorChip(title: "fgPurpleDark", BezierColor.fgPurpleDark)

        Text("ForegroundNavy").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgNavyNormal", BezierColor.fgNavyNormal)
        ColorChip(title: "fgNavyLight", BezierColor.fgNavyLight)
        ColorChip(title: "fgNavyDark", BezierColor.fgNavyDark)

        Text("ForegroundGrey").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgGreyDarkest", BezierColor.fgGreyDarkest)
        ColorChip(title: "fgGreyDark", BezierColor.fgGreyDark)
        ColorChip(title: "fgGreyNormal", BezierColor.fgGreyNormal)
        ColorChip(title: "fgGreyLight", BezierColor.fgGreyLight)
        ColorChip(title: "fgGreyLighter", BezierColor.fgGreyLighter)
        ColorChip(title: "fgGreyLightest", BezierColor.fgGreyLightest)

        Text("ForegroundGreyAlpha").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgGreyAlphaDarkest", BezierColor.fgGreyAlphaDarkest)
        ColorChip(title: "fgGreyAlphaDarker", BezierColor.fgGreyAlphaDarker)
        ColorChip(title: "fgGreyAlphaDark", BezierColor.fgGreyAlphaDark)
        ColorChip(title: "fgGreyAlphaLight", BezierColor.fgGreyAlphaLight)
        
        Text("ForegroundWhite").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgWhiteNormal", BezierColor.fgWhiteNormal)

        Text("ForegroundBlack").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgBlackLightest", BezierColor.fgBlackLightest)
        ColorChip(title: "fgBlackLight", BezierColor.fgBlackLight)
        ColorChip(title: "fgBlackDark", BezierColor.fgBlackDark)
        ColorChip(title: "fgBlackDarker", BezierColor.fgBlackDarker)
        ColorChip(title: "fgBlackDarkest", BezierColor.fgBlackDarkest)
        ColorChip(title: "fgBlackPure", BezierColor.fgBlackPure)

        Text("ForegroundAbsoluteWhite").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgAbsoluteWhiteLightest", BezierColor.fgAbsoluteWhiteLightest)
        ColorChip(title: "fgAbsoluteWhiteLighter", BezierColor.fgAbsoluteWhiteLighter)
        ColorChip(title: "fgAbsoluteWhiteLight", BezierColor.fgAbsoluteWhiteLight)
        ColorChip(title: "fgAbsoluteWhiteNormal", BezierColor.fgAbsoluteWhiteNormal)
        ColorChip(title: "fgAbsoluteWhiteDark", BezierColor.fgAbsoluteWhiteDark)

        Text("ForegroundAbsoluteBlack").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "fgAbsoluteBlackLightest", BezierColor.fgAbsoluteBlackLightest)
        ColorChip(title: "fgAbsoluteBlackLighter", BezierColor.fgAbsoluteBlackLighter)
        ColorChip(title: "fgAbsoluteBlackLight", BezierColor.fgAbsoluteBlackLight)
        ColorChip(title: "fgAbsoluteBlackNormal", BezierColor.fgAbsoluteBlackNormal)
        ColorChip(title: "fgAbsoluteBlackDark", BezierColor.fgAbsoluteBlackDark)

        Text("BackgroundBlue").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgBlueNormal", BezierColor.bgBlueNormal)
        ColorChip(title: "bgBlueLight", BezierColor.bgBlueLight)
        ColorChip(title: "bgBlueLighter", BezierColor.bgBlueLighter)
        ColorChip(title: "bgBlueLightest", BezierColor.bgBlueLightest)
        ColorChip(title: "bgBlueDark", BezierColor.bgBlueDark)
        ColorChip(title: "bgBlueShadeLighter", BezierColor.bgBlueShadeLighter)
        ColorChip(title: "bgBlueShadeNormal", BezierColor.bgBlueShadeNormal)
        
        Text("BackgroundCobalt").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgCobaltNormal", BezierColor.bgCobaltNormal)
        ColorChip(title: "bgCobaltLight", BezierColor.bgCobaltLight)
        ColorChip(title: "bgCobaltLighter", BezierColor.bgCobaltLighter)
        ColorChip(title: "bgCobaltLightest", BezierColor.bgCobaltLightest)
        ColorChip(title: "bgCobaltDark", BezierColor.bgCobaltDark)
        ColorChip(title: "bgCobaltShadeLighter", BezierColor.bgCobaltShadeLighter)
        ColorChip(title: "bgCobaltShadeNormal", BezierColor.bgCobaltShadeNormal)

        Text("BackgroundRed").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgRedNormal", BezierColor.bgRedNormal)
        ColorChip(title: "bgRedLight", BezierColor.bgRedLight)
        ColorChip(title: "bgRedLighter", BezierColor.bgRedLighter)
        ColorChip(title: "bgRedLightest", BezierColor.bgRedLightest)
        ColorChip(title: "bgRedDark", BezierColor.bgRedDark)
        ColorChip(title: "bgRedShadeLighter", BezierColor.bgRedShadeLighter)
        ColorChip(title: "bgRedShadeNormal", BezierColor.bgRedShadeNormal)

        Text("BackgroundOrange").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgOrangeNormal", BezierColor.bgOrangeNormal)
        ColorChip(title: "bgOrangeLight", BezierColor.bgOrangeLight)
        ColorChip(title: "bgOrangeLighter", BezierColor.bgOrangeLighter)
        ColorChip(title: "bgOrangeLightest", BezierColor.bgOrangeLightest)
        ColorChip(title: "bgOrangeDark", BezierColor.bgOrangeDark)
        ColorChip(title: "bgOrangeShadeLighter", BezierColor.bgOrangeShadeLighter)
        ColorChip(title: "bgOrangeShadeNormal", BezierColor.bgOrangeShadeNormal)

        Text("BackgroundGreen").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgGreenNormal", BezierColor.bgGreenNormal)
        ColorChip(title: "bgGreenLight", BezierColor.bgGreenLight)
        ColorChip(title: "bgGreenLighter", BezierColor.bgGreenLighter)
        ColorChip(title: "bgGreenLightest", BezierColor.bgGreenLightest)
        ColorChip(title: "bgGreenDark", BezierColor.bgGreenDark)
        ColorChip(title: "bgGreenShadeLighter", BezierColor.bgGreenShadeLighter)
        ColorChip(title: "bgGreenShadeNormal", BezierColor.bgGreenShadeNormal)

        Text("BackgroundTeal").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgTealNormal", BezierColor.bgTealNormal)
        ColorChip(title: "bgTealLight", BezierColor.bgTealLight)
        ColorChip(title: "bgTealLighter", BezierColor.bgTealLighter)
        ColorChip(title: "bgTealLightest", BezierColor.bgTealLightest)
        ColorChip(title: "bgTealDark", BezierColor.bgTealDark)
        ColorChip(title: "bgTealShadeLighter", BezierColor.bgTealShadeLighter)
        ColorChip(title: "bgTealShadeNormal", BezierColor.bgTealShadeNormal)

        Text("BackgroundOlive").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgOliveNormal", BezierColor.bgOliveNormal)
        ColorChip(title: "bgOliveLight", BezierColor.bgOliveLight)
        ColorChip(title: "bgOliveLighter", BezierColor.bgOliveLighter)
        ColorChip(title: "bgOliveLightest", BezierColor.bgOliveLightest)
        ColorChip(title: "bgOliveDark", BezierColor.bgOliveDark)
        ColorChip(title: "bgOliveShadeLighter", BezierColor.bgOliveShadeLighter)
        ColorChip(title: "bgOliveShadeNormal", BezierColor.bgOliveShadeNormal)

        Text("BackgroundYellow").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgYellowNormal", BezierColor.bgYellowNormal)
        ColorChip(title: "bgYellowLight", BezierColor.bgYellowLight)
        ColorChip(title: "bgYellowLighter", BezierColor.bgYellowLighter)
        ColorChip(title: "bgYellowLightest", BezierColor.bgYellowLightest)
        ColorChip(title: "bgYellowDark", BezierColor.bgYellowDark)
        ColorChip(title: "bgYellowShadeLighter", BezierColor.bgYellowShadeLighter)
        ColorChip(title: "bgYellowShadeNormal", BezierColor.bgYellowShadeNormal)

        Text("BackgroundPink").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgPinkNormal", BezierColor.bgPinkNormal)
        ColorChip(title: "bgPinkLight", BezierColor.bgPinkLight)
        ColorChip(title: "bgPinkLighter", BezierColor.bgPinkLighter)
        ColorChip(title: "bgPinkLightest", BezierColor.bgPinkLightest)
        ColorChip(title: "bgPinkDark", BezierColor.bgPinkDark)
        ColorChip(title: "bgPinkShadeLighter", BezierColor.bgPinkShadeLighter)
        ColorChip(title: "bgPinkShadeNormal", BezierColor.bgPinkShadeNormal)

        Text("BackgroundPurple").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgPurpleNormal", BezierColor.bgPurpleNormal)
        ColorChip(title: "bgPurpleLight", BezierColor.bgPurpleLight)
        ColorChip(title: "bgPurpleLighter", BezierColor.bgPurpleLighter)
        ColorChip(title: "bgPurpleLightest", BezierColor.bgPurpleLightest)
        ColorChip(title: "bgPurpleDark", BezierColor.bgPurpleDark)
        ColorChip(title: "bgPurpleShadeLighter", BezierColor.bgPurpleShadeLighter)
        ColorChip(title: "bgPurpleShadeNormal", BezierColor.bgPurpleShadeNormal)

        Text("BackgroundNavy").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgNavyNormal", BezierColor.bgNavyNormal)
        ColorChip(title: "bgNavyLight", BezierColor.bgNavyLight)
        ColorChip(title: "bgNavyLighter", BezierColor.bgNavyLighter)
        ColorChip(title: "bgNavyLightest", BezierColor.bgNavyLightest)
        ColorChip(title: "bgNavyDark", BezierColor.bgNavyDark)
        ColorChip(title: "bgNavyShadeLighter", BezierColor.bgNavyShadeLighter)
        ColorChip(title: "bgNavyShadeNormal", BezierColor.bgNavyShadeNormal)

        Text("BackgroundGrey").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgGreyDarkest", BezierColor.bgGreyDarkest)
        ColorChip(title: "bgGreyDark", BezierColor.bgGreyDark)
        ColorChip(title: "bgGreyNormal", BezierColor.bgGreyNormal)
        ColorChip(title: "bgGreyLight", BezierColor.bgGreyLight)
        ColorChip(title: "bgGreyLighter", BezierColor.bgGreyLighter)
        ColorChip(title: "bgGreyLightest", BezierColor.bgGreyLightest)

        Text("BackgroundGreyAlpha").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgGreyAlphaDarkest", BezierColor.bgGreyAlphaDarkest)
        ColorChip(title: "bgGreyAlphaDarker", BezierColor.bgGreyAlphaDarker)
        ColorChip(title: "bgGreyAlphaDark", BezierColor.bgGreyAlphaDark)
        ColorChip(title: "bgGreyAlphaLight", BezierColor.bgGreyAlphaLight)

        Text("BackgroundBlack").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgBlackDarkest", BezierColor.bgBlackDarkest)
        ColorChip(title: "bgBlackDarker", BezierColor.bgBlackDarker)
        ColorChip(title: "bgBlackDark", BezierColor.bgBlackDark)
        ColorChip(title: "bgBlackLight", BezierColor.bgBlackLight)
        ColorChip(title: "bgBlackLighter", BezierColor.bgBlackLighter)
        ColorChip(title: "bgBlackLightest", BezierColor.bgBlackLightest)

        Text("BackgroundWhite").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgWhiteHighest", BezierColor.bgWhiteHighest)
        ColorChip(title: "bgWhiteHigher", BezierColor.bgWhiteHigher)
        ColorChip(title: "bgWhiteNormal", BezierColor.bgWhiteNormal)

        Text("BackgroundWhiteAlpha").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgWhiteAlphaLightest", BezierColor.bgWhiteAlphaLightest)
        ColorChip(title: "bgWhiteAlphaLighter", BezierColor.bgWhiteAlphaLighter)
        ColorChip(title: "bgWhiteAlphaLight", BezierColor.bgWhiteAlphaLight)
        ColorChip(title: "bgWhiteAlphaTransparent", BezierColor.bgWhiteAlphaTransparent)

        Text("BackgroundAbsoluteBlack").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgAbsoluteBlackDark", BezierColor.bgAbsoluteBlackDark)
        ColorChip(title: "bgAbsoluteBlackNormal", BezierColor.bgAbsoluteBlackNormal)
        ColorChip(title: "bgAbsoluteBlackLight", BezierColor.bgAbsoluteBlackLight)
        ColorChip(title: "bgAbsoluteBlackLighter", BezierColor.bgAbsoluteBlackLighter)
        ColorChip(title: "bgAbsoluteBlackLightest", BezierColor.bgAbsoluteBlackLightest)

        Text("BackgroundAbsoluteWhite").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "bgAbsoluteWhiteDark", BezierColor.bgAbsoluteWhiteDark)
        ColorChip(title: "bgAbsoluteWhiteNormal", BezierColor.bgAbsoluteWhiteNormal)
        ColorChip(title: "bgAbsoluteWhiteLight", BezierColor.bgAbsoluteWhiteLight)
        ColorChip(title: "bgAbsoluteWhiteLighter", BezierColor.bgAbsoluteWhiteLighter)
        ColorChip(title: "bgAbsoluteWhiteLightest", BezierColor.bgAbsoluteWhiteLightest)
        
        Text("Surface").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "surfaceLowest", BezierColor.surfaceLowest)
        ColorChip(title: "surfaceLower", BezierColor.surfaceLower)
        ColorChip(title: "surfaceNormal", BezierColor.surfaceNormal)

        Text("Shadow").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "shadowXlarge", BezierColor.shadowXlarge)
        ColorChip(title: "shadowLarge", BezierColor.shadowLarge)
        ColorChip(title: "shadowMedium", BezierColor.shadowMedium)
        ColorChip(title: "shadowSmall", BezierColor.shadowSmall)
        ColorChip(title: "shadowBase", BezierColor.shadowBase)
        ColorChip(title: "shadowBaseInner", BezierColor.shadowBaseInner)
        
        Text("Dim").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "dimBlackNormal", BezierColor.dimBlackNormal)
        ColorChip(title: "dimBlackLight", BezierColor.dimBlackLight)

        Text("SemanticColorToken").applyBezierFontStyle(.heading1Bold, bezierColor: .fgBlackDarker)
        Text("PrimaryBackground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "primaryBgNormal", BezierColor.primaryBgNormal)
        ColorChip(title: "primaryBgLight", BezierColor.primaryBgLight)
        ColorChip(title: "primaryBgLighter", BezierColor.primaryBgLighter)
        ColorChip(title: "primaryBgLightest", BezierColor.primaryBgLightest)
        ColorChip(title: "primaryBgDark", BezierColor.primaryBgDark)

        Text("PrimaryForeground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "primaryFgNormal", BezierColor.primaryFgNormal)
        ColorChip(title: "primaryFgLight", BezierColor.primaryFgLight)
        ColorChip(title: "primaryFgDark", BezierColor.primaryFgDark)

        Text("CriticalBackground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "criticalBgDark", BezierColor.criticalBgDark)
        ColorChip(title: "criticalBgNormal", BezierColor.criticalBgNormal)
        ColorChip(title: "criticalBgLight", BezierColor.criticalBgLight)
        ColorChip(title: "criticalBgLighter", BezierColor.criticalBgLighter)
        ColorChip(title: "criticalBgLightest", BezierColor.criticalBgLightest)

        Text("CriticalForeground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "criticalFgNormal", BezierColor.criticalFgNormal)
        ColorChip(title: "criticalFgLight", BezierColor.criticalFgLight)
        ColorChip(title: "criticalFgDark", BezierColor.criticalFgDark)

        Text("WarningBackground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "warningBgDark", BezierColor.warningBgDark)
        ColorChip(title: "warningBgNormal", BezierColor.warningBgNormal)
        ColorChip(title: "warningBgLight", BezierColor.warningBgLight)
        ColorChip(title: "warningBgLighter", BezierColor.warningBgLighter)
        ColorChip(title: "warningBgLightest", BezierColor.warningBgLightest)

        Text("WarningForeground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "warningFgNormal", BezierColor.warningFgNormal)
        ColorChip(title: "warningFgLight", BezierColor.warningFgLight)
        ColorChip(title: "warningFgDark", BezierColor.warningFgDark)

        Text("AccentBackground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "accentBgDark", BezierColor.accentBgDark)
        ColorChip(title: "accentBgNormal", BezierColor.accentBgNormal)
        ColorChip(title: "accentBgLight", BezierColor.accentBgLight)
        ColorChip(title: "accentBgLighter", BezierColor.accentBgLighter)
        ColorChip(title: "accentBgLightest", BezierColor.accentBgLightest)

        Text("AccentForeground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "accentFgNormal", BezierColor.accentFgNormal)
        ColorChip(title: "accentFgLight", BezierColor.accentFgLight)
        ColorChip(title: "accentFgDark", BezierColor.accentFgDark)

        Text("SuccessBackground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "successBgDark", BezierColor.successBgDark)
        ColorChip(title: "successBgNormal", BezierColor.successBgNormal)
        ColorChip(title: "successBgLight", BezierColor.successBgLight)
        ColorChip(title: "successBgLighter", BezierColor.successBgLighter)
        ColorChip(title: "successBgLightest", BezierColor.successBgLightest)

        Text("SuccessForeground").applyBezierFontStyle(.title1Bold, bezierColor: .fgBlackDarker)
        ColorChip(title: "successFgNormal", BezierColor.successFgNormal)
        ColorChip(title: "successFgLight", BezierColor.successFgLight)
        ColorChip(title: "successFgDark", BezierColor.successFgDark)
      }
      .padding(20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      BezierColor.bgWhiteNormal.color
        .ignoresSafeArea()
    )
  }
}



#Preview {
  BezierButtonExample()
}


