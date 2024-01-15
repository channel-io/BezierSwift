//
//  BezierToastViewModifier.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

struct BezierToastViewModifier: ViewModifier {
  @Binding var param: BezierToastParam?
  
  init(param: Binding<BezierToastParam?>) {
    self._param = param
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: self.param) { param in
        guard let param else { return }
        
        BezierSwift.showToast(item: BezierToastItem(param: param) {
          self.param = nil
        })
      }
  }
}
