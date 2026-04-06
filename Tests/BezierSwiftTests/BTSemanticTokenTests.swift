import Testing
import UIKit
@testable import BezierSwift

struct BTSemanticTokenTests {
  // MARK: - Display
  @Test func displayLargeProperties() {
    let token = BTSemanticToken.displayLarge
    #expect(token.fontSize == 36)
    #expect(token.lineHeight == 44)
    #expect(token.letterSpacing == -0.4)
    #expect(token.resolvedWeight == .bold)
  }

  @Test func displayMediumProperties() {
    let token = BTSemanticToken.displayMedium
    #expect(token.fontSize == 30)
    #expect(token.lineHeight == 36)
    #expect(token.letterSpacing == -0.4)
    #expect(token.resolvedWeight == .bold)
  }

  // MARK: - Heading
  @Test func headingXlargeProperties() {
    let token = BTSemanticToken.headingXlarge
    #expect(token.fontSize == 24)
    #expect(token.lineHeight == 32)
    #expect(token.letterSpacing == -0.4)
    #expect(token.resolvedWeight == .bold)
  }

  @Test func headingLargeProperties() {
    let token = BTSemanticToken.headingLarge
    #expect(token.fontSize == 22)
    #expect(token.lineHeight == 28)
    #expect(token.letterSpacing == -0.4)
  }

  @Test func headingMediumProperties() {
    let token = BTSemanticToken.headingMedium
    #expect(token.fontSize == 18)
    #expect(token.lineHeight == 24)
    #expect(token.letterSpacing == 0)
  }

  @Test func headingSmallProperties() {
    let token = BTSemanticToken.headingSmall
    #expect(token.fontSize == 17)
    #expect(token.lineHeight == 24)
    #expect(token.letterSpacing == -0.1)
  }

  @Test func headingXsmallProperties() {
    let token = BTSemanticToken.headingXsmall
    #expect(token.fontSize == 16)
    #expect(token.lineHeight == 24)
    #expect(token.letterSpacing == -0.1)
  }

  @Test func headingXxsmallProperties() {
    let token = BTSemanticToken.headingXxsmall
    #expect(token.fontSize == 15)
    #expect(token.lineHeight == 20)
    #expect(token.letterSpacing == -0.1)
    #expect(token.resolvedWeight == .bold)
  }

  // MARK: - Text (default weight)
  @Test func textXxlargeDefaultProperties() {
    let token = BTSemanticToken.textXxlarge()
    #expect(token.fontSize == 17)
    #expect(token.lineHeight == 24)
    #expect(token.letterSpacing == -0.1)
    #expect(token.resolvedWeight == .regular)
  }

  @Test func textXlargeDefaultProperties() {
    let token = BTSemanticToken.textXlarge()
    #expect(token.fontSize == 16)
    #expect(token.lineHeight == 24)
    #expect(token.letterSpacing == -0.1)
  }

  @Test func textLargeDefaultProperties() {
    let token = BTSemanticToken.textLarge()
    #expect(token.fontSize == 15)
    #expect(token.lineHeight == 20)
    #expect(token.letterSpacing == -0.1)
  }

  @Test func textMediumDefaultProperties() {
    let token = BTSemanticToken.textMedium()
    #expect(token.fontSize == 14)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .regular)
  }

  @Test func textSmallDefaultProperties() {
    let token = BTSemanticToken.textSmall()
    #expect(token.fontSize == 13)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
  }

  @Test func textXsmallDefaultProperties() {
    let token = BTSemanticToken.textXsmall()
    #expect(token.fontSize == 12)
    #expect(token.lineHeight == 16)
    #expect(token.letterSpacing == 0)
  }

  @Test func textXxsmallDefaultProperties() {
    let token = BTSemanticToken.textXxsmall()
    #expect(token.fontSize == 11)
    #expect(token.lineHeight == 16)
    #expect(token.letterSpacing == 0)
  }

  // MARK: - Text (bold weight)
  @Test func textMediumBoldProperties() {
    let token = BTSemanticToken.textMedium(weight: .bold)
    #expect(token.fontSize == 14)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .bold)
  }

  // MARK: - Label
  @Test func labelLargeProperties() {
    let token = BTSemanticToken.labelLarge
    #expect(token.fontSize == 14)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .bold)
  }

  @Test func labelMediumProperties() {
    let token = BTSemanticToken.labelMedium
    #expect(token.fontSize == 13)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
  }

  @Test func labelSmallProperties() {
    let token = BTSemanticToken.labelSmall
    #expect(token.fontSize == 12)
    #expect(token.lineHeight == 16)
    #expect(token.letterSpacing == 0)
  }

  // MARK: - Caption
  @Test func captionMediumDefaultProperties() {
    let token = BTSemanticToken.captionMedium()
    #expect(token.fontSize == 12)
    #expect(token.lineHeight == 16)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .regular)
  }

  @Test func captionSmallBoldProperties() {
    let token = BTSemanticToken.captionSmall(weight: .bold)
    #expect(token.fontSize == 11)
    #expect(token.lineHeight == 16)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .bold)
  }

  // MARK: - Code
  @Test func codeMediumProperties() {
    let token = BTSemanticToken.codeMedium
    #expect(token.fontSize == 14)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .regular)
    #expect(token.isMonospace == true)
  }

  @Test func codeSmallProperties() {
    let token = BTSemanticToken.codeSmall
    #expect(token.fontSize == 13)
    #expect(token.lineHeight == 18)
    #expect(token.letterSpacing == 0)
    #expect(token.resolvedWeight == .regular)
    #expect(token.isMonospace == true)
  }

  // MARK: - Font / UIFont generation
  @Test func fontGenerationSystemFont() {
    let token = BTSemanticToken.textMedium()
    let uiFont = token.uiFont
    #expect(uiFont.pointSize == 14)
  }

  @Test func fontGenerationMonospace() {
    let token = BTSemanticToken.codeMedium
    let uiFont = token.uiFont
    #expect(uiFont.pointSize == 14)
  }

  // MARK: - lineSpacing
  @Test func lineSpacingCalculation() {
    let token = BTSemanticToken.textMedium()
    #expect(token.lineSpacing >= 0)
  }

  // MARK: - All 22 tokens
  @Test func allTokensHaveFontSize() {
    let allTokens: [BTSemanticToken] = [
      .displayLarge, .displayMedium,
      .headingXlarge, .headingLarge, .headingMedium, .headingSmall, .headingXsmall, .headingXxsmall,
      .textXxlarge(), .textXlarge(), .textLarge(), .textMedium(), .textSmall(), .textXsmall(), .textXxsmall(),
      .labelLarge, .labelMedium, .labelSmall,
      .captionMedium(), .captionSmall(),
      .codeMedium, .codeSmall,
    ]
    #expect(allTokens.count == 22)
    for token in allTokens {
      #expect(token.fontSize > 0)
      #expect(token.lineHeight > 0)
    }
  }

  // MARK: - Non-code tokens are not monospace
  @Test func nonCodeTokensAreNotMonospace() {
    #expect(BTSemanticToken.textMedium().isMonospace == false)
    #expect(BTSemanticToken.labelLarge.isMonospace == false)
    #expect(BTSemanticToken.headingMedium.isMonospace == false)
  }
}
