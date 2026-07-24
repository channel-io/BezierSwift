//
//  BezierAvatarSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Avatar Size

/// 아바타의 지름 크기. Figma `Avatar` 컴포넌트의 `size` 프로퍼티에 대응 (Figma 값 `"20"` = `.size20`, bare 숫자에 `size` prefix가 붙은 형태). Figma엔 `60`이 있으나 Swift엔 없고, `.size16`·`.size160`은 모바일 parity로 추가된 값이다.
public enum BezierAvatarSize: String, CaseIterable {
  /// 초소형. 모바일 전용 예외 크기다.
  case size16
  /// 드롭다운·칩·인라인 식별자에 쓴다.
  case size20
  /// 대화 목록·발신자·알림에 쓰는 기본 크기다.
  case size24
  /// 사이드바 팀원 목록에 쓴다.
  case size30
  /// 담당자 배지·대화 헤더에 쓴다.
  case size36
  /// 고객정보 패널 상단에 쓴다.
  case size42
  /// 프로필 카드 헤더에 쓴다.
  case size48
  /// 설정 내 프로필·상세 모달에 쓴다. 목록 안에서는 쓰지 않는다.
  case size72
  /// 모달 대형·온보딩에 쓴다. 목록 안에서는 쓰지 않는다.
  case size90
  /// 계정 설정 대표 프로필에 쓴다. 목록 안에서는 쓰지 않는다.
  case size120
  /// 최대 크기. 목록 안에서는 쓰지 않는다.
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
