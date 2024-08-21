//
//  BezierIconButtonExample.swift
//  SwiftUIExample
//
//  Created by Tom on 8/21/24.
//

import SwiftUI

import BezierSwift

struct BezierIconButtonExample: View {
  
  var body: some View {
    VStack {
      BezierIconButton(
        configuration: BezierIconButtonConfiguration(
          variant: .primary,
          color: .blue,
          size: .xlarge, 
          shape: .rectangle
        ),
        content: { configuration in
          BezierIcon.ios.image
            .frame(width: configuration.contentLength, height: configuration.contentLength)
            .foregroundColor(configuration.contentColor.color)
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
  BezierIconButtonExample()
}
