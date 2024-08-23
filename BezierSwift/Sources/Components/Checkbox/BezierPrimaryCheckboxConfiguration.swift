//
//  BezierPrimaryCheckboxConfiguration.swift
//
//
//  Created by 구본욱 on 8/23/24.
//

import Foundation

// MARK: - BezierPrimaryCheckboxConfiguration
public struct BezierPrimaryCheckboxConfiguration: Equatable {
  public typealias Color = BezierCheckboxColor
  public typealias Checked = BezierCheckboxChecked

  // MARK: Properties
  // TODO: - Min Target을 iOS 15 이상으로 올린 이후에 AttributedString을 적용해 링크 텍스트를 넣을수 있도록 합니다 - by Finn 2024.08.21
  let label: String?
  let color: Color
  let checked: Checked
  let showRequired: Bool

  init(
    label: String?,
    color: Color,
    checked: Checked,
    showRequired: Bool
  ) {
    self.label = label
    self.color = color
    self.checked = checked
    self.showRequired = showRequired
  }
}

// MARK: - BezierCheckboxConfiguration
extension BezierPrimaryCheckboxConfiguration: BezierCheckboxConfiguration {
  public var variant: BezierCheckboxVariant { .primary }
}

// MARK: - BezierCheckboxSourceConfiguration
extension BezierPrimaryCheckboxConfiguration: BezierCheckboxSourceConfiguration {
  var sourceBackgroundColor: BezierColor {
    switch self.checked {
    case .checked, .indeterminate:
      return self.color == .blue ? .primaryBgNormal : .bgGreenNormal
    case .unchecked:
      return .bgWhiteNormal
    }
  }

  var sourceNeedStroke: Bool {
    return self.checked == .unchecked
  }

  var sourceStrokeColor: BezierColor {
    guard self.sourceNeedStroke else { return .bgWhiteAlphaTransparent }

    return .bgBlackDark
  }

  var sourceIcon: BezierIcon? {
    switch self.checked {
    case .checked:
      return .checkBold
    case .unchecked:
      return nil
    case .indeterminate:
      return .hyphenBold
    }
  }

  var sourceIconColor: BezierColor {
    return self.checked == .unchecked ? .bgWhiteAlphaTransparent : .fgAbsoluteWhiteDark
  }
}
