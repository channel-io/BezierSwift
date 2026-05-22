//
//  SUBezierAvatarStatus.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierAvatarStatus: View, Themeable {
  private let type: BezierAvatarStatusType
  private let size: BezierAvatarStatusSize

  @Environment(\.colorScheme) public var colorScheme

  public init(type: BezierAvatarStatusType, size: BezierAvatarStatusSize) {
    self.type = type
    self.size = size
  }

  public var body: some View {
    ZStack {
      Circle().fill(self.palette(BCSemanticToken.surfaceHighest))

      if let icon = self.type.indicatorIcon {
        icon.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: self.size.innerIndicatorLength, height: self.size.innerIndicatorLength)
          .foregroundColor(self.palette(self.type.indicatorToken))
      } else {
        Circle()
          .fill(self.palette(self.type.indicatorToken))
          .frame(width: self.size.innerIndicatorLength, height: self.size.innerIndicatorLength)
      }
    }
    .frame(width: self.size.containerLength, height: self.size.containerLength)
  }
}

struct SUBezierAvatarStatus_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(BezierAvatarStatusSize.allCases, id: \.self) { size in
        VStack(alignment: .leading, spacing: 4) {
          Text(size.rawValue)
            .font(.caption.weight(.semibold))
            .foregroundColor(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierAvatarStatusType.allCases, id: \.self) { type in
              SUBezierAvatarStatus(type: type, size: size)
            }
          }
        }
      }
    }
    .padding()
  }
}
