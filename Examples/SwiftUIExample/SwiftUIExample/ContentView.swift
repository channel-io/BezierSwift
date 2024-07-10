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
    NavigationView {
      List {
        Section {
          NavigationLink {
            BezierButtonExample()
          } label: {
            Text("Button")
          }
        } header: {
          Text("Component")
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
