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
        text: "BezierButton",
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
