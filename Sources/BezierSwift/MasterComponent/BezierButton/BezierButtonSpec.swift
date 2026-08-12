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

  var typographyToken: BTSemanticToken? {
    switch self {
    case .xsmall: return .labelSmall
    case .small:  return .labelMedium
    case .medium: return .labelLarge
    case .large, .xlarge: return nil
    }
  }

  /// 라벨 폰트 크기.
  public var fontSize: CGFloat {
    self.typographyToken?.fontSize ?? BTGlobalToken.FontSize.size16
  }

  /// 라벨 행높이.
  public var lineHeight: CGFloat {
    self.typographyToken?.lineHeight ?? BTGlobalToken.LineHeight.height24
  }

  /// 라벨 폰트 weight.
  public var fontWeight: UIFont.Weight {
    switch self {
    case .xsmall, .small, .medium: return .bold
    case .large, .xlarge: return .medium
    }
  }

  /// 라벨 UIFont. SwiftUI에서는 `Font(uiFont)`로 사용한다.
  public var uiFont: UIFont {
    self.typographyToken?.uiFont ?? .systemFont(ofSize: self.fontSize, weight: self.fontWeight)
  }
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

  func pressedBackgroundToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken {
    (self.backgroundToken(semantic) ?? .fillNeutralTransparent).pressedColor
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
    case (.filled, .destructive): return .textAbsoluteWhite

    case (.outlined, .primary):     return .textNeutralHeaviest
    case (.outlined, .secondary):   return .textNeutralLight
    case (.outlined, .destructive): return .textAccentRed

    case (.ghost, .primary):     return .textNeutralLight
    case (.ghost, .secondary):   return .textNeutralLighter
    case (.ghost, .destructive): return .textAccentRed
    }
  }
}
