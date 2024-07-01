//
//  BezierButtonConfiguration.swift
//
//
//  Created by Tom on 6/18/24.
//

import Foundation

// - MARK: BezierButtonConfiguration
public struct BezierButtonConfiguration {
  // TODO: avatar, emoji 추가 필요 by Tom 2024.06.18
  public enum PrefixContent {
    case icon(BezierIcon)
  }
  
  // TODO: avatar, emoji 추가 필요 by Tom 2024.06.18
  public enum SuffixContent {
    case icon(BezierIcon)
  }
  
  public enum Variant {
    case primary
    case secondary
    case tertiary
  }
  
  public enum Size {
    case xsmall
    case small
    case medium
    case large
    case xlarge
  }
  
  public enum Color {
    case blue
    case cobalt
    case red
    case orange
    case green
    case pink
    case purple
    case darkGrey
    case lightGrey
    case absoluteWhite
  }
  
  public var text: String
  public var variant: Variant
  public var color: Color
  public var size: Size
  public var prefixContent: PrefixContent?
  public var suffixContent: SuffixContent?

  // MARK: Text
  var textFont: BezierFont {
    switch self.size {
    case .xsmall: return .caption2SemiBold
    case .small: return .caption1SemiBold
    case .medium: return .body2SemiBold
    case .large: return .body1SemiBold
    case .xlarge: return .title2SemiBold
    }
  }
  
  var textColor: BezierColor {
    guard self.variant != .primary else {
      return self.color == .absoluteWhite ? .fgAbsoluteBlackNormal : .fgAbsoluteWhiteDark
    }
    
    switch self.color {
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
    case .absoluteWhite:
      return .fgAbsoluteWhiteNormal
    }
  }
  
  // MARK: Affix Content
  var affixContentSize: CGSize {
    switch self.size {
    case .xsmall, .small: return CGSize(width: 16, height: 16)
    case .medium, .large: return CGSize(width: 20, height: 20)
    case .xlarge: return CGSize(width: 24, height: 24)
    }
  }
  
  var affixContentForegroundColor: BezierColor {
    switch (self.variant, self.color) {
    case (.secondary, .darkGrey), (.tertiary, .darkGrey):
      return .fgBlackDarker
    case (.secondary, .lightGrey), (.tertiary, .lightGrey):
      return .fgBlackDark
    case (.secondary, .absoluteWhite), (.tertiary, .absoluteWhite):
      return .fgAbsoluteWhiteLight
    default:
      return self.textColor
    }
  }
  
  // MARK: Bezier Button
  var horizontalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 6
    case .small: return 8
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }
  
  var horizontalSpacing: CGFloat {
    switch self.size {
    case .xsmall: return 3
    case .small, .medium: return 4
    case .large: return 5
    case .xlarge: return 6
    }
  }
  
  var cornerRadius: CGFloat {
    switch self.size {
    case .xsmall: return 8
    case .small: return 10
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }
  
  var height: CGFloat {
    switch self.size {
    case .xsmall: return 24
    case .small: return 32
    case .medium: return 40
    case .large: return 48
    case .xlarge: return 54
    }
  }
  
  var backgroundColor: BezierColor {
    guard self.variant != .tertiary else { return .bgWhiteAlphaTransparent }
    
    let isPrimary = self.variant == .primary
    
    switch self.color {
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
    case .absoluteWhite:
      return isPrimary ? .bgAbsoluteWhiteDark : .bgAbsoluteWhiteLightest
    }
  }
  
  // MARK: Initialization
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large,
    prefixContent: PrefixContent? = nil,
    suffixContent: SuffixContent? = nil
  ) {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
  }
}
