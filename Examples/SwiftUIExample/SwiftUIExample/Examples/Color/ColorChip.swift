//
//  ColorChip.swift
//  SwiftUIExample
//
//  Created by Tom on 11/14/24.
//

import SwiftUI

@_spi(Private) import BezierSwift

struct ColorChip: View {
  private let title: String
  private var bezierColor: BezierColor
  @State private var isPressed: Bool = false
  
  init(title: String, _ bezierColor: BezierColor) {
    self.title = title
    self.bezierColor = bezierColor
  }
  
  var body: some View {
    HStack(spacing: 16) {
      Button {
        
      } label: {
        Color.clear
          .contentShape(Rectangle())
      }
      .buttonStyle(ColorChipStyle(backgroundColor: self.bezierColor))
      .frame(width: 100, height: 100)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(self.title)
          .applyBezierFontStyle(.title3Bold, bezierColor: .fgBlackDarker)
        
        Text("Light Color Token: " + self.bezierColor.darkColorTokenHex)
          .applyBezierFontStyle(.body1Regular, bezierColor: .fgBlackDarker)
        
        Text("Dark Color Token: " + self.bezierColor.darkColorTokenHex)
          .applyBezierFontStyle(.body1Regular, bezierColor: .fgBlackDarker)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      .padding(.top, 8)
    }
  }
}

struct ColorChipStyle: ButtonStyle {
  let backgroundColor: BezierColor
  
  init(backgroundColor: BezierColor) {
    self.backgroundColor = backgroundColor
  }
  
  // TODO: Pressed Color 논의가 끝나지 않은 상태라 이번 PR에서 제외합니다. by Tom 2024.08.02
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(
        RoundedRectangle(cornerRadius: 16, style: .circular)
          .foregroundColor(
            configuration.isPressed ? self.backgroundColor.pressedColor : self.backgroundColor.color
          )
      )
  }
}
