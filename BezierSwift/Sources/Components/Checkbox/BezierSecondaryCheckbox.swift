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
  public typealias Configuration = BezierSecondaryCheckboxConfiguration

  private let configuration: Configuration

  public init(configuration: Configuration) {
    self.configuration = configuration
  }

  public var body: some View {
    HStack(alignment: .top, spacing: 0) {
      ZStack(alignment: .center) {
        BezierCheckboxSource(configuration: self.configuration)
      }
      .frame(length: Metric.minHeight)

      Text(self.configuration.label ?? "")
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

#Preview {
  BezierSecondaryCheckbox(
    configuration: .init(
      label: "hello",
      color: .green,
      checked: true
    )
  )
}
