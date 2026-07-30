import SwiftUI
import UIKit
import BezierSwift

struct TypographyCatalog: View {
  var body: some View {
    CatalogScreen(title: "Typography") {
      CatalogSection(.swiftUI) {
        VStack(alignment: .leading, spacing: 16) {
          ForEach(TypographyTokenSpec.all) { spec in
            VStack(alignment: .leading, spacing: 4) {
              Text(spec.sample)
                .applyBezierFontStyle(spec.token, semanticColorToken: .textNeutral)
              Text("\(spec.name)  ·  \(spec.detail)")
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
            }
          }
        }
      }
      CatalogSection(.uiKit) {
        VStack(alignment: .leading, spacing: 16) {
          ForEach(TypographyTokenSpec.all) { spec in
            VStack(alignment: .leading, spacing: 4) {
              UIKitWrap {
                let label = UILabel()
                label.text = spec.sample
                label.font = spec.token.uiFont
                label.textColor = BCSemanticToken.textNeutral.palette(BezierExamplesComponent.shared)
                label.numberOfLines = 0
                return label
              }
              Text("\(spec.name)  ·  \(spec.detail)")
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
            }
          }
        }
      }
    }
  }
}

private struct TypographyTokenSpec: Identifiable {
  let token: BTSemanticToken
  let name: String
  let detail: String
  let sample: String
  var id: String { self.name }

  private static let sampleText = "The quick brown fox 다람쥐 헌 쳇바퀴"
  private static let codeSampleText = "let greeting = \"Hello\""

  static let all: [TypographyTokenSpec] = BTSemanticToken.allCases.flatMap { token in
    // boldPair가 자기 자신이 아니면 weight를 고를 수 있는 토큰이다 — regular 행에 bold 행을 잇는다.
    token.boldPair == token
      ? [TypographyTokenSpec(token)]
      : [TypographyTokenSpec(token), TypographyTokenSpec(token.boldPair, isBoldVariant: true)]
  }

  private init(_ token: BTSemanticToken, isBoldVariant: Bool = false) {
    self.token = token
    self.name = TokenName.kebab(token) + (isBoldVariant ? " (bold)" : "")
    self.detail = Self.detailText(of: token)
    self.sample = token.isMonospace ? Self.codeSampleText : Self.sampleText
  }

  private static func detailText(of token: BTSemanticToken) -> String {
    var parts = [
      Self.ptText(token.fontSize),
      TokenName.caseName(token.resolvedWeight).capitalized,
      "line \(Self.ptText(token.lineHeight))",
    ]
    if token.isMonospace {
      parts.append("Monospace")
    }
    return parts.joined(separator: " / ")
  }

  private static func ptText(_ value: CGFloat) -> String {
    value == value.rounded() ? "\(Int(value))pt" : String(format: "%gpt", Double(value))
  }
}
