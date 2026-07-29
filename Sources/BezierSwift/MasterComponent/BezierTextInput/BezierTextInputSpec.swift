//
//  BezierTextInputSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Variant

/// 입력 필드의 스타일. Figma `TextInput` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierTextInputVariant: CaseIterable {
  /// 일반 흰 배경(surface) 위에 입력 필드를 배치할 때 쓰는 기본값. 배경과 보더로 입력 가능 영역을 명확히 표시한다.
  case primary
  /// 중첩 패널·카드·사이드바처럼 이미 배경색이 있는 영역 위에 배치할 때 쓴다. 배경색이 state와 무관하게 고정되어 에러 인지가 어려우므로, `hasError` 표시가 필요한 폼에는 `primary`를 쓴다 (secondary + error 조합 금지).
  case secondary

  var base: BezierBaseInputVariant {
    switch self {
    case .primary: return .primary
    case .secondary: return .secondary
    }
  }
}

// MARK: - Size

/// 입력 필드의 크기. Figma `TextInput` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierTextInputSize: CaseIterable {
  /// 검색바·인라인 필터 등 소형 맥락에 쓴다. 높이 40pt.
  case small
  /// 설정·프로필 입력, 모달 내 폼 등 대부분의 모바일 폼 맥락에 쓰는 기본값. 높이 48pt.
  case medium

  var metric: BezierBaseInputMetric {
    switch self {
    case .small: return .small
    case .medium: return .medium
    }
  }
}
