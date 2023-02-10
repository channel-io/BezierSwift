//
//  View+BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

extension View {
  @available(iOS 15.0, *)
  func bezierToast(info: Binding<BezierToastInfo?>) -> some View {
    modifier (
      BezierToastViewModifier(info: info)
    )
  }
}

