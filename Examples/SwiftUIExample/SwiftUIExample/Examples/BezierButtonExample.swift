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
        isFilled: true,
        prefixContent:
          BezierIcon.ios.image
            .frame(width: 24, height: 24)
            .foregroundColor(BezierColor.fgWhiteNormal.color),
        suffixContent:
          BezierIcon.android.image
          .frame(width: 24, height: 24)
          .foregroundColor(BezierColor.fgWhiteNormal.color)
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
