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
      ColorTokenSpec(.surfaceDefault,        "surface-default"),
      ColorTokenSpec(.surfaceLow,     "surface-low"),
      ColorTokenSpec(.surfaceHigh,    "surface-high"),
      ColorTokenSpec(.surfaceHigher,  "surface-higher"),
      ColorTokenSpec(.surfaceHighest, "surface-highest"),
    ]),
    ColorTokenGroup(title: "Border", tokens: [
      ColorTokenSpec(.borderAbsoluteWhite,   "border-absolute-white"),
      ColorTokenSpec(.borderNeutralDefault,         "border-neutral-default"),
      ColorTokenSpec(.borderNeutralHeavy,    "border-neutral-heavy"),
      ColorTokenSpec(.borderNeutralHeavier,  "border-neutral-heavier"),
    ]),
    ColorTokenGroup(title: "Fill (Absolute)", tokens: [
      ColorTokenSpec(.fillAbsoluteBlackDefault,      "fill-absolute-black-default"),
      ColorTokenSpec(.fillAbsoluteBlackLight, "fill-absolute-black-light"),
      ColorTokenSpec(.fillAbsoluteWhiteDefault,      "fill-absolute-white-default"),
      ColorTokenSpec(.fillAbsoluteWhiteLight, "fill-absolute-white-light"),
    ]),
    ColorTokenGroup(title: "Fill (Neutral)", tokens: [
      ColorTokenSpec(.fillNeutralDefault,          "fill-neutral-default"),
      ColorTokenSpec(.fillNeutralLightest,  "fill-neutral-lightest"),
      ColorTokenSpec(.fillNeutralLighter,   "fill-neutral-lighter"),
      ColorTokenSpec(.fillNeutralLight,     "fill-neutral-light"),
      ColorTokenSpec(.fillNeutralHeavy,     "fill-neutral-heavy"),
      ColorTokenSpec(.fillNeutralHeavier,   "fill-neutral-heavier"),
      ColorTokenSpec(.fillNeutralHeaviest,  "fill-neutral-heaviest"),
    ]),
    ColorTokenGroup(title: "Fill (Accent)", tokens: [
      ColorTokenSpec(.fillAccentBlueDefault,   "fill-accent-blue-default"),
      ColorTokenSpec(.fillAccentCobaltDefault, "fill-accent-cobalt-default"),
      ColorTokenSpec(.fillAccentGreenDefault,  "fill-accent-green-default"),
      ColorTokenSpec(.fillAccentNavyDefault,   "fill-accent-navy-default"),
      ColorTokenSpec(.fillAccentOliveDefault,  "fill-accent-olive-default"),
      ColorTokenSpec(.fillAccentOrangeDefault, "fill-accent-orange-default"),
      ColorTokenSpec(.fillAccentPinkDefault,   "fill-accent-pink-default"),
      ColorTokenSpec(.fillAccentPurpleDefault, "fill-accent-purple-default"),
      ColorTokenSpec(.fillAccentRedDefault,    "fill-accent-red-default"),
      ColorTokenSpec(.fillAccentTealDefault,   "fill-accent-teal-default"),
      ColorTokenSpec(.fillAccentYellowDefault, "fill-accent-yellow-default"),
    ]),
    ColorTokenGroup(title: "Fill (Status)", tokens: [
      ColorTokenSpec(.fillActionDefault,    "fill-action-default"),
      ColorTokenSpec(.fillCriticalDefault,  "fill-critical-default"),
      ColorTokenSpec(.fillHighlightDefault, "fill-highlight-default"),
      ColorTokenSpec(.fillSuccessDefault,   "fill-success-default"),
      ColorTokenSpec(.fillWarningDefault,   "fill-warning-default"),
    ]),
    ColorTokenGroup(title: "Text", tokens: [
      ColorTokenSpec(.textNeutralDefault,         "text-neutral-default"),
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
      ColorTokenSpec(.iconNeutralDefault,         "icon-neutral-default"),
      ColorTokenSpec(.iconNeutralHeavy,    "icon-neutral-heavy"),
      ColorTokenSpec(.iconNeutralHeavier,  "icon-neutral-heavier"),
      ColorTokenSpec(.iconAction,          "icon-action"),
      ColorTokenSpec(.iconCritical,        "icon-critical"),
      ColorTokenSpec(.iconHighlight,       "icon-highlight"),
      ColorTokenSpec(.iconSuccess,         "icon-success"),
      ColorTokenSpec(.iconWarning,         "icon-warning"),
    ]),
    ColorTokenGroup(title: "Dim", tokens: [
      ColorTokenSpec(.dimAbsoluteBlackDefault,      "dim-absolute-black-default"),
      ColorTokenSpec(.dimAbsoluteBlackHeavy, "dim-absolute-black-heavy"),
      ColorTokenSpec(.dimAbsoluteWhiteDefault,      "dim-absolute-white-default"),
      ColorTokenSpec(.dimAbsoluteWhiteHeavy, "dim-absolute-white-heavy"),
    ]),
    ColorTokenGroup(title: "State", tokens: [
      ColorTokenSpec(.stateActive,  "state-active"),
      ColorTokenSpec(.stateDefault, "state-default"),
      ColorTokenSpec(.stateFocus,   "state-focus"),
      ColorTokenSpec(.stateWarningDefault, "state-warning-default"),
    ]),
    ColorTokenGroup(title: "Chart", tokens: [
      ColorTokenSpec(.chartThemeDefault01, "chart-theme-default-01"),
      ColorTokenSpec(.chartThemeDefault02, "chart-theme-default-02"),
      ColorTokenSpec(.chartThemeDefault03, "chart-theme-default-03"),
      ColorTokenSpec(.chartThemeDefault04, "chart-theme-default-04"),
      ColorTokenSpec(.chartThemeDefault05, "chart-theme-default-05"),
      ColorTokenSpec(.chartThemeDefault06, "chart-theme-default-06"),
      ColorTokenSpec(.chartThemeDefault07, "chart-theme-default-07"),
      ColorTokenSpec(.chartThemeDefault08, "chart-theme-default-08"),
      ColorTokenSpec(.chartThemeDefault09, "chart-theme-default-09"),
      ColorTokenSpec(.chartThemeDefault10, "chart-theme-default-10"),
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
