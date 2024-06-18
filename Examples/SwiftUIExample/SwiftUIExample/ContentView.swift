//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/06/28.
//

import SwiftUI
import BezierSwift

struct ContentView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(self.palette(.primaryBgLightest))

      Text("Hello World")
        .applyBezierFontStyle(.title1Bold, bezierColor: .primaryFgDark)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
