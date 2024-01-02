//
//  ColorPOCView.swift
//  RedesignSwiftUIExample
//
//  Created by 구본욱 on 1/2/24.
//

import SwiftUI

struct ColorPOCView: View {
  @Environment(\.colorScheme) var colorScheme
  @State var useSystemTheme: Bool = true
  @State var isDarkTheme: Bool = false

  var body: some View {
    if self.useSystemTheme {
      self.content
    } else {
      self.content
        .preferredColorScheme(self.isDarkTheme ? .dark : .light)
    }
  }
}

extension ColorPOCView {
  private var content: some View {
    VStack {
      ColorPOCSubview()

      Toggle(isOn: self.$useSystemTheme) {
        Text("시스템 테마 사용하기")
      }
      Toggle(isOn: self.$isDarkTheme) {
        Text("다크모드 사용하기")
      }
      .disabled(self.useSystemTheme)
    }
    .padding(.horizontal, 16)
  }
}

#Preview {
    ColorPOCView()
}
