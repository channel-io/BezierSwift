//
//  ContentView.swift
//  RedesignSwiftUIExample
//
//  Created by Tom on 12/20/23.
//

import SwiftUI
import RedesignBezierSwift

struct ContentView: View {
  var body: some View {
    VStack {
      Text("테스트")
        .applyBezierFontStyle(.title1Bold)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
