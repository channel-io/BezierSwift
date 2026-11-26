import BezierSwift
import SwiftUI
import Testing
import UIKit

@Suite("Bezier V3 Typography")
struct BezierTypographyTests {
  @Test("본문의 세 가지 굵기를 SwiftUI와 UIKit 시스템 폰트에 적용한다")
  func textWeights() {
    let regular = BTSemanticToken.textMedium()
    let medium = BTSemanticToken.textMedium(weight: .medium)
    let bold = BTSemanticToken.textMedium(weight: .bold)

    #expect(regular.uiFont == .systemFont(ofSize: 14, weight: .regular))
    #expect(medium.uiFont == .systemFont(ofSize: 14, weight: .semibold))
    #expect(bold.uiFont == .systemFont(ofSize: 14, weight: .bold))
    #expect(regular.font == .system(size: 14, weight: .regular))
    #expect(medium.font == .system(size: 14, weight: .semibold))
    #expect(bold.font == .system(size: 14, weight: .bold))
    #expect(medium.boldPair == bold)
  }

  @Test("라벨은 Medium으로 표시한다", arguments: [
    BTSemanticToken.labelSmall, .labelMedium, .labelLarge,
  ])
  func labelWeight(token: BTSemanticToken) {
    #expect(token.resolvedWeight == .medium)
    #expect(token.uiFont == .systemFont(ofSize: token.fontSize, weight: .semibold))
    #expect(token.font == .system(size: token.fontSize, weight: .semibold))
  }

  @Test("Display는 Bold를 사용한다", arguments: [
    BTSemanticToken.displayLarge, .displayMedium,
  ])
  func displayWeight(token: BTSemanticToken) {
    #expect(token.resolvedWeight == .bold)
    #expect(token.uiFont == .systemFont(ofSize: token.fontSize, weight: .bold))
    #expect(token.font == .system(size: token.fontSize, weight: .bold))
  }

  @Test("버튼은 크기별 라벨 굵기와 폰트를 일치시킨다", arguments: BezierButtonSize.allCases)
  func buttonWeight(size: BezierButtonSize) {
    let expected: UIFont.Weight
    switch size {
    case .xsmall, .small, .medium: expected = .semibold
    case .large, .xlarge: expected = .medium
    }

    #expect(size.fontWeight == expected)
    #expect(size.uiFont == .systemFont(ofSize: size.fontSize, weight: expected))
  }

  @Test("헤딩과 본문의 기본 자간은 0pt다")
  func defaultLetterSpacing() {
    #expect(BTSemanticToken.headingMedium.letterSpacing == 0)
    #expect(BTSemanticToken.textMedium().letterSpacing == 0)
    #expect(BTSemanticToken.headingLarge.letterSpacing == -0.4)
    #expect(BTSemanticToken.textLarge().letterSpacing == -0.1)
  }
}
