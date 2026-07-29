//
//  BezierBaseInputSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Variant

enum BezierBaseInputVariant {
  case primary
  case secondary
}

// MARK: - State

enum BezierBaseInputState: Equatable {
  case `default`
  case focused
  case error
  case readOnly
  case disabled

  static func resolve(
    isEnabled: Bool,
    isReadOnly: Bool,
    hasError: Bool,
    isFocused: Bool
  ) -> BezierBaseInputState {
    if !isEnabled { return .disabled }
    if isReadOnly { return .readOnly }
    if hasError { return .error }
    if isFocused { return .focused }
    return .default
  }
}

// MARK: - Metric

struct BezierBaseInputMetric: Equatable {
  let height: CGFloat
  let cornerRadius: CGFloat
  let leadingContentLength: CGFloat

  static let small = BezierBaseInputMetric(height: 40, cornerRadius: 12, leadingContentLength: 20)
  static let medium = BezierBaseInputMetric(height: 48, cornerRadius: 14, leadingContentLength: 24)
}

// MARK: - Constant

enum BezierBaseInputConstant {
  static let horizontalPadding: CGFloat = 10
  static let contentSpacing: CGFloat = 6
  static let borderWidth: CGFloat = 1.5
  static let minWidth: CGFloat = 40
  static let trailingContentLength: CGFloat = 20
  static let systemElementLength: CGFloat = 20

  static let disabledOpacity: CGFloat = BOGlobalToken.disabled

  static let textTypography: BTSemanticToken = .textXLarge(weight: .regular)
  static let affixTypography: BTSemanticToken = .textLarge(weight: .regular)

  static let textColor: BCSemanticToken = .textNeutral
  static let readOnlyTextColor: BCSemanticToken = .textNeutralLight
  static let placeholderColor: BCSemanticToken = .textNeutralLighter
  static let iconColor: BCSemanticToken = .iconNeutral
  static let affixTextColor: BCSemanticToken = .textNeutralLight
}

// MARK: - Appearance

enum BezierBaseInputAppearance {
  static func backgroundColor(
    variant: BezierBaseInputVariant,
    state: BezierBaseInputState
  ) -> BCSemanticToken {
    switch variant {
    case .primary:
      switch state {
      case .default, .disabled: return .fillGrey
      case .focused, .error: return .fillGreyLight
      case .readOnly: return .fillGreyHeavy
      }
    case .secondary:
      return .fillNeutralLight
    }
  }

  static func borderColor(
    variant: BezierBaseInputVariant,
    state: BezierBaseInputState
  ) -> BCSemanticToken? {
    switch state {
    case .focused: return .stateActive
    case .error: return .stateWarning
    case .default, .readOnly, .disabled:
      switch variant {
      case .primary: return .stateDefault
      case .secondary: return nil
      }
    }
  }

  static func textColor(state: BezierBaseInputState) -> BCSemanticToken {
    state == .readOnly
      ? BezierBaseInputConstant.readOnlyTextColor
      : BezierBaseInputConstant.textColor
  }
}
