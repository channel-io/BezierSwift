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
  /// 추상화된 자식뷰로 TintColor를 전달하기 위한 ViewModifire입니다.
  /// - Parameters:
  ///   - bezierColor: 부모 뷰에서 정의한 `BezierColor`를 environment 로 전달하여 TintColor를 적용합니다.
  /// - Attention:TintColor가 적용되는 자식뷰의 UI에는 반드시 `tintable()` 선언해야 합니다.
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
