import SwiftUI
import UIKit
import BezierSwift

struct ColorTokenCatalog: View {
  var body: some View {
    CatalogScreen(title: "Color Token") {
      ForEach(ColorTokenGroup.all) { group in
        VStack(alignment: .leading, spacing: 8) {
          Text(group.title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
          CatalogSection(.swiftUI) {
            SwiftUISwatchGrid(tokens: group.tokens)
          }
          CatalogSection(.uiKit) {
            UIKitSwatchGrid(tokens: group.tokens)
          }
        }
      }
    }
  }
}

// MARK: - Group definition

private struct ColorTokenGroup: Identifiable {
  let title: String
  let tokens: [ColorTokenSpec]
  var id: String { self.title }

  static let all: [ColorTokenGroup] = [
    ColorTokenGroup(title: "Surface", tokens: [
      ColorTokenSpec(.surface,        "surface"),
      ColorTokenSpec(.surfaceLow,     "surface-low"),
      ColorTokenSpec(.surfaceHigh,    "surface-high"),
      ColorTokenSpec(.surfaceHigher,  "surface-higher"),
      ColorTokenSpec(.surfaceHighest, "surface-highest"),
    ]),
    ColorTokenGroup(title: "Border", tokens: [
      ColorTokenSpec(.borderAbsoluteWhite,   "border-absolute-white"),
      ColorTokenSpec(.borderNeutral,         "border-neutral"),
      ColorTokenSpec(.borderNeutralHeavy,    "border-neutral-heavy"),
      ColorTokenSpec(.borderNeutralHeavier,  "border-neutral-heavier"),
    ]),
    ColorTokenGroup(title: "Fill (Absolute)", tokens: [
      ColorTokenSpec(.fillAbsoluteBlack,      "fill-absolute-black"),
      ColorTokenSpec(.fillAbsoluteBlackLight, "fill-absolute-black-light"),
      ColorTokenSpec(.fillAbsoluteWhite,      "fill-absolute-white"),
      ColorTokenSpec(.fillAbsoluteWhiteLight, "fill-absolute-white-light"),
    ]),
    ColorTokenGroup(title: "Fill (Neutral)", tokens: [
      ColorTokenSpec(.fillNeutralLightest,  "fill-neutral-lightest"),
      ColorTokenSpec(.fillNeutralLighter,   "fill-neutral-lighter"),
      ColorTokenSpec(.fillNeutralLight,     "fill-neutral-light"),
      ColorTokenSpec(.fillNeutralHeavy,     "fill-neutral-heavy"),
      ColorTokenSpec(.fillNeutralHeavier,   "fill-neutral-heavier"),
      ColorTokenSpec(.fillNeutralHeaviest,  "fill-neutral-heaviest"),
    ]),
    ColorTokenGroup(title: "Fill (Accent)", tokens: [
      ColorTokenSpec(.fillAccentBlue,   "fill-accent-blue"),
      ColorTokenSpec(.fillAccentCobalt, "fill-accent-cobalt"),
      ColorTokenSpec(.fillAccentGreen,  "fill-accent-green"),
      ColorTokenSpec(.fillAccentNavy,   "fill-accent-navy"),
      ColorTokenSpec(.fillAccentOlive,  "fill-accent-olive"),
      ColorTokenSpec(.fillAccentOrange, "fill-accent-orange"),
      ColorTokenSpec(.fillAccentPink,   "fill-accent-pink"),
      ColorTokenSpec(.fillAccentPurple, "fill-accent-purple"),
      ColorTokenSpec(.fillAccentRed,    "fill-accent-red"),
      ColorTokenSpec(.fillAccentTeal,   "fill-accent-teal"),
      ColorTokenSpec(.fillAccentYellow, "fill-accent-yellow"),
    ]),
    ColorTokenGroup(title: "Fill (Status)", tokens: [
      ColorTokenSpec(.fillAction,    "fill-action"),
      ColorTokenSpec(.fillCritical,  "fill-critical"),
      ColorTokenSpec(.fillHighlight, "fill-highlight"),
      ColorTokenSpec(.fillSuccess,   "fill-success"),
      ColorTokenSpec(.fillWarning,   "fill-warning"),
    ]),
    ColorTokenGroup(title: "Text", tokens: [
      ColorTokenSpec(.textNeutral,         "text-neutral"),
      ColorTokenSpec(.textNeutralLight,    "text-neutral-light"),
      ColorTokenSpec(.textNeutralLighter,  "text-neutral-lighter"),
      ColorTokenSpec(.textNeutralHeaviest, "text-neutral-heaviest"),
      ColorTokenSpec(.textInverse,         "text-inverse"),
      ColorTokenSpec(.textAction,          "text-action"),
      ColorTokenSpec(.textCritical,        "text-critical"),
      ColorTokenSpec(.textHighlight,       "text-highlight"),
      ColorTokenSpec(.textSuccess,         "text-success"),
      ColorTokenSpec(.textWarning,         "text-warning"),
    ]),
    ColorTokenGroup(title: "Icon", tokens: [
      ColorTokenSpec(.iconNeutral,         "icon-neutral"),
      ColorTokenSpec(.iconNeutralHeavy,    "icon-neutral-heavy"),
      ColorTokenSpec(.iconNeutralHeavier,  "icon-neutral-heavier"),
      ColorTokenSpec(.iconAction,          "icon-action"),
      ColorTokenSpec(.iconCritical,        "icon-critical"),
      ColorTokenSpec(.iconHighlight,       "icon-highlight"),
      ColorTokenSpec(.iconSuccess,         "icon-success"),
      ColorTokenSpec(.iconWarning,         "icon-warning"),
    ]),
    ColorTokenGroup(title: "Dim", tokens: [
      ColorTokenSpec(.dimAbsoluteBlack,      "dim-absolute-black"),
      ColorTokenSpec(.dimAbsoluteBlackHeavy, "dim-absolute-black-heavy"),
      ColorTokenSpec(.dimAbsoluteWhite,      "dim-absolute-white"),
      ColorTokenSpec(.dimAbsoluteWhiteHeavy, "dim-absolute-white-heavy"),
    ]),
  ]
}

private struct ColorTokenSpec: Identifiable {
  let token: BCSemanticToken
  let name: String
  var id: String { self.name }
  init(_ token: BCSemanticToken, _ name: String) {
    self.token = token
    self.name = name
  }
}

// MARK: - SwiftUI grid

private struct SwiftUISwatchGrid: View {
  let tokens: [ColorTokenSpec]
  @Environment(\.colorScheme) private var colorScheme

  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.tokens) { spec in
        VStack(alignment: .leading, spacing: 6) {
          RoundedRectangle(cornerRadius: 6)
            .fill(self.colorScheme == .dark ? spec.token.dark.color : spec.token.light.color)
            .frame(height: 44)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.25))
            )
          Text(spec.name)
            .font(.system(size: 10))
            .lineLimit(2)
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}

// MARK: - UIKit grid

private struct UIKitSwatchGrid: View {
  let tokens: [ColorTokenSpec]

  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.tokens) { spec in
        VStack(alignment: .leading, spacing: 6) {
          UIKitWrap {
            let view = UIView()
            view.backgroundColor = spec.token.palette(BezierExamplesComponent.shared)
            view.layer.cornerRadius = 6
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.separator.cgColor
            return view
          }
          .frame(height: 44)
          Text(spec.name)
            .font(.system(size: 10))
            .lineLimit(2)
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}
