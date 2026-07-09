//
//  BezierStatusSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Status Type

public enum BezierStatusType: String, CaseIterable {
  case online
  case offline
  case lock
  case onlineDnd
  case offlineDnd

  /// 내부 원(_circle) fill. 아이콘 type에서는 아이콘 배경 역할.
  /// offline의 `fillNeutralHeavy`는 토큰 자체가 15% opacity(black15/white20)이므로 추가 opacity를 곱하지 않는다.
  public var circleToken: BCSemanticToken {
    switch self {
    case .online:                            return .textAccentGreen
    case .offline:                           return .fillNeutralHeavy
    case .lock, .onlineDnd, .offlineDnd:     return .surfaceHigh
    }
  }

  /// Glyph 자산이 필요한 type만 BezierIcon 매핑. Filled-circle type은 nil.
  public var icon: BezierIcon? {
    switch self {
    case .online, .offline:        return nil
    case .lock:                    return .lock
    case .onlineDnd, .offlineDnd:  return .moonFilled
    }
  }

  /// 아이콘(shape) fill. `icon != nil ⇔ iconToken != nil`.
  public var iconToken: BCSemanticToken? {
    switch self {
    case .online, .offline:  return nil
    case .lock:              return .textNeutralLight
    case .onlineDnd:         return .iconAccentGreen
    case .offlineDnd:        return .iconAccentYellow
    }
  }
}

// MARK: - Status Size

public enum BezierStatusSize: String, CaseIterable {
  case small
  case medium
  case large
  case xlarge
  case xxlarge

  public var containerLength: CGFloat {
    switch self {
    case .small:   return 8
    case .medium:  return 12
    case .large:   return 16
    case .xlarge:  return 24
    case .xxlarge: return 32
    }
  }

  /// 외부 stroke 두께. 내부 원은 컨테이너에서 이 두께만큼 안쪽으로 inset된다.
  public var borderWidth: CGFloat {
    switch self {
    case .small:   return 1
    case .medium:  return 2
    case .large:   return 2
    case .xlarge:  return 3
    case .xxlarge: return 4
    }
  }

  /// 내부 원(_circle) 지름 = 전체 − 2×border.
  public var circleLength: CGFloat {
    self.containerLength - self.borderWidth * 2
  }
}
