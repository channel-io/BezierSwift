//
//  BezierStatusBadge.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import SwiftUI

/// BezierStatusBadge는 Avatar와 함께 사용되며 Root(Avatar)의 상태를 아이콘이나 이미지를 사용해 직관적으로 알려줍니다.
public struct BezierStatusBadge: View {
  public enum Size: Sendable {
    case large
    case medium
  }

  private let online: Bool
  private let size: Size
  private let doNotDisturb: Bool
  
  /// - Parameters:
  ///   - online: StatusBadge와 함께 사용되는 Avatar의 대상이 현재 온라인 상태인지를 표현하는 값입니다.
  ///   - size: 일반적으로 medium 이 쓰이며, Root(Avatar)가 일정 사이즈 이상인 경우 large를 사용합니다.
  ///   - doNotDisturb: StatusBadge와 함께 사용되는 Avatar의 대상이 Do Not Disturb(방해 금지 모드) 상태인지를 표현하는 값입니다.
  init(online: Bool, size: Size, doNotDisturb: Bool) {
    self.online = online
    self.size = size
    self.doNotDisturb = doNotDisturb
  }

  public var body: some View {
    ZStack(alignment: .center) {
      Circle()
        .fill(BezierColor.bgWhiteHighest.color)

      self.icon
        .frame(length: self.iconLength)
        .foregroundColor(self.iconColor.color)
    }
    .frame(length: self.length)
    .compositingGroup()
  }
}

extension BezierStatusBadge {
  @ViewBuilder
  private var icon: some View {
    if self.doNotDisturb {
      BezierIcon.moonFilled.image
    } else {
      Circle()
        .fill()
    }
  }
}

extension BezierStatusBadge {
  private var length: CGFloat {
    switch self.size {
    case .large: return 20
    case .medium: return 12
    }
  }

  private var iconLength: CGFloat {
    switch self.size {
    case .large:
      return self.doNotDisturb ? 16 : 14
    case .medium:
      return self.doNotDisturb ? 10 : 8
    }
  }

  private var iconColor: BezierColor {
    guard self.online else {
      return self.doNotDisturb ? .fgYellowNormal : .bgGreyDark
    }

    return .fgGreenNormal
  }
}

#Preview {
  HStack {
    VStack {
      BezierStatusBadge(online: true, size: .medium, doNotDisturb: false)
      BezierStatusBadge(online: true, size: .large, doNotDisturb: false)
    }
    VStack {
      BezierStatusBadge(online: false, size: .medium, doNotDisturb: false)
      BezierStatusBadge(online: false, size: .large, doNotDisturb: false)
    }
    VStack {
      BezierStatusBadge(online: true, size: .medium, doNotDisturb: true)
      BezierStatusBadge(online: true, size: .large, doNotDisturb: true)
    }
    VStack {
      BezierStatusBadge(online: false, size: .medium, doNotDisturb: true)
      BezierStatusBadge(online: false, size: .large, doNotDisturb: true)
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
