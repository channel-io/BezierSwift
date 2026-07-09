//
//  SUBezierIconButton.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierIconButton: View, Themeable {
  private let size: BezierIconButtonSize
  private let variant: BezierIconButtonVariant
  private let semantic: BezierIconButtonSemantic
  private let icon: Image
  private let isActive: Bool
  private let isLoading: Bool
  private let action: () -> Void

  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierIconButtonSize = .medium,
    variant: BezierIconButtonVariant = .ghost,
    semantic: BezierIconButtonSemantic = .secondary,
    icon: Image,
    isActive: Bool = false,
    isLoading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.variant = variant
    self.semantic = semantic
    self.icon = icon
    self.isActive = isActive
    self.isLoading = isLoading
    self.action = action
  }

  public var body: some View {
    Button(action: { if !self.isLoading { self.action() } }) {
      ZStack {
        self.iconView
          .opacity(self.isLoading ? 0 : 1)

        if self.isLoading {
          self.loadingIndicator
        }
      }
      .frame(width: self.size.length, height: self.size.length)
    }
    .buttonStyle(
      SUBezierIconButtonStyle(
        variant: self.variant,
        semantic: self.semantic,
        isActive: self.isActive,
        isLoading: self.isLoading
      )
    )
    .opacity((self.isLoading || self.isEnabled) ? 1 : BezierIconButtonConstant.disabledOpacity)
    .disabled(self.isLoading)
  }

  private var iconView: some View {
    self.icon
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

private struct SUBezierIconButtonStyle: ButtonStyle, Themeable {
  let variant: BezierIconButtonVariant
  let semantic: BezierIconButtonSemantic
  let isActive: Bool
  let isLoading: Bool

  @Environment(\.colorScheme) var colorScheme

  func makeBody(configuration: Configuration) -> some View {
    let isInteractionOverlayActive = (configuration.isPressed && !self.isLoading) || self.isActive
    configuration.label
      .background(self.backgroundShape(isOverlayActive: isInteractionOverlayActive))
      .overlay(self.borderShape)
      .clipShape(Circle())
  }

  @ViewBuilder
  private func backgroundShape(isOverlayActive: Bool) -> some View {
    if self.variant.backgroundToken(self.semantic) == nil && isOverlayActive {
      // 배경 없는 variant(outlined·ghost)의 pressed / active — bezier-tokens 미등록 raw overlay
      Circle().fill(Color.black.opacity(BezierIconButtonConstant.ghostOverlayAlpha))
    } else if let token = self.variant.backgroundToken(self.semantic) {
      Circle().fill(self.palette(token))
    } else {
      Color.clear
    }
  }

  @ViewBuilder
  private var borderShape: some View {
    if let borderToken = self.variant.borderToken(self.semantic) {
      Circle().strokeBorder(
        self.palette(borderToken),
        lineWidth: BezierIconButtonConstant.borderWidth
      )
    }
  }
}

struct SUBezierIconButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      HStack(spacing: 12) {
        SUBezierIconButton(size: .xsmall, variant: .ghost, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .small, variant: .ghost, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .medium, variant: .ghost, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .large, variant: .ghost, icon: Image(systemName: "xmark")) {}
      }

      HStack(spacing: 12) {
        SUBezierIconButton(size: .xsmall, variant: .filled, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .small, variant: .filled, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .medium, variant: .filled, icon: Image(systemName: "xmark")) {}
        SUBezierIconButton(size: .large, variant: .filled, icon: Image(systemName: "xmark")) {}
      }

      HStack(spacing: 12) {
        SUBezierIconButton(size: .medium, variant: .ghost, icon: Image(systemName: "xmark"), isActive: true) {}
        SUBezierIconButton(size: .medium, variant: .filled, icon: Image(systemName: "xmark"), isActive: true) {}
      }

      HStack(spacing: 12) {
        SUBezierIconButton(size: .medium, variant: .ghost, icon: Image(systemName: "xmark"), isLoading: true) {}
        SUBezierIconButton(size: .large, variant: .filled, icon: Image(systemName: "xmark"), isLoading: true) {}
        SUBezierIconButton(size: .medium, variant: .filled, icon: Image(systemName: "xmark")) {}
          .disabled(true)
      }
    }
    .padding()
  }
}
