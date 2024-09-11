//
//  BezierFloatingButtonExample.swift
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
        text: "BezierFloatingButton",
        variant: .primary,
        color: .blue,
        size: .xlarge,
        prefixContent: { length, color in
          BezierIcon.ios.image
            .frame(width: length, height: length)
            .foregroundColor(color.color)
        },
        suffixContent: { length, color in
          BezierIcon.android.image
            .frame(width: length, height: length)
            .foregroundColor(color.color)
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
