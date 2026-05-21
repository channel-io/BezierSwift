//
//  SUBezierAvatarGroup.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierAvatarGroup: View, Themeable {
  private let avatars: [Image?]
  private let size: BezierAvatarGroupSize
  private let ellipsisType: BezierAvatarGroupEllipsisType

  @Environment(\.colorScheme) public var colorScheme

  public init(
    avatars: [Image?] = [],
    size: BezierAvatarGroupSize = .size20,
    ellipsisType: BezierAvatarGroupEllipsisType = .icon
  ) {
    self.avatars = avatars
    self.size = size
    self.ellipsisType = ellipsisType
  }

  public var body: some View {
    let maxVisible = BezierAvatarGroupConstant.maxVisibleAvatars
    let visibleCount = min(self.avatars.count, maxVisible)
    let hasOverflow = self.avatars.count > maxVisible
    let stride: CGFloat = {
      switch self.ellipsisType {
      case .icon:  return self.size.iconVariantStride
      case .count: return self.size.countVariantStride
      }
    }()
    let avatarLength = self.size.avatarLength

    let totalWidth = self.totalWidth(visibleCount: visibleCount, hasOverflow: hasOverflow, stride: stride)

    return ZStack(alignment: .topLeading) {
      ForEach(0..<visibleCount, id: \.self) { index in
        SUBezierAvatar(image: self.avatars[index], size: self.size.avatarSize, showBorder: false)
          .offset(x: CGFloat(index) * stride, y: 0)
      }

      if hasOverflow {
        switch self.ellipsisType {
        case .icon:
          self.ellipsisIconView
            .offset(x: CGFloat(maxVisible) * stride, y: 0)
        case .count:
          self.ellipsisCountView
            .offset(x: CGFloat(visibleCount - 1) * stride + avatarLength + self.size.countTextSpacing, y: 0)
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
        let labelWidth = self.size.countTextContainerFixedWidth ?? self.intrinsicCountTextWidth(overflowCount: overflowCount)
        let lastAvatarRight = CGFloat(visibleCount - 1) * stride + avatarLength
        return lastAvatarRight + self.size.countTextSpacing + labelWidth
      }
    } else if visibleCount > 0 {
      return CGFloat(visibleCount - 1) * stride + avatarLength
    }
    return 0
  }

  private func intrinsicCountTextWidth(overflowCount: Int) -> CGFloat {
    let attributedString = self.size.countTextToken.attributedString(
      placeholderComponent(),
      text: "+\(overflowCount)",
      semanticColorToken: .textNeutralLighter,
      alignment: .center
    )
    return ceil(attributedString.size().width)
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

      RoundedRectangle(cornerRadius: self.size.avatarSize.cornerRadius, style: .continuous)
        .strokeBorder(self.palette(BCSemanticToken.surface), lineWidth: self.size.avatarSize.borderWidth)
        .frame(width: self.size.avatarLength, height: self.size.avatarLength)
    }
    .frame(width: self.size.avatarLength, height: self.size.avatarLength, alignment: .topLeading)
  }

  private var ellipsisCountView: some View {
    let overflowCount = self.avatars.count - BezierAvatarGroupConstant.maxVisibleAvatars
    let labelWidth = self.size.countTextContainerFixedWidth ?? self.intrinsicCountTextWidth(overflowCount: overflowCount)
    return Text("+\(overflowCount)")
      .applyBezierFontStyle(self.size.countTextToken, semanticColorToken: .textNeutralLighter)
      .multilineTextAlignment(.center)
      .frame(width: labelWidth, height: self.size.avatarLength, alignment: .center)
  }
}

// MARK: - Helper

/// SwiftUI 컨텍스트에서 NSAttributedString 사이즈 계산용 dummy component.
private func placeholderComponent() -> BezierComponentable {
  return SUBezierAvatarGroupSizingProxy()
}

private final class SUBezierAvatarGroupSizingProxy: BezierComponentable {
  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal
}

// MARK: - Preview

struct SUBezierAvatarGroup_Previews: PreviewProvider {
  static var previews: some View {
    let sampleAvatars: [Image] = [
      Image(systemName: "person.crop.circle.fill"),
      Image(systemName: "person.crop.circle.fill"),
      Image(systemName: "person.crop.circle.fill"),
      Image(systemName: "person.crop.circle.fill"),
      Image(systemName: "person.crop.circle.fill"),
    ]
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("size=20, icon").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(avatars: sampleAvatars, size: .size20, ellipsisType: .icon)

        Text("size=20, count").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(avatars: sampleAvatars, size: .size20, ellipsisType: .count)

        Text("size=24, icon").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(avatars: sampleAvatars, size: .size24, ellipsisType: .icon)

        Text("size=24, count").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(avatars: sampleAvatars, size: .size24, ellipsisType: .count)

        Text("size=24, count, +12").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(
          avatars: sampleAvatars + Array(repeating: Image(systemName: "person.crop.circle.fill"), count: 10),
          size: .size24,
          ellipsisType: .count
        )

        Text("size=24, ≤3 avatars (no ellipsis)").font(.caption.weight(.semibold))
        SUBezierAvatarGroup(
          avatars: Array(sampleAvatars.prefix(2)),
          size: .size24,
          ellipsisType: .count
        )
      }
      .padding()
    }
  }
}
