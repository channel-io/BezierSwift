//
//  View+BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

extension View {
  @available(iOS 14.0, *)
  public func bezierToast(viewModel: Binding<BezierToastViewModel?>) -> some View {
    modifier (
      BezierToastViewModifier(viewModel: viewModel)
    )
  }
}

