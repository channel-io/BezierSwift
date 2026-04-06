import Foundation

/// Bezier Typography V3 Semantic Token
/// 6개 카테고리, 22개 토큰.
public enum BTSemanticToken: Equatable {
  // MARK: - Display (2) — weight 700 고정
  case displayLarge
  case displayMedium

  // MARK: - Heading (6) — weight 700 고정
  case headingXlarge
  case headingLarge
  case headingMedium
  case headingSmall
  case headingXsmall
  case headingXxsmall

  // MARK: - Text (7) — 기본 400, weight prop으로 bold 700 가능
  case textXxlarge(weight: BTFontWeight = .regular)
  case textXlarge(weight: BTFontWeight = .regular)
  case textLarge(weight: BTFontWeight = .regular)
  case textMedium(weight: BTFontWeight = .regular)
  case textSmall(weight: BTFontWeight = .regular)
  case textXsmall(weight: BTFontWeight = .regular)
  case textXxsmall(weight: BTFontWeight = .regular)

  // MARK: - Label (3) — weight 700 고정
  case labelLarge
  case labelMedium
  case labelSmall

  // MARK: - Caption (2) — 기본 400, weight prop으로 bold 700 가능
  case captionMedium(weight: BTFontWeight = .regular)
  case captionSmall(weight: BTFontWeight = .regular)

  // MARK: - Code (2) — weight 400 고정, monospace
  case codeMedium
  case codeSmall
}
