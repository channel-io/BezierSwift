//
//  StatusBadge.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import SwiftUI

/// StatusBadge는 Avatar와 함께 사용되며 Root(Avatar)의 상태를 아이콘이나 이미지를 사용해 직관적으로 알려줍니다.
public struct StatusBadge: View {
  private let configuration: StatusBadgeConfiguration
  
  /// 주어진 StatusBadgeConfiguration에 따른 StatusBadge 뷰를 생성합니다.
  /// - Parameter configuration: StatusBadge의 사이즈와 아이콘 형태를 결정짓는 configuration 객체입니다.
  public init(configuration: StatusBadgeConfiguration) {
    self.configuration = configuration
  }

  public var body: some View {
    ZStack(alignment: .center) {
      Circle()
        .fill(BezierColor.bgWhiteHighest.color)

      self.icon
        // TODO: BezierButton 병합후 View.frame(length:) 로 변경합니다. - by Finn 2024.08.09
        .frame(width: self.configuration.iconLength, height: self.configuration.iconLength)
        .foregroundColor(self.configuration.iconColor.color)
    }
    // TODO: BezierButton 병합후 View.frame(length:) 로 변경합니다. - by Finn 2024.08.09
    .frame(width: self.configuration.length, height: self.configuration.length)
    .compositingGroup()
  }
}

extension StatusBadge {
  @ViewBuilder
  private var icon: some View {
    if self.configuration.doNotDisturb {
      BezierIcon.moonFilled.image
    } else {
      Circle()
        .fill()
    }
  }
}

#Preview("Light Mode") {
  HStack {
    VStack {
      StatusBadge(configuration: .init(online: true, size: .medium, doNotDisturb: false))
      StatusBadge(configuration: .init(online: true, size: .large, doNotDisturb: false))
    }
    VStack {
      StatusBadge(configuration: .init(online: false, size: .medium, doNotDisturb: false))
      StatusBadge(configuration: .init(online: false, size: .large, doNotDisturb: false))
    }
    VStack {
      StatusBadge(configuration: .init(online: true, size: .medium, doNotDisturb: true))
      StatusBadge(configuration: .init(online: true, size: .large, doNotDisturb: true))
    }
    VStack {
      StatusBadge(configuration: .init(online: false, size: .medium, doNotDisturb: true))
      StatusBadge(configuration: .init(online: false, size: .large, doNotDisturb: true))
    }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .fill(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
  .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
  HStack {
    VStack {
      StatusBadge(configuration: .init(online: true, size: .medium, doNotDisturb: false))
      StatusBadge(configuration: .init(online: true, size: .large, doNotDisturb: false))
    }
    VStack {
      StatusBadge(configuration: .init(online: false, size: .medium, doNotDisturb: false))
      StatusBadge(configuration: .init(online: false, size: .large, doNotDisturb: false))
    }
    VStack {
      StatusBadge(configuration: .init(online: true, size: .medium, doNotDisturb: true))
      StatusBadge(configuration: .init(online: true, size: .large, doNotDisturb: true))
    }
    VStack {
      StatusBadge(configuration: .init(online: false, size: .medium, doNotDisturb: true))
      StatusBadge(configuration: .init(online: false, size: .large, doNotDisturb: true))
    }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .fill(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
  .preferredColorScheme(.dark)
}
