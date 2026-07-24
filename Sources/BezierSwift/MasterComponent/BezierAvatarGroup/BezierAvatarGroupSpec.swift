//
//  BezierAvatarGroupSpec.swift
//  BezierSwift
//

import SwiftUI
import UIKit

// MARK: - AvatarGroup Size

/// 아바타 그룹의 아바타 크기. Figma `AvatarGroup` 컴포넌트의 `size` 프로퍼티에 대응 (Figma 값 `"20"` = `.size20`, 철자만 다르다).
public enum BezierAvatarGroupSize: String, CaseIterable {
  /// 인라인 보조(타이핑·AI 참조)에 쓴다.
  case size20
  /// 리스트·카드의 독립 UI(담당자·팔로워)에 쓰는 기본 크기다.
  case size24
  /// 중밀도 배치에 쓴다.
  case size30
  /// 카드 헤더에 쓴다.
  case size36
  /// 상세 패널에 쓴다.
  case size42
  /// 프로필 미리보기에 쓴다.
  case size48
  /// 팀 페이지에 쓴다.
  case size72
  /// 히어로 영역에 쓴다.
  case size90
  /// 풀사이즈로 쓴다.
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

/// 최대 표시 인원을 넘는 초과분의 표현 방식. Figma `AvatarGroup` 컴포넌트의 `ellipsisType` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierAvatarGroupEllipsisType: String, CaseIterable {
  /// 초과 인원 수가 불필요하고 폭이 매우 좁을 때 쓴다. 기본값이다.
  case icon
  /// "+N"으로 총 초과 인원 수가 중요할 때 쓴다.
  case count
}

// MARK: - Constants

public enum BezierAvatarGroupConstant {
  public static let maxVisibleAvatars: Int = 3
}
