//
//  BezierProgressBarSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - ProgressBar Variant

/// 프로그레스 바의 색상 변형. Figma `ProgressBar` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값). 트랙(배경) 색만 다르고 진행 바 색은 공통이다. 바가 놓이는 배경에 맞춰 고른다.
public enum BezierProgressBarVariant: String, CaseIterable {
  /// 기본값. 화면 바탕 등 일반 배경 위에 놓을 때 쓴다.
  case `default`
  /// 이미지·파일 썸네일 등 콘텐츠 위에 겹쳐 놓을 때 쓴다. 트랙이 불투명해 콘텐츠 위에서도 식별된다.
  case overlaid

  var trackColorToken: BCSemanticToken {
    switch self {
    case .default: return .fillNeutralHeavy
    case .overlaid: return .fillGreyHeavier
    }
  }

  var activeColorToken: BCSemanticToken {
    .fillNeutralHeaviest
  }
}

// MARK: - ProgressBar Size

/// 프로그레스 바의 크기. Figma `ProgressBar` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값). 바 높이와 corner radius를 결정한다.
public enum BezierProgressBarSize: String, CaseIterable {
  /// 기본값. 사용자 주의가 집중되는 독립적 진행률 표시에 쓴다. 높이 6pt.
  case medium
  /// 콘텐츠 위 겹침·좁은 공간 등 보조적 진행률 표시에 쓴다. 높이 4pt.
  case small

  public var height: CGFloat {
    switch self {
    case .medium: return 6
    case .small: return 4
    }
  }

  public var cornerRadius: CGFloat {
    switch self {
    case .medium: return 3
    case .small: return 2
    }
  }
}

// MARK: - ProgressBar Constant

public enum BezierProgressBarConstant {
  public static let animationDuration: TimeInterval = 0.3
}
