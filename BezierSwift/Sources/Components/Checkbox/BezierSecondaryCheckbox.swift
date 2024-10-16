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

/// 최소 1가지 이상의 옵션을 선택 또는 해제할 수 있는 컨트롤 컴포넌트입니다. 위계상 primary 에 속할 때만 사용해야하며 단독으로 사용할 수 없고, Indent 되어 표시됩니다.
// MARK: - BezierSecondaryCheckbox
public struct BezierSecondaryCheckbox: View {
  public typealias Color = BezierCheckboxColor

  private let label: AttributedString?
  private let color: Color
  private let checked: Bool
  
  /// BezierPrimaryCheckbox의 하위(Nested)에 추가될 수 있는 서브 체크박스를 생성합니다.
  /// - Parameters:
  ///   - label: 체크박스에 함께 표기될 텍스트를 지정합니다.
  ///   - color: 체크박스 소스가 표기될 색상을 지정합니다. blue와 green을 지정할 수 있습니다.
  ///   - checked: 체크박스의 체크 상태를 지정합니다.
  public init(label: String?, color: Color, checked: Bool) {
    if let label {
      self.label = AttributedString(label)
    } else {
      self.label = nil
    }
    self.color = color
    self.checked = checked
  }
  
  /// BezierPrimaryCheckbox의 하위(Nested)에 추가될 수 있는 서브 체크박스를 생성합니다.
  /// - Parameters:
  ///   - label: 체크박스에 함께 표기될 AttributedString를 지정합니다.
  ///   - color: 체크박스 소스가 표기될 색상을 지정합니다. blue와 green을 지정할 수 있습니다.
  ///   - checked: 체크박스의 체크 상태를 지정합니다.
  public init(label: AttributedString?, color: Color, checked: Bool) {
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
