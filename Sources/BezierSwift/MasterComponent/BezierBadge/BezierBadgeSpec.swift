//
//  BezierBadgeSpec.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierBadgeSize: String, CaseIterable {
  case xsmall
  case small
  case medium
  case large

  public var height: CGFloat {
    switch self {
    case .xsmall: return 18
    case .small:  return 22
    case .medium: return 22
    case .large:  return 26
    }
  }

  public var horizontalPadding: CGFloat { 4 }

  public var textHorizontalPadding: CGFloat { 4 }

  public var verticalPadding: CGFloat {
    switch self {
    case .xsmall: return 1
    case .small:  return 2
    case .medium: return 2
    case .large:  return 3
    }
  }

  public var iconLength: CGFloat { 16 }

  public var dotLength: CGFloat {
    switch self {
    case .xsmall: return 6
    case .small:  return 6
    case .medium: return 8
    case .large:  return 10
    }
  }

  public var typography: BTSemanticToken {
    switch self {
    case .xsmall: return .textXSmall(weight: .regular)
    case .small:  return .textMedium(weight: .regular)
    case .medium: return .textLarge(weight: .regular)
    case .large:  return .textXLarge(weight: .regular)
    }
  }
}

public enum BezierBadgeVariant: String, CaseIterable {
  case `default`
  case monochromeLight
  case monochromeDark
  case blue
  case cobalt
  case teal
  case green
  case olive
  case pink
  case navy
  case yellow
  case orange
  case red
  case purple
}

public enum BezierBadgeShape: Equatable {
  case dot
  case numeric(Int)
  case text(String)
}

public enum BezierBadgeConstant {
  public static let numericCap: Int = 99
}

extension BezierBadgeVariant {
  public var backgroundToken: BCSemanticToken {
    switch self {
    case .default:         return .fillNeutralLight
    case .monochromeLight: return .fillNeutralLight
    case .monochromeDark:  return .fillNeutralHeavier
    case .blue:            return .fillAccentBlueHeavy
    case .cobalt:          return .fillAccentCobaltHeavy
    case .teal:            return .fillAccentTealHeavy
    case .green:           return .fillAccentGreenHeavy
    case .olive:           return .fillAccentOliveHeavy
    case .pink:            return .fillAccentPinkHeavy
    case .navy:            return .fillAccentNavyHeavy
    case .yellow:          return .fillAccentYellowHeavy
    case .orange:          return .fillAccentOrangeHeavy
    case .red:             return .fillAccentRedHeavy
    case .purple:          return .fillAccentPurpleHeavy
    }
  }

  public var foregroundToken: BCSemanticToken {
    switch self {
    case .default:         return .textNeutral
    case .monochromeLight: return .textNeutralLighter
    case .monochromeDark:  return .textAbsoluteWhite
    case .blue:            return .textAccentBlue
    case .cobalt:          return .textAccentCobalt
    case .teal:            return .textAccentTeal
    case .green:           return .textAccentGreen
    case .olive:           return .textAccentOlive
    case .pink:            return .textAccentPink
    case .navy:            return .textAccentNavy
    case .yellow:          return .textAccentYellow
    case .orange:          return .textAccentOrange
    case .red:             return .textAccentRed
    case .purple:          return .textAccentPurple
    }
  }
}

extension BezierBadgeShape {
  public var displayText: String? {
    switch self {
    case .dot:
      return nil
    case .numeric(let value):
      let clamped = max(0, value)
      return clamped > BezierBadgeConstant.numericCap
        ? "\(BezierBadgeConstant.numericCap)+"
        : "\(clamped)"
    case .text(let text):
      return text
    }
  }

  public var isDot: Bool {
    if case .dot = self { return true }
    return false
  }
}
