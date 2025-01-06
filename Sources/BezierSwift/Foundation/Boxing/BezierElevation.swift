//
//  BezierElevation.swift
//  
//
//  Created by Jam on 2023/02/09.
//

import SwiftUI

public enum BezierElevation {
  case mEv1
  case mEv2
  case mEv3
  case mEv4
  case mEv5
  case mEv6

  var rawValue: (bezierColor: BezierColor, x: CGFloat, y: CGFloat, blur: CGFloat) {
    switch self {
    case .mEv1: return (.shadowMedium, 0, 1, 4)
    case .mEv2: return (.shadowMedium, 0, 2, 6)
    case .mEv3: return (.shadowLarge, 0, 4, 20)
    case .mEv4: return (.shadowXlarge, 0, 4, 24)
    case .mEv5: return (.shadowXlarge, 0, 6, 40)
    case .mEv6: return (.shadowXlarge, 0, 12, 60)
    }
  }
}

extension View {
  public func applyBezierElevation(_ elevation: BezierElevation) -> some View {
    self.modifier(BezierElevationView(elevation))
  }
}

private struct BezierElevationView: ViewModifier {
  let elevation: BezierElevation
  
  init(_ elevation: BezierElevation) {
    self.elevation = elevation
  }
  
  func body(content: Content) -> some View {
    let elevationRawValue = elevation.rawValue
    
    content
      .shadow(
        color: elevationRawValue.bezierColor.color,
        radius: elevationRawValue.blur,
        x: elevationRawValue.x,
        y: elevationRawValue.y
      )
  }
}
