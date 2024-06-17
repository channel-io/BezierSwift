//
//  BezierButtonVariant.swift
//  
//
//  Created by 구본욱 on 6/17/24.
//

import Foundation

public enum BezierButtonVariant {
  case primary
  case secondary
  case tertiary
}

// MARK: - Methods for Colors
extension BezierButtonVariant {
  public func backgroundColor(with color: BezierButtonColor) -> BezierColor {
    guard self != .tertiary else { return .bgWhiteAlphaTransparent }

    let isPrimary = self == .primary

    switch color {
    case .blue:
      return isPrimary ? .primaryBgNormal : .primaryBgLightest
    case .cobalt:
      return isPrimary ? .accentBgNormal : .accentBgLightest
    case .red:
      return isPrimary ? .criticalBgNormal : .criticalBgLightest
    case .green:
      return isPrimary ? .successBgNormal : .successBgLightest
    case .orange:
      return isPrimary ? .warningBgNormal : .warningBgLightest
    case .pink:
      return isPrimary ? .bgPinkNormal : .bgPinkLightest
    case .purple:
      return isPrimary ? .bgPurpleNormal : .bgPurpleLightest
    case .darkGrey:
      return isPrimary ? .bgGreyDarkest : .bgBlackLighter
    case .lightGrey:
      return isPrimary ? .bgBlackDark : .bgBlackLighter
    case .white:
      return isPrimary ? .bgAbsoluteWhiteDark : .bgAbsoluteWhiteLightest
    }
  }

  public func textColor(with color: BezierButtonColor) -> BezierColor {
    guard self != .primary else {
      return color == .white ? .fgAbsoluteBlackNormal : .fgAbsoluteWhiteDark
    }

    switch color {
    case .blue:
      return .primaryFgNormal
    case .cobalt:
      return .fgCobaltNormal
    case .red:
      return .fgRedNormal
    case .orange:
      return .warningFgNormal
    case .green:
      return .successFgNormal
    case .pink:
      return .fgPinkNormal
    case .purple:
      return .fgPurpleNormal
    case .darkGrey:
      return .fgBlackDarkest
    case .lightGrey:
      return .fgBlackDarker
    case .white:
      return .fgAbsoluteWhiteNormal
    }
  }

  public func affixColor(with  color: BezierButtonColor) -> BezierColor {
    switch (self, color) {
    case (.secondary, .darkGrey), (.tertiary, .darkGrey):
      return .fgBlackDarker
    case (.secondary, .lightGrey), (.tertiary, .lightGrey):
      return .fgBlackDark
    case (.secondary, .white), (.tertiary, .white):
      return .fgAbsoluteWhiteLight
    default:
      return self.textColor(with: color)
    }
  }
}
