//
//  BezierElevation.swift
//  
//
//  Created by Jam on 2023/02/09.
//

import SwiftUI

enum BezierElevation {
  case mEv1
  case mEv2
  case mEv3
  case mEv4
  case mEv5
  case mEv6

  func rawValue(
    _ themeable: Themeable
  ) -> (color: Color, x: CGFloat, y: CGFloat, blur: CGFloat) {
    switch self {
    case .mEv1: return (themeable.palette(.shdwMedium), 0, 1, 4)
    case .mEv2: return (themeable.palette(.shdwMedium), 0, 2, 6)
    case .mEv3: return (themeable.palette(.shdwLarge), 0, 4, 20)
    case .mEv4: return (themeable.palette(.shdwXlarge), 0, 4, 24)
    case .mEv5: return (themeable.palette(.shdwXlarge), 0, 6, 40)
    case .mEv6: return (themeable.palette(.shdwXlarge), 0, 12, 60)
    }
  }
}

extension View {
  func applyBezierElevation(_ themeable: Themeable, type: BezierElevation) -> some View {
    let rawVaue = type.rawValue(themeable)
    return self
      .shadow(
        color: rawVaue.color,
        radius: rawVaue.blur,
        x: rawVaue.x,
        y: rawVaue.y
      )
  }
}
