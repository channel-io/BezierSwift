//
//  BezierFloatingButtonStyle.swift
//  
//
//  Created by Tom on 8/18/24.
//

import SwiftUI

struct BezierFloatingButtonStyle: ButtonStyle {
  let backgroundColor: BezierColor
  
  init(backgroundColor: BezierColor) {
    self.backgroundColor = backgroundColor
  }
  
  // TODO: Pressed Color 논의가 끝나지 않은 상태라 이번 PR에서 제외합니다. by Tom 2024.08.02
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        Capsule(style: .circular)
          .foregroundColor(
            configuration.isPressed ? self.backgroundColor.color: self.backgroundColor.color
          )
      )
      .applyBezierShadow(.shadow2)
  }
}
