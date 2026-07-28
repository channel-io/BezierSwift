//
//  BezierBaseItemSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Size

/// 행(row) 아이템의 크기. Figma `_BaseItem` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierBaseItemSize: CaseIterable {
  /// 항목을 더 촘촘히 많이 노출할 때 쓴다. 단 `description`을 지원하지 않으므로, 설명이 필요하면 `medium`을 쓴다.
  case small
  /// 대부분의 리스트 행에 쓰는 기본값.
  case medium
  /// `leadingContent`(Avatar 등)가 커져 더 큰 행 높이가 필요할 때만 쓴다.
  case large

  var minHeight: CGFloat {
    switch self {
    case .small: return 40
    case .medium: return 48
    case .large: return 52
    }
  }

  var verticalPadding: CGFloat {
    switch self {
    case .small, .medium: return 6
    case .large: return 8
    }
  }

  var leadingLength: CGFloat {
    switch self {
    case .small, .medium: return 24
    case .large: return 36
    }
  }
}

// MARK: - Style (internal)

/// 파생 `*Item` 컴포넌트가 BaseItem을 composition으로 소유할 때 주입하는 내부 스타일. 기본값은 BaseItem 자체(Figma `_BaseItem`) 스펙과 동일하며, public API로는 노출하지 않는다.
struct BezierBaseItemStyle {
  var horizontalPadding: CGFloat = BezierBaseItemConstant.horizontalPadding
  var cornerRadius: CGFloat = BezierBaseItemConstant.cornerRadius
  var centerLeadingInset: CGFloat = BezierBaseItemConstant.centerLeadingInset
  var titleColor: BCSemanticToken = BezierBaseItemConstant.titleColor
  var allowsSmallDescription: Bool = false
}

// MARK: - Constant

public enum BezierBaseItemConstant {
  public static let horizontalPadding: CGFloat = 6
  public static let cornerRadius: CGFloat = 8
  public static let slotSpacing: CGFloat = 10
  public static let titleRowSpacing: CGFloat = 4
  public static let centerLeadingInset: CGFloat = 2

  static let disabledOpacity: CGFloat = BOGlobalToken.disabled

  static let titleTypography: BTSemanticToken = .textXLarge(weight: .regular)
  static let descriptionTypography: BTSemanticToken = .captionMedium(weight: .regular)

  static let titleColor: BCSemanticToken = .textNeutral
  static let descriptionColor: BCSemanticToken = .textNeutralLighter
  static let pressedBackgroundColor: BCSemanticToken = .fillNeutralLighter

  // Press scale 피드백 (Figma 외 · 협의 — ch-desk-ios ListItemPressFeedback 참조)
  // 콘텐츠가 눌림 시 0.97로 축소되고, 뗄 때 살짝 오버슈트하며 복귀한다.
  static let pressScale: CGFloat = 0.97
  static let pressInDuration: TimeInterval = 0.10
  static let releaseDuration: TimeInterval = 0.40
  static let releaseScaleValues: [NSNumber] = [0.97, 1.004, 1.0]
  static let releaseScaleKeyTimes: [NSNumber] = [0, 0.55, 1.0]
}
