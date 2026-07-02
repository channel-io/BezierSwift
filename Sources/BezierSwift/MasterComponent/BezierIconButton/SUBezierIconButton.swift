//
//  SUBezierIconButton.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierIconButton: View, Themeable {
  private let size: BezierIconButtonSize
  private let variant: BezierIconButtonVariant
  private let icon: Image
  private let isActive: Bool
  private let isLoading: Bool
  private let action: () -> Void

  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.colorScheme) public var colorScheme

  public init(
    size: BezierIconButtonSize = .medium,
    variant: BezierIconButtonVariant = .ghost,
    icon: Image,
    isActive: Bool = false,
    isLoading: Bool = false,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.variant = variant
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
      .foregroundColor(self.palette(self.variant.foregroundToken))
  }

  private var loadingIndicator: some View {
    SUBezierSpinner(
      size: self.size.spinnerSize,
      fillColorOverride: self.palette(self.variant.loadingSpinnerToken)
    )
  }
}

private struct SUBezierIconButtonStyle: ButtonStyle, Themeable {
  let variant: BezierIconButtonVariant
  let isActive: Bool
  let isLoading: Bool

  @Environment(\.colorScheme) var colorScheme

  func makeBody(configuration: Configuration) -> some View {
    let isInteractionOverlayActive = (configuration.isPressed && !self.isLoading) || self.isActive
    configuration.label
      .background(self.backgroundShape(isOverlayActive: isInteractionOverlayActive))
      .clipShape(Circle())
  }

  @ViewBuilder
  private func backgroundShape(isOverlayActive: Bool) -> some View {
    if self.variant == .ghost && isOverlayActive {
      // SPEC §4: ghost의 pressed / active overlay (raw rgba(0,0,0,0.05))
      Circle().fill(Color.black.opacity(BezierIconButtonConstant.ghostOverlayAlpha))
    } else if let token = self.variant.backgroundToken {
      Circle().fill(self.palette(token))
    } else {
      Color.clear
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
