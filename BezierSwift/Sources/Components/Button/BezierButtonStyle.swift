//
//  BezierButtonStyle.swift
//
//
//  Created by Tom on 6/28/24.
//

import SwiftUI

struct BezierButtonStyle: ButtonStyle {
  let configuration: BezierButtonConfiguration
  
  init(configuration: BezierButtonConfiguration) {
    self.configuration = configuration
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        RoundedRectangle(cornerRadius: self.configuration.cornerRadius, style: .circular)
          .foregroundColor(
            configuration.isPressed ? self.configuration.backgroundColor.color: self.configuration.backgroundColor.color
          )
      )
  }
}
