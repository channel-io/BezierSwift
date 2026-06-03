//
//  BezierTagSpec.swift
//  BezierSwift
//

import CoreGraphics
import UIKit

public enum BezierTagSize: String, CaseIterable {
  case xsmall
  case small
  case medium
  case large

  public var height: CGFloat {
    switch self {
    case .xsmall: return 18
    case .small:  return 22
    case .medium: return 22
    case .large:  return 26
    }
  }

  public var horizontalPadding: CGFloat { 4 }

  public var textHorizontalPadding: CGFloat { 4 }

  public var verticalPadding: CGFloat {
    switch self {
    case .xsmall: return 1
    case .small:  return 2
    case .medium: return 2
    case .large:  return 3
    }
  }

  public var closeIconLength: CGFloat { 16 }

  // MARK: - Typography
  //
  // Figma `text/*` 변수 바인딩. size 차원(fontSize·letterSpacing)과 lineHeight 차원이
  // 엇갈리게 매핑된다(예: medium = size/large + line-height/medium). BTSemanticToken 의
  // 차원별 raw 값을 조합해 Figma SSOT 와 정합시킨다.

  public var fontSize: CGFloat {
    switch self {
    case .xsmall: return BTSemanticToken.textXSmall().fontSize
    case .small:  return BTSemanticToken.textMedium().fontSize
    case .medium: return BTSemanticToken.textLarge().fontSize
    case .large:  return BTSemanticToken.textXLarge().fontSize
    }
  }

  public var lineHeight: CGFloat {
    switch self {
    case .xsmall: return BTSemanticToken.textXSmall().lineHeight
    case .small:  return BTSemanticToken.textMedium().lineHeight
    case .medium: return BTSemanticToken.textMedium().lineHeight
    case .large:  return BTSemanticToken.textLarge().lineHeight
    }
  }

  public var letterSpacing: CGFloat {
    switch self {
    case .xsmall: return BTSemanticToken.textXSmall().letterSpacing
    case .small:  return BTSemanticToken.textMedium().letterSpacing
    case .medium: return BTSemanticToken.textLarge().letterSpacing
    case .large:  return BTSemanticToken.textXLarge().letterSpacing
    }
  }

  public var fontWeight: BTFontWeight { .regular }

  public var lineSpacing: CGFloat {
    let font = UIFont.systemFont(ofSize: self.fontSize, weight: self.fontWeight.uiKitWeight)
    return max(0, self.lineHeight - font.lineHeight)
  }

  public var verticalLineSpacing: CGFloat { self.lineSpacing / 2 }
}

public enum BezierTagVariant: String, CaseIterable {
  case `default`
  case red
  case orange
  case yellow
  case olive
  case green
  case cobalt
  case purple
  case pink
  case navy
  case blue
  case teal
}

extension BezierTagVariant {
  public var backgroundToken: BCSemanticToken {
    switch self {
    case .default: return .fillNeutralLight
    case .red:     return .fillAccentRedHeavy
    case .orange:  return .fillAccentOrangeHeavy
    case .yellow:  return .fillAccentYellowHeavy
    case .olive:   return .fillAccentOliveHeavy
    case .green:   return .fillAccentGreenHeavy
    case .cobalt:  return .fillAccentCobaltHeavy
    case .purple:  return .fillAccentPurpleHeavy
    case .pink:    return .fillAccentPinkHeavy
    case .navy:    return .fillAccentNavyHeavy
    case .blue:    return .fillAccentBlueHeavy
    case .teal:    return .fillAccentTealHeavy
    }
  }

  // SPEC §4: 모든 variant에서 foreground는 동일한 `color/text/neutral`.
  public var foregroundToken: BCSemanticToken { .textNeutral }
}
