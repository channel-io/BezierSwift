//
//  BezierIconButtonSpec.swift
//  BezierSwift
//

import CoreGraphics

/// 아이콘 버튼의 크기. Figma `IconButton` 컴포넌트의 `size` 프로퍼티에 대응 (case 이름 = Figma 값). `BezierButton`과 동일한 밀도 기준을 따른다.
public enum BezierIconButtonSize: String, CaseIterable {
  /// 좁은 인라인·툴바에서 가장 조밀하게 놓는 크기.
  case xsmall
  /// 좁은 인라인·툴바에 놓는 조밀한 크기.
  case small
  /// 표준 크기. 대부분의 맥락에서 기본으로 쓴다.
  case medium
  /// 큰 진입점이나 강조가 필요한 단독 액션에 쓰는 크기.
  case large

  public var length: CGFloat {
    switch self {
    case .xsmall: return 20
    case .small:  return 24
    case .medium: return 32
    case .large:  return 44
    }
  }

  public var padding: CGFloat {
    switch self {
    case .xsmall: return 2
    case .small:  return 4
    case .medium: return 6
    case .large:  return 12
    }
  }

  public var iconLength: CGFloat {
    self.length - self.padding * 2
  }

  public var spinnerSize: BezierSpinnerSize {
    switch self {
    case .xsmall: return .size12
    case .small:  return .size12
    case .medium: return .size12
    case .large:  return .size16
    }
  }
}

/// 아이콘 버튼의 시각적 강조도. Figma `IconButton` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierIconButtonVariant: String, CaseIterable {
  /// 화면당 하나만 두는 강조된 아이콘 액션.
  case filled
  /// `filled` 옆에 두는 보조 액션이나 행 내 인라인 액션.
  case outlined
  /// 기본값. 툴바나 저강조 맥락의 아이콘 액션.
  case ghost
}

/// 아이콘 버튼의 의미론적 위계. Figma `IconButton` 컴포넌트의 `semantic` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierIconButtonSemantic: String, CaseIterable {
  /// 화면에서 최상위 위계를 갖는 아이콘 액션.
  case primary
  /// 기본값. 닫기·더보기·편집·뒤로 등 일반적인 아이콘 액션.
  case secondary
  /// 삭제·연결 해제 등 파괴적인 아이콘 액션.
  case destructive
}

extension BezierIconButtonVariant {
  func backgroundToken(_ semantic: BezierIconButtonSemantic) -> BCSemanticToken? {
    switch (self, semantic) {
    case (.filled, .primary):     return .fillNeutralHeaviest
    case (.filled, .secondary):   return .fillNeutral
    case (.filled, .destructive): return .fillAccentRedHeavier
    case (.outlined, _),
         (.ghost, _):
      return nil
    }
  }

  func borderToken(_ semantic: BezierIconButtonSemantic) -> BCSemanticToken? {
    switch self {
    case .outlined: return .borderNeutral
    case .filled, .ghost: return nil
    }
  }

  func foregroundToken(_ semantic: BezierIconButtonSemantic) -> BCSemanticToken {
    switch (self, semantic) {
    case (.filled, .primary):     return .iconInverseHeavier
    case (.filled, .secondary):   return .iconNeutralHeavy
    case (.filled, .destructive): return .iconInverseHeavier

    case (.outlined, .primary):     return .iconNeutralHeavier
    case (.outlined, .secondary):   return .iconNeutral
    case (.outlined, .destructive): return .textAccentRed

    case (.ghost, .primary):     return .iconNeutralHeavier
    case (.ghost, .secondary):   return .iconNeutral
    case (.ghost, .destructive): return .textAccentRed
    }
  }

  func loadingSpinnerToken(_ semantic: BezierIconButtonSemantic) -> BCSemanticToken {
    self.foregroundToken(semantic)
  }
}

enum BezierIconButtonConstant {
  static let borderWidth: CGFloat = 1
  static let disabledOpacity: CGFloat = BOGlobalToken.disabled
  /// 배경 없는 variant(outlined·ghost)의 pressed / active overlay 색상.
  /// bezier-tokens에 등록되지 않은 임시값 — Variable 등록 시 교체 예정.
  static let ghostOverlayAlpha: CGFloat = 0.05
}
