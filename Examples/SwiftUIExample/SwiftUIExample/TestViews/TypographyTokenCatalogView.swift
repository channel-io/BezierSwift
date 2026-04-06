import SwiftUI
import BezierSwift

struct TypographyTokenCatalogView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 32) {
        displaySection
        headingSection
        textSection
        labelSection
        captionSection
        codeSection
      }
      .padding()
    }
    .navigationTitle("V3 Typography")
  }

  // MARK: - Display
  private var displaySection: some View {
    TokenSection(title: "Display") {
      TokenRow(name: "display-large", detail: "36pt / Bold") {
        Text("Display Large")
          .applyBezierFontStyle(.displayLarge, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "display-medium", detail: "30pt / Bold") {
        Text("Display Medium")
          .applyBezierFontStyle(.displayMedium, semanticColorToken: .textNeutral)
      }
    }
  }

  // MARK: - Heading
  private var headingSection: some View {
    TokenSection(title: "Heading") {
      TokenRow(name: "heading-xlarge", detail: "24pt / Bold") {
        Text("Heading XLarge")
          .applyBezierFontStyle(.headingXlarge, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "heading-large", detail: "22pt / Bold") {
        Text("Heading Large")
          .applyBezierFontStyle(.headingLarge, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "heading-medium", detail: "18pt / Bold") {
        Text("Heading Medium")
          .applyBezierFontStyle(.headingMedium, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "heading-small", detail: "17pt / Bold") {
        Text("Heading Small")
          .applyBezierFontStyle(.headingSmall, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "heading-xsmall", detail: "16pt / Bold") {
        Text("Heading XSmall")
          .applyBezierFontStyle(.headingXsmall, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "heading-xxsmall", detail: "15pt / Bold") {
        Text("Heading XXSmall")
          .applyBezierFontStyle(.headingXxsmall, semanticColorToken: .textNeutral)
      }
    }
  }

  // MARK: - Text
  private var textSection: some View {
    TokenSection(title: "Text") {
      Group {
        TokenRow(name: "text-xxlarge", detail: "17pt / Regular") {
          Text("Text XXLarge")
            .applyBezierFontStyle(.textXxlarge(), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-xxlarge (bold)", detail: "17pt / Bold") {
          Text("Text XXLarge Bold")
            .applyBezierFontStyle(.textXxlarge(weight: .bold), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-xlarge", detail: "16pt / Regular") {
          Text("Text XLarge")
            .applyBezierFontStyle(.textXlarge(), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-large", detail: "15pt / Regular") {
          Text("Text Large")
            .applyBezierFontStyle(.textLarge(), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-medium", detail: "14pt / Regular") {
          Text("Text Medium")
            .applyBezierFontStyle(.textMedium(), semanticColorToken: .textNeutral)
        }
      }
      Group {
        TokenRow(name: "text-medium (bold)", detail: "14pt / Bold") {
          Text("Text Medium Bold")
            .applyBezierFontStyle(.textMedium(weight: .bold), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-small", detail: "13pt / Regular") {
          Text("Text Small")
            .applyBezierFontStyle(.textSmall(), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-xsmall", detail: "12pt / Regular") {
          Text("Text XSmall")
            .applyBezierFontStyle(.textXsmall(), semanticColorToken: .textNeutral)
        }
        TokenRow(name: "text-xxsmall", detail: "11pt / Regular") {
          Text("Text XXSmall")
            .applyBezierFontStyle(.textXxsmall(), semanticColorToken: .textNeutral)
        }
      }
    }
  }

  // MARK: - Label
  private var labelSection: some View {
    TokenSection(title: "Label") {
      TokenRow(name: "label-large", detail: "14pt / Bold") {
        Text("Label Large")
          .applyBezierFontStyle(.labelLarge, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "label-medium", detail: "13pt / Bold") {
        Text("Label Medium")
          .applyBezierFontStyle(.labelMedium, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "label-small", detail: "12pt / Bold") {
        Text("Label Small")
          .applyBezierFontStyle(.labelSmall, semanticColorToken: .textNeutral)
      }
    }
  }

  // MARK: - Caption
  private var captionSection: some View {
    TokenSection(title: "Caption") {
      TokenRow(name: "caption-medium", detail: "12pt / Regular") {
        Text("Caption Medium")
          .applyBezierFontStyle(.captionMedium(), semanticColorToken: .textNeutral)
      }
      TokenRow(name: "caption-medium (bold)", detail: "12pt / Bold") {
        Text("Caption Medium Bold")
          .applyBezierFontStyle(.captionMedium(weight: .bold), semanticColorToken: .textNeutral)
      }
      TokenRow(name: "caption-small", detail: "11pt / Regular") {
        Text("Caption Small")
          .applyBezierFontStyle(.captionSmall(), semanticColorToken: .textNeutral)
      }
      TokenRow(name: "caption-small (bold)", detail: "11pt / Bold") {
        Text("Caption Small Bold")
          .applyBezierFontStyle(.captionSmall(weight: .bold), semanticColorToken: .textNeutral)
      }
    }
  }

  // MARK: - Code
  private var codeSection: some View {
    TokenSection(title: "Code") {
      TokenRow(name: "code-medium", detail: "14pt / Regular / Monospace") {
        Text("Code Medium: let x = 42")
          .applyBezierFontStyle(.codeMedium, semanticColorToken: .textNeutral)
      }
      TokenRow(name: "code-small", detail: "13pt / Regular / Monospace") {
        Text("Code Small: let x = 42")
          .applyBezierFontStyle(.codeSmall, semanticColorToken: .textNeutral)
      }
    }
  }
}

// MARK: - Helper Views

private struct TokenSection<Content: View>: View {
  let title: String
  @ViewBuilder let content: Content

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.system(size: 13, weight: .semibold))
        .foregroundColor(.secondary)
        .textCase(.uppercase)
        .padding(.bottom, 4)

      content

      Divider()
    }
  }
}

private struct TokenRow<Content: View>: View {
  let name: String
  let detail: String
  @ViewBuilder let content: Content

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      content

      Text("\(name)  ·  \(detail)")
        .font(.system(size: 11))
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 2)
  }
}

struct TypographyTokenCatalogView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TypographyTokenCatalogView()
    }
  }
}
