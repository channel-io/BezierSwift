//
//  LegacyBezierToastViewModifier.swift
//  BezierSwift
//

import SwiftUI

struct LegacyBezierToastViewModifier: ViewModifier {
  @Binding var param: LegacyBezierToastParam?
  @State private var presentationID: UUID?

  init(param: Binding<LegacyBezierToastParam?>) {
    self._param = param
  }

  func body(content: Content) -> some View {
    content
      .onChange(of: self.param) { param in
        guard let param else {
          self.presentationID = nil
          return
        }
        let id = UUID()
        self.presentationID = id

        BezierSwift.showLegacyToast(item: LegacyBezierToastItem(param: param) {
          guard self.presentationID == id, self.param == param else { return }
          self.presentationID = nil
          self.param = nil
        })
      }
  }
}
