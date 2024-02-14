//
//  ColorSchemeChangeSubview.swift
//  RedesignSwiftUIExample
//
//  Created by 구본욱 on 1/2/24.
//

import SwiftUI

struct ColorSchemeChangeSubview: View {
  @State private var isPresented: Bool = false

  var body: some View {
    VStack(spacing: 12) {
      Text("이것은 ColorChangeSchemeView의 하위에 정의된 뷰입니다.")

      Button {
        self.isPresented = true
      } label: {
        Text("하위 뷰에서 한번더 하위 뷰를 띄워보기")
      }
    }
    .sheet(isPresented: self.$isPresented) {
      NavigationStack {
        ColorSchemeChangeView()
      }
    }
  }
}

#Preview {
    ColorSchemeChangeSubview()
}
