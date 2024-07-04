//
//  BezierSpinnerConfiguration.swift
//
//
//  Created by Tom on 6/29/24.
//

import Foundation

// - MARK: BezierSpinnerConfiguration
public struct BezierSpinnerConfiguration: Sendable {
  public enum Variant: Sendable{
    case primary
    case secondary
    case onOverlay
  }
  
  public enum Size: Sendable {
    case small
    case medium
  }
  
  let variant: Variant
  let size: Size
  
  var trackColor: BezierColor {
    switch self.variant {
    case .primary: return .primaryBgLightest
    case .secondary: return .bgBlackLight
    case .onOverlay: return .bgAbsoluteWhiteLightest
    }
  }
  
  var indicatorColor: BezierColor {
    switch self.variant {
    case .primary: return .primaryFgNormal
    case .secondary: return .fgBlackLight
    case .onOverlay: return .bgAbsoluteWhiteLight
    }
  }
  
  var lineWidth: CGFloat {
    switch self.size {
    case .small: return 4
    case .medium: return 6
    }
  }
  
  var spinnerRadius: CGFloat {
    return (self.spinnerSize.width - self.lineWidth) / 2
  }
  
  var spinnerSize: CGSize {
    switch self.size {
    case .small: return CGSize(width: 28, height: 28)
    case .medium: return CGSize(width: 50, height: 50)
    }
  }
  
  public init(
    variant: Variant = .secondary,
    size: Size
  ) {
    self.variant = variant
    self.size = size
  }
}

