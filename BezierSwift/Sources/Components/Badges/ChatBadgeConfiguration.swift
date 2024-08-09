//
//  ChatBadgeConfiguration.swift
//
//
//  Created by 구본욱 on 8/9/24.
//

import Foundation

/// ChatBadge의 사이즈와 아이콘 형태를 결정짓는 configuration  객체입니다.
public struct ChatBadgeConfiguration: Sendable, Equatable {
  public enum Size: Sendable {
    case medium
    case large
  }

  let size: Size

  var length: CGFloat {
    switch self.size {
    case .medium:
      return 12
    case .large:
      return 20
    }
  }

  var iconLength: CGFloat {
    switch self.size {
    case .medium:
      return 10
    case .large:
      return 16
    }
  }
  
  /// ChatBadge의 사이즈를 결정짓는 configuration 객체를 생성합니다.
  /// - Parameter size: 일반적으로 medium이 쓰이며, Root(Avatar)가 일정 사이즈 이상인 경우 large를 사용합니다.
  public init(size: Size) {
    self.size = size
  }
}
