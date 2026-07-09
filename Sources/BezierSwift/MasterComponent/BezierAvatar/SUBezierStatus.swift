//
//  SUBezierStatus.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierStatus: View, Themeable {
  private let type: BezierStatusType
  private let size: BezierStatusSize

  @Environment(\.colorScheme) public var colorScheme

  public init(type: BezierStatusType, size: BezierStatusSize) {
    self.type = type
    self.size = size
  }

  public var body: some View {
    ZStack {
      Circle().fill(self.palette(BCSemanticToken.surfaceHigh))
      Circle().strokeBorder(self.palette(BCSemanticToken.surfaceHighest), lineWidth: self.size.borderWidth)

      if let icon = self.type.icon, let iconToken = self.type.iconToken {
        icon.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: self.size.circleLength, height: self.size.circleLength)
          .foregroundColor(self.palette(iconToken))
      } else {
        Circle()
          .fill(self.palette(self.type.circleToken))
          .frame(width: self.size.circleLength, height: self.size.circleLength)
      }
    }
    .frame(width: self.size.containerLength, height: self.size.containerLength)
  }
}

struct SUBezierStatus_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 16) {
      ForEach(BezierStatusSize.allCases, id: \.self) { size in
        VStack(alignment: .leading, spacing: 4) {
          Text(size.rawValue)
            .font(.caption.weight(.semibold))
            .foregroundColor(.secondary)
          HStack(spacing: 8) {
            ForEach(BezierStatusType.allCases, id: \.self) { type in
              SUBezierStatus(type: type, size: size)
            }
          }
        }
      }
    }
    .padding()
  }
}
