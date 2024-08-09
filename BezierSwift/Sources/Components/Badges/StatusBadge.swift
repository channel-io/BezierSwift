//
//  StatusBadge.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import SwiftUI

private enum Constant {
  static let backgroundColor: BezierColor = .bgWhiteHighest
}

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
      self.icon
        .frame(
          width: self.configuration.iconLength,
          height: self.configuration.iconLength
        )
        .foregroundColor(self.configuration.iconColor.color)
    }
    .frame(width: self.configuration.length, height: self.configuration.length)
    .background(
      Circle()
        .foregroundColor(Constant.backgroundColor.color)
    )
  }
}

extension StatusBadge {
  @ViewBuilder
  private var icon: some View {
    if self.configuration.isDoNotDisturb {
      BezierIcon.moonFilled.image
    } else {
      Circle()
    }
  }
}

#Preview("Light Mode") {
  VStack {
    HStack {
      VStack {
        StatusBadge(configuration: .init(isOnline: true, size: .medium, isDoNotDisturb: false))
        StatusBadge(configuration: .init(isOnline: true, size: .large, isDoNotDisturb: false))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: false, size: .medium, isDoNotDisturb: false))
        StatusBadge(configuration: .init(isOnline: false, size: .large, isDoNotDisturb: false))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: true, size: .medium, isDoNotDisturb: true))
        StatusBadge(configuration: .init(isOnline: true, size: .large, isDoNotDisturb: true))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: false, size: .medium, isDoNotDisturb: true))
        StatusBadge(configuration: .init(isOnline: false, size: .large, isDoNotDisturb: true))
      }
    }
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
    HStack {
      VStack {
        StatusBadge(configuration: .init(isOnline: true, size: .medium, isDoNotDisturb: false))
        StatusBadge(configuration: .init(isOnline: true, size: .large, isDoNotDisturb: false))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: false, size: .medium, isDoNotDisturb: false))
        StatusBadge(configuration: .init(isOnline: false, size: .large, isDoNotDisturb: false))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: true, size: .medium, isDoNotDisturb: true))
        StatusBadge(configuration: .init(isOnline: true, size: .large, isDoNotDisturb: true))
      }
      VStack {
        StatusBadge(configuration: .init(isOnline: false, size: .medium, isDoNotDisturb: true))
        StatusBadge(configuration: .init(isOnline: false, size: .large, isDoNotDisturb: true))
      }
    }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    Rectangle()
      .foregroundColor(BezierColor.bgBlackDark.color)
  )
  .ignoresSafeArea()
  .preferredColorScheme(.dark)
}
