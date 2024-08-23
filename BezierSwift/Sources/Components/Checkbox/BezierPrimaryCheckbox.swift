//
//  BezierPrimaryCheckbox.swift
//
//
//  Created by 구본욱 on 8/23/24.
//

import SwiftUI

// MARK: - Metric
private enum Metric {
  static let minHeight: CGFloat = 40
  static let labelTop: CGFloat = 11
}

// MARK: - BezierPrimaryCheckbox
public struct BezierPrimaryCheckbox<Nested: View>: View {
  public typealias Configuration = BezierPrimaryCheckboxConfiguration
  public typealias NestedBuilder = (Configuration) -> Nested

  private let configuration: Configuration
  private let nestedBuilder: NestedBuilder

  public init(configuration: Configuration, nestedBuilder: @escaping NestedBuilder) {
    self.configuration = configuration
    self.nestedBuilder = nestedBuilder
  }

  public init(configuration: Configuration) where Nested == EmptyView {
    self.configuration = configuration
    self.nestedBuilder = { _ in EmptyView() }
  }

  public var body: some View {
    VStack(spacing: 0) {
      HStack(alignment: .top, spacing: 0) {
        ZStack(alignment: .center) {
          BezierCheckboxSource(configuration: self.configuration)
        }
        .frame(length: Metric.minHeight)

        HStack(alignment: .center, spacing: 0) {
          Text(self.configuration.label ?? "")
            .font(BezierFont.caption1Regular.font)
            .lineLimit(nil)

          if self.configuration.showRequired {
            Text("*")
              .font(BezierFont.caption1Regular.font)
              .foregroundColor(BezierColor.fgRedNormal.color)
          }

          Spacer()
        }
        .padding(.vertical, Metric.labelTop)
      }

      self.nestedBuilder(self.configuration)
        .padding(.leading, Metric.minHeight)
    }
    .frame(minHeight: Metric.minHeight)
    .compositingGroup()
    .applyDisabledStyle()
  }
}

#Preview {
  VStack {
    BezierPrimaryCheckbox(
      configuration: .init(
        label: "Hello",
        color: .blue,
        checked: .indeterminate,
        showRequired: true
      )
    ) { _ in
      BezierSecondaryCheckbox(
        configuration: .init(
          label: "Secondary",
          color: .blue,
          checked: false
        )
      )
    }

    BezierPrimaryCheckbox(
      configuration: .init(
        label: "Hello",
        color: .green,
        checked: .indeterminate,
        showRequired: true
      )
    )
  }
  .padding(.horizontal, 20)
}
