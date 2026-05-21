import SwiftUI
import UIKit
import BezierSwift

struct IconButtonCatalog: View {
  @State private var size: BezierIconButtonSize = .medium
  @State private var variant: BezierIconButtonVariant = .ghost
  @State private var icon: BezierIcon = .star
  @State private var isLoading: Bool = false
  @State private var isEnabled: Bool = true

  var body: some View {
    CatalogScreen(title: "IconButton") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Matrix (variant × size)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIMatrix }
      CatalogSection(.uiKit) { self.uiKitMatrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierIconButtonSize.allCases)
      LabeledSegmented(label: "Variant", selection: self.$variant, options: BezierIconButtonVariant.allCases)
      Toggle("Loading", isOn: self.$isLoading).font(.callout)
      Toggle("Enabled", isOn: self.$isEnabled).font(.callout)
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierIconButton(
        size: self.size,
        variant: self.variant,
        icon: self.icon.image,
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
        { BezierIconButton(size: self.size, variant: self.variant) },
        update: { button in
          button.size = self.size
          button.variant = self.variant
          button.icon = self.icon.uiImage
          button.isLoading = self.isLoading
          button.isEnabled = self.isEnabled
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierIconButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierIconButtonSize.allCases, id: \.self) { size in
              SUBezierIconButton(size: size, variant: variant, icon: BezierIcon.star.image, action: {})
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var uiKitMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierIconButtonVariant.allCases, id: \.self) { variant in
        VStack(alignment: .leading, spacing: 6) {
          Text(variant.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierIconButtonSize.allCases, id: \.self) { size in
              UIKitWrap {
                let button = BezierIconButton(size: size, variant: variant)
                button.icon = BezierIcon.star.uiImage
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
}
