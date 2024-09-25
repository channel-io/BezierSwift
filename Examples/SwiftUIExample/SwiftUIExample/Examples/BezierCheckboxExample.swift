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
        label: "Hello",
        color: .blue,
        checked: .indeterminate,
        showRequired: true
      ) {
        BezierSecondaryCheckbox(
          label: "Secondary",
          color: .blue,
          checked: false
        )
      }
      BezierPrimaryCheckbox(
        label: "Hello",
        color: .green,
        checked: .indeterminate,
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
