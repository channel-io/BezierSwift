//
//  BezierFloatingButton.swift
//  SwiftUIExample
//
//  Created by Tom on 8/21/24.
//

import SwiftUI

import BezierSwift

struct BezierFloatingButtonExample: View {
  
  var body: some View {
    VStack {
      BezierFloatingButton(
        configuration: BezierFloatingButtonConfiguration(
          text: "BezierFloatingButton",
          variant: .primary,
          color: .blue,
          size: .xlarge
        ),
        prefixContent: { configuration in
          BezierIcon.ios.image
            .frame(width: configuration.affixContentLength, height: configuration.affixContentLength)
            .foregroundColor(configuration.affixContentColor.color)
        },
        suffixContent: { configuration in
          BezierIcon.android.image
            .frame(width: configuration.affixContentLength, height: configuration.affixContentLength)
            .foregroundColor(configuration.affixContentColor.color)
        }
      ) {
        print("BezierFloatingButton")
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      BezierColor.bgWhiteNormal.color
        .ignoresSafeArea()
    )
  }
}

#Preview {
  BezierFloatingButtonExample()
}
