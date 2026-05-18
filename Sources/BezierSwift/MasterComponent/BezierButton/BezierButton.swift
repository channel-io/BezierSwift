//
//  BezierButton.swift
//  BezierSwift
//

import SwiftUI

public struct BezierButton: View, Themeable {
  private let size: BezierButtonSize
  private let variant: BezierButtonVariant
  private let semantic: BezierButtonSemantic
  private let resizing: BezierButtonResizing
  private let title: String?
  private let leadingIcon: Image?
  private let trailingIcon: Image?
  private let isLoading: Bool
  private let action: () -> Void

  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierButtonSize,
    variant: BezierButtonVariant,
    semantic: BezierButtonSemantic,
    resizing: BezierButtonResizing = .hug,
    title: String? = nil,
    leadingIcon: Image? = nil,
    trailingIcon: Image? = nil,
    isLoading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.variant = variant
    self.semantic = semantic
    self.resizing = resizing
    self.title = title
    self.leadingIcon = leadingIcon
    self.trailingIcon = trailingIcon
    self.isLoading = isLoading
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
        minWidth: self.resizing == .fill ? nil : self.size.minWidth,
        maxWidth: self.resizing == .fill ? .infinity : nil,
        minHeight: self.size.height,
        maxHeight: self.size.height
      )
    }
    .buttonStyle(
      BezierButtonStyle(
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

      if let title = self.title {
        Text(title)
          .applyBezierFontStyle(
            self.size.typography,
            semanticColorToken: self.variant.foregroundToken(self.semantic)
          )
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
    ProgressView()
      .progressViewStyle(.circular)
      .tint(self.palette(self.variant.foregroundToken(self.semantic)))
      .scaleEffect(self.loadingScale)
  }

  private var loadingScale: CGFloat {
    switch self.size {
    case .xsmall, .small: return 0.6
    case .medium, .large, .xlarge: return 0.8
    }
  }
}

private struct BezierButtonStyle: ButtonStyle, Themeable {
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

struct BezierButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      BezierButton(size: .xsmall, variant: .filled, semantic: .primary, title: "Label") {}
      BezierButton(size: .small, variant: .outlined, semantic: .secondary, title: "Label") {}
      BezierButton(size: .medium, variant: .ghost, semantic: .destructive, title: "Label") {}
      BezierButton(size: .large, variant: .filled, semantic: .destructive, title: "Confirm", leadingIcon: Image(systemName: "trash")) {}
      BezierButton(size: .xlarge, variant: .filled, semantic: .primary, resizing: .fill, title: "Continue", trailingIcon: Image(systemName: "arrow.right")) {}
      BezierButton(size: .medium, variant: .filled, semantic: .primary, title: "Loading", isLoading: true) {}
    }
    .padding()
  }
}
