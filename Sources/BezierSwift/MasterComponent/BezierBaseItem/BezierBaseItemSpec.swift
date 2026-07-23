//
//  BezierBaseItemSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Size

public enum BezierBaseItemSize: CaseIterable {
  case small
  case medium
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
