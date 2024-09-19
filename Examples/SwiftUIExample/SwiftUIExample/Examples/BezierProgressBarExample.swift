//
//  BezierProgressBarExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/17/24.
//

import SwiftUI

import BezierSwift

struct BezierProgressBarExample: View {
  @State var progress: CGFloat = 0
  
  var body: some View {
    BezierProgressBar(progress: self.progress, size: .medium, variant: .primary)
      .onTapGesture {
        self.progress += 0.3
      }
  }
}

#Preview {
  BezierProgressBarExample()
}
