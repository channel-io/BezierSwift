//
//  SUBezierStatus.swift
//  BezierSwift
//

import SwiftUI

/// 접속 상태를 나타내는 표식 (SwiftUI). 보통 `SUBezierAvatar`가 내부에서 사용하지만 단독으로도 쓸 수 있다. UIKit에서는 `BezierStatus`를 사용한다.
public struct SUBezierStatus: View, Themeable {
  private let type: BezierStatusType
  private let size: BezierStatusSize

  @Environment(\.colorScheme) public var colorScheme

  /// 상태 종류와 크기를 지정해 표식을 만든다.
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
