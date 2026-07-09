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

  public func stride(overlap: Bool) -> CGFloat {
    overlap ? self.avatarLength - self.overlapAmount : self.avatarLength + self.spacingGap
  }

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

  public var moreIconLength: CGFloat {
    switch self {
    case .size20:                             return 12
    case .size24:                             return 16
    case .size30:                             return 20
    case .size36, .size42:                    return 24
    case .size48, .size72, .size90, .size120: return 30
    }
  }

  public var moreIconInset: CGFloat { (self.avatarLength - self.moreIconLength) / 2 }

  public var borderWidth: CGFloat { self.avatarSize.borderWidth }

  public func countTextSpacing(overlap: Bool) -> CGFloat {
    guard overlap else { return self.spacingGap }
    return self == .size120 ? 6 : 4
  }

  var countFont: BezierAvatarGroupCountFont {
    switch self {
    case .size20:  return BezierAvatarGroupCountFont(fontSize: 12)
    case .size24:  return BezierAvatarGroupCountFont(fontSize: 13)
    case .size30:  return BezierAvatarGroupCountFont(fontSize: 15)
    case .size36:  return BezierAvatarGroupCountFont(fontSize: 16)
    case .size42:  return BezierAvatarGroupCountFont(fontSize: 18)
    case .size48:  return BezierAvatarGroupCountFont(fontSize: 24)
    case .size72:  return BezierAvatarGroupCountFont(fontSize: 24)
    case .size90:  return BezierAvatarGroupCountFont(fontSize: 32)
    case .size120: return BezierAvatarGroupCountFont(fontSize: 36)
    }
  }

  func countTextWidth(overflowCount: Int) -> CGFloat {
    let text = "+\(overflowCount)" as NSString
    return ceil(text.size(withAttributes: [.font: self.countFont.uiFont]).width)
  }
}

// MARK: - AvatarGroup Count Typography Token

/// AvatarGroup count "+N" 텍스트 전용 typography. 컴포넌트 내부에서만 소비하는 internal 토큰.
///
/// count 텍스트는 단일 라인이며 avatar length 컨테이너에 수직 center 되므로 line-height 는
/// 렌더에 영향이 없어 fontSize 만 정의한다. Figma 의 line-height 참조값은 SPEC.md §4 참고.
struct BezierAvatarGroupCountFont: Equatable {
  let fontSize: CGFloat

  var uiFont: UIFont { .systemFont(ofSize: self.fontSize, weight: .regular) }
  var font: Font { .system(size: self.fontSize, weight: .regular) }
}

// MARK: - Ellipsis Type

public enum BezierAvatarGroupEllipsisType: String, CaseIterable {
  case icon
  case count
}

// MARK: - Constants

public enum BezierAvatarGroupConstant {
  public static let maxVisibleAvatars: Int = 3
}
