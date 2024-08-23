//
//  BezierCheckboxSource.swift
//
//
//  Created by 구본욱 on 8/16/24.
//

import SwiftUI

struct BezierCheckboxSource: View {
  let configuration: BezierCheckboxSourceConfiguration

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
