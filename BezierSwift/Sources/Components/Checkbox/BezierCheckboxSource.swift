//
//  BezierCheckboxSource.swift
//
//
//  Created by 구본욱 on 8/16/24.
//

import SwiftUI

struct BezierCheckboxSource: View {
  let configuration: BezierCheckboxConfiguration

  var body: some View {
    ZStack(alignment: .center) {
      if self.configuration.needStroke {
        Circle()
          .fill(self.configuration.strokeColor.color)
      }

      Circle()
        .fill(self.configuration.backgroundColor.color)
        .if(self.configuration.needStroke) {
          $0.padding(.all, 2)
        }

      self.configuration.icon?.image
        .frame(length: 16)
        .foregroundColor(self.configuration.iconColor.color)
    }
    .frame(length: 20)
    .padding(.all, 2)
    .compositingGroup()
    .opacity(self.configuration.opacity)
  }
}

#Preview {
  HStack {
    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(checked: .unchecked, color: .green, disabled: false))
        BezierCheckboxSource(configuration: .primary(checked: .checked, color: .green, disabled: false))
        BezierCheckboxSource(configuration: .primary(checked: .indeterminate, color: .green, disabled: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(checked: .unchecked, color: .green, disabled: true))
        BezierCheckboxSource(configuration: .primary(checked: .checked, color: .green, disabled: true))
        BezierCheckboxSource(configuration: .primary(checked: .indeterminate, color: .green, disabled: true))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(isChecked: true, color: .green))
        BezierCheckboxSource(configuration: .secondary(isChecked: false, color: .green))
        BezierCheckboxSource(configuration: .secondary(isChecked: false, color: .green)).opacity(0)
      }
    }

    Spacer().frame(width: 30)

    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(checked: .unchecked, color: .blue, disabled: false))
        BezierCheckboxSource(configuration: .primary(checked: .checked, color: .blue, disabled: false))
        BezierCheckboxSource(configuration: .primary(checked: .indeterminate, color: .blue, disabled: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(checked: .unchecked, color: .blue, disabled: true))
        BezierCheckboxSource(configuration: .primary(checked: .checked, color: .blue, disabled: true))
        BezierCheckboxSource(configuration: .primary(checked: .indeterminate, color: .blue, disabled: true))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(isChecked: true, color: .blue))
        BezierCheckboxSource(configuration: .secondary(isChecked: false, color: .blue))
        BezierCheckboxSource(configuration: .secondary(isChecked: false, color: .blue)).opacity(0)
      }
    }
  }
}
