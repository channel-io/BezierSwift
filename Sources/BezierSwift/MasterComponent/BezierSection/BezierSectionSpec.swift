//
//  BezierSectionSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Variant

public enum BezierSectionVariant: CaseIterable {
  case solid
  case card
}

// MARK: - Label Color

public enum BezierSectionLabelColor: CaseIterable {
  case neutralDark
  case neutralLight

  var textColor: BCSemanticToken {
    switch self {
    case .neutralDark: return .textNeutral
    case .neutralLight: return .textNeutralLighter
    }
  }
}

// MARK: - Appearance

extension BezierSectionVariant {
  struct Appearance {
    struct Border {
      let color: BCSemanticToken
      let width: CGFloat
    }

    struct Divider {
      let color: BCSemanticToken
      let thickness: CGFloat
      let leadingInset: CGFloat
      let trailingInset: CGFloat
    }

    struct Insets {
      let top: CGFloat
      let leading: CGFloat
      let bottom: CGFloat
      let trailing: CGFloat

      static let zero = Insets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }

    let backgroundColor: BCSemanticToken?
    let cornerRadius: CGFloat
    let border: Border?
    let divider: Divider?
    let contentInsets: Insets

    var hasChrome: Bool {
      self.backgroundColor != nil || self.border != nil
    }
  }

  var appearance: Appearance {
    switch self {
    case .solid:
      return Appearance(
        backgroundColor: nil,
        cornerRadius: 0,
        border: nil,
        divider: nil,
        contentInsets: .zero
      )
    case .card:
      return Appearance(
        backgroundColor: BezierSectionConstant.cardBackgroundColor,
        cornerRadius: BezierSectionConstant.cardCornerRadius,
        border: Appearance.Border(
          color: BezierSectionConstant.cardBorderColor,
          width: BezierSectionConstant.cardBorderWidth
        ),
        divider: Appearance.Divider(
          color: BezierSectionConstant.cardDividerColor,
          thickness: BezierSectionConstant.cardDividerThickness,
          leadingInset: 0,
          trailingInset: 0
        ),
        contentInsets: BezierSectionConstant.cardContentInsets
      )
    }
  }
}

// MARK: - Constant

public enum BezierSectionConstant {
  public static let labelHeight: CGFloat = 32
  public static let labelHorizontalPadding: CGFloat = 10
  public static let labelCornerRadius: CGFloat = 8
  public static let labelTrailingSpacing: CGFloat = 4
  public static let labelLeadingSpacing: CGFloat = 8
  public static let labelLeadingContentLength: CGFloat = 20
  public static let labelTrailingContentHeight: CGFloat = 20
  public static let labelToContentSpacing: CGFloat = 0

  static let labelTypography: BTSemanticToken = .textMedium(weight: .bold)

  static let cardBackgroundColor: BCSemanticToken = .surface
  static let cardBorderColor: BCSemanticToken = .borderNeutral
  static let cardBorderWidth: CGFloat = 1
  static let cardCornerRadius: CGFloat = 16
  static let cardDividerColor: BCSemanticToken = .borderNeutral
  static let cardDividerThickness: CGFloat = 1
  static let cardContentInsets = BezierSectionVariant.Appearance.Insets(
    top: 2,
    leading: 0,
    bottom: 2,
    trailing: 0
  )
}
