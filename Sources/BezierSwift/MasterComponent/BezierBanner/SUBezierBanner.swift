//
//  SUBezierBanner.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierBanner: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let variant: BezierBannerVariant
  private let leadingIcon: BezierIcon?
  private let title: String?
  private let description: String
  private let clickArea: BezierBannerClickArea

  public init(
    variant: BezierBannerVariant = .default,
    leadingIcon: BezierIcon? = nil,
    title: String? = nil,
    description: String,
    clickArea: BezierBannerClickArea = .none
  ) {
    self.variant = variant
    self.leadingIcon = leadingIcon
    self.title = title
    self.description = description
    self.clickArea = clickArea
  }

  @ViewBuilder
  public var body: some View {
    if case .full(let onClick) = self.clickArea {
      Button(action: onClick) { self.container }
        .buttonStyle(.plain)
    } else {
      self.container
    }
  }

  private var container: some View {
    HStack(alignment: .top, spacing: 0) {
      self.leadingIconView
      self.contentView
      self.actionIconView
    }
    .padding(.horizontal, BezierBannerConstant.horizontalPadding)
    .padding(.vertical, BezierBannerConstant.verticalPadding)
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: BezierBannerConstant.cornerRadius)
        .fill(self.palette(self.variant.backgroundColor))
    )
  }

  @ViewBuilder
  private var leadingIconView: some View {
    if let leadingIcon = self.leadingIcon {
      leadingIcon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: BezierBannerConstant.iconLength, height: BezierBannerConstant.iconLength)
        .foregroundColor(self.palette(self.variant.iconColor))
        .padding(.leading, BezierBannerConstant.leadingIconLeadingPadding)
        .padding(.trailing, BezierBannerConstant.leadingIconTrailingPadding)
        .padding(.vertical, BezierBannerConstant.leadingIconVerticalPadding)
    }
  }

  private var contentView: some View {
    VStack(alignment: .leading, spacing: BezierBannerConstant.contentSpacing) {
      if let title = self.title {
        Text(title)
          .applyBezierFontStyle(
            BezierBannerConstant.titleTypography,
            semanticColorToken: self.variant.textColor
          )
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      Text(self.description)
        .applyBezierFontStyle(
          BezierBannerConstant.descriptionTypography,
          semanticColorToken: self.variant.textColor
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(BezierBannerConstant.contentPadding)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  private var actionIconView: some View {
    if let trailingIcon = self.clickArea.trailingIcon {
      let iconView = trailingIcon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: BezierBannerConstant.iconLength, height: BezierBannerConstant.iconLength)
        .foregroundColor(self.palette(self.variant.iconColor))
        .padding(BezierBannerConstant.actionIconPadding)

      if case .actionIcon(let onClick) = self.clickArea {
        Button(action: onClick) { iconView }
          .buttonStyle(.plain)
      } else {
        iconView
      }
    }
  }
}

struct SUBezierBanner_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      SUBezierBanner(
        leadingIcon: .info,
        title: "Banner Title",
        description: "Banner description text goes here.",
        clickArea: .actionIcon(onClick: {})
      )
      SUBezierBanner(
        variant: .red,
        leadingIcon: .errorTriangleFilled,
        description: "Something went wrong.",
        clickArea: .full(onClick: {})
      )
      SUBezierBanner(
        variant: .green,
        leadingIcon: .checkCircleFilled,
        title: "Success",
        description: "Saved successfully."
      )
    }
    .padding()
  }
}
