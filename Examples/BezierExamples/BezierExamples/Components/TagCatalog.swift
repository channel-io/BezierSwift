import SwiftUI
import UIKit
import BezierSwift

struct TagCatalog: View {
  @State private var size: BezierTagSize = .small
  @State private var variant: BezierTagVariant = .default
  @State private var label: String = "Label"
  @State private var hasDeleteAction: Bool = false
  @State private var deleteCount: Int = 0

  var body: some View {
    CatalogScreen(title: "Tag") {
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
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierTagSize.allCases)
      HStack(spacing: 8) {
        Text("Variant").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierTagVariant.allCases, id: \.self) { v in
            Text(v.rawValue).tag(v)
          }
        }
        .pickerStyle(.menu)
      }
      HStack(spacing: 8) {
        Text("Label").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        TextField("Label", text: self.$label).textFieldStyle(.roundedBorder)
      }
      Toggle("Deletable", isOn: self.$hasDeleteAction).font(.callout)
      if self.hasDeleteAction {
        Text("Deleted: \(self.deleteCount)")
          .font(.caption2)
          .foregroundStyle(.secondary)
      }
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierTag(
        size: self.size,
        variant: self.variant,
        label: self.label.isEmpty ? nil : self.label,
        onDelete: self.hasDeleteAction ? { self.deleteCount += 1 } : nil
      )
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierTag(size: self.size, variant: self.variant) },
        update: { tag in
          tag.size = self.size
          tag.variant = self.variant
          tag.label = self.label.isEmpty ? nil : self.label
          tag.onDelete = self.hasDeleteAction ? { self.deleteCount += 1 } : nil
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierTagVariant.allCases, id: \.self) { variant in
        SUBezierTag(size: .small, variant: variant, label: variant.rawValue)
      }
    }
  }

  private var uiKitVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierTagVariant.allCases, id: \.self) { variant in
        UIKitWrap {
          let tag = BezierTag(size: .small, variant: variant)
          tag.label = variant.rawValue
          return tag
        }
        .fixedSize()
      }
    }
  }
}
