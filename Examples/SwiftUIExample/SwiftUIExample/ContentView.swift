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
    NavigationView {
      List {
        NavigationLink("V3 Typography Catalog") {
          TypographyTokenCatalogView()
        }
        NavigationLink("Bezier Icon Catalog") {
          BezierIconCatalogView()
        }
        NavigationLink("Elevation Test") {
          BezierElevationTestView()
        }
      }
      .navigationTitle("BezierSwift Examples")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
