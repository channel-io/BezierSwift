//
//  BezierFloatingIconButtonExample.swift
//  SwiftUIExample
//
//  Created by Tom on 8/21/24.
//

import SwiftUI

import BezierSwift

struct BezierFloatingIconButtonExample: View {
  
  var body: some View {
    VStack {
      BezierFloatingIconButton(
        configuration: BezierFloatingIconButtonConfiguration(
          variant: .primary,
          color: .blue,
          size: .xlarge
        ),
        content: { configuration in
          BezierIcon.ios.image
            .frame(width: configuration.contentLength, height: configuration.contentLength)
            .foregroundColor(configuration.contentColor.color)
        }
      ) {
        print("BezierFloatingIconButton")
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
  BezierFloatingIconButtonExample()
}
