//
//  SUBezierAvatar.swift
//  BezierSwift
//

import SwiftUI

/// 사용자·대상을 나타내는 아바타 (SwiftUI). 이미지·크기·테두리·접속 상태 표식을 조합한다. UIKit에서는 `BezierAvatar`를 사용한다.
public struct SUBezierAvatar: View, Themeable {
  private let image: Image?
  private let size: BezierAvatarSize
  private let showBorder: Bool
  private let statusType: BezierStatusType?

  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled

  /// 이미지·크기·테두리·상태 표식을 지정해 아바타를 만든다. 모든 인자는 기본값이 있어 필요한 것만 넘기면 된다.
  public init(
    image: Image? = nil,
    size: BezierAvatarSize = .size24,
    showBorder: Bool = false,
    statusType: BezierStatusType? = nil
  ) {
    self.image = image
    self.size = size
    self.showBorder = showBorder
    self.statusType = statusType
  }

  public var body: some View {
    ZStack(alignment: .topLeading) {
      ZStack {
        self.imageLayer
        self.borderLayer
      }
      .compositingGroup()
      .clipShape(RoundedRectangle(cornerRadius: self.size.cornerRadius, style: .continuous))
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
  }

  @ViewBuilder
  private var borderLayer: some View {
    if self.showBorder {
      // 외곽은 완전히 덮고 안쪽 경계만 AA한다. 바깥쪽 AA는 합성 후 clipShape가 담당한다.
      AvatarBorderShape(cornerRadius: self.size.cornerRadius, borderWidth: self.size.borderWidth)
        .fill(self.palette(BCSemanticToken.surface), style: FillStyle(eoFill: true))
        .frame(width: self.size.length, height: self.size.length)
    }
  }

  @ViewBuilder
  private var statusLayer: some View {
    if let statusType = self.statusType {
      Group {
        if let avatarStatusSize = self.size.matchingAvatarStatusSize {
          SUBezierStatus(type: statusType, size: avatarStatusSize)
        } else {
          // size16 전용 6×6 mini status (Status 매트릭스 외, SPEC Part 1 §4)
          Circle()
            .fill(self.palette(statusType.circleToken))
            .frame(width: self.size.statusOverlayLength, height: self.size.statusOverlayLength)
        }
      }
      .offset(x: self.size.statusOverlayPosition.x, y: self.size.statusOverlayPosition.y)
      .zIndex(1)
    }
  }
}

private struct AvatarBorderShape: Shape {
  let cornerRadius: CGFloat
  let borderWidth: CGFloat

  func path(in rect: CGRect) -> Path {
    // 채움 끝의 AA는 외곽 마스크 밖에서 처리되도록 한다(소수 픽셀 좌표에서도 색 번짐 방지).
    var path = Path(rect.insetBy(dx: -self.borderWidth, dy: -self.borderWidth))
    path.addPath(
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
        .inset(by: self.borderWidth)
        .path(in: rect)
    )
    return path
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

  private static func avatarRow(showBorder: Bool, statusType: BezierStatusType?) -> some View {
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
