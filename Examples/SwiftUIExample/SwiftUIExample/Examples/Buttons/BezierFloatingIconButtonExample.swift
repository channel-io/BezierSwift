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
        variant: .primary,
        color: .blue,
        size: .xlarge,
        content: { length, color in
          BezierIcon.ios.image
            .frame(width: length, height: length)
            .foregroundColor(color.color)
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
