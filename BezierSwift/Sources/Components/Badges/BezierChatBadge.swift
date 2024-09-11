//
//  BezierChatBadge.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import SwiftUI

/// ChatBadge는 Avatar와 함께 사용되며 아이콘을 사용해 Root(Avatar)의 상태가 Private임을 알려줍니다.
public struct BezierChatBadge: View {
  public enum Size: Sendable {
    case medium
    case large
  }

  private let size: Size
  
  /// - Parameters:
  ///   - size: 일반적으로 medium이 쓰이며, Root(Avatar)가 일정 사이즈 이상인 경우 large를 사용합니다.
  init(size: Size) {
    self.size = size
  }

  public var body: some View {
    ZStack(alignment: .center) {
      Circle()
        .fill(BezierColor.bgWhiteHighest.color)

      BezierIcon.lock.image
        .frame(length: self.iconLength)
        .foregroundColor(BezierColor.fgBlackDarker.color)
    }
    .frame(length: self.length)
    .compositingGroup()
  }
}

extension BezierChatBadge {
  private var length: CGFloat {
    switch self.size {
    case .medium:
      return 12
    case .large:
      return 20
    }
  }

  private var iconLength: CGFloat {
    switch self.size {
    case .medium:
      return 10
    case .large:
      return 16
    }
  }
}

#Preview {
  VStack {
    BezierChatBadge(size: .medium)
    BezierChatBadge(size: .large)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .foregroundColor(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
}
