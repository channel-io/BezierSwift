//
//  BezierElevation.swift
//  
//
//  Created by Jam on 2023/02/09.
//

import SwiftUI

public enum BezierElevation: CaseIterable {
  case mEv1
  case mEv2
  case mEv3
  case mEv4
  case mEv5
  case mEv6

  var rawValue: (semanticColor: BCSemanticToken, x: CGFloat, y: CGFloat, blur: CGFloat) {
    switch self {
    case .mEv1: return (.elevationMedium, 0, 1, 4)
    case .mEv2: return (.elevationMedium, 0, 2, 6)
    case .mEv3: return (.elevationLarge, 0, 4, 20)
    case .mEv4: return (.elevationXlarge, 0, 4, 24)
    case .mEv5: return (.elevationXlarge, 0, 6, 40)
    case .mEv6: return (.elevationXlarge, 0, 12, 60)
    }
  }

  /// 그림자 구성값. UIKit에서는 `CALayer`의 그림자 프로퍼티에 직접 넣는다.
  /// `color`는 semantic 토큰이므로 `palette(_:)`로 해석해 쓴다.
  ///
  /// SwiftUI에서는 이 값을 직접 쓰지 않고 `applyBezierElevation(_:)`을 쓴다.
  public var shadow: (color: BCSemanticToken, offsetX: CGFloat, offsetY: CGFloat, blur: CGFloat) {
    let raw = self.rawValue
    return (color: raw.semanticColor, offsetX: raw.x, offsetY: raw.y, blur: raw.blur)
  }
}

extension View {
  public func applyBezierElevation(_ elevation: BezierElevation) -> some View {
    self.modifier(BezierElevationView(elevation))
  }
}

private struct BezierElevationView: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  let elevation: BezierElevation
  
  init(_ elevation: BezierElevation) {
    self.elevation = elevation
  }
  
  func body(content: Content) -> some View {
    let elevationRawValue = elevation.rawValue
    
    content
      .shadow(
        color: self.palette(elevationRawValue.semanticColor),
        radius: elevationRawValue.blur,
        x: elevationRawValue.x,
        y: elevationRawValue.y
      )
  }
}
