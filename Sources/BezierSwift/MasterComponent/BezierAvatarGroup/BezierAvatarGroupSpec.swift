//
//  BezierAvatarGroupSpec.swift
//  BezierSwift
//

import SwiftUI
import UIKit

// MARK: - AvatarGroup Size

public enum BezierAvatarGroupSize: String, CaseIterable {
  case size20
  case size24
  case size30
  case size36
  case size42
  case size48
  case size72
  case size90
  case size120

  public var avatarSize: BezierAvatarSize {
    switch self {
    case .size20:  return .size20
    case .size24:  return .size24
    case .size30:  return .size30
    case .size36:  return .size36
    case .size42:  return .size42
    case .size48:  return .size48
    case .size72:  return .size72
    case .size90:  return .size90
    case .size120: return .size120
    }
  }

  public var avatarLength: CGFloat { self.avatarSize.length }

  /// SPEC §4: avatar 간 stride. overlap=true는 겹침(음수 간격), false는 나란히(양수 간격). icon/count 공통.
  public func stride(overlap: Bool) -> CGFloat {
    overlap ? self.avatarLength - self.overlapAmount : self.avatarLength + self.spacingGap
  }

  /// SPEC §4: overlap=true 시 avatar 간 겹침(px).
  private var overlapAmount: CGFloat {
    switch self {
    case .size20:  return 5
    case .size24:  return 6
    case .size30:  return 7
    case .size36:  return 9
    case .size42:  return 10
    case .size48:  return 12
    case .size72:  return 18
    case .size90:  return 22
    case .size120: return 30
    }
  }

  /// SPEC §4: overlap=false 시 avatar 간 간격(px).
  private var spacingGap: CGFloat {
    switch self {
    case .size20, .size24, .size30: return 3
    case .size36, .size42:          return 4
    case .size48:                   return 6
    case .size72:                   return 9
    case .size90:                   return 11
    case .size120:                  return 14
    }
  }

  /// SPEC §5.1: overlay 내부 more 아이콘 length. size48부터 30pt 상한.
  public var moreIconLength: CGFloat {
    switch self {
    case .size20:                             return 12
    case .size24:                             return 16
    case .size30:                             return 20
    case .size36, .size42:                    return 24
    case .size48, .size72, .size90, .size120: return 30
    }
  }

  /// SPEC §5.1: overlay edge 로부터 more 아이콘까지의 inset. 중앙정렬.
  public var moreIconInset: CGFloat { (self.avatarLength - self.moreIconLength) / 2 }

  /// SPEC §5: ellipsis(icon, overlap=true) 외곽 border 두께. BezierAvatar 두께 준수.
  public var borderWidth: CGFloat { self.avatarSize.borderWidth }

  /// SPEC §4: count "+N" 텍스트와 마지막 avatar 사이 간격.
  /// overlap=true는 고정(size120만 6), overlap=false는 avatar 간격과 동일.
  public func countTextSpacing(overlap: Bool) -> CGFloat {
    guard overlap else { return self.spacingGap }
    return self == .size120 ? 6 : 4
  }

  /// SPEC §6: count "+N" 텍스트 전용 typography 토큰.
  public var countFont: BezierAvatarGroupCountFont {
    switch self {
    case .size20:  return BezierAvatarGroupCountFont(fontSize: 12, lineHeight: 18)
    case .size24:  return BezierAvatarGroupCountFont(fontSize: 13, lineHeight: 18)
    case .size30:  return BezierAvatarGroupCountFont(fontSize: 15, lineHeight: 18)
    case .size36:  return BezierAvatarGroupCountFont(fontSize: 16, lineHeight: 18)
    case .size42:  return BezierAvatarGroupCountFont(fontSize: 18, lineHeight: 18)
    case .size48:  return BezierAvatarGroupCountFont(fontSize: 24, lineHeight: 18)
    case .size72:  return BezierAvatarGroupCountFont(fontSize: 24, lineHeight: 18)
    case .size90:  return BezierAvatarGroupCountFont(fontSize: 32, lineHeight: 32)
    case .size120: return BezierAvatarGroupCountFont(fontSize: 36, lineHeight: 18)
    }
  }
}

// MARK: - AvatarGroup Count Typography Token

/// AvatarGroup count "+N" 텍스트 전용 typography 토큰.
///
/// Figma SSOT(Mobile Components `4055:1145`)의 size별 raw 값이다. size별 fontSize/lineHeight
/// 조합이 BTSemanticToken 의 고정 페어(예: text/small = 13/18)와 맞지 않는 경우가 있어
/// (size48·72 = 24/18, size120 = 36/18, size90 = 32/32) 공용 typography 토큰 대신
/// AvatarGroup 전용 토큰으로 정의한다. weight 는 전 size regular, letter-spacing 은 0.
public struct BezierAvatarGroupCountFont: Equatable {
  public let fontSize: CGFloat
  public let lineHeight: CGFloat

  public var uiFont: UIFont { .systemFont(ofSize: self.fontSize, weight: .regular) }
  public var font: Font { .system(size: self.fontSize, weight: .regular) }
}

// MARK: - Ellipsis Type

public enum BezierAvatarGroupEllipsisType: String, CaseIterable {
  case icon
  case count
}

// MARK: - Constants

public enum BezierAvatarGroupConstant {
  /// SPEC §I-1: Figma instance preview 기준 3개까지 노출하고 초과분을 ellipsis 로 표시.
  public static let maxVisibleAvatars: Int = 3
}
