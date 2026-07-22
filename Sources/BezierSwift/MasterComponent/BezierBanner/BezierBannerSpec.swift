//
//  BezierBannerSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Variant

public enum BezierBannerVariant: CaseIterable {
  case `default`
  case blue
  case cobalt
  case green
  case orange
  case red

  var backgroundColor: BCSemanticToken {
    switch self {
    case .default: return .fillNeutralLighter
    case .blue: return .fillAccentBlue
    case .cobalt: return .fillAccentCobalt
    case .green: return .fillAccentGreen
    case .orange: return .fillAccentOrange
    case .red: return .fillAccentRed
    }
  }

  var iconColor: BCSemanticToken {
    switch self {
    case .default: return .iconNeutral
    case .blue: return .iconAccentBlue
    case .cobalt: return .iconAccentCobalt
    case .green: return .iconAccentGreen
    case .orange: return .iconAccentOrange
    case .red: return .iconAccentRed
    }
  }

  var textColor: BCSemanticToken {
    switch self {
    case .default: return .textNeutralLight
    case .blue: return .textAccentBlue
    case .cobalt: return .textAccentCobalt
    case .green: return .textAccentGreen
    case .orange: return .textAccentOrange
    case .red: return .textAccentRed
    }
  }
}

// MARK: - ClickArea

public enum BezierBannerClickArea {
  case none
  case full(onClick: () -> Void)
  case actionIcon(onClick: () -> Void)

  var trailingIcon: BezierIcon? {
    switch self {
    case .none: return nil
    case .full: return .chevronSmallRight
    case .actionIcon: return .cancelSmall
    }
  }
}

// MARK: - Constant

public enum BezierBannerConstant {
  public static let horizontalPadding: CGFloat = 8
  public static let verticalPadding: CGFloat = 10
  public static let cornerRadius: CGFloat = 16

  public static let leadingIconLeadingPadding: CGFloat = 4
  public static let leadingIconTrailingPadding: CGFloat = 2
  public static let leadingIconVerticalPadding: CGFloat = 5
  public static let iconLength: CGFloat = 20

  public static let contentPadding: CGFloat = 6
  public static let contentSpacing: CGFloat = 4

  public static let actionIconContainerLength: CGFloat = 30
  public static let actionIconPadding: CGFloat = 5

  static let titleTypography: BTSemanticToken = .textMedium(weight: .bold)
  static let descriptionTypography: BTSemanticToken = .textMedium(weight: .regular)
}
