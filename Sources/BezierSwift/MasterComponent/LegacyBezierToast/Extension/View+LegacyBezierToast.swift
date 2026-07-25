//
//  View+LegacyBezierToast.swift
//  BezierSwift
//

import SwiftUI

extension View {
  public func legacyBezierToast(param: Binding<LegacyBezierToastParam?>) -> some View {
    self.modifier(LegacyBezierToastViewModifier(param: param))
  }
}
