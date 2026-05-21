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

  public var statusOverlayLength: CGFloat {
    switch self {
    case .size16:                   return 6
    case .size20, .size24:          return 8
    case .size30, .size36, .size42, .size48: return 12
    case .size72:                   return 16
    case .size90, .size120, .size160: return 24
    }
  }

  public var statusOverlayPosition: CGPoint {
    switch self {
    case .size16:  return CGPoint(x: 12, y: 12)
    case .size20:  return CGPoint(x: 14, y: 14)
    case .size24:  return CGPoint(x: 18, y: 18)
    case .size30:  return CGPoint(x: 21, y: 20)
    case .size36:  return CGPoint(x: 26, y: 26)
    case .size42:  return CGPoint(x: 32, y: 32)
    case .size48:  return CGPoint(x: 36, y: 37)
    case .size72:  return CGPoint(x: 55, y: 54)
    case .size90:  return CGPoint(x: 68, y: 68)
    case .size120: return CGPoint(x: 96, y: 94)
    case .size160: return CGPoint(x: 132, y: 129)
    }
  }

  /// SPEC Part 1 §4: size16은 AvatarStatus 매트릭스 외 custom 6×6 노드(1084:8)를 쓴다.
  /// 다른 size는 AvatarStatus 매트릭스의 표준 size로 매핑된다.
  public var matchingAvatarStatusSize: BezierAvatarStatusSize? {
    switch self {
    case .size16:                                                return nil
    case .size20, .size24:                                       return .small
    case .size30, .size36, .size42, .size48:                     return .medium
    case .size72:                                                return .large
    case .size90, .size120, .size160:                            return .xlarge
    }
  }
}

// MARK: - Disabled State Opacity (Figma variable opacity/disabled = 0.4)

public enum BezierAvatarConstant {
  public static let disabledOpacity: CGFloat = 0.4
}

// MARK: - AvatarStatus Type

public enum BezierAvatarStatusType: String, CaseIterable {
  case online
  case offline
  case lock
  case onlineDnd
  case offlineDnd

  public var indicatorToken: BCSemanticToken {
    switch self {
    case .online:     return .iconAccentGreen
    case .offline:    return .iconNeutral
    case .lock:       return .iconNeutral
    case .onlineDnd:  return .iconAccentGreen
    case .offlineDnd: return .iconAccentYellow
    }
  }

  /// Filled-circle 도형은 nil. Glyph 자산이 필요한 type만 BezierIcon 매핑.
  public var indicatorIcon: BezierIcon? {
    switch self {
    case .online, .offline:        return nil
    case .lock:                    return .lock
    case .onlineDnd, .offlineDnd:  return .moonFilled
    }
  }
}

// MARK: - AvatarStatus Size

public enum BezierAvatarStatusSize: String, CaseIterable {
  case small
  case medium
  case large
  case xlarge

  public var containerLength: CGFloat {
    switch self {
    case .small:  return 8
    case .medium: return 12
    case .large:  return 16
    case .xlarge: return 24
    }
  }

  public var padding: CGFloat {
    switch self {
    case .small:  return 2
    case .medium: return 2
    case .large:  return 3
    case .xlarge: return 2
    }
  }

  public var innerIndicatorLength: CGFloat {
    switch self {
    case .small:  return 6
    case .medium: return 8
    case .large:  return 12
    case .xlarge: return 18
    }
  }
}
