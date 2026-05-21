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
    .init(title: "Background", tokens: [
      .init(.bgBlackDark,        "bg-black-dark"),
      .init(.bgBlackDarker,      "bg-black-darker"),
      .init(.bgBlackDarkest,     "bg-black-darkest"),
      .init(.bgBlackLight,       "bg-black-light"),
      .init(.bgBlackLighter,     "bg-black-lighter"),
      .init(.bgBlackLightest,    "bg-black-lightest"),
      .init(.bgGrey,             "bg-grey"),
      .init(.bgGreyDark,         "bg-grey-dark"),
      .init(.bgGreyLight,        "bg-grey-light"),
      .init(.bgWhiteHigh,        "bg-white-high"),
      .init(.bgWhiteLow,         "bg-white-low"),
      .init(.bgWhiteNormal,      "bg-white-normal"),
    ]),
    .init(title: "Border", tokens: [
      .init(.borderAbsoluteWhite, "border-absolute-white"),
      .init(.borderNeutral,       "border-neutral"),
      .init(.borderNeutralHeavy,  "border-neutral-heavy"),
      .init(.borderNeutralHeavier,"border-neutral-heavier"),
    ]),
    .init(title: "Fill (Absolute)", tokens: [
      .init(.fillAbsoluteBlack,  "fill-absolute-black"),
      .init(.fillAbsoluteWhite,  "fill-absolute-white"),
    ]),
    .init(title: "Fill (Accent)", tokens: [
      .init(.fillAccentBlue,    "fill-accent-blue"),
      .init(.fillAccentCobalt,  "fill-accent-cobalt"),
      .init(.fillAccentGreen,   "fill-accent-green"),
      .init(.fillAccentNavy,    "fill-accent-navy"),
      .init(.fillAccentOlive,   "fill-accent-olive"),
      .init(.fillAccentOrange,  "fill-accent-orange"),
      .init(.fillAccentPink,    "fill-accent-pink"),
      .init(.fillAccentPurple,  "fill-accent-purple"),
      .init(.fillAccentRed,     "fill-accent-red"),
      .init(.fillAccentTeal,    "fill-accent-teal"),
    ]),
    .init(title: "Text", tokens: [
      .init(.textNeutral,         "text-neutral"),
      .init(.textNeutralLight,    "text-neutral-light"),
      .init(.textNeutralLighter,  "text-neutral-lighter"),
      .init(.textNeutralHeavier,  "text-neutral-heavier"),
      .init(.textNeutralHeaviest, "text-neutral-heaviest"),
      .init(.textInverse,         "text-inverse"),
      .init(.textSuccess,         "text-success"),
      .init(.textWarning,         "text-warning"),
    ]),
    .init(title: "Dim", tokens: [
      .init(.dimAbsoluteBlack,        "dim-absolute-black"),
      .init(.dimAbsoluteBlackHeavy,   "dim-absolute-black-heavy"),
      .init(.dimAbsoluteWhite,        "dim-absolute-white"),
      .init(.dimAbsoluteWhiteHeavy,   "dim-absolute-white-heavy"),
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
