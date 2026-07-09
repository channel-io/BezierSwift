//
//  SUBezierAvatarGroup.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierAvatarGroup: View, Themeable {
  private let avatars: [Image?]
  private let size: BezierAvatarGroupSize
  private let ellipsisType: BezierAvatarGroupEllipsisType
  private let overlap: Bool

  @Environment(\.colorScheme) public var colorScheme

  public init(
    avatars: [Image?] = [],
    size: BezierAvatarGroupSize = .size20,
    ellipsisType: BezierAvatarGroupEllipsisType = .icon,
    overlap: Bool = true
  ) {
    self.avatars = avatars
    self.size = size
    self.ellipsisType = ellipsisType
    self.overlap = overlap
  }

  public var body: some View {
    let maxVisible = BezierAvatarGroupConstant.maxVisibleAvatars
    let visibleCount = min(self.avatars.count, maxVisible)
    let hasOverflow = self.avatars.count > maxVisible
    let stride = self.size.stride(overlap: self.overlap)
    let avatarLength = self.size.avatarLength

    let totalWidth = self.totalWidth(visibleCount: visibleCount, hasOverflow: hasOverflow, stride: stride)

    return ZStack(alignment: .topLeading) {
      ForEach(0..<visibleCount, id: \.self) { index in
        SUBezierAvatar(image: self.avatars[index], size: self.size.avatarSize, showBorder: self.overlap)
          .offset(x: CGFloat(index) * stride, y: 0)
      }

      if hasOverflow {
        switch self.ellipsisType {
        case .icon:
          self.ellipsisIconView
            .offset(x: CGFloat(maxVisible) * stride, y: 0)
        case .count:
          self.ellipsisCountView
            .offset(
              x: CGFloat(visibleCount - 1) * stride + avatarLength + self.size.countTextSpacing(overlap: self.overlap),
              y: 0
            )
        }
      }
    }
    .frame(width: totalWidth, height: avatarLength, alignment: .topLeading)
  }

  // MARK: - Width Calculation

  private func totalWidth(visibleCount: Int, hasOverflow: Bool, stride: CGFloat) -> CGFloat {
    let avatarLength = self.size.avatarLength
    if hasOverflow {
      switch self.ellipsisType {
      case .icon:
        return CGFloat(BezierAvatarGroupConstant.maxVisibleAvatars) * stride + avatarLength
      case .count:
        let overflowCount = self.avatars.count - BezierAvatarGroupConstant.maxVisibleAvatars
        let labelWidth = self.size.countTextWidth(overflowCount: overflowCount)
        let lastAvatarRight = CGFloat(visibleCount - 1) * stride + avatarLength
        return lastAvatarRight + self.size.countTextSpacing(overlap: self.overlap) + labelWidth
      }
    } else if visibleCount > 0 {
      return CGFloat(visibleCount - 1) * stride + avatarLength
    }
    return 0
  }

  // MARK: - Ellipsis Layers

  private var ellipsisIconView: some View {
    ZStack(alignment: .topLeading) {
      SUBezierAvatar(image: self.avatars[BezierAvatarGroupConstant.maxVisibleAvatars], size: self.size.avatarSize, showBorder: false)

      RoundedRectangle(cornerRadius: self.size.avatarSize.cornerRadius, style: .continuous)
        .fill(self.palette(BCSemanticToken.dimAbsoluteBlack))
        .frame(width: self.size.avatarLength, height: self.size.avatarLength)

      BezierIcon.more.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: self.size.moreIconLength, height: self.size.moreIconLength)
        .foregroundColor(.white)
        .offset(x: self.size.moreIconInset, y: self.size.moreIconInset)

      if self.overlap {
        RoundedRectangle(cornerRadius: self.size.avatarSize.cornerRadius, style: .continuous)
          .strokeBorder(self.palette(BCSemanticToken.surface), lineWidth: self.size.borderWidth)
          .frame(width: self.size.avatarLength, height: self.size.avatarLength)
      }
    }
    .frame(width: self.size.avatarLength, height: self.size.avatarLength, alignment: .topLeading)
  }

  private var ellipsisCountView: some View {
    let overflowCount = self.avatars.count - BezierAvatarGroupConstant.maxVisibleAvatars
    let labelWidth = self.size.countTextWidth(overflowCount: overflowCount)
    return Text("+\(overflowCount)")
      .font(self.size.countFont.font)
      .foregroundColor(self.palette(BCSemanticToken.textNeutralLighter))
      .multilineTextAlignment(.center)
      .frame(width: labelWidth, height: self.size.avatarLength, alignment: .center)
  }
}

// MARK: - Preview

struct SUBezierAvatarGroup_Previews: PreviewProvider {
  static var previews: some View {
    let sampleAvatars: [Image] = Array(
      repeating: Image(systemName: "person.crop.circle.fill"),
      count: 5
    )
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        ForEach(BezierAvatarGroupSize.allCases, id: \.self) { size in
          Text(size.rawValue).font(.caption.weight(.semibold))
          HStack(spacing: 16) {
            SUBezierAvatarGroup(avatars: sampleAvatars, size: size, ellipsisType: .icon, overlap: true)
            SUBezierAvatarGroup(avatars: sampleAvatars, size: size, ellipsisType: .count, overlap: true)
          }
          HStack(spacing: 16) {
            SUBezierAvatarGroup(avatars: sampleAvatars, size: size, ellipsisType: .icon, overlap: false)
            SUBezierAvatarGroup(avatars: sampleAvatars, size: size, ellipsisType: .count, overlap: false)
          }
        }
      }
      .padding()
    }
  }
}
