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
  @State private var variant: BezierButtonConfiguration.Variant = .primary
  @State private var color: BezierButtonConfiguration.Color = .blue
  @State private var size: BezierButtonConfiguration.Size = .medium
  @State private var prefixContent: BezierButtonConfiguration.PrefixContent? = nil
  @State private var suffixContent: BezierButtonConfiguration.SuffixContent? = nil
  
  var body: some View {
    VStack {
      BezierButton(
        configuration: BezierButtonConfiguration(
          text: self.text,
          variant: self.variant,
          color: self.color,
          size: self.size,
          prefixContent: self.prefixContent,
          suffixContent: self.suffixContent
        )
      ) {
        
      }
      .fixedSize()
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
