//
//  SUBezierButton.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierButton: View, Themeable {
  private let size: BezierButtonSize
  private let variant: BezierButtonVariant
  private let semantic: BezierButtonSemantic
  private let title: String?
  private let leadingIcon: Image?
  private let trailingIcon: Image?
  private let isLoading: Bool
  private let isFillWidth: Bool
  private let action: () -> Void

  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierButtonSize,
    variant: BezierButtonVariant,
    semantic: BezierButtonSemantic,
    title: String? = nil,
    leadingIcon: Image? = nil,
    trailingIcon: Image? = nil,
    isLoading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      variant: variant,
      semantic: semantic,
      title: title,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      isLoading: isLoading,
      isFillWidth: false,
      action: action
    )
  }

  // 배치는 컨테이너 책임이라 public으로 노출하지 않는다 — 모듈 내 컨테이너(SUBezierConfirmModal 등) 전용
  init(
    size: BezierButtonSize,
    variant: BezierButtonVariant,
    semantic: BezierButtonSemantic,
    title: String? = nil,
    leadingIcon: Image? = nil,
    trailingIcon: Image? = nil,
    isLoading: Bool = false,
    isFillWidth: Bool,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.variant = variant
    self.semantic = semantic
    self.title = title
    self.leadingIcon = leadingIcon
    self.trailingIcon = trailingIcon
    self.isLoading = isLoading
    self.isFillWidth = isFillWidth
    self.action = action
  }

  public var body: some View {
    Button(action: { if !self.isLoading { self.action() } }) {
      ZStack {
        self.contentStack
          .opacity(self.isLoading ? 0 : 1)

        if self.isLoading {
          self.loadingIndicator
        }
      }
      .padding(.horizontal, self.size.horizontalPadding)
      .frame(
        minWidth: self.size.minWidth,
        maxWidth: self.isFillWidth ? .infinity : nil,
        minHeight: self.size.height,
        maxHeight: self.size.height
      )
      .fixedSize(horizontal: !self.isFillWidth, vertical: false)
    }
    .buttonStyle(
      SUBezierButtonStyle(
        size: self.size,
        variant: self.variant,
        semantic: self.semantic,
        isLoading: self.isLoading
      )
    )
    .opacity(self.isEnabled ? 1 : BezierButtonConstant.disabledOpacity)
  }

  private var contentStack: some View {
    HStack(spacing: self.size.contentSpacing) {
      if let leadingIcon = self.leadingIcon {
        self.iconView(leadingIcon)
      }

      if let title = self.title, !title.isEmpty {
        let uiFont = BTGlobalToken.FontFamily.system.uiFont(
          size: self.size.fontSize,
          weight: self.size.fontWeight
        )
        let lineSpacing = max(0, self.size.lineHeight - uiFont.lineHeight)

        Text(title)
          .font(
            BTGlobalToken.FontFamily.system.font(
              size: self.size.fontSize,
              weight: self.size.fontWeight
            )
          )
          .lineSpacing(lineSpacing)
          .padding(.vertical, lineSpacing / 2)
          .foregroundColor(self.palette(self.variant.foregroundToken(self.semantic)))
          .padding(.horizontal, self.size.textHorizontalPadding)
          .fixedSize(horizontal: true, vertical: false)
      }

      if let trailingIcon = self.trailingIcon {
        self.iconView(trailingIcon)
      }
    }
  }

  private func iconView(_ image: Image) -> some View {
    image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .frame(width: self.size.iconLength, height: self.size.iconLength)
      .foregroundColor(self.palette(self.variant.foregroundToken(self.semantic)))
  }

  private var loadingIndicator: some View {
    SUBezierSpinner(
      size: self.size.spinnerSize,
      fillColorOverride: self.palette(self.variant.loadingSpinnerToken(self.semantic))
    )
  }
}

private struct SUBezierButtonStyle: ButtonStyle, Themeable {
  let size: BezierButtonSize
  let variant: BezierButtonVariant
  let semantic: BezierButtonSemantic
  let isLoading: Bool

  @Environment(\.colorScheme) var colorScheme

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(self.backgroundShape)
      .clipShape(Capsule())
      .overlay(self.borderShape)
      .opacity(configuration.isPressed && !self.isLoading ? BezierButtonConstant.pressedOpacity : 1)
  }

  @ViewBuilder
  private var backgroundShape: some View {
    if let token = self.variant.backgroundToken(self.semantic) {
      Capsule().fill(self.palette(token))
    } else {
      Color.clear
    }
  }

  @ViewBuilder
  private var borderShape: some View {
    if let token = self.variant.borderToken(self.semantic) {
      Capsule()
        .strokeBorder(
          self.palette(token),
          lineWidth: BezierButtonConstant.borderWidth
        )
    }
  }
}

struct SUBezierButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      SUBezierButton(size: .xsmall, variant: .filled, semantic: .primary, title: "Label") {}
      SUBezierButton(size: .small, variant: .outlined, semantic: .secondary, title: "Label") {}
      SUBezierButton(size: .medium, variant: .ghost, semantic: .destructive, title: "Label") {}
      SUBezierButton(size: .large, variant: .filled, semantic: .destructive, title: "Confirm", leadingIcon: Image(systemName: "trash")) {}
      SUBezierButton(size: .xlarge, variant: .filled, semantic: .primary, title: "Continue", trailingIcon: Image(systemName: "arrow.right")) {}
      SUBezierButton(size: .medium, variant: .filled, semantic: .primary, title: "Loading", isLoading: true) {}
    }
    .padding()
  }
}
