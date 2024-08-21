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
  }
}

#Preview {
  HStack {
    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .green))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .green))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .green))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .green))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .green))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .green))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: true, color: .green))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .green))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .green)).opacity(0)
      }
    }

    Spacer().frame(width: 30)

    VStack {
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .blue))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .blue))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .blue))
      }
      HStack {
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .unchecked, color: .blue))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .checked, color: .blue))
        BezierCheckboxSource(configuration: .primary(label: nil, checked: .indeterminate, color: .blue))
      }
      HStack {
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: true, color: .blue))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .blue))
        BezierCheckboxSource(configuration: .secondary(label: nil, isChecked: false, color: .blue)).opacity(0)
      }
    }
  }
}
