//
//  BezierSpinnerSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Spinner Size

/// 스피너의 지름 크기. Figma `Spinner` 컴포넌트의 `size` 프로퍼티에 대응 (Figma 값 `"12"` = `.size12`). 담기는 맥락(버튼 내부·인라인·전체 화면 로딩)에 맞춰 고른다. Figma 모바일 스펙 확정 전이라 참고용이다(신뢰도 낮음).
public enum BezierSpinnerSize: String, CaseIterable {
  /// 최소 크기. 버튼 내부·인라인에 쓴다.
  case size12
  /// 버튼 내부·인라인에 쓴다.
  case size16
  /// 인라인·소형 영역에 쓴다.
  case size20
  /// 중형 영역에 쓴다.
  case size24
  /// 중형 영역에 쓴다.
  case size30
  /// 대형 영역에 쓴다.
  case size36
  /// 대형 영역에 쓴다.
  case size42
  /// 최대 크기. 전체 화면·대형 영역에 쓴다.
  case size48

  public var length: CGFloat {
    switch self {
    case .size12: return 12
    case .size16: return 16
    case .size20: return 20
    case .size24: return 24
    case .size30: return 30
    case .size36: return 36
    case .size42: return 42
    case .size48: return 48
    }
  }

  public var ringWidth: CGFloat {
    self.length * BezierSpinnerConstant.ringWidthRatio
  }
}

// MARK: - Spinner Constant

public enum BezierSpinnerConstant {
  public static let ringWidthRatio: CGFloat = 0.125
  public static let innerRadiusRatio: CGFloat = 0.75
  public static let rotationDuration: TimeInterval = 1.0
}
