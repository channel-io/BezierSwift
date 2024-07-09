//
//  DisabledStyle.swift
//
//
//  Created by Tom on 7/4/24.
//

import SwiftUI

private enum Constant {
  static let disabledOpacity = CGFloat(0.4)
  static let enabledOpacity = CGFloat(1.0)
}

extension View {
  public func applyDisabledStyle() -> some View {
    DisabledStyle(content: self)
  }
}

private struct DisabledStyle<Content: View>: View {
  @Environment(\.isEnabled) var isEnabled

  let content: Content

  var body: some View {
    self.content
      .compositingGroup()
      .opacity(self.isEnabled ? Constant.enabledOpacity : Constant.disabledOpacity)
  }
}
