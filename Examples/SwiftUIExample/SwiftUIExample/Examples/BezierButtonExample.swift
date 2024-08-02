//
//  BezierButtonExample.swift
//  SwiftUIExample
//
//  Created by Tom on 7/10/24.
//

import SwiftUI

import BezierSwift

struct BezierButtonExample: View {
  @State private var text: String = "BezierButton"
  @State private var variant: BezierButtonConfiguration.Variant = .secondary
  @State private var color: BezierButtonConfiguration.Color = .blue
  @State private var size: BezierButtonConfiguration.Size = .medium
  
  var body: some View {
    VStack {
      BezierButton(
        configuration: BezierButtonConfiguration(
          text: self.text,
          variant: self.variant,
          color: self.color,
          size: self.size
        ),
        prefixContent: BezierIconView(bezierIcon: .ai),
        suffixContent: BezierIconView(bezierIcon: .ai)
      ) {
        
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
