//
//  BezierButtonConfiguration.swift
//
//
//  Created by Tom on 6/18/24.
//

import Foundation

// - MARK: BezierButtonConfiguration
/// - Parameters:
///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary`, `tertiary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
///   - Color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
public struct BezierButtonConfiguration: Equatable {
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
    case tertiary
  }
  
  // MARK: Size
  public enum Size {
    case xsmall
    case small
    case medium
    case large
    case xlarge
  }
  
  // MARK: Color
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
  
  // MARK: Properties
  let text: String
  let variant: Variant
  let color: Color
  let size: Size
  
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
  
  var horizontalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 6
    case .small: return 8
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }
  
  var verticalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 2
    case .small: return 3
    case .medium: return 8
    case .large: return 11
    case .xlarge: return 15
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
  
  var loaderSize: BezierLoaderConfiguration.Size {
    switch self.size {
    case .xsmall, .small: return .xxsmall
    case .medium, .large: return .xsmall
    case .xlarge: return .small
    }
  }
  
  var loaderVariant: BezierLoaderConfiguration.Variant {
    return self.variant == .primary ? .onOverlay : .secondary
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary`, `tertiary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - Color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large
  ) {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
  }
}
