//
//  SUBezierTag.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierTag: View, Themeable {
  private let size: BezierTagSize
  private let variant: BezierTagVariant
  private let label: String?
  private let closeIcon: Image
  private let onDelete: (() -> Void)?

  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierTagSize = .small,
    variant: BezierTagVariant = .default,
    label: String? = nil,
    closeIcon: Image = BezierIcon.cancelSmall.image,
    onDelete: (() -> Void)? = nil
  ) {
    self.size = size
    self.variant = variant
    self.label = label
    self.closeIcon = closeIcon
    self.onDelete = onDelete
  }

  public var body: some View {
    HStack(spacing: 0) {
      if let label = self.label, !label.isEmpty {
        // TYPO-MIGRATION: Figma raw 값을 직접 사용. 추후 BTSemanticToken으로 통합 예정 (BezierTagSpec.swift 참고).
        Text(label)
          .font(.system(size: self.size.fontSize, weight: self.size.fontWeight.swiftUIWeight))
          .tracking(self.size.letterSpacing)
          .lineSpacing(self.size.lineSpacing)
          .padding(.vertical, self.size.verticalLineSpacing)
          .foregroundColor(self.palette(self.variant.foregroundToken))
          .padding(.horizontal, self.size.textHorizontalPadding)
          .fixedSize(horizontal: true, vertical: false)
      }
      if let onDelete = self.onDelete {
        Button(action: onDelete) {
          self.closeIcon
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: self.size.closeIconLength, height: self.size.closeIconLength)
            .foregroundColor(self.palette(self.variant.foregroundToken))
        }
        .buttonStyle(.plain)
      }
    }
    .padding(.horizontal, self.size.horizontalPadding)
    .frame(minHeight: self.size.height, maxHeight: self.size.height)
    .background(Capsule().fill(self.palette(self.variant.backgroundToken)))
    .clipShape(Capsule())
  }
}

struct SUBezierTag_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(BezierTagSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 8) {
            Text(size.rawValue)
              .font(.caption.weight(.semibold))
              .foregroundColor(.secondary)
            VariantRow(size: size)
            VariantRow(size: size, hasOnDelete: true)
          }
        }
      }
      .padding()
    }
  }

  private struct VariantRow: View {
    let size: BezierTagSize
    var hasOnDelete: Bool = false

    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(BezierTagVariant.allCases, id: \.self) { variant in
            SUBezierTag(
              size: size,
              variant: variant,
              label: "Tag",
              onDelete: hasOnDelete ? {} : nil
            )
          }
        }
      }
    }
  }
}
