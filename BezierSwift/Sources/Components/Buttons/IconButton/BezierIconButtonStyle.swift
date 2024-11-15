//
//  BezierIconButtonStyle.swift
//
//
//  Created by Tom on 8/16/24.
//

import SwiftUI

struct BezierIconButtonStyle<Content: View>: ButtonStyle {
  let shape: BezierIconButton<Content>.Shape
  let cornerRadius: CGFloat
  let backgroundColor: BezierColor
  
  init(shape: BezierIconButton<Content>.Shape, cornerRadius: CGFloat, backgroundColor: BezierColor) {
    self.shape = shape
    self.cornerRadius = cornerRadius
    self.backgroundColor = backgroundColor
  }
  
  // TODO: Pressed Color 논의가 끝나지 않은 상태라 이번 PR에서 제외합니다. by Tom 2024.08.02
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        Group {
          switch self.shape {
          case .circle:
            Capsule(style: .circular)
          case .rectangle:
            RoundedRectangle(cornerRadius: self.cornerRadius, style: .circular)
          }
        }
          .foregroundColor(
            configuration.isPressed ? self.backgroundColor.pressedColor: self.backgroundColor.color
          )
      )
  }
}
