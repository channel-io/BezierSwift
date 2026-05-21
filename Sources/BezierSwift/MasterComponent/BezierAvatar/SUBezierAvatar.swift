//
//  SUBezierAvatar.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierAvatar: View, Themeable {
  private let image: Image?
  private let size: BezierAvatarSize
  private let showBorder: Bool
  private let statusType: BezierAvatarStatusType?

  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled

  public init(
    image: Image? = nil,
    size: BezierAvatarSize = .size24,
    showBorder: Bool = false,
    statusType: BezierAvatarStatusType? = nil
  ) {
    self.image = image
    self.size = size
    self.showBorder = showBorder
    self.statusType = statusType
  }

  public var body: some View {
    ZStack(alignment: .topLeading) {
      self.imageLayer
      self.borderLayer
      self.statusLayer
    }
    .frame(width: self.size.length, height: self.size.length, alignment: .topLeading)
    .opacity(self.isEnabled ? 1 : BezierAvatarConstant.disabledOpacity)
  }

  // MARK: - Layers

  private var imageLayer: some View {
    Group {
      if let image = self.image {
        image
          .resizable()
          .scaledToFill()
      } else {
        Color.clear
      }
    }
    .frame(width: self.size.length, height: self.size.length)
    .clipShape(RoundedRectangle(cornerRadius: self.size.cornerRadius, style: .continuous))
  }

  @ViewBuilder
  private var borderLayer: some View {
    if self.showBorder {
      RoundedRectangle(cornerRadius: self.size.cornerRadius, style: .continuous)
        .strokeBorder(self.palette(BCSemanticToken.surface), lineWidth: self.size.borderWidth)
        .frame(width: self.size.length, height: self.size.length)
    }
  }

  @ViewBuilder
  private var statusLayer: some View {
    if let statusType = self.statusType {
      Group {
        if let avatarStatusSize = self.size.matchingAvatarStatusSize {
          SUBezierAvatarStatus(type: statusType, size: avatarStatusSize)
        } else {
          // size16 전용 6×6 mini status (AvatarStatus 매트릭스 외, SPEC Part 1 §4)
          Circle()
            .fill(self.palette(statusType.indicatorToken))
            .frame(width: self.size.statusOverlayLength, height: self.size.statusOverlayLength)
        }
      }
      .offset(x: self.size.statusOverlayPosition.x, y: self.size.statusOverlayPosition.y)
      .zIndex(1)
    }
  }
}

struct SUBezierAvatar_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("default")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        avatarRow(showBorder: false, statusType: nil)

        Text("showBorder")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        avatarRow(showBorder: true, statusType: nil)

        Text("status = online")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        avatarRow(showBorder: false, statusType: .online)

        Text("status = lock")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        avatarRow(showBorder: false, statusType: .lock)

        Text("disabled")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        avatarRow(showBorder: false, statusType: .online)
          .disabled(true)
      }
      .padding()
    }
  }

  private static func avatarRow(showBorder: Bool, statusType: BezierAvatarStatusType?) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 24) {
        ForEach(BezierAvatarSize.allCases, id: \.self) { size in
          SUBezierAvatar(
            image: Image(systemName: "person.crop.circle.fill"),
            size: size,
            showBorder: showBorder,
            statusType: statusType
          )
        }
      }
    }
  }
}
