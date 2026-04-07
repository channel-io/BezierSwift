import SwiftUI
import UIKit

extension BTSemanticToken {
  // MARK: - Font Size
  public var fontSize: CGFloat {
    switch self {
    case .displayLarge:                     return BTGlobalToken.FontSize.size36
    case .displayMedium:                    return BTGlobalToken.FontSize.size30
    case .headingXlarge:                    return BTGlobalToken.FontSize.size24
    case .headingLarge:                     return BTGlobalToken.FontSize.size22
    case .headingMedium:                    return BTGlobalToken.FontSize.size18
    case .headingSmall:                     return BTGlobalToken.FontSize.size17
    case .headingXsmall:                    return BTGlobalToken.FontSize.size16
    case .headingXxsmall:                   return BTGlobalToken.FontSize.size15
    case .textXxlarge:                      return BTGlobalToken.FontSize.size17
    case .textXlarge:                       return BTGlobalToken.FontSize.size16
    case .textLarge:                        return BTGlobalToken.FontSize.size15
    case .textMedium:                       return BTGlobalToken.FontSize.size14
    case .textSmall:                        return BTGlobalToken.FontSize.size13
    case .textXsmall:                       return BTGlobalToken.FontSize.size12
    case .textXxsmall:                      return BTGlobalToken.FontSize.size11
    case .labelLarge:                       return BTGlobalToken.FontSize.size14
    case .labelMedium:                      return BTGlobalToken.FontSize.size13
    case .labelSmall:                       return BTGlobalToken.FontSize.size12
    case .captionMedium:                    return BTGlobalToken.FontSize.size12
    case .captionSmall:                     return BTGlobalToken.FontSize.size11
    case .codeMedium:                       return BTGlobalToken.FontSize.size14
    case .codeSmall:                        return BTGlobalToken.FontSize.size13
    }
  }

  // MARK: - Line Height
  public var lineHeight: CGFloat {
    switch self {
    case .displayLarge:                     return BTGlobalToken.LineHeight.height44
    case .displayMedium:                    return BTGlobalToken.LineHeight.height36
    case .headingXlarge:                    return BTGlobalToken.LineHeight.height32
    case .headingLarge:                     return BTGlobalToken.LineHeight.height28
    case .headingMedium:                    return BTGlobalToken.LineHeight.height24
    case .headingSmall:                     return BTGlobalToken.LineHeight.height24
    case .headingXsmall:                    return BTGlobalToken.LineHeight.height24
    case .headingXxsmall:                   return BTGlobalToken.LineHeight.height20
    case .textXxlarge:                      return BTGlobalToken.LineHeight.height24
    case .textXlarge:                       return BTGlobalToken.LineHeight.height24
    case .textLarge:                        return BTGlobalToken.LineHeight.height20
    case .textMedium:                       return BTGlobalToken.LineHeight.height18
    case .textSmall:                        return BTGlobalToken.LineHeight.height18
    case .textXsmall:                       return BTGlobalToken.LineHeight.height16
    case .textXxsmall:                      return BTGlobalToken.LineHeight.height16
    case .labelLarge:                       return BTGlobalToken.LineHeight.height18
    case .labelMedium:                      return BTGlobalToken.LineHeight.height18
    case .labelSmall:                       return BTGlobalToken.LineHeight.height16
    case .captionMedium:                    return BTGlobalToken.LineHeight.height16
    case .captionSmall:                     return BTGlobalToken.LineHeight.height16
    case .codeMedium:                       return BTGlobalToken.LineHeight.height18
    case .codeSmall:                        return BTGlobalToken.LineHeight.height18
    }
  }

  // MARK: - Letter Spacing
  public var letterSpacing: CGFloat {
    switch self {
    case .displayLarge, .displayMedium,
         .headingXlarge, .headingLarge:
      return BTGlobalToken.LetterSpacing.spacing0_4

    case .headingMedium:
      return BTGlobalToken.LetterSpacing.spacing0

    case .headingSmall, .headingXsmall, .headingXxsmall,
         .textXxlarge, .textXlarge, .textLarge:
      return BTGlobalToken.LetterSpacing.spacing0_1

    case .textMedium, .textSmall, .textXsmall, .textXxsmall,
         .labelLarge, .labelMedium, .labelSmall,
         .captionMedium, .captionSmall,
         .codeMedium, .codeSmall:
      return BTGlobalToken.LetterSpacing.spacing0
    }
  }

  // MARK: - Resolved Weight
  public var resolvedWeight: BTFontWeight {
    switch self {
    case .displayLarge, .displayMedium,
         .headingXlarge, .headingLarge, .headingMedium,
         .headingSmall, .headingXsmall, .headingXxsmall,
         .labelLarge, .labelMedium, .labelSmall:
      return .bold

    case .textXxlarge(let weight),
         .textXlarge(let weight),
         .textLarge(let weight),
         .textMedium(let weight),
         .textSmall(let weight),
         .textXsmall(let weight),
         .textXxsmall(let weight):
      return weight

    case .captionMedium(let weight),
         .captionSmall(let weight):
      return weight

    case .codeMedium, .codeSmall:
      return .regular
    }
  }

  // MARK: - Font Family (internal)
  var resolvedFontFamily: BTGlobalToken.FontFamily {
    switch self {
    case .codeMedium, .codeSmall:
      return .monospace
    default:
      return .system
    }
  }

  // MARK: - Monospace 여부 (public)
  public var isMonospace: Bool {
    self.resolvedFontFamily == .monospace
  }

  // MARK: - SwiftUI Font
  public var font: Font {
    self.resolvedFontFamily.font(size: self.fontSize, weight: self.resolvedWeight)
  }

  // MARK: - UIKit UIFont
  public var uiFont: UIFont {
    self.resolvedFontFamily.uiFont(size: self.fontSize, weight: self.resolvedWeight)
  }

  // MARK: - Line Spacing (for SwiftUI .lineSpacing modifier)
  public var lineSpacing: CGFloat {
    let spacing = self.lineHeight - self.uiFont.lineHeight
    return max(0, spacing)
  }

  // MARK: - Vertical Padding (half of lineSpacing, for balanced top/bottom)
  public var verticalPadding: CGFloat {
    self.lineSpacing / 2
  }
}
