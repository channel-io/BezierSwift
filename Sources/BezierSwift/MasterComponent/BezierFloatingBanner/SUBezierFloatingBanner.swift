//
//  SUBezierFloatingBanner.swift
//  BezierSwift
//

import SwiftUI

/// 화면 위에 떠 있는 플로팅 배너 (SwiftUI). `surfaceHighest` 배경과 그림자로 콘텐츠 위에 부유하는 스낵바형 지속 메시지를 표현한다. 긴급·강조 상태 안내에 쓰며, 화면 내 고정 인라인 배너는 `SUBezierBanner`, 자동 소멸하는 즉각 피드백은 `SUBezierToast`를 쓴다. UIKit에서는 `BezierFloatingBanner`를 사용한다.
public struct SUBezierFloatingBanner: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let leadingIcon: BezierIcon?
  private let leadingIconColor: BCSemanticToken
  private let title: String?
  private let description: String
  private let clickArea: BezierFloatingBannerClickArea

  /// leading 아이콘·제목·본문·탭 동작을 지정해 배너를 만든다. `description`만 필수이며 나머지는 선택이다.
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
