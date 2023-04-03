//
//  View+BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

extension View {
  public func bezierToast(viewModel: Binding<BezierToastViewModel?>) -> some View {
    modifier (
      BezierToastViewModifier(viewModel: viewModel)
    )
  }
  
  public func bezierToast1(param: Binding<BezierToastParam?>) -> some View {
    modifier (
      BezierToastViewModifier1(param: param)
    )
  }
}


struct BezierToastViewModifier1: ViewModifier {
  @Binding var param: BezierToastParam?
  
  func body(content: Content) -> some View {
    content
      .onChange(of: self.param) { param in
        guard let param else { return }
        
        BezierToastManager.showToast(BezierToastItem(param: param, binding: self.$param))
      }
  }
}
