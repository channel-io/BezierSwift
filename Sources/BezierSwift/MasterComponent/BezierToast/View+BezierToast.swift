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
  
  public func bezierToast1(_ param: BezierToastParam) -> some View {
    let _ = BezierToastManager.showToast(param)
    return self
  }
}

