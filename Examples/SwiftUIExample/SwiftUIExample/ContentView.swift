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
  @State var isUIKitViewControllerShowed: Bool = false

  var body: some View {
    NavigationView {
      List {
        Text("Hello World")
          .applyBezierFontStyle(.title1Bold, bezierColor: .primaryFgDark)
        NavigationLink(destination: UIKitExampleView()) {
          Text("UIKitExampleView")
            .applyBezierFontStyle(.title1Bold, bezierColor: .primaryFgDark)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
