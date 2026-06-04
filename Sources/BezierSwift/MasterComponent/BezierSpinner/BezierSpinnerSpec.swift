//
//  BezierSpinnerSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Spinner Size

public enum BezierSpinnerSize: String, CaseIterable {
  case size12
  case size16
  case size20
  case size24
  case size30
  case size36
  case size42
  case size48

  public var length: CGFloat {
    switch self {
    case .size12: return 12
    case .size16: return 16
    case .size20: return 20
    case .size24: return 24
    case .size30: return 30
    case .size36: return 36
    case .size42: return 42
    case .size48: return 48
    }
  }

  public var ringWidth: CGFloat {
    self.length * BezierSpinnerConstant.ringWidthRatio
  }
}

// MARK: - Spinner Constant

public enum BezierSpinnerConstant {
  public static let ringWidthRatio: CGFloat = 0.125
  public static let innerRadiusRatio: CGFloat = 0.75
  public static let rotationDuration: TimeInterval = 1.0
}
