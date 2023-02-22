//
//  BezierCornerRadius.swift
//  
//
//  Created by Jam on 2023/02/09.
//

import SwiftUI

public enum BezierCornerRadius {
  case round2
  case round3
  case round4
  case round6
  case round8
  case round12
  case round16
  case round20
  case round22
  case round32
  case round44
  case roundHalf(length: CGFloat)
  case roundAvatar(length: CGFloat)

  var rawValue: CGFloat {
    switch self {
    case .round2:
      return CGFloat(2)
    case .round3:
      return CGFloat(3)
    case .round4:
      return CGFloat(4)
    case .round6:
      return CGFloat(6)
    case .round8:
      return CGFloat(8)
    case .round12:
      return CGFloat(12)
    case .round16:
      return CGFloat(16)
    case .round20:
      return CGFloat(20)
    case .round22:
      return CGFloat(22)
    case .round32:
      return CGFloat(32)
    case .round44:
      return CGFloat(44)
    case .roundHalf(let length):
      return length / CGFloat(2)
    case .roundAvatar(let length):
      return length * CGFloat(0.42)
    }
  }
}


extension View {
  public func applyBezierCornerRadius(type: BezierCornerRadius, correction: CGFloat = 0) -> some View {
    return self
      .clipShape(
        RoundedRectangle(
          cornerRadius: type.rawValue + correction,
          style: .continuous
        )
      )
  }
}
