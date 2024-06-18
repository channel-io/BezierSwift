//
//  BezierButtonSize.swift
//
//
//  Created by 구본욱 on 6/17/24.
//

import Foundation

public enum BezierButtonSize {
  case xsmall
  case small
  case medium
  case large
  case xlarge

  public static func `default`() -> BezierButtonSize {
    return .large
  }
}

extension BezierButtonSize {
  var horizontalPadding: CGFloat {
    switch self {
    case .xsmall: return 6
    case .small: return 8
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }

  var verticalPadding: CGFloat {
    switch self {
    case .xsmall: return 3
    case .small: return 6
    case .medium: return 9
    case .large: return 11
    case .xlarge: return 15
    }
  }

  var textHorizontalPadding: CGFloat {
    switch self {
    case .xsmall: return 3
    case .small, .medium: return 4
    case .large: return 5
    case .xlarge: return 6
    }
  }

  var textVerticalPadding: CGFloat {
    switch self {
    case .xsmall, .medium, .xlarge: return 0
    case .small, .large: return 1
    }
  }

  var radius: CGFloat {
    switch self {
    case .xsmall: return 8
    case .small: return 10
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }

  var affixSize: CGSize {
    switch self {
    case .xsmall, .small: return CGSize(width: 16, height: 16)
    case .medium, .large: return CGSize(width: 20, height: 20)
    case .xlarge: return CGSize(width: 24, height: 24)
    }
  }

  var font: BezierFont {
    switch self {
    case .xsmall: return .caption2SemiBold
    case .small: return .caption1SemiBold
    case .medium: return .body2SemiBold
    case .large: return .body1SemiBold
    case .xlarge: return .title2SemiBold
    }
  }
}
