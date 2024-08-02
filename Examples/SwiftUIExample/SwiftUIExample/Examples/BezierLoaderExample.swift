//
//  BezierLoaderExample.swift
//  SwiftUIExample
//
//  Created by Tom on 7/31/24.
//

import SwiftUI

import BezierSwift

struct BezierLoaderExample: View {
  @State private var size: BezierLoaderConfiguration.Size = .medium
  @State private var variant: BezierLoaderConfiguration.Variant = .secondary
  
  var body: some View {
    VStack {
      BezierLoader(
        configuration: BezierLoaderConfiguration(
          size: self.size,
          variant: self.variant
        )
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      BezierColor.bgWhiteNormal.color
        .ignoresSafeArea()
    )
  }
}

#Preview {
  BezierButtonExample()
}
