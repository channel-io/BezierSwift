//
//  View+SUBezierToast.swift
//  BezierSwift
//

import SwiftUI

extension View {
  /// 선언형 V3 Toast 트리거. `param`이 non-nil이 되면 전역 Toast를 표시하고 자동으로 nil로 되돌린다.
  public func bezierToast(param: Binding<BezierToastParam?>) -> some View {
    self.modifier(SUBezierToastViewModifier(param: param))
  }
}

/// V3 Toast의 선언형 트리거 파라미터. preset + 메시지.
public struct BezierToastParam: Equatable {
  let preset: BezierToastPreset
  let title: String

  public init(preset: BezierToastPreset = .info, title: String) {
    self.preset = preset
    self.title = title
  }
}

struct SUBezierToastViewModifier: ViewModifier {
  @Binding var param: BezierToastParam?

  init(param: Binding<BezierToastParam?>) {
    self._param = param
  }

  func body(content: Content) -> some View {
    content
      .onChange(of: self.param) { param in
        guard let param else { return }

        BezierSwift.showToast(preset: param.preset, title: param.title) {
          self.param = nil
        }
      }
  }
}
