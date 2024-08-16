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

      HStack(alignment: .bottom, spacing: 0) {
        Text(self.configuration.label ?? "")
          .font(BezierFont.caption1Regular.font)
          .lineLimit(nil)

        Spacer()

        ZStack(alignment: .bottom) {
          if self.configuration.showRequiredAsterisk {
            Text("*")
              .font(BezierFont.caption1Regular.font)
              .foregroundColor(BezierColor.fgRedNormal.color)
          }
        }
        .frame(width: 12)
      }
      .padding(.vertical, self.configuration.labelTop)
    }
    .frame(minHeight: self.configuration.minHeight)
    .compositingGroup()
  }
}

#Preview {
  VStack {
    BezierCheckbox(
      configuration: .primary(
        label: "Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox",
        checked: .checked,
        color: .blue,
        disabled: false,
        showRequiredAsterisk: true
      )
    )
    BezierCheckbox(
      configuration: .primary(
        label: "Bezier Checkbox",
        checked: .unchecked,
        color: .blue,
        disabled: false,
        showRequiredAsterisk: true
      )
    )
    BezierCheckbox(
      configuration: .secondary(
        label: "Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox Bezier Checkbox",
        isChecked: true,
        color: .blue,
        showRequiredAsterisk: true
      )
    )
    BezierCheckbox(
      configuration: .secondary(
        label: "Bezier Checkbox",
        isChecked: false,
        color: .blue,
        showRequiredAsterisk: true
      )
    )
  }
  .padding(.horizontal, 20)
}
