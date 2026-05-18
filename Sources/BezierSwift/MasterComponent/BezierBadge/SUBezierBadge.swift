//
//  SUBezierBadge.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierBadge: View, Themeable {
  private let size: BezierBadgeSize
  private let variant: BezierBadgeVariant
  private let shape: BezierBadgeShape
  private let leadingIcon: Image?

  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierBadgeSize = .small,
    variant: BezierBadgeVariant = .default,
    shape: BezierBadgeShape,
    leadingIcon: Image? = nil
  ) {
    self.size = size
    self.variant = variant
    self.shape = shape
    self.leadingIcon = leadingIcon
  }

  public var body: some View {
    if self.shape.isDot {
      Circle()
        .fill(self.palette(self.variant.backgroundToken))
        .frame(width: self.size.dotLength, height: self.size.dotLength)
    } else {
      HStack(spacing: 0) {
        if let leadingIcon = self.leadingIcon {
          self.iconView(leadingIcon)
        }
        if let text = self.shape.displayText, !text.isEmpty {
          Text(text)
            .applyBezierFontStyle(
              self.size.typography,
              semanticColorToken: self.variant.foregroundToken
            )
            .padding(.horizontal, self.size.textHorizontalPadding)
            .fixedSize(horizontal: true, vertical: false)
        }
      }
      .padding(.horizontal, self.size.horizontalPadding)
      .frame(minHeight: self.size.height, maxHeight: self.size.height)
      .frame(minWidth: self.size.height)
      .background(Capsule().fill(self.palette(self.variant.backgroundToken)))
      .clipShape(Capsule())
    }
  }

  private func iconView(_ image: Image) -> some View {
    image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .frame(width: self.size.iconLength, height: self.size.iconLength)
      .foregroundColor(self.palette(self.variant.foregroundToken))
  }
}

extension View {
  public func bezierBadge(
    _ shape: BezierBadgeShape,
    size: BezierBadgeSize = .small,
    variant: BezierBadgeVariant = .default,
    leadingIcon: Image? = nil,
    alignment: Alignment = .topTrailing
  ) -> some View {
    self.overlay(alignment: alignment) {
      SUBezierBadge(
        size: size,
        variant: variant,
        shape: shape,
        leadingIcon: leadingIcon
      )
    }
  }
}

struct SUBezierBadge_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(BezierBadgeSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 8) {
            Text(size.rawValue)
              .font(.caption.weight(.semibold))
              .foregroundColor(.secondary)
            VariantRow(size: size, shape: .text("Badge"))
            VariantRow(size: size, shape: .text("Badge"), leadingIcon: Image(systemName: "plus"))
            VariantRow(size: size, shape: .numeric(7))
            VariantRow(size: size, shape: .numeric(150))
            VariantRow(size: size, shape: .dot)
          }
        }

        VStack(alignment: .leading, spacing: 8) {
          Text("Overlay modifier")
            .font(.caption.weight(.semibold))
            .foregroundColor(.secondary)
          HStack(spacing: 24) {
            Image(systemName: "bell.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 40)
              .bezierBadge(.numeric(7), size: .small, variant: .red)
            Image(systemName: "envelope.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 40)
              .bezierBadge(.dot, size: .small, variant: .red, alignment: .topTrailing)
            Image(systemName: "person.crop.circle")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 40)
              .bezierBadge(.text("NEW"), size: .xsmall, variant: .blue, alignment: .bottomTrailing)
          }
        }
      }
      .padding()
    }
  }

  private struct VariantRow: View {
    let size: BezierBadgeSize
    let shape: BezierBadgeShape
    var leadingIcon: Image? = nil

    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
            SUBezierBadge(size: size, variant: variant, shape: shape, leadingIcon: leadingIcon)
          }
        }
      }
    }
  }
}
