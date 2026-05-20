//
//  BezierButtonSpec.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierButtonSize: String, CaseIterable {
  case xsmall
  case small
  case medium
  case large
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

  public var spinnerLength: CGFloat {
    switch self {
    case .xsmall: return 12
    case .small:  return 14
    case .medium: return 16
    case .large:  return 18
    case .xlarge: return 18
    }
  }

  public var fontSize: CGFloat {
    switch self {
    case .xsmall: return 13
    case .small:  return 14
    case .medium: return 15
    case .large, .xlarge: return 16
    }
  }

  public var lineHeight: CGFloat {
    switch self {
    case .xsmall, .small: return 18
    case .medium, .large, .xlarge: return 20
    }
  }

  // Figma SemiBold(600) → iOS BTFontWeight binary system(`bold`) 매핑 (디자인 시스템 합의)
  public var fontWeight: BTFontWeight { .bold }
}

public enum BezierButtonVariant: String, CaseIterable {
  case filled
  case outlined
  case ghost
}

public enum BezierButtonSemantic: String, CaseIterable {
  case primary
  case secondary
  case destructive
}

enum BezierButtonConstant {
  static let borderWidth: CGFloat = 1
  static let disabledOpacity: CGFloat = 0.4
  static let pressedOpacity: CGFloat = 0.7
}

extension BezierButtonVariant {
  func backgroundToken(_ semantic: BezierButtonSemantic) -> BCSemanticToken? {
    switch (self, semantic) {
    case (.filled, .primary):     return .fillNeutralHeaviest
    case (.filled, .secondary):   return .fillNeutralLight
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
