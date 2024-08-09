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

  let isOnline: Bool
  let size: Size
  let isDoNotDisturb: Bool

  var length: CGFloat {
    switch self.size {
    case .large: return 20
    case .medium: return 12
    }
  }

  var iconLength: CGFloat {
    switch self.size {
    case .large:
      return self.isDoNotDisturb ? 16 : 14
    case .medium:
      return self.isDoNotDisturb ? 10 : 8
    }
  }

  var iconColor: BezierColor {
    guard self.isOnline else {
      return self.isDoNotDisturb ? .fgYellowNormal : .bgGreyDark
    }

    return .fgGreenNormal
  }
  
  /// StatusBadge의 사이즈와 아이콘 형태를 결정짓는 configuration 객체를 생성합니다.
  /// - Parameters:
  ///   - isOnline: StatusBadge와 함께 사용되는 Avatar의 대상이 현재 온라인 상태인지를 표현하는 값입니다.
  ///   - size: 일반적으로 medium 이 쓰이며, Root(Avatar)가 일정 사이즈 이상인 경우 large를 사용합니다.
  ///   - isDoNotDisturb: StatusBadge와 함께 사용되는 Avatar의 대상이 Do Not Disturb(방해 금지 모드) 상태인지를 표현하는 값입니다.
  public init(isOnline: Bool, size: Size, isDoNotDisturb: Bool) {
    self.isOnline = isOnline
    self.size = size
    self.isDoNotDisturb = isDoNotDisturb
  }
}
