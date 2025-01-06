//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/06/28.
//

import SwiftUI
import BezierSwift

struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    Rectangle()
      .fill(BezierColor.bgRedDark.color)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
