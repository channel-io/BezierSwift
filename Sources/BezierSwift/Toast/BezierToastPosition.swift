//
//  BezierToastPosition.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierToastPosition: Equatable {
  case top

  var startOffsetY: CGFloat {
    switch self {
    case .top: return -16
    }
  }

  var endOffsetY: CGFloat {
    switch self {
    case .top: return 4
    }
  }
}
