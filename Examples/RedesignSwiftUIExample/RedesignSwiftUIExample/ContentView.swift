//
//  ContentView.swift
//  RedesignSwiftUIExample
//
//  Created by Tom on 12/20/23.
//

import SwiftUI
import RedesignBezierSwift

struct ContentView: View {
  enum Path: Int, Hashable {
    case testView
    case colorPocView
  }

  var body: some View {
    NavigationStack {
      VStack(spacing: 12) {
        NavigationLink(value: Path.testView) {
          Text("TestView로 가기")
        }
        NavigationLink(value: Path.colorPocView) {
          Text("ColorPOCView로 가기")
        }
      }
      .padding()
      .navigationDestination(for: Path.self) { path in
        switch path {
        case .testView:
          TestView()
        case .colorPocView:
          ColorPOCView()
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
