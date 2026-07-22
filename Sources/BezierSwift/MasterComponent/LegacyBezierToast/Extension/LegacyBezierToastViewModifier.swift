//
//  LegacyBezierToastViewModifier.swift
//  BezierSwift
//

import SwiftUI

struct LegacyBezierToastViewModifier: ViewModifier {
  @Binding var param: LegacyBezierToastParam?

  init(param: Binding<LegacyBezierToastParam?>) {
    self._param = param
  }

  func body(content: Content) -> some View {
    content
      .onChange(of: self.param) { param in
        guard let param else { return }

        BezierSwift.showLegacyToast(item: LegacyBezierToastItem(param: param) {
          self.param = nil
        })
      }
  }
}
