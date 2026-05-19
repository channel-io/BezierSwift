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

  public var spinnerLength: CGFloat {
    switch self {
    case .xsmall: return 12
    case .small:  return 14
    case .medium: return 16
    case .large:  return 18
    }
  }
}

public enum BezierIconButtonVariant: String, CaseIterable {
  case filled
  case ghost
}

extension BezierIconButtonVariant {
  var backgroundToken: BCSemanticToken? {
    switch self {
    case .filled: return .fillNeutralLight
    case .ghost:  return nil
    }
  }

  var foregroundToken: BCSemanticToken {
    switch self {
    case .filled: return .iconNeutralHeavy
    case .ghost:  return .iconNeutral
    }
  }
}

enum BezierIconButtonConstant {
  static let disabledOpacity: CGFloat = 0.4
  /// Ghost variant의 pressed / active overlay 색상.
  /// bezier-tokens에 등록되지 않은 임시값 — Variable 등록 시 교체 예정.
  static let ghostOverlayAlpha: CGFloat = 0.05
}
