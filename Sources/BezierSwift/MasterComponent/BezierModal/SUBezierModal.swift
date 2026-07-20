//
//  SUBezierModal.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierModal<Content: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let content: Content

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    VStack(spacing: 0) {
      self.content
        .frame(maxWidth: .infinity, minHeight: BezierModalSpec.contentMinHeight)
    }
    .padding(.top, BezierModalSpec.topPadding)
    .padding(.bottom, BezierModalSpec.bottomPadding)
    .padding(.horizontal, BezierModalSpec.horizontalPadding)
    .frame(width: BezierModalSpec.width)
    .background(self.palette(BezierModalSpec.backgroundToken))
    .applyBezierCornerRadius(type: BezierModalSpec.cornerRadius)
    .applyBezierElevation(BezierModalSpec.elevation)
  }
}

struct SUBezierModal_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
      SUBezierModal {
        Text("Custom Content")
          .frame(height: 184)
      }
    }
  }
}
