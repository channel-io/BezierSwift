//
//  BezierLoaderExample.swift
//  SwiftUIExample
//
//  Created by Tom on 7/31/24.
//

import SwiftUI

import BezierSwift

struct BezierLoaderExample: View {
  
  var body: some View {
    VStack {
      BezierLoader(
        configuration: BezierLoaderConfiguration(
          size: .xxsmall,
          variant: .primary
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
