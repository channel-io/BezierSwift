//
//  ContentView.swift
//  RedesignSwiftUIExample
//
//  Created by Tom on 12/20/23.
//

import SwiftUI
import BezierSwift

struct ContentView: View {
  var body: some View {
    VStack {
      Text("테스트")
        .applyBezierFontStyle(.heading1Bold, bezierColor: .fgPinkDark)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
