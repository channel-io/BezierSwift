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
      if self.configuration.sourceNeedStroke {
        Circle()
          .fill(self.configuration.sourceStrokeColor.color)
      }

      Circle()
        .fill(self.configuration.sourceBackgroundColor.color)
        .if(self.configuration.sourceNeedStroke) {
          $0.padding(.all, 2)
        }

      self.configuration.sourceIcon?.image
        .frame(length: 16)
        .foregroundColor(self.configuration.sourceIconColor.color)
    }
    .frame(length: 20)
    .padding(.all, 2)
    .compositingGroup()
    .opacity(self.configuration.sourceOpacity)
  }
}

#Preview {
  HStack {
    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .green, disabled: false, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .green, disabled: false, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .green, disabled: false, showRequiredAsterisk: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .green, disabled: true, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .green, disabled: true, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .green, disabled: true, showRequiredAsterisk: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: true, color: .green, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .green, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .green, showRequiredAsterisk: false)).opacity(0)
      }
    }

    Spacer().frame(width: 30)

    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .blue, disabled: false, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .blue, disabled: false, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .blue, disabled: false, showRequiredAsterisk: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .blue, disabled: true, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .blue, disabled: true, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .blue, disabled: true, showRequiredAsterisk: false))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: true, color: .blue, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .blue, showRequiredAsterisk: false))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .blue, showRequiredAsterisk: false)).opacity(0)
      }
    }
  }
}
