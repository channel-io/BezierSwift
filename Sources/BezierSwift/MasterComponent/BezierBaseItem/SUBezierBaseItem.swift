//
//  SUBezierBaseItem.swift
//  BezierSwift
//

import SwiftUI

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

  public init(
    size: BezierBaseItemSize = .medium,
    title: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil,
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder centerSlot: () -> CenterSlot,
    @ViewBuilder trailing: () -> Trailing
  ) {
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
          .buttonStyle(SUBezierBaseItemStyle(size: self.size))
      } else {
        self.row.modifier(SUBezierBaseItemContainer(size: self.size, isPressed: false))
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

  private var centerView: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: BezierBaseItemConstant.titleRowSpacing) {
        if !self.title.isEmpty {
          Text(self.title)
            .applyBezierFontStyle(
              BezierBaseItemConstant.titleTypography,
              semanticColorToken: BezierBaseItemConstant.titleColor
            )
            .lineLimit(1)
            .truncationMode(.tail)
        }
        self.centerSlotView
        Spacer(minLength: 0)
      }

      if self.size != .small, let itemDescription = self.itemDescription, !itemDescription.isEmpty {
        Text(itemDescription)
          .applyBezierFontStyle(
            BezierBaseItemConstant.descriptionTypography,
            semanticColorToken: BezierBaseItemConstant.descriptionColor
          )
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(.leading, BezierBaseItemConstant.centerLeadingInset)
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
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let size: BezierBaseItemSize
  let isPressed: Bool

  private var contentScale: CGFloat {
    (self.isPressed && !self.reduceMotion) ? BezierBaseItemConstant.pressScale : 1
  }

  func body(content: Content) -> some View {
    content
      // 콘텐츠만 축소 — 배경은 full-size 유지 (press scale 피드백)
      .scaleEffect(self.contentScale)
      .padding(.horizontal, BezierBaseItemConstant.horizontalPadding)
      .padding(.vertical, self.size.verticalPadding)
      .frame(minHeight: self.size.minHeight)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        self.isPressed
          ? self.palette(BezierBaseItemConstant.pressedBackgroundColor)
          : Color.clear
      )
      .clipShape(RoundedRectangle(cornerRadius: BezierBaseItemConstant.cornerRadius))
      .contentShape(Rectangle())
      .animation(.spring(response: 0.34, dampingFraction: 0.62), value: self.isPressed)
  }
}

// MARK: - ButtonStyle (pressed 배경)

private struct SUBezierBaseItemStyle: ButtonStyle {
  let size: BezierBaseItemSize

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(SUBezierBaseItemContainer(size: self.size, isPressed: configuration.isPressed))
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
