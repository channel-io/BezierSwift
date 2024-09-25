//
//  BezierCheckboxExample.swift
//  SwiftUIExample
//
//  Created by 구본욱 on 9/25/24.
//

import SwiftUI

import BezierSwift

struct BezierCheckboxExample: View {
  var body: some View {
    VStack {
      BezierPrimaryCheckbox(
        label: "Blue Has Nested Indeterminate",
        color: .blue,
        checked: .indeterminate,
        showRequired: true
      ) {
        VStack {
          BezierSecondaryCheckbox(
            label: "Secondary",
            color: .blue,
            checked: false
          )
          BezierSecondaryCheckbox(
            label: "Secondary",
            color: .green,
            checked: true
          )
        }
      }
      BezierPrimaryCheckbox(
        label: "Green No Nested Indeterminate",
        color: .green,
        checked: .indeterminate,
        showRequired: true
      )
      BezierPrimaryCheckbox(
        label: "Blue No Nested Checked",
        color: .blue,
        checked: .checked,
        showRequired: false
      )
      BezierPrimaryCheckbox(
        label: "Green No Nested Unchecked",
        color: .green,
        checked: .unchecked,
        showRequired: true
      )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      BezierColor.bgWhiteNormal.color
        .ignoresSafeArea()
    )

  }
}

#Preview {
  BezierCheckboxExample()
}
