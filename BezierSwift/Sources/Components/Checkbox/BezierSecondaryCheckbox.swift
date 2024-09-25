//
//  BezierSecondaryCheckbox.swift
//
//
//  Created by 구본욱 on 8/23/24.
//

import SwiftUI

// MARK: - Metric
private enum Metric {
  static let minHeight: CGFloat = 36
  static let labelTop: CGFloat = 9
}

// MARK: - BezierSecondaryCheckbox
public struct BezierSecondaryCheckbox: View {
  public typealias Color = BezierCheckboxColor

  private let label: String?
  private let color: Color
  private let checked: Bool

  public init(label: String?, color: Color, checked: Bool) {
    self.label = label
    self.color = color
    self.checked = checked
  }

  public var body: some View {
    HStack(alignment: .top, spacing: 0) {
      ZStack(alignment: .center) {
        BezierCheckboxSource(
          needStroke: false,
          icon: .checkBold,
          strokeColor: .bgWhiteAlphaTransparent,
          backgroundColor: .bgWhiteAlphaTransparent,
          iconColor: self.sourceIconColor
        )
      }
      .frame(length: Metric.minHeight)

      Text(self.label ?? "")
        .font(BezierFont.caption1Regular.font)
        .lineLimit(nil)
        .padding(.vertical, Metric.labelTop)

      Spacer()
    }
    .frame(minHeight: Metric.minHeight)
    .compositingGroup()
    .applyDisabledStyle()
  }
}

extension BezierSecondaryCheckbox {
  private var sourceIconColor: BezierColor {
    if self.checked {
      return self.color == .blue ? .primaryBgNormal : .fgGreenNormal
    } else {
      return .fgBlackDark
    }
  }
}

#Preview {
  BezierSecondaryCheckbox(
    label: "hello",
    color: .green,
    checked: true
  )
}
