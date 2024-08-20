//
//  BezierFloatingButtonConfiguration.swift
//  
//
//  Created by Tom on 8/18/24.
//

import Foundation

// - MARK: BezierButtonConfiguration
/// - Parameters:
///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
///   - Color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
public struct BezierFloatingButtonConfiguration: Equatable {
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
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
    case .xlarge: return .title3SemiBold
    }
  }
  
  var textColor: BezierColor {
    guard self.variant != .primary else { return .fgAbsoluteWhiteDark }
    
    switch self.color {
    case .blue: return .primaryFgNormal
    case .cobalt: return .fgCobaltNormal
    case .red: return .fgRedNormal
    case .orange: return .warningFgNormal
    case .green: return .successFgNormal
    case .pink: return .fgPinkNormal
    case .purple: return .fgPurpleNormal
    case .darkGrey: return .fgBlackDarkest
    case .lightGrey: return .fgBlackDarker
    }
  }
  
  var affixContentLength: CGFloat {
    switch self.size {
    case .xsmall, .small: return 16
    case .medium, .large: return 20
    case .xlarge: return 24
    }
  }
  
  var affixContentForegroundColor: BezierColor {
    switch self.variant {
    case .primary:
      switch self.color {
      case .blue: return .fgAbsoluteWhiteDark
      case .cobalt: return .fgAbsoluteWhiteDark
      case .red: return .fgAbsoluteWhiteDark
      case .orange: return .fgAbsoluteWhiteDark
      case .green: return .fgAbsoluteWhiteDark
      case .pink: return .fgAbsoluteWhiteDark
      case .purple: return .fgAbsoluteWhiteDark
      case .darkGrey: return .fgWhiteNormal
      case .lightGrey: return .fgAbsoluteWhiteNormal
      }
    case .secondary:
      switch self.color {
      case .blue: return .primaryFgNormal
      case .cobalt: return .accentFgNormal
      case .red: return .criticalFgNormal
      case .orange: return .warningFgNormal
      case .green: return .successFgNormal
      case .pink: return .fgPinkNormal
      case .purple: return .fgPurpleNormal
      case .darkGrey: return .fgBlackDarker
      case .lightGrey: return .fgBlackDark
      }
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
    case .xsmall: return 3
    case .small: return 7
    case .medium: return 9
    case .large: return 10
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
  
  var backgroundColor: BezierColor {
    guard self.variant != .secondary else { return .bgWhiteHigher }
    
    switch self.color {
    case .blue: return .primaryBgNormal
    case .cobalt: return .accentBgNormal
    case .red: return .criticalBgNormal
    case .green: return .successBgNormal
    case .orange: return .warningBgNormal
    case .pink: return .bgPinkNormal
    case .purple: return .bgPurpleNormal
    case .darkGrey: return .bgGreyDarkest
    case .lightGrey: return .bgBlackDark
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
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
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
