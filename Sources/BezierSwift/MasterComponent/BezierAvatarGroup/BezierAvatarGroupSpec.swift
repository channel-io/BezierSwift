//
//  BezierAvatarGroupSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - AvatarGroup Size

public enum BezierAvatarGroupSize: String, CaseIterable {
  case size20
  case size24

  public var avatarSize: BezierAvatarSize {
    switch self {
    case .size20: return .size20
    case .size24: return .size24
    }
  }

  public var avatarLength: CGFloat { self.avatarSize.length }

  /// SPEC §2.2 / §2.4: icon variant stride (7pt overlap)
  public var iconVariantStride: CGFloat {
    switch self {
    case .size20: return 13
    case .size24: return 17
    }
  }

  /// SPEC §2.3 / §2.5: count variant stride. size20·size24 모두 7pt overlap (Figma SSOT).
  public var countVariantStride: CGFloat {
    switch self {
    case .size20: return 13
    case .size24: return 17
    }
  }

  /// SPEC §2.3 / §2.5: count text 와 마지막 avatar 사이 간격
  public var countTextSpacing: CGFloat { 4 }

  /// SPEC §5.1: overlay 내부 more 아이콘 length
  public var moreIconLength: CGFloat {
    switch self {
    case .size20: return 12
    case .size24: return 16
    }
  }

  /// SPEC §5.1: overlay edge 로부터 more 아이콘까지의 inset
  public var moreIconInset: CGFloat { 4 }

  /// SPEC §4: count text typography token
  public var countTextToken: BTSemanticToken {
    switch self {
    case .size20: return .textXSmall(weight: .bold)
    case .size24: return .textSmall(weight: .bold)
    }
  }

  /// SPEC §2.3: size=20 count variant 의 text container 는 16pt 고정 폭. size=24는 intrinsic.
  public var countTextContainerFixedWidth: CGFloat? {
    switch self {
    case .size20: return 16
    case .size24: return nil
    }
  }
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
