//
//  SUBezierSectionItem.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierSection` 안에 넣는 리스트 행 아이템 (SwiftUI). leading · 텍스트 · description · centerSlot · 우측 accessory로 구성되며 탭·pressed·disabled를 지원한다. 섹션 밖 독립 리스트 행에는 `SUBezierBaseItem`을 쓴다. UIKit에서는 `BezierSectionItem`을 사용한다.
public struct SUBezierSectionItem<CenterSlot: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled

  private let size: BezierSectionItemSize
  private let content: String
  private let itemDescription: String?
  private let leading: BezierSectionItemLeading<AnyView>
  private let customCenterContent: AnyView?
  private let accessory: BezierSectionItemAccessory<AnyView>?
  private let isDestructive: Bool
  private let onTap: (() -> Void)?
  private let centerSlot: CenterSlot

  /// size·본문·description·leading·accessory·탭 핸들러와 `centerSlot` 빌더로 행을 만든다.
  public init(
    size: BezierSectionItemSize = .medium,
    content: String,
    description: String? = nil,
    leading: BezierSectionItemLeading<AnyView> = .none,
    customCenterContent: AnyView? = nil,
    accessory: BezierSectionItemAccessory<AnyView>? = nil,
    isDestructive: Bool = false,
    onTap: (() -> Void)? = nil,
    @ViewBuilder centerSlot: () -> CenterSlot
  ) {
    self.size = size
    self.content = content
    self.itemDescription = description
    self.leading = leading
    self.customCenterContent = customCenterContent
    self.accessory = accessory
    self.isDestructive = isDestructive
    self.onTap = onTap
    self.centerSlot = centerSlot()
  }

  public var body: some View {
    Group {
      if let onTap = self.onTap {
        Button(action: onTap) { self.row }
          .buttonStyle(SUBezierSectionItemStyle(size: self.size))
      } else {
        self.row.modifier(SUBezierSectionItemContainer(size: self.size, isPressed: false))
      }
    }
    .opacity(self.isEnabled ? 1 : BezierSectionItemConstant.disabledOpacity)
    .allowsHitTesting(self.isEnabled)
  }

  private var row: some View {
    HStack(spacing: BezierSectionItemConstant.slotSpacing) {
      self.contentColumn
      self.accessoryView
    }
  }

  private var contentColumn: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: BezierSectionItemConstant.slotSpacing) {
        self.leadingView

        VStack(
          alignment: .leading,
          spacing: BezierSectionItemConstant.nestedDescriptionSpacing
        ) {
          self.labelRow

          if self.size.isDescriptionNested {
            self.descriptionView
          }
        }
      }

      if !self.size.isDescriptionNested {
        self.descriptionView
          .padding(
            .leading,
            self.leading.hasLeadingContent ? BezierSectionItemConstant.descriptionIndent : 0
          )
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var labelRow: some View {
    HStack(spacing: BezierSectionItemConstant.labelRowSpacing) {
      if self.leading.isCustom, let customCenterContent = self.customCenterContent {
        customCenterContent
      } else if !self.content.isEmpty {
        Text(self.content)
          .applyBezierFontStyle(
            BezierSectionItemConstant.contentTypography,
            semanticColorToken: self.isDestructive
              ? BezierSectionItemConstant.destructiveContentColor
              : BezierSectionItemConstant.contentColor
          )
          .lineLimit(1)
          .truncationMode(.tail)
      }

      if !self.leading.isCustom, CenterSlot.self != EmptyView.self {
        self.centerSlot
          .frame(height: BezierSectionItemConstant.centerSlotHeight)
      }

      Spacer(minLength: 0)
    }
  }

  @ViewBuilder
  private var leadingView: some View {
    switch self.leading {
    case .none:
      EmptyView()
    case .icon(let icon):
      icon.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .foregroundColor(
          self.palette(
            self.isDestructive
              ? BezierSectionItemConstant.destructiveIconColor
              : BezierSectionItemConstant.leadingIconColor
          )
        )
        .frame(
          width: self.leading.leadingLength(size: self.size),
          height: self.leading.leadingLength(size: self.size)
        )
    case .avatar(let view), .custom(let view):
      view
        .frame(
          width: self.leading.leadingLength(size: self.size),
          height: self.leading.leadingLength(size: self.size)
        )
    }
  }

  @ViewBuilder
  private var descriptionView: some View {
    if !self.leading.isCustom, let itemDescription = self.itemDescription, !itemDescription.isEmpty {
      Text(itemDescription)
        .applyBezierFontStyle(
          BezierSectionItemConstant.descriptionTypography,
          semanticColorToken: BezierSectionItemConstant.descriptionColor
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  @ViewBuilder
  private var accessoryView: some View {
    if let accessory = self.accessory {
      SUBezierSectionItemAccessoryView(accessory: accessory)
    }
  }
}

// MARK: - Convenience init (centerSlot 생략)

extension SUBezierSectionItem where CenterSlot == EmptyView {
  /// centerSlot 없이 만드는 편의 이니셜라이저.
  public init(
    size: BezierSectionItemSize = .medium,
    content: String,
    description: String? = nil,
    leading: BezierSectionItemLeading<AnyView> = .none,
    customCenterContent: AnyView? = nil,
    accessory: BezierSectionItemAccessory<AnyView>? = nil,
    isDestructive: Bool = false,
    onTap: (() -> Void)? = nil
  ) {
    self.init(
      size: size,
      content: content,
      description: description,
      leading: leading,
      customCenterContent: customCenterContent,
      accessory: accessory,
      isDestructive: isDestructive,
      onTap: onTap,
      centerSlot: { EmptyView() }
    )
  }
}

// MARK: - Container

private struct SUBezierSectionItemContainer: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let size: BezierSectionItemSize
  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .bezierPressScale(isPressed: self.isPressed)
      .padding(.horizontal, BezierSectionItemConstant.horizontalPadding)
      .padding(.vertical, self.size.verticalPadding)
      .frame(minHeight: self.size.minHeight)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        self.isPressed
          ? self.palette(BezierSectionItemConstant.pressedBackgroundColor)
          : Color.clear
      )
      .contentShape(Rectangle())
  }
}

