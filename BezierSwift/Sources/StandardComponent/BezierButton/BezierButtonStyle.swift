//
//  BezierButtonStyle.swift
//
//
//  Created by Tom on 6/28/24.
//

import SwiftUI

struct BezierButtonStyle: ButtonStyle, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  
  let configuration: BezierButtonConfiguration
  
  init(configuration: BezierButtonConfiguration) {
    self.configuration = configuration
  }
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        RoundedRectangle(cornerRadius: self.configuration.cornerRadius, style: .circular)
          .foregroundColor(
            self.palette(configuration.isPressed ? self.configuration.backgroundColor: .bgRedDark)
          )
      )
  }
}
