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

/// 최소 1가지 이상의 옵션을 선택 또는 해제할 수 있는 컨트롤 컴포넌트로, 일반적으로 사용하는 체크박스 아이템입니다.
// MARK: - BezierPrimaryCheckbox
public struct BezierPrimaryCheckbox<Nested>: View where Nested: View {
  public typealias Color = BezierCheckboxColor
  public typealias Checked = BezierCheckboxChecked
  public typealias NestedBuilder = () -> Nested

  @Environment(\.isEnabled) var isEnabled

  // TODO: - Min Target을 iOS 15 이상으로 올린 이후에 AttributedString을 적용해 링크 텍스트를 넣을수 있도록 합니다 - by Finn 2024.08.21
  private let label: String?
  private let color: Color
  private let checked: Checked
  private let showRequired: Bool
  private let nestedBuilder: NestedBuilder
  
  /// Nested가 존재하는 체크박스를 생성합니다.
  /// - Parameters:
  ///   - label: 체크박스에 함께 표기될 텍스트를 지정합니다.
  ///   - color: 체크박스 소스가 표기될 색상을 지정합니다. blue와 green을 지정할 수 있습니다.
  ///   - checked: 체크박스의 체크 상태를 지정합니다. checked, unchecked, indeterminate를 지정할 수 있습니다.
  ///   - showRequired: * 표시(Asterisk)를 사용해서 필수 항목임을 표현할지 지정합니다.
  ///   - nestedBuilder: 체크박스의 하위 영역에 표시될 내용을 지정하는 뷰를 생성합니다.
  public init(
    label: String?,
    color: Color,
    checked: Checked,
    showRequired: Bool,
    @ViewBuilder nestedBuilder: @escaping NestedBuilder
  ) {
    self.label = label
    self.color = color
    self.checked = checked
    self.showRequired = showRequired
    self.nestedBuilder = nestedBuilder
  }

  /// Nested가 없는 체크박스를 생성합니다.
  /// - Parameters:
  ///   - label: 체크박스에 함께 표기될 텍스트를 지정합니다.
  ///   - color: 체크박스 소스가 표기될 색상을 지정합니다. blue와 green을 지정할 수 있습니다.
  ///   - checked: 체크박스의 체크 상태를 지정합니다. checked, unchecked, indeterminate를 지정할 수 있습니다.
  ///   - showRequired: * 표시(Asterisk)를 사용해서 필수 항목임을 표현할지 지정합니다.
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

      VStack(alignment: .leading, spacing: 0) {
        self.nestedBuilder()
      }.padding(.leading, Metric.minHeight)
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
      return self.isEnabled ? .bgWhiteNormal : .bgBlackDark
    }
  }

  private var sourceNeedStroke: Bool {
    return self.checked == .unchecked && self.isEnabled
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
