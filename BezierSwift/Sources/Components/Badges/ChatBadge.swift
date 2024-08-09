//
//  ChatBadge.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import SwiftUI

private enum Constant {
  static let backgroundColor: BezierColor = .bgWhiteHighest
  static let iconColor: BezierColor = .fgBlackDarker
}

/// ChatBadge는 Avatar와 함께 사용되며 아이콘을 사용해 Root(Avatar)의 상태가 Private임을 알려줍니다.
struct ChatBadge: View {
  private let configuration: ChatBadgeConfiguration
  
  /// 주어진 ChatBadgeConfiguration에 따른 ChatBadge를 생성합니다.
  /// - Parameter configuration: ChatBadge의 사이즈를 결정짓는 configuration 객체입니다.
  public init(configuration: ChatBadgeConfiguration) {
    self.configuration = configuration
  }

  public var body: some View {
    ZStack(alignment: .center) {
      BezierIcon
        .lock
        .image
        .frame(width: self.configuration.iconLength, height: self.configuration.iconLength)
        .foregroundColor(Constant.iconColor.color)
    }
    .frame(width: self.configuration.length, height: self.configuration.length)
    .background(
      Circle()
        .foregroundColor(Constant.backgroundColor.color)
    )
  }
}

#Preview("Light Mode") {
  VStack {
    ChatBadge(configuration: .init(size: .medium))
    ChatBadge(configuration: .init(size: .large))
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .foregroundColor(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
  .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
  VStack {
    ChatBadge(configuration: .init(size: .medium))
    ChatBadge(configuration: .init(size: .large))
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .foregroundColor(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
  .preferredColorScheme(.dark)
}
