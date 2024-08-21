//
//  BezierButtonExample.swift
//  SwiftUIExample
//
//  Created by Tom on 7/10/24.
//

import SwiftUI

import BezierSwift

struct BezierButtonExample: View {
  
  var body: some View {
    VStack {
      BezierButton(
        configuration: BezierButtonConfiguration(
          text: "BezierButton",
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
        print("BezierButton")
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
  BezierButtonExample()
}