// MARK: - ButtonStyle (pressed 배경)

private struct SUBezierSectionItemStyle: ButtonStyle {
  let size: BezierSectionItemSize

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(SUBezierSectionItemContainer(size: self.size, isPressed: configuration.isPressed))
  }
}

// MARK: - Accessory

struct SUBezierSectionItemAccessoryView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let accessory: BezierSectionItemAccessory<AnyView>

  var body: some View {
    Group {
      switch self.accessory {
      case .navigation:
        self.icon(.chevronSmallRight, length: BezierSectionItemConstant.accessoryIconLength)
      case .outlink:
        self.icon(.arrowRightUpSmall, length: BezierSectionItemConstant.accessoryIconLength)
      case .select(let value):
        self.valueWithChevron(value)
      case .multiselect(let values):
        self.valueWithChevron(BezierSectionItemConstant.multiselectText(values: values))
      case .display(let value):
        self.valueText(value)
          .padding(.horizontal, BezierSectionItemConstant.accessoryTextHorizontalPadding)
      case .toggle(let isOn):
        SUBezierSectionItemToggleIndicator(isOn: isOn)
      case .custom(let content):
        content
      }
    }
    .frame(height: BezierSectionItemConstant.accessoryHeight)
  }

  private func valueWithChevron(_ value: String) -> some View {
    HStack(spacing: BezierSectionItemConstant.accessoryTextSpacing) {
      self.valueText(value)
      self.icon(.chevronUpdown, length: BezierSectionItemConstant.accessoryChevronUpdownLength)
    }
    .padding(.horizontal, BezierSectionItemConstant.accessoryTextHorizontalPadding)
  }

  private func valueText(_ value: String) -> some View {
    Text(value)
      .applyBezierFontStyle(
        BezierSectionItemConstant.accessoryTextTypography,
        semanticColorToken: BezierSectionItemConstant.accessoryTextColor
      )
      .lineLimit(1)
      .truncationMode(.tail)
  }

  private func icon(_ icon: BezierIcon, length: CGFloat) -> some View {
    icon.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .foregroundColor(self.palette(BezierSectionItemConstant.accessoryIconColor))
      .frame(width: length, height: length)
  }
}

// MARK: - Toggle Indicator

struct SUBezierSectionItemToggleIndicator: View, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let isOn: Bool

  var body: some View {
    ZStack(alignment: self.isOn ? .trailing : .leading) {
      RoundedRectangle(cornerRadius: BezierSectionItemConstant.toggleCornerRadius)
        .fill(
          self.palette(
            self.isOn
              ? BezierSectionItemConstant.toggleTrackOnColor
              : BezierSectionItemConstant.toggleTrackOffColor
          )
        )

      Circle()
        .fill(self.palette(BezierSectionItemConstant.toggleThumbColor))
        .frame(
          width: BezierSectionItemConstant.toggleThumbLength,
          height: BezierSectionItemConstant.toggleThumbLength
        )
        .shadow(
          color: Color.black.opacity(Double(BezierSectionItemConstant.toggleThumbShadowOpacity)),
          radius: BezierSectionItemConstant.toggleThumbShadowRadius,
          x: BezierSectionItemConstant.toggleThumbShadowOffset.width,
          y: BezierSectionItemConstant.toggleThumbShadowOffset.height
        )
        .padding(BezierSectionItemConstant.toggleThumbInset)
    }
    .frame(
      width: BezierSectionItemConstant.toggleWidth,
      height: BezierSectionItemConstant.toggleHeight
    )
  }
}

struct SUBezierSectionItem_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(spacing: 0) {
        SUBezierSectionItem(
          content: "다음 화면 이동",
          leading: .icon(.folder),
          accessory: .navigation,
          onTap: {}
        )
        SUBezierSectionItem(
          content: "언어",
          leading: .icon(.globe),
          accessory: .select(value: "한국어"),
          onTap: {}
        )
        SUBezierSectionItem(
          content: "알림",
          accessory: .toggle(isOn: true),
          onTap: {}
        )
        SUBezierSectionItem(
          size: .large,
          content: "설명 있는 행",
          description: "large는 description이 label 아래 nested로 배치됩니다.",
          leading: .icon(.folder),
          onTap: {}
        )
        SUBezierSectionItem(
          content: "삭제",
          leading: .icon(.trash),
          isDestructive: true,
          onTap: {}
        )
      }
    }
  }
}
