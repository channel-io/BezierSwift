//
//  BezierSectionSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Variant

/// 섹션의 시각 스타일. Figma `Section` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값). 배경·테두리·radius·행 간 divider 유무를 결정한다.
public enum BezierSectionVariant: CaseIterable {
  /// 배경·테두리·divider 없는 투명 섹션. 화면 배경 위에 그대로 얹는 기본 리스트에 쓴다.
  case solid
  /// `surface` 배경 + 1pt `borderNeutral` 테두리 + radius 16 카드. 행 사이에 divider가 들어간다. 리스트를 카드로 감싸 구분할 때 쓴다.
  case card
}

// MARK: - Label Color

/// 섹션 라벨 텍스트 색. Figma `Internal/SectionLabel`의 `color` 프로퍼티에 대응 (Figma 값 `neutral-dark`/`neutral-light` = 코드 `neutralDark`/`neutralLight`).
public enum BezierSectionLabelColor: CaseIterable {
  /// 진한 라벨(`textNeutral`). 일반 섹션 헤더의 기본값이다.
  case neutralDark
  /// 연한 라벨(`textNeutralLighter`). 오버레이/시트 내부 등 약하게 표기할 때 쓴다.
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
