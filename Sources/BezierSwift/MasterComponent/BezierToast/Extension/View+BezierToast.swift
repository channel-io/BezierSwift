//
//  View+BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

extension View {
  public func bezierToast(param: Binding<BezierToastParam?>) -> some View {
    self.modifier(BezierToastViewModifier(param: param))
  }
}
