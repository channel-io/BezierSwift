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
  public typealias Color = BezierCheckboxColor
  public typealias Checked = BezierCheckboxChecked
  public typealias NestedBuilder = () -> Nested

  // TODO: - Min Target을 iOS 15 이상으로 올린 이후에 AttributedString을 적용해 링크 텍스트를 넣을수 있도록 합니다 - by Finn 2024.08.21
  private let label: String?
  private let color: Color
  private let checked: Checked
  private let showRequired: Bool
  private let nestedBuilder: NestedBuilder

  public init(
    label: String?,
    color: Color,
    checked: Checked,
    showRequired: Bool,
    nestedBuilder: @escaping NestedBuilder
  ) {
    self.label = label
    self.color = color
    self.checked = checked
    self.showRequired = showRequired
    self.nestedBuilder = nestedBuilder
  }

  public init(
    label: String?,
    color: Color,
    checked: Checked,
    showRequired: Bool
  ) where Nested == EmptyView {
    self.label = label
    self.color = color
    self.checked = checked
    self.showRequired = showRequired
    self.nestedBuilder = { EmptyView() }
  }

  public var body: some View {
    VStack(spacing: 0) {
      HStack(alignment: .top, spacing: 0) {
        ZStack(alignment: .center) {
          BezierCheckboxSource(
            needStroke: self.sourceNeedStroke,
            icon: self.sourceIcon,
            strokeColor: self.sourceStrokeColor,
            backgroundColor: self.sourceBackgroundColor,
            iconColor: self.sourceIconColor
          )
        }
        .frame(length: Metric.minHeight)

        HStack(alignment: .center, spacing: 0) {
          Text(self.label ?? "")
            .font(BezierFont.caption1Regular.font)
            .lineLimit(nil)

          if self.showRequired {
            Text("*")
              .font(BezierFont.caption1Regular.font)
              .foregroundColor(BezierColor.fgRedNormal.color)
          }

          Spacer()
        }
        .padding(.vertical, Metric.labelTop)
      }

      self.nestedBuilder()
        .padding(.leading, Metric.minHeight)
    }
    .frame(minHeight: Metric.minHeight)
    .compositingGroup()
    .applyDisabledStyle()
  }
}

extension BezierPrimaryCheckbox {
  private var sourceBackgroundColor: BezierColor {
    switch self.checked {
    case .checked, .indeterminate:
      return self.color == .blue ? .primaryBgNormal : .bgGreenNormal
    case .unchecked:
      return .bgWhiteNormal
    }
  }

  private var sourceNeedStroke: Bool {
    return self.checked == .unchecked
  }

  private var sourceStrokeColor: BezierColor {
    guard self.sourceNeedStroke else { return .bgWhiteAlphaTransparent }

    return .bgBlackDark
  }

  private var sourceIcon: BezierIcon? {
    switch self.checked {
    case .checked:
      return .checkBold
    case .unchecked:
      return nil
    case .indeterminate:
      return .hyphenBold
    }
  }

  private var sourceIconColor: BezierColor {
    return self.checked == .unchecked ? .bgWhiteAlphaTransparent : .fgAbsoluteWhiteDark
  }
}

#Preview {
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
  .padding(.horizontal, 20)
}
