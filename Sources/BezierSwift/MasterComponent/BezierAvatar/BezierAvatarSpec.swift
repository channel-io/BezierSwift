//
//  BezierAvatarSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Avatar Size

public enum BezierAvatarSize: String, CaseIterable {
  case size16
  case size20
  case size24
  case size30
  case size36
  case size42
  case size48
  case size72
  case size90
  case size120
  case size160

  public var length: CGFloat {
    switch self {
    case .size16:  return 16
    case .size20:  return 20
    case .size24:  return 24
    case .size30:  return 30
    case .size36:  return 36
    case .size42:  return 42
    case .size48:  return 48
    case .size72:  return 72
    case .size90:  return 90
    case .size120: return 120
    case .size160: return 160
    }
  }

  public var cornerRadius: CGFloat {
    switch self {
    case .size16:  return 6.72
    case .size20:  return 8.4
    case .size24:  return 10.08
    case .size30:  return 12.6
    case .size36:  return 15.12
    case .size42:  return 17.64
    case .size48:  return 20.16
    case .size72:  return 30.24
    case .size90:  return 37.8
    case .size120: return 50.4
    case .size160: return 67.2
    }
  }

  public var borderWidth: CGFloat {
    switch self {
    case .size16, .size20:                   return 1
    case .size24, .size30, .size36:          return 1.5
    case .size42, .size48:                   return 2
    case .size72:                            return 2.5
    case .size90:                            return 3
    case .size120:                           return 3.5
    case .size160:                           return 4
    }
  }

  /// SPEC Part 1 §4: size16은 Status 매트릭스 외 custom 6×6 노드(1084:8)를 쓴다 → nil.
  /// 다른 size는 Avatar-spec §6 매핑에 따라 Status 표준 size로 매핑된다.
  public var matchingAvatarStatusSize: BezierStatusSize? {
    switch self {
    case .size16:                    return nil
    case .size20, .size24:           return .small
    case .size30, .size36, .size42:  return .medium
    case .size48:                    return .large
    case .size72, .size90:           return .xlarge
    case .size120, .size160:         return .xxlarge
    }
  }

  /// Status overlay 지름. size16은 custom 6, 그 외는 매핑된 Status size의 containerLength.
  public var statusOverlayLength: CGFloat {
    self.matchingAvatarStatusSize?.containerLength ?? 6
  }

  /// Status overlay 좌상단 좌표. Avatar-spec §6 공식:
  /// size < 72 → gap −2 (avatarSize − statusSize + 2), size ≥ 72 → gap +4 (avatarSize − statusSize − 4).
  public var statusOverlayPosition: CGPoint {
    let statusLength = self.statusOverlayLength
    let offset = self.length < 72
      ? self.length - statusLength + 2
      : self.length - statusLength - 4
    return CGPoint(x: offset, y: offset)
  }
}

// MARK: - Disabled State Opacity (Figma variable opacity/disabled = 0.4)

public enum BezierAvatarConstant {
  public static let disabledOpacity: CGFloat = 0.4
}
