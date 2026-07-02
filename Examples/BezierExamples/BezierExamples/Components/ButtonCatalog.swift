import SwiftUI
import UIKit
import BezierSwift

struct ButtonCatalog: View {
  @State private var size: BezierButtonSize = .medium
  @State private var variant: BezierButtonVariant = .filled
  @State private var semantic: BezierButtonSemantic = .primary
  @State private var title: String = "Label"
  @State private var hasLeadingIcon: Bool = false
  @State private var hasTrailingIcon: Bool = false
  @State private var isLoading: Bool = false
  @State private var isEnabled: Bool = true

  var body: some View {
    CatalogScreen(title: "Button") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Matrix (medium · variant × semantic)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIMatrix }
      CatalogSection(.uiKit) { self.uiKitMatrix }
      Text("Loading colors (large · variant × semantic)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUILoadingColorMatrix }
      CatalogSection(.uiKit) { self.uiKitLoadingColorMatrix }
      Text("Loading sizes (filled · primary · size scale)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUILoadingSizeMatrix }
      CatalogSection(.uiKit) { self.uiKitLoadingSizeMatrix }
    }
  }

  // MARK: - Controls

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierButtonSize.allCases)
      LabeledSegmented(label: "Variant", selection: self.$variant, options: BezierButtonVariant.allCases)
      LabeledSegmented(label: "Semantic", selection: self.$semantic, options: BezierButtonSemantic.allCases)
      HStack(spacing: 8) {
        Text("Title")
          .font(.caption)
          .foregroundStyle(.secondary)
          .frame(width: 72, alignment: .leading)
        TextField("Title", text: self.$title)
          .textFieldStyle(.roundedBorder)
      }
      Toggle("Leading Icon", isOn: self.$hasLeadingIcon).font(.callout)
      Toggle("Trailing Icon", isOn: self.$hasTrailingIcon).font(.callout)
      Toggle("Loading", isOn: self.$isLoading).font(.callout)
      Toggle("Enabled", isOn: self.$isEnabled).font(.callout)
    }
  }

  // MARK: - Preview

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierButton(
        size: self.size,
        variant: self.variant,
        semantic: self.semantic,
        title: self.title.isEmpty ? nil : self.title,
        leadingIcon: self.hasLeadingIcon ? Image(systemName: "star.fill") : nil,
        trailingIcon: self.hasTrailingIcon ? Image(systemName: "arrow.right") : nil,
        isLoading: self.isLoading,
        action: {}
      )
      .disabled(!self.isEnabled)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        {
          BezierButton(size: self.size, variant: self.variant, semantic: self.semantic)
        },
        update: { button in
          button.size = self.size
          button.variant = self.variant
          button.semantic = self.semantic
          button.title = self.title.isEmpty ? nil : self.title
          button.leadingIcon = self.hasLeadingIcon ? UIImage(systemName: "star.fill") : nil
          button.trailingIcon = self.hasTrailingIcon ? UIImage(systemName: "arrow.right") : nil
          button.isLoading = self.isLoading
          button.isEnabled = self.isEnabled
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  // MARK: - Matrix

  private var swiftUIMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue)
            .font(.caption2)
            .foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
              SUBezierButton(
                size: .medium,
                variant: variant,
                semantic: semantic,
                title: semantic.rawValue.capitalized,
                action: {}
              )
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var uiKitMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue)
            .font(.caption2)
            .foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
              UIKitWrap {
                let button = BezierButton(size: .medium, variant: variant, semantic: semantic)
                button.title = semantic.rawValue.capitalized
                return button
              }
              .fixedSize()
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  // MARK: - Loading Matrices

  private var swiftUILoadingColorMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
              SUBezierButton(
                size: .large,
                variant: variant,
                semantic: semantic,
                title: semantic.rawValue.capitalized,
                isLoading: true,
                action: {}
              )
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var uiKitLoadingColorMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
              UIKitWrap {
                let button = BezierButton(size: .large, variant: variant, semantic: semantic)
                button.title = semantic.rawValue.capitalized
                button.isLoading = true
                return button
              }
              .fixedSize()
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var swiftUILoadingSizeMatrix: some View {
    HStack(spacing: 8) {
      ForEach(BezierButtonSize.allCases, id: \.self) { size in
        SUBezierButton(
          size: size,
          variant: .filled,
          semantic: .primary,
          title: size.rawValue,
          isLoading: true,
          action: {}
        )
      }
      Spacer(minLength: 0)
    }
  }

  private var uiKitLoadingSizeMatrix: some View {
    HStack(spacing: 8) {
      ForEach(BezierButtonSize.allCases, id: \.self) { size in
        UIKitWrap {
          let button = BezierButton(size: size, variant: .filled, semantic: .primary)
          button.title = size.rawValue
          button.isLoading = true
          return button
        }
        .fixedSize()
      }
      Spacer(minLength: 0)
    }
  }
}
