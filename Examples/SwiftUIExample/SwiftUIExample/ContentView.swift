//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/06/28.
//

import SwiftUI
import BezierSwift

struct ContentView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(BezierColor.primaryBgLightest.color)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
