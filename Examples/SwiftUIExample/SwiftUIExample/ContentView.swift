//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/06/28.
//

import SwiftUI

import BezierSwift

// TODO: Bezier Component 로 전환 필요 by Tom 2024.07.31
struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Section {
          NavigationLink {
            BezierLoaderExample()
          } label: {
            Text("Loader")
          }
        } header: {
          Text("Status")
        }
        Section {
          NavigationLink {
            BezierAvatarExample()
          } label: {
            Text("Avatar")
          }
        } header: {
          Text("Navigation")
        }
        Section {
          NavigationLink {
            BezierButtonExample()
          } label: {
            Text("Button")
          }
          NavigationLink {
            BezierIconButtonExample()
          } label: {
            Text("IconButton")
          }
          NavigationLink {
            BezierFloatingButtonExample()
          } label: {
            Text("FloatingButton")
          }
          NavigationLink {
            BezierFloatingIconButtonExample()
          } label: {
            Text("FloatingIconButton")
          }
        } header: {
          Text("Action")
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
