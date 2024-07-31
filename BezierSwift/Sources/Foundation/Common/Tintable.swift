//
//  Tintable.swift
//
//
//  Created by Tom on 7/31/24.
//

import SwiftUI

struct TintBezierColorKey: EnvironmentKey {
  static var defaultValue: BezierColor? = nil
}

extension EnvironmentValues {
  var tintBezierColor: BezierColor? {
    get { self[TintBezierColorKey.self] }
    set { self[TintBezierColorKey.self] = newValue }
  }
}

extension View {
  @ViewBuilder
  func applyTintBezierColor(_ bezierColor: BezierColor) -> some View {
    self.environment(\.tintBezierColor, bezierColor)
  }
  
  @ViewBuilder
  func tintable() -> some View {
    TintableView { self }
  }
}

private struct TintableView<Content: View>: View {
  @Environment(\.tintBezierColor) var tintBezierColor
  var content: () -> Content

  var body: some View {
    self.content()
      .if(self.tintBezierColor != nil) {
        $0.foregroundColor(self.tintBezierColor?.color)
      }
  }
}
