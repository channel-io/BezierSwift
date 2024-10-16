//
//  BezierCheckboxSource.swift
//
//
//  Created by 구본욱 on 8/16/24.
//

import SwiftUI

struct BezierCheckboxSource: View {
  private let needStroke: Bool
  private let icon: BezierIcon?
  private let strokeColor: BezierColor
  private let backgroundColor: BezierColor
  private let iconColor: BezierColor

  init(
    needStroke: Bool,
    icon: BezierIcon?,
    strokeColor: BezierColor,
    backgroundColor: BezierColor,
    iconColor: BezierColor
  ) {
    self.needStroke = needStroke
    self.icon = icon
    self.strokeColor = strokeColor
    self.backgroundColor = backgroundColor
    self.iconColor = iconColor
  }

  var body: some View {
    ZStack {
      Circle()
        .fill(self.backgroundColor.color)
        .applyBezierBorder(
          shape: Circle(),
          style: self.strokeColor.color,
          lineWidth: 2,
          alignment: .inner
        )

      self.icon?.image
        .frame(length: 16)
        .foregroundColor(self.iconColor.color)
    }
    .frame(length: 20)
    .padding(.all, 2)
    .compositingGroup()
  }
}
