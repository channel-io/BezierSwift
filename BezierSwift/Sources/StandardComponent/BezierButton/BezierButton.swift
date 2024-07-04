//
//  BezierButton.swift
//
//
//  Created by Tom on 6/28/24.
//


import SwiftUI

public struct BezierButton: View {
  private let configuration: BezierButtonConfiguration
  let action: () -> Void
  
  public init(
    configuration: BezierButtonConfiguration,
    action: @escaping () -> Void
  ) {
    self.configuration = configuration
    self.action = action
  }

  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: self.configuration.horizontalSpacing) {
        switch self.configuration.prefixContent {
        case .icon(let bezierIcon):
          bezierIcon.image
            .frame(
              width: self.configuration.affixContentSize.width,
              height: self.configuration.affixContentSize.height
            )
            .foregroundColor(self.configuration.affixContentForegroundColor.color)
        case .none: EmptyView()
        }
        
        Text(self.configuration.text)
          .applyBezierFontStyle(self.configuration.textFont, bezierColor: self.configuration.textColor)
        
        switch self.configuration.suffixContent {
        case .icon(let bezierIcon):
          bezierIcon.image
            .frame(
              width: self.configuration.affixContentSize.width,
              height: self.configuration.affixContentSize.height
            )
            .foregroundColor(self.configuration.affixContentForegroundColor.color)
        case .none: EmptyView()
        }
      }
      .padding(.horizontal, self.configuration.horizontalPadding)
      .frame(height: self.configuration.height)
    }
    .buttonStyle(BezierButtonStyle(configuration: self.configuration))
    .applyDisabledStyle()
  }
}

#Preview {
  BezierButton(
    configuration: BezierButtonConfiguration(
      text: "Test",
      variant: .primary,
      color: .blue,
      size: .xsmall,
      prefixContent: .icon(.plus),
      suffixContent: .icon(.arrowRight)
    )
  ) {
    
  }
}
