//
//  SUBezierBaseItem.swift
//  BezierSwift
//

import SwiftUI

/// leading·center·trailing 3영역으로 구성되는 리스트 행 아이템 (SwiftUI). 세 영역의 뷰를 `@ViewBuilder`로 채운다. UIKit에서는 `BezierBaseItem`을 사용한다.
public struct SUBezierBaseItem<Leading: View, CenterSlot: View, Trailing: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled

  private let size: BezierBaseItemSize
  private let title: String
  private let itemDescription: String?
  private let onTap: (() -> Void)?
  private let leading: Leading
  private let centerSlot: CenterSlot
  private let trailing: Trailing
  private let style: BezierBaseItemStyle

  /// 텍스트·크기·탭 동작과 함께 leading·centerSlot·trailing 세 슬롯 뷰를 지정해 생성한다. `description`은 `size`가 `.small`이면 무시되고, `onTap`이 `nil`이면 정적인 행이 된다.
  public init(
    size: BezierBaseItemSize = .medium,
    title: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil,
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder centerSlot: () -> CenterSlot,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(
      style: BezierBaseItemStyle(),
      size: size,
      title: title,
      description: description,
      onTap: onTap,
      leading: leading,
      centerSlot: centerSlot,
      trailing: trailing
    )
  }

  /// 파생 `*Item` 컴포넌트가 composition 시 내부 스타일을 주입하는 이니셜라이저. public API로는 노출하지 않는다.
  init(
    style: BezierBaseItemStyle,
    size: BezierBaseItemSize = .medium,
    title: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil,
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder centerSlot: () -> CenterSlot,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.style = style
    self.size = size
    self.title = title
    self.itemDescription = description
    self.onTap = onTap
    self.leading = leading()
    self.centerSlot = centerSlot()
    self.trailing = trailing()
  }

  public var body: some View {
    Group {
      if let onTap = self.onTap {
        Button(action: onTap) { self.row }
          .buttonStyle(SUBezierBaseItemStyle(size: self.size, style: self.style))
      } else {
        self.row.modifier(
          SUBezierBaseItemContainer(size: self.size, style: self.style, isPressed: false)
        )
      }
    }
    .opacity(self.isEnabled ? 1 : BezierBaseItemConstant.disabledOpacity)
    .allowsHitTesting(self.isEnabled)
  }

  private var row: some View {
    HStack(spacing: BezierBaseItemConstant.slotSpacing) {
      self.leadingView
      self.centerView
      self.trailingView
    }
  }

  @ViewBuilder
  private var leadingView: some View {
    if Leading.self != EmptyView.self {
      self.leading
        .frame(width: self.size.leadingLength, height: self.size.leadingLength)
    }
  }

  private var supportsDescription: Bool {
    self.size != .small || self.style.allowsSmallDescription
  }

  private var centerView: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: BezierBaseItemConstant.titleRowSpacing) {
        if !self.title.isEmpty {
          Text(self.title)
            .applyBezierFontStyle(
              BezierBaseItemConstant.titleTypography,
              semanticColorToken: self.style.titleColor
            )
            .lineLimit(1)
            .truncationMode(.tail)
        }
        self.centerSlotView
        Spacer(minLength: 0)
      }

      if self.supportsDescription, let itemDescription = self.itemDescription, !itemDescription.isEmpty {
        Text(itemDescription)
          .applyBezierFontStyle(
            BezierBaseItemConstant.descriptionTypography,
            semanticColorToken: BezierBaseItemConstant.descriptionColor
          )
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(.leading, self.style.centerLeadingInset)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  @ViewBuilder
  private var centerSlotView: some View {
    if CenterSlot.self != EmptyView.self {
      self.centerSlot
    }
  }

  @ViewBuilder
  private var trailingView: some View {
    if Trailing.self != EmptyView.self {
      self.trailing
    }
  }
}

// MARK: - Convenience init (centerSlot 생략)

extension SUBezierBaseItem where CenterSlot == EmptyView {
  /// centerSlot을 생략하고 leading·trailing만으로 생성하는 편의 이니셜라이저.
  public init(
    size: BezierBaseItemSize = .medium,
    title: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil,
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(
      size: size,
      title: title,
      description: description,
      onTap: onTap,
      leading: leading,
      centerSlot: { EmptyView() },
      trailing: trailing
    )
  }
}

// MARK: - Container

private struct SUBezierBaseItemContainer: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let size: BezierBaseItemSize
  let style: BezierBaseItemStyle
  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .bezierPressScale(isPressed: self.isPressed)
      .padding(.horizontal, self.style.horizontalPadding)
      .padding(.vertical, self.style.verticalPadding ?? self.size.verticalPadding)
      .frame(minHeight: self.size.minHeight)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        self.isPressed
          ? self.palette(BezierBaseItemConstant.pressedBackgroundColor)
          : Color.clear
      )
      .clipShape(RoundedRectangle(cornerRadius: self.style.cornerRadius))
      .contentShape(Rectangle())
      .animation(
        .spring(
          response: BezierPressFeedback.springResponse,
          dampingFraction: BezierPressFeedback.springDampingFraction
        ),
        value: self.isPressed
      )
  }
}

// MARK: - ButtonStyle (pressed 배경)

private struct SUBezierBaseItemStyle: ButtonStyle {
  let size: BezierBaseItemSize
  let style: BezierBaseItemStyle

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(
        SUBezierBaseItemContainer(size: self.size, style: self.style, isPressed: configuration.isPressed)
      )
  }
}

struct SUBezierBaseItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierBaseItem(
        size: .small,
        title: "Small item",
        onTap: {},
        leading: { Circle().fill(Color.gray) },
        trailing: { EmptyView() }
      )
      SUBezierBaseItem(
        size: .medium,
        title: "Medium item with description",
        description: "Secondary description text",
        onTap: {},
        leading: { Circle().fill(Color.gray) },
        trailing: { Image(systemName: "chevron.right") }
      )
      SUBezierBaseItem(
        size: .large,
        title: "Large item",
        description: "Two-line description sitting next to a 36pt leading square.",
        leading: { RoundedRectangle(cornerRadius: 8).fill(Color.gray) },
        trailing: { EmptyView() }
      )
      SUBezierBaseItem(
        size: .medium,
        title: "Disabled item",
        onTap: {},
        leading: { Circle().fill(Color.gray) },
        trailing: { EmptyView() }
      )
      .disabled(true)
    }
    .padding()
  }
}
