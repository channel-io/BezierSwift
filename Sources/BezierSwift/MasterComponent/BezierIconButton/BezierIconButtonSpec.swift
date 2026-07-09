//
//  BezierIconButtonSpec.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierIconButtonSize: String, CaseIterable {
  case xsmall
  case small
  case medium
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

public enum BezierIconButtonVariant: String, CaseIterable {
  case filled
  case outlined
  case ghost
}

public enum BezierIconButtonSemantic: String, CaseIterable {
  case primary
  case secondary
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
