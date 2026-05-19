//
//  SUBezierBadge.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierBadge: View, Themeable {
  private let size: BezierBadgeSize
  private let variant: BezierBadgeVariant
  private let label: String?
  private let leadingIcon: Image?

  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierBadgeSize = .small,
    variant: BezierBadgeVariant = .default,
    label: String? = nil,
    leadingIcon: Image? = nil
  ) {
    self.size = size
    self.variant = variant
    self.label = label
    self.leadingIcon = leadingIcon
  }

  public var body: some View {
    HStack(spacing: 0) {
      if let leadingIcon = self.leadingIcon {
        self.iconView(leadingIcon)
      }
      if let label = self.label, !label.isEmpty {
        // TYPO-MIGRATION: Figma raw 값을 직접 사용. 추후 BTSemanticToken으로 통합 예정 (BezierBadgeSpec.swift 참고).
        Text(label)
          .font(.system(size: self.size.fontSize, weight: self.size.fontWeight.swiftUIWeight))
          .tracking(self.size.letterSpacing)
          .lineSpacing(self.size.lineSpacing)
          .padding(.vertical, self.size.verticalLineSpacing)
          .foregroundColor(self.palette(self.variant.foregroundToken))
          .padding(.horizontal, self.size.textHorizontalPadding)
          .fixedSize(horizontal: true, vertical: false)
      }
    }
    .padding(.horizontal, self.size.horizontalPadding)
    .frame(minHeight: self.size.height, maxHeight: self.size.height)
    .background(Capsule().fill(self.palette(self.variant.backgroundToken)))
    .clipShape(Capsule())
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

struct SUBezierBadge_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(BezierBadgeSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 8) {
            Text(size.rawValue)
              .font(.caption.weight(.semibold))
              .foregroundColor(.secondary)
            VariantRow(size: size)
            VariantRow(size: size, leadingIcon: Image(systemName: "plus"))
          }
        }
      }
      .padding()
    }
  }

  private struct VariantRow: View {
    let size: BezierBadgeSize
    var leadingIcon: Image? = nil

    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
            SUBezierBadge(size: size, variant: variant, label: "Badge", leadingIcon: leadingIcon)
          }
        }
      }
    }
  }
}
