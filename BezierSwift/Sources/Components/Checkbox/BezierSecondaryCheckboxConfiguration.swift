//
//  BezierSecondaryCheckboxConfiguration.swift
//
//
//  Created by 구본욱 on 8/23/24.
//

import Foundation

// MARK: - BezierSecondaryCheckboxConfiguration
public struct BezierSecondaryCheckboxConfiguration: Equatable {
  public typealias Color = BezierCheckboxColor

  let label: String?
  let color: Color
  let checked: Bool

  init(
    label: String?,
    color: Color,
    checked: Bool
  ) {
    self.label = label
    self.color = color
    self.checked = checked
  }
}

// MARK: - BezierCheckboxConfiguration
extension BezierSecondaryCheckboxConfiguration: BezierCheckboxConfiguration {
  public var variant: BezierCheckboxVariant { .secondary }
}

// MARK: - BezierCheckboxSourceConfiguration
extension BezierSecondaryCheckboxConfiguration: BezierCheckboxSourceConfiguration {
  var sourceBackgroundColor: BezierColor { .bgWhiteAlphaTransparent }

  var sourceNeedStroke: Bool { false }

  var sourceStrokeColor: BezierColor { .bgWhiteAlphaTransparent }

  var sourceIcon: BezierIcon? { .checkBold }

  var sourceIconColor: BezierColor {
    if self.checked {
      return self.color == .blue ? .primaryBgNormal : .fgGreenNormal
    } else {
      return .fgBlackDark
    }
  }
}
