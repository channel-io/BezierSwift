//
//  BezierTagSpec.swift
//  BezierSwift
//

import CoreGraphics
import UIKit

/// 태그의 크기(밀도). Figma `Tag` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierTagSize: String, CaseIterable {
  /// 밀도가 가장 높은 조밀한 크기. 좁은 공간이나 인라인 라벨에 쓴다.
  case xsmall
  /// 기본 밀도. 목록·폼 등 일반적인 상황에 쓴다.
  case small
  /// 본문 텍스트와 함께 놓아 가독성을 높일 때 쓴다.
  case medium
  /// 가장 큰 밀도. 강조가 필요하거나 넉넉한 영역에 쓴다.
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

/// 태그의 색상 계열. Figma `Tag` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값). Figma의 `monochrome-light`/`monochrome-dark`는 Swift Tag에서 제공하지 않는다.
public enum BezierTagVariant: String, CaseIterable {
  /// 색상 약속이 없는 중립 기본.
  case `default`
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case red
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case orange
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case yellow
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case olive
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case green
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case cobalt
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case purple
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case pink
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case navy
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
  case blue
  /// 팀 내 색상↔의미 약속이 있는 카테고리 구분용. 상태·시맨틱 강조는 `BezierBadge`를 쓴다.
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
