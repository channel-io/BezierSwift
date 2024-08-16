//
//  BezierCheckboxConfiguration.swift
//  
//
//  Created by 구본욱 on 8/16/24.
//

import Foundation

public enum BezierCheckboxVariant {
  case primary
  case secondary
}

public enum BezierCheckboxColor {
  case blue
  case green
}

public enum BezierCheckboxChecked {
  case checked
  case unchecked
  case indeterminate
}

// MARK: - BezierCheckboxConfiguration
public struct BezierCheckboxConfiguration: Equatable {
  public typealias Variant = BezierCheckboxVariant
  public typealias Color = BezierCheckboxColor
  public typealias Checked = BezierCheckboxChecked

  // MARK: Properties
  let label: String?
  let checked: Checked
  let variant: Variant
  let color: Color
  let disabled: Bool
  let showRequiredAsterisk: Bool

  init(label: String?, variant: Variant, color: Color, checked: Checked, disabled: Bool, showRequiredAsterisk: Bool) {
    self.label = label
    self.variant = variant
    self.color = color
    self.showRequiredAsterisk = showRequiredAsterisk

    if self.variant == .primary {
      self.checked = checked
      self.disabled = disabled
    } else {
      self.checked = checked != .indeterminate ? checked : .checked
      self.disabled = false
    }
  }
}

// MARK: - Properties For Checkbox
extension BezierCheckboxConfiguration {
  var indent: CGFloat {
    switch self.variant {
    case .primary: return 0
    case .secondary: return 32
    }
  }

  var minHeight: CGFloat {
    switch self.variant {
    case .primary: return 40
    case .secondary: return 36
    }
  }

  var sourcePadding: CGFloat {
    switch self.variant {
    case .primary: return 8
    case .secondary: return 6
    }
  }

  var labelTop: CGFloat {
    switch self.variant {
    case .primary: return 11
    case .secondary: return 9
    }
  }
}

// MARK: - Properties For CheckboxSource
extension BezierCheckboxConfiguration {
  var sourceOpacity: CGFloat {
    guard self.disabled, self.checked != .unchecked else { return 1 }

    return 0.4
  }

  var sourceBackgroundColor: BezierColor {
    guard self.variant == .primary else { return .bgWhiteAlphaTransparent }

    switch self.checked {
    case .checked, .indeterminate:
      return self.color == .blue ? .primaryBgNormal : .bgGreenNormal
    case .unchecked:
      return self.disabled ? .bgBlackDark : .bgWhiteNormal
    }
  }

  var sourceNeedStroke: Bool {
    guard self.variant == .primary, self.checked == .unchecked, !self.disabled else {
      return false
    }

    return true
  }

  var sourceStrokeColor: BezierColor {
    guard self.sourceNeedStroke else { return .bgWhiteAlphaTransparent }

    return .bgBlackDark
  }

  var sourceIcon: BezierIcon? {
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

  var sourceIconColor: BezierColor {
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
}

// MARK: - Preset Initializer
extension BezierCheckboxConfiguration {
  public static func primary(
    label: String?,
    checked: Checked,
    color: Color,
    disabled: Bool,
    showRequiredAsterisk: Bool
  ) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(
      label: label,
      variant: .primary,
      color: color,
      checked: checked,
      disabled: disabled,
      showRequiredAsterisk: showRequiredAsterisk
    )
  }

  public static func secondary(
    label: String?,
    isChecked: Bool,
    color: Color,
    showRequiredAsterisk: Bool
  ) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(
      label: label,
      variant: .secondary,
      color: color,
      checked: isChecked ? .checked : .unchecked,
      disabled: false,
      showRequiredAsterisk: showRequiredAsterisk
    )
  }
}
