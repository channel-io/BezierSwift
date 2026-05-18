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

  public var typography: BTSemanticToken {
    switch self {
    case .xsmall: return .labelMedium
    case .small:  return .labelLarge
    case .medium: return .headingXXSmall
    case .large:  return .headingXSmall
    case .xlarge: return .headingXSmall
    }
  }
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

public enum BezierButtonResizing: String, CaseIterable {
  case hug
  case fill
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
