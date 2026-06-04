//
//  BezierBadgeSpec.swift
//  BezierSwift
//

import CoreGraphics
import UIKit

public enum BezierBadgeSize: String, CaseIterable {
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

  public var iconLength: CGFloat { 16 }

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

  /// SwiftUI `.lineSpacing` modifier에 전달할 값. UIFont의 line height와 spec의
  /// lineHeight 차이를 보정한다.
  public var lineSpacing: CGFloat {
    let font = UIFont.systemFont(ofSize: self.fontSize, weight: self.fontWeight.uiKitWeight)
    return max(0, self.lineHeight - font.lineHeight)
  }

  /// 상·하 line-box 보정을 균등하게 적용하기 위한 vertical padding.
  public var verticalLineSpacing: CGFloat { self.lineSpacing / 2 }
}

public enum BezierBadgeVariant: String, CaseIterable {
  case `default`
  case monochromeLight
  case monochromeDark
  case blue
  case cobalt
  case teal
  case green
  case olive
  case pink
  case navy
  case yellow
  case orange
  case red
  case purple
}

extension BezierBadgeVariant {
  public var backgroundToken: BCSemanticToken {
    switch self {
    case .default:         return .fillNeutralLight
    case .monochromeLight: return .fillNeutralLight
    case .monochromeDark:  return .fillNeutralHeavier
    case .blue:            return .fillAccentBlueHeavy
    case .cobalt:          return .fillAccentCobaltHeavy
    case .teal:            return .fillAccentTealHeavy
    case .green:           return .fillAccentGreenHeavy
    case .olive:           return .fillAccentOliveHeavy
    case .pink:            return .fillAccentPinkHeavy
    case .navy:            return .fillAccentNavyHeavy
    case .yellow:          return .fillAccentYellowHeavy
    case .orange:          return .fillAccentOrangeHeavy
    case .red:             return .fillAccentRedHeavy
    case .purple:          return .fillAccentPurpleHeavy
    }
  }

  public var foregroundToken: BCSemanticToken {
    switch self {
    case .default:         return .textNeutral
    case .monochromeLight: return .textNeutralLighter
    case .monochromeDark:  return .textAbsoluteWhite
    case .blue:            return .textAccentBlue
    case .cobalt:          return .textAccentCobalt
    case .teal:            return .textAccentTeal
    case .green:           return .textAccentGreen
    case .olive:           return .textAccentOlive
    case .pink:            return .textAccentPink
    case .navy:            return .textAccentNavy
    case .yellow:          return .textAccentYellow
    case .orange:          return .textAccentOrange
    case .red:             return .textAccentRed
    case .purple:          return .textAccentPurple
    }
  }
}
