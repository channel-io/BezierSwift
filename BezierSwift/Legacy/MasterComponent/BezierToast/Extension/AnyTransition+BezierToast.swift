//
//  AnyTransition+Extensions.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI

extension AnyTransition {
  public static func toast(position: BezierToastPosition) -> AnyTransition {
    .asymmetric(
      insertion: .toastInsertion(position: position),
      removal: .opacity
    )
  }
  
  static func toastInsertion(position: BezierToastPosition) -> AnyTransition {
    .modifier(
      active: ToastInsertionModifier(position: position, transitionPercent: 0),
      identity: ToastInsertionModifier(position: position, transitionPercent: 1)
    )
    .combined(with: .opacity)
  }
  
  struct ToastInsertionModifier: Animatable, ViewModifier {
    let position: BezierToastPosition
    var transitionPercent: Double
    
    private var offsetY: CGFloat {
      self.position.startOffsetY + (self.position.endOffsetY - self.position.startOffsetY) * self.transitionPercent
    }
    
    func body(content: Content) -> some View {
      content.offset(y: self.offsetY)
    }
  }
}
