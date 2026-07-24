//
//  BezierBadgeSpec.swift
//  BezierSwift
//

import CoreGraphics
import UIKit

/// 배지의 크기. Figma `Badge` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierBadgeSize: String, CaseIterable {
  /// 가장 조밀한 배치.
  case xsmall
  /// 조밀한 배치.
  case small
  /// 표준 밀도의 배치.
  case medium
  /// 큰 맥락에서 존재감을 키운 배치.
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

/// 배지의 색상 변형. Figma `Badge` 컴포넌트의 `variant` 프로퍼티에 대응. 일부 case는 Figma 값과 이름이 다르니 case별 표기를 참고한다.
public enum BezierBadgeVariant: String, CaseIterable {
  /// 색상 의미가 없는 중립 기본값.
  case `default`
  /// Figma `neutral-light`. 연한 배경 위에서 존재감을 낮춘 보조 배지.
  case monochromeLight
  /// Figma `neutral-dark`. 어둡거나 이미지 위 배경에서 쓰는 배지.
  case monochromeDark
  /// 정보성 표시(신규·Beta·추천).
  case blue
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
  case cobalt
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
  case teal
  /// 완료·성공·활성 상태.
  case green
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
  case olive
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
  case pink
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
  case navy
  /// 주의·검토가 필요하지만 위험은 아닌 상태.
  case yellow
  /// 경고·중간 우선순위. `yellow`보다 강한 주의를 나타낸다.
  case orange
  /// 위험·긴급·기한 초과. 남용하지 않는다.
  case red
  /// 팀 내 색상↔의미 약속이 있는 카테고리·속성 구분용. 약속 없이 색상만 다양화하지 않는다.
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
