//
//  BezierButtonSpec.swift
//  BezierSwift
//

import UIKit

/// 버튼의 크기. Figma `Button` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값). 놓이는 맥락의 밀도에 따라 고른다.
public enum BezierButtonSize: String, CaseIterable {
  /// 테이블 행·필터 칩 옆 등 가장 조밀한 맥락.
  case xsmall
  /// 툴바·인라인 컨트롤 등 조밀한 맥락.
  case small
  /// 폼 제출·모달 하단·헤더 등 표준 액션. 대부분의 기본값.
  case medium
  /// Empty state CTA·온보딩 등 큰 진입점.
  case large
  /// 가장 큰 강조가 필요한 대형 진입점.
  case xlarge

  public var height: CGFloat {
    switch self {
    case .xsmall: return 24
    case .small:  return 30
    case .medium: return 40
    case .large:  return 44
    case .xlarge: return 54
    }
  }

  public var minWidth: CGFloat {
    switch self {
    case .xsmall: return 20
    case .small:  return 24
    case .medium: return 36
    case .large:  return 44
    case .xlarge: return 54
    }
  }

  public var horizontalPadding: CGFloat {
    switch self {
    case .xsmall: return 4
    case .small:  return 6
    case .medium: return 10
    case .large:  return 12
    case .xlarge: return 20
    }
  }

  public var contentSpacing: CGFloat {
    switch self {
    case .xsmall, .small: return 0
    case .medium, .large, .xlarge: return 2
    }
  }

  public var textHorizontalPadding: CGFloat {
    switch self {
    case .xsmall, .small: return 3
    case .medium, .large, .xlarge: return 4
    }
  }

  public var iconLength: CGFloat { 16 }

  public var spinnerSize: BezierSpinnerSize {
    switch self {
    case .xsmall: return .size12
    case .small:  return .size12
    case .medium: return .size12
    case .large:  return .size16
    case .xlarge: return .size20
    }
  }

  // MARK: - Typography
  //
  // Figma 변수 바인딩: xsmall·small·medium 은 `label/*` semantic, large·xlarge 는
  // `font-size/16` + `line-height/24` global. BezierSwift 에는 16/24 조합의 label/text
  // semantic 토큰이 없으므로 (내부 참조 가능한) BTGlobalToken raw 값을 직접 사용한다.
  public var fontSize: CGFloat {
    switch self {
    case .xsmall: return BTGlobalToken.FontSize.size13
    case .small:  return BTGlobalToken.FontSize.size14
    case .medium: return BTGlobalToken.FontSize.size15
    case .large, .xlarge: return BTGlobalToken.FontSize.size16
    }
  }

  public var lineHeight: CGFloat {
    switch self {
    case .xsmall: return BTGlobalToken.LineHeight.height18
    case .small, .medium: return BTGlobalToken.LineHeight.height20
    case .large, .xlarge: return BTGlobalToken.LineHeight.height24
    }
  }

  // Figma SemiBold(600) → iOS BTFontWeight binary system(`bold`) 매핑 (디자인 시스템 합의)
  public var fontWeight: BTFontWeight { .bold }
}

/// 버튼의 시각적 강조도. Figma `Button` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierButtonVariant: String, CaseIterable {
  /// 화면에서 가장 중요한 단일 액션(저장·확인·제출). 한 화면에 하나만 둔다.
  case filled
  /// 주 액션과 함께 두는 보조 액션(취소·나중에)이나 행 내 인라인 액션(편집·복제).
  case outlined
  /// 흐름을 방해하지 않는 최저 강조 액션(필터 초기화·도움말)이나 그룹의 세 번째 옵션.
  case ghost
}

/// 버튼의 의미론적 색상 역할. Figma `Button` 컴포넌트의 `semantic` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierButtonSemantic: String, CaseIterable {
  /// 강조가 필요한 주 액션. 최고 위계.
  case primary
  /// 중립·보조 조작. 낮은 대비의 보조 위계.
  case secondary
  /// 되돌릴 수 없는 파괴적 액션(삭제·연결 끊기). 확인 모달과 함께 쓴다.
  case destructive
}

enum BezierButtonConstant {
  static let borderWidth: CGFloat = 1
  static let disabledOpacity: CGFloat = BOGlobalToken.disabled
  static let pressedOpacity: CGFloat = 0.7
}

extension BezierButtonVariant {
  func backgroundToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken? {
    switch (self, semantic) {
    case (.filled, .primary):     return .fillNeutralHeaviest
    case (.filled, .secondary):   return .fillNeutral
    case (.filled, .destructive): return .fillAccentRedHeavier
    case (.outlined, _),
         (.ghost, _):
      return nil
    }
  }

  func borderToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken? {
    switch self {
    case .outlined: return .borderNeutral
    case .filled, .ghost: return nil
    }
  }

  func loadingSpinnerToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken {
    self.foregroundToken(semantic)
  }

  func foregroundToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken {
    switch (self, semantic) {
    case (.filled, .primary):     return .textInverse
    case (.filled, .secondary):   return .textNeutral
    case (.filled, .destructive): return .textInverse

    case (.outlined, .primary):     return .textNeutralHeaviest
    case (.outlined, .secondary):   return .textNeutralLight
    case (.outlined, .destructive): return .textAccentRed

    case (.ghost, .primary):     return .textNeutralLight
    case (.ghost, .secondary):   return .textNeutralLighter
    case (.ghost, .destructive): return .textAccentRed
    }
  }
}
