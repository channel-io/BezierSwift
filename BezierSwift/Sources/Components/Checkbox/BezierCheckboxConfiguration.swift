//
//  File.swift
//  
//
//  Created by 구본욱 on 8/16/24.
//

import Foundation

// MARK: - BezierCheckboxConfiguration
public struct BezierCheckboxConfiguration: Equatable {
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
  }

  // MARK: Color
  public enum Color {
    case blue
    case green
  }

  // MARK: Checked
  public enum Checked {
    case checked
    case unchecked
    case indeterminate
  }

  // MARK: Properties
  let checked: Checked
  let variant: Variant
  let color: Color
  let disabled: Bool

  var opacity: CGFloat {
    guard self.disabled, self.checked != .unchecked else { return 1 }

    return 0.4
  }

  var backgroundColor: BezierColor {
    // secondary일 때는 배경이 없음
    guard self.variant == .primary else { return .bgWhiteAlphaTransparent }

    switch self.checked {
    case .checked, .indeterminate:
      return self.color == .blue ? .primaryBgNormal : .bgGreenNormal
    case .unchecked:
      return self.disabled ? .bgBlackDark : .bgWhiteNormal
    }
  }

  var needStroke: Bool {
    guard self.variant == .primary, self.checked == .unchecked, !self.disabled else {
      return false
    }

    return true
  }

  var strokeColor: BezierColor {
    guard self.needStroke else { return .bgWhiteAlphaTransparent }

    return .bgBlackDark
  }

  var icon: BezierIcon? {
    guard self.variant == .primary else { return .checkBold }

    switch self.checked {
    case .checked:
      return .checkBold
    case .unchecked:
      return nil
    case .indeterminate:
      return .hyphenBold
    }
  }

  var iconColor: BezierColor {
    guard self.variant == .secondary else {
      return self.checked == .unchecked ? .bgWhiteAlphaTransparent : .fgAbsoluteWhiteDark
    }

    switch self.checked {
    case .checked:
      return self.color == .blue ? .primaryBgNormal : .fgGreenNormal
    case .unchecked:
      return .fgBlackDark
    case .indeterminate:
      return .bgWhiteAlphaTransparent
    }
  }

  init(variant: Variant, color: Color, checked: Checked, disabled: Bool) {
    self.variant = variant
    self.color = color

    if self.variant == .primary {
      self.checked = checked
      self.disabled = disabled
    } else {
      self.checked = checked != .indeterminate ? checked : .checked
      self.disabled = false
    }
  }
}

extension BezierCheckboxConfiguration {
  public static func primary(checked: Checked, color: Color, disabled: Bool) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(variant: .primary, color: color, checked: checked, disabled: disabled)
  }

  public static func secondary(isChecked: Bool, color: Color) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(
      variant: .secondary,
      color: color,
      checked: isChecked ? .checked : .unchecked,
      disabled: false
    )
  }
}
