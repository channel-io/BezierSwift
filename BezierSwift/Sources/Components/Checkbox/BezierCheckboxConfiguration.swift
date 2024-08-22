//
//  BezierCheckboxConfiguration.swift
//  
//
//  Created by 구본욱 on 8/16/24.
//

import Foundation

// MARK: - Bezier Checkbox Variants Types
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

public enum BezierCheckboxNested {
  case none
  case vertical
}

// MARK: - BezierCheckboxConfiguration
public struct BezierCheckboxConfiguration: Equatable {
  public typealias Variant = BezierCheckboxVariant
  public typealias Color = BezierCheckboxColor
  public typealias Checked = BezierCheckboxChecked
  public typealias Nested = BezierCheckboxNested

  // MARK: Properties
  // TODO: - Min Target을 iOS 15 이상으로 올린 이후에 AttributedString을 적용해 링크 텍스트를 넣을수 있도록 합니다 - by Finn 2024.08.21
  let label: String?
  let variant: Variant
  let color: Color
  let checked: Checked
  let nested: Nested
  let showRequired: Bool

  init(
    label: String?,
    variant: Variant,
    color: Color,
    checked: Checked, 
    nested: Nested,
    showRequired: Bool
  ) {
    self.label = label
    self.variant = variant
    self.color = color

    if self.variant == .primary {
      self.checked = checked
      self.showRequired = showRequired
      self.nested = nested
    } else {
      self.checked = checked != .indeterminate ? checked : .checked
      self.showRequired = false
      self.nested = .none
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
  var sourceBackgroundColor: BezierColor {
    guard self.variant == .primary else { return .bgWhiteAlphaTransparent }

    switch self.checked {
    case .checked, .indeterminate:
      return self.color == .blue ? .primaryBgNormal : .bgGreenNormal
    case .unchecked:
      return .bgWhiteNormal
    }
  }

  var sourceNeedStroke: Bool {
    guard self.variant == .primary, self.checked == .unchecked else {
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
    nested: Nested = .none,
    showRequired: Bool = false
  ) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(
      label: label,
      variant: .primary,
      color: color,
      checked: checked,
      nested: nested,
      showRequired: showRequired
    )
  }

  public static func secondary(
    label: String?,
    isChecked: Bool,
    color: Color
  ) -> BezierCheckboxConfiguration {
    return BezierCheckboxConfiguration(
      label: label,
      variant: .secondary,
      color: color,
      checked: isChecked ? .checked : .unchecked,
      nested: .none,
      showRequired: false
    )
  }
}
