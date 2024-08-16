//
//  BezierShadow.swift
//  
//
//  Created by Tom on 12/20/23.
//

import SwiftUI

fileprivate struct ShadowConfiguration {
  let shadowColorToken: ShadowColorToken
  let radius: CGFloat
  let x: CGFloat
  let y: CGFloat
}

public enum BezierShadow {
  case shadow1
  case shadow2
  case shadow3
  case shadow4
  case shadow5
  case shadow6
  
  fileprivate var shadowConfiguration: ShadowConfiguration {
    switch self {
    case .shadow1: ShadowConfiguration(shadowColorToken: .small, radius: 1, x: 0, y: 1)
    case .shadow2: ShadowConfiguration(shadowColorToken: .small, radius: 3, x: 0, y: 2)
    case .shadow3: ShadowConfiguration(shadowColorToken: .medium, radius: 8, x: 0, y: 4)
    case .shadow4: ShadowConfiguration(shadowColorToken: .large, radius: 12, x: 0, y: 4)
    case .shadow5: ShadowConfiguration(shadowColorToken: .xlarge, radius: 20, x: 0, y: 6)
    case .shadow6: ShadowConfiguration(shadowColorToken: .xlarge, radius: 30, x: 0, y: 12)
    }
  }
  
  fileprivate var baseShadowConfiguration: ShadowConfiguration {
    ShadowConfiguration(shadowColorToken: .base, radius: 1, x: 0, y: 0)
  }
}

extension View {
  public func applyBezierShadow(_ shadow: BezierShadow) -> some View {
    self.modifier(BezierShadowViewModifier(shadow))
  }
}

private struct BezierShadowViewModifier: ViewModifier {
  @Environment(\.colorScheme) var colorScheme
  
  let shadow: BezierShadow
  
  init(_ shadow: BezierShadow) {
    self.shadow = shadow
  }
  
  func body(content: Content) -> some View {
    content
      .shadow(
        color: self.shadow.shadowConfiguration.shadowColorToken.color,
        radius: self.shadow.shadowConfiguration.radius,
        x: self.shadow.shadowConfiguration.x,
        y: self.shadow.shadowConfiguration.y
      )
      .shadow(
        color: self.shadow.baseShadowConfiguration.shadowColorToken.color,
        radius: self.shadow.baseShadowConfiguration.radius,
        x: self.shadow.baseShadowConfiguration.x,
        y: self.shadow.baseShadowConfiguration.y
      )
  }
}

#Preview {
  VStack(spacing: 50) {
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow1)
    
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow2)
    
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow3)
    
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow4)
    
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow5)
    
    Rectangle()
      .fill(BezierColor.bgWhiteNormal.color)
      .frame(length: 48)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .applyBezierShadow(.shadow6)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(BezierColor.bgWhiteNormal.color)
}
