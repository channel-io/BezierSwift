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
        variant: .primary,
        color: .blue,
        size: .xlarge,
        shape: .rectangle,
        content: { length, color in
          BezierIcon.ios.image
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
  BezierIconButtonExample()
}
