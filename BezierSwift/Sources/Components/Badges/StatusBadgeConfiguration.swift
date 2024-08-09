//
//  StatusBadgeConfiguration.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import Foundation

/// StatusBadge의 사이즈와 아이콘 형태를 결정짓는 configuration 객체입니다.
public struct StatusBadgeConfiguration: Sendable, Equatable {
  public enum Size: Sendable {
    case large
    case medium
  }

  let online: Bool
  let size: Size
  let doNotDisturb: Bool

  var length: CGFloat {
    switch self.size {
    case .large: return 20
    case .medium: return 12
    }
  }

  var iconLength: CGFloat {
    switch self.size {
    case .large:
      return self.doNotDisturb ? 16 : 14
    case .medium:
      return self.doNotDisturb ? 10 : 8
    }
  }

  var iconColor: BezierColor {
    guard self.online else {
      return self.doNotDisturb ? .fgYellowNormal : .bgGreyDark
    }

    return .fgGreenNormal
  }
  
  /// StatusBadge의 사이즈와 아이콘 형태를 결정짓는 configuration 객체를 생성합니다.
  /// - Parameters:
  ///   - online: StatusBadge와 함께 사용되는 Avatar의 대상이 현재 온라인 상태인지를 표현하는 값입니다.
  ///   - size: 일반적으로 medium 이 쓰이며, Root(Avatar)가 일정 사이즈 이상인 경우 large를 사용합니다.
  ///   - doNotDisturb: StatusBadge와 함께 사용되는 Avatar의 대상이 Do Not Disturb(방해 금지 모드) 상태인지를 표현하는 값입니다.
  public init(online: Bool, size: Size, doNotDisturb: Bool) {
    self.online = online
    self.size = size
    self.doNotDisturb = doNotDisturb
  }
}
