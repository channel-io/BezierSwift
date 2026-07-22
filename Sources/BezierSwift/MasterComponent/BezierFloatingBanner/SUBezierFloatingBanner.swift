//
//  SUBezierFloatingBanner.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierFloatingBanner: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let leadingIcon: BezierIcon?
  private let leadingIconColor: BCSemanticToken
  private let title: String?
  private let description: String
  private let clickArea: BezierFloatingBannerClickArea

  public init(
    leadingIcon: BezierIcon? = nil,
    leadingIconColor: BCSemanticToken = BezierFloatingBannerConstant.defaultLeadingIconColor,
    title: String? = nil,
    description: String,
    clickArea: BezierFloatingBannerClickArea = .none
  ) {
    self.leadingIcon = leadingIcon
    self.leadingIconColor = leadingIconColor
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
    .padding(.leading, BezierFloatingBannerConstant.leadingPadding)
    .padding(.trailing, BezierFloatingBannerConstant.trailingPadding)
    .padding(.vertical, BezierFloatingBannerConstant.verticalPadding)
    .frame(minHeight: BezierFloatingBannerConstant.minHeight)
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: BezierFloatingBannerConstant.cornerRadius)
        .fill(self.palette(BezierFloatingBannerConstant.backgroundColor))
    )
    .applyBezierElevation(BezierFloatingBannerConstant.elevation)
  }

  @ViewBuilder
  private var leadingIconView: some View {
    if let leadingIcon = self.leadingIcon {
      leadingIcon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: BezierFloatingBannerConstant.iconLength, height: BezierFloatingBannerConstant.iconLength)
        .foregroundColor(self.palette(self.leadingIconColor))
        .padding(.leading, BezierFloatingBannerConstant.leadingIconLeadingPadding)
        .padding(.vertical, BezierFloatingBannerConstant.leadingIconVerticalPadding)
    }
  }

  private var contentView: some View {
    VStack(alignment: .leading, spacing: BezierFloatingBannerConstant.contentSpacing) {
      if let title = self.title {
        Text(title)
          .applyBezierFontStyle(
            BezierFloatingBannerConstant.titleTypography,
            semanticColorToken: BezierFloatingBannerConstant.textColor
          )
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      Text(self.description)
        .applyBezierFontStyle(
          BezierFloatingBannerConstant.descriptionTypography,
          semanticColorToken: BezierFloatingBannerConstant.textColor
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(BezierFloatingBannerConstant.contentPadding)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  private var actionIconView: some View {
    if let trailingIcon = self.clickArea.trailingIcon {
      let iconView = trailingIcon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: BezierFloatingBannerConstant.iconLength, height: BezierFloatingBannerConstant.iconLength)
        .foregroundColor(self.palette(BezierFloatingBannerConstant.actionIconColor))
        .padding(BezierFloatingBannerConstant.actionIconPadding)

      if case .actionIcon(let onClick) = self.clickArea {
        Button(action: onClick) { iconView }
          .buttonStyle(.plain)
      } else {
        iconView
      }
    }
  }
}

struct SUBezierFloatingBanner_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      SUBezierFloatingBanner(
        leadingIcon: .plus,
        title: "Banner Title",
        description: "Banner description text goes here.",
        clickArea: .actionIcon(onClick: {})
      )
      SUBezierFloatingBanner(
        description: "Floating banner without leading icon.",
        clickArea: .full(onClick: {})
      )
      SUBezierFloatingBanner(
        leadingIcon: .checkCircleFilled,
        leadingIconColor: .iconAccentGreen,
        title: "Success",
        description: "Saved successfully."
      )
    }
    .padding()
    .background(Color.gray.opacity(0.2))
  }
}
