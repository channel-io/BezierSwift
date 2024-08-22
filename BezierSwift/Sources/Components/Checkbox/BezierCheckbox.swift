//
//  BezierCheckbox.swift
//
//
//  Created by 구본욱 on 8/16/24.
//

import SwiftUI

public struct BezierCheckbox: View {
  let configuration: BezierCheckboxConfiguration

  public var body: some View {
    HStack(alignment: .top, spacing: 0) {
      Spacer()
        .frame(width: self.configuration.indent)

      ZStack(alignment: .center) {
        BezierCheckboxSource(configuration: self.configuration)
      }
      .frame(length: self.configuration.minHeight)

      VStack(spacing: 0) {
        HStack(alignment: .bottom, spacing: 0) {
          Text(self.configuration.label ?? "")
            .font(BezierFont.caption1Regular.font)
            .lineLimit(nil)

          Spacer()

          ZStack(alignment: .bottom) {
            if self.configuration.showRequired {
              Text("*")
                .font(BezierFont.caption1Regular.font)
                .foregroundColor(BezierColor.fgRedNormal.color)
            }
          }
          .frame(width: 12)
        }
        .padding(.vertical, self.configuration.labelTop)
      }
    }
    .frame(minHeight: self.configuration.minHeight)
    .compositingGroup()
    .applyDisabledStyle()
  }
}

#Preview {
  VStack {
    BezierCheckbox(
      configuration: .primary(
        label: "안녕",
        checked: .indeterminate,
        color: .blue,
        nested: .vertical
      )
    )
  }
  .padding(.horizontal, 20)
}
