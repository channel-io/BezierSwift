//
//  BezierFloatingBannerSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - ClickArea

public enum BezierFloatingBannerClickArea {
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

public enum BezierFloatingBannerConstant {
  public static let leadingPadding: CGFloat = 10
  public static let trailingPadding: CGFloat = 8
  public static let verticalPadding: CGFloat = 10
  public static let cornerRadius: CGFloat = 16
  public static let minHeight: CGFloat = 30

  public static let leadingIconLeadingPadding: CGFloat = 2
  public static let leadingIconVerticalPadding: CGFloat = 5
  public static let iconLength: CGFloat = 20

  public static let contentPadding: CGFloat = 6
  public static let contentSpacing: CGFloat = 4

  public static let actionIconContainerLength: CGFloat = 30
  public static let actionIconPadding: CGFloat = 5

  public static let elevation: BezierElevation = .mEv3

  static let backgroundColor: BCSemanticToken = .surfaceHighest
  static let textColor: BCSemanticToken = .textNeutralLight
  static let actionIconColor: BCSemanticToken = .iconNeutral
  public static let defaultLeadingIconColor: BCSemanticToken = .iconNeutral

  static let titleTypography: BTSemanticToken = .textMedium(weight: .bold)
  static let descriptionTypography: BTSemanticToken = .textMedium(weight: .regular)
}
