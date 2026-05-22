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

  static let all: [TypographyTokenSpec] = [
    .init(token: .displayLarge,                 name: "display-large",          detail: "36pt / Bold",                  sample: Self.sampleText),
    .init(token: .displayMedium,                name: "display-medium",         detail: "30pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingXLarge,                name: "heading-xlarge",         detail: "24pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingLarge,                 name: "heading-large",          detail: "22pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingMedium,                name: "heading-medium",         detail: "18pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingSmall,                 name: "heading-small",          detail: "17pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingXSmall,                name: "heading-xsmall",         detail: "16pt / Bold",                  sample: Self.sampleText),
    .init(token: .headingXXSmall,               name: "heading-xxsmall",        detail: "15pt / Bold",                  sample: Self.sampleText),
    .init(token: .textXXLarge(),                name: "text-xxlarge",           detail: "17pt / Regular",               sample: Self.sampleText),
    .init(token: .textXXLarge(weight: .bold),   name: "text-xxlarge (bold)",    detail: "17pt / Bold",                  sample: Self.sampleText),
    .init(token: .textXLarge(),                 name: "text-xlarge",            detail: "16pt / Regular",               sample: Self.sampleText),
    .init(token: .textLarge(),                  name: "text-large",             detail: "15pt / Regular",               sample: Self.sampleText),
    .init(token: .textMedium(),                 name: "text-medium",            detail: "14pt / Regular",               sample: Self.sampleText),
    .init(token: .textMedium(weight: .bold),    name: "text-medium (bold)",     detail: "14pt / Bold",                  sample: Self.sampleText),
    .init(token: .textSmall(),                  name: "text-small",             detail: "13pt / Regular",               sample: Self.sampleText),
    .init(token: .textXSmall(),                 name: "text-xsmall",            detail: "12pt / Regular",               sample: Self.sampleText),
    .init(token: .textXXSmall(),                name: "text-xxsmall",           detail: "11pt / Regular",               sample: Self.sampleText),
    .init(token: .labelLarge,                   name: "label-large",            detail: "14pt / Bold",                  sample: Self.sampleText),
    .init(token: .labelMedium,                  name: "label-medium",           detail: "13pt / Bold",                  sample: Self.sampleText),
    .init(token: .labelSmall,                   name: "label-small",            detail: "12pt / Bold",                  sample: Self.sampleText),
    .init(token: .captionMedium(),              name: "caption-medium",         detail: "12pt / Regular",               sample: Self.sampleText),
    .init(token: .captionMedium(weight: .bold), name: "caption-medium (bold)",  detail: "12pt / Bold",                  sample: Self.sampleText),
    .init(token: .captionSmall(),               name: "caption-small",          detail: "11pt / Regular",               sample: Self.sampleText),
    .init(token: .captionSmall(weight: .bold),  name: "caption-small (bold)",   detail: "11pt / Bold",                  sample: Self.sampleText),
    .init(token: .codeMedium,                   name: "code-medium",            detail: "14pt / Regular / Monospace",   sample: Self.codeSampleText),
    .init(token: .codeSmall,                    name: "code-small",             detail: "13pt / Regular / Monospace",   sample: Self.codeSampleText),
  ]
}
