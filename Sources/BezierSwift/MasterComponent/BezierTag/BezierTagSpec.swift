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

  // MARK: - Typography (Figma raw, see SPEC §3)
  //
  // TYPO-MIGRATION: Figma component description의 `📌 TYPO-MIGRATION: Text Style
  // 미적용` 상태에 따라 raw 값을 직접 사용한다. 디자인팀의 로컬 typography 스타일
  // 일괄 바인딩이 끝나 raw가 token과 정합되면 BTSemanticToken 기반 API로 통합 예정.

  public var fontSize: CGFloat {
    switch self {
    case .xsmall: return 12
    case .small:  return 14
    case .medium: return 15
    case .large:  return 16
    }
  }

  public var lineHeight: CGFloat {
    switch self {
    case .xsmall: return 16
    case .small, .medium: return 18
    case .large: return 20
    }
  }

  public var letterSpacing: CGFloat {
    switch self {
    case .xsmall, .small: return 0
    case .medium, .large: return -0.1
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
