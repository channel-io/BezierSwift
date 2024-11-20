//
//  BezierSwitch.swift
//  BezierSwift
//
//  Created by 구본욱 on 10/23/24.
//

import SwiftUI

private enum Metric {
  static let backgroundMinHeight: CGFloat = 40
}

public struct BezierSwitch: View {
  let label: String
  let isOn: Binding<Bool>

  public init(
    label: String,
    isOn: Binding<Bool>
  ) {
    self.label = label
    self.isOn = isOn
  }

  public var body: some View {
    HStack(alignment: .top) {
      Text(self.label)
        .applyBezierFontStyle(.caption1Regular, bezierColor: .fgBlackDarkest)
        .frame(minHeight: 40)
        .padding(.leading, 12)

      BezierSwitchControl(isOn: self.isOn)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
    .compositingGroup()
  }
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @State var isOn: Bool = false
  BezierSwitch(label: "Hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world", isOn: $isOn)
}
