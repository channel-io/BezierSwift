import SwiftUI
import UIKit
import BezierSwift

struct BadgeCatalog: View {
  @State private var size: BezierBadgeSize = .small
  @State private var variant: BezierBadgeVariant = .default
  @State private var label: String = "Label"
  @State private var hasLeadingIcon: Bool = false

  var body: some View {
    CatalogScreen(title: "Badge") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Variants (size: small)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIVariantGrid }
      CatalogSection(.uiKit) { self.uiKitVariantGrid }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierBadgeSize.allCases)
      HStack(spacing: 8) {
        Text("Variant").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierBadgeVariant.allCases, id: \.self) { v in
            Text(v.rawValue).tag(v)
          }
        }
        .pickerStyle(.menu)
      }
      HStack(spacing: 8) {
        Text("Label").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        TextField("Label", text: self.$label).textFieldStyle(.roundedBorder)
      }
      Toggle("Leading Icon", isOn: self.$hasLeadingIcon).font(.callout)
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierBadge(
        size: self.size,
        variant: self.variant,
        label: self.label.isEmpty ? nil : self.label,
        leadingIcon: self.hasLeadingIcon ? BezierIcon.star.image : nil
      )
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierBadge(size: self.size, variant: self.variant) },
        update: { badge in
          badge.size = self.size
          badge.variant = self.variant
          badge.label = self.label.isEmpty ? nil : self.label
          badge.leadingIcon = self.hasLeadingIcon ? BezierIcon.star.uiImage : nil
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
        SUBezierBadge(size: .small, variant: variant, label: variant.rawValue)
      }
    }
  }

  private var uiKitVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
        UIKitWrap {
          let badge = BezierBadge(size: .small, variant: variant)
          badge.label = variant.rawValue
          return badge
        }
        .fixedSize()
      }
    }
  }
}
