//
//  BezierTheme.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI

// - MARK: BezierThemeCompatible
// `BezierAppearance`와 `BezierTheme`의 호환을 위한 프로토콜입니다.
// NOTE: `private` 프로토콜로 외부에서 사용할 수 없습니다. Appearance 추가가 필요하면 프로토콜 준수가 필수입니다. by Tom
private protocol BezierThemeCompatible {
  static var light: Self { get }
  static var dark: Self { get }
}

// - MARK: BezierAppearance
// Appearance(Light/Dark)를 정의합니다.
// NOTE: `BezierThemeCompatible` 프로토콜을 준수하여 `BezierTheme`와 호환됩니다.
public enum BezierAppearance: BezierThemeCompatible {
  case light
  case dark
}

// - MARK: BezierTheme
// 시스템 테마 및 사용자 설정 테마를 정의합니다.
// NOTE: BezierThemeCompatible 프로토콜을 준수하여 BezierAppearance와 호환됩니다. 시스템 설정에 따른 동적 모드 전환을 지원합니다.
public enum BezierTheme: BezierThemeCompatible {
  case light
  case dark
  case system
  
  var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .light: return .light
    case .dark: return .dark
    case .system: return .unspecified
    }
  }
  
  // MARK: appearance
  // 현재 테마의 BezierAppearance 반환. 시스템 모드인 경우 실제 스타일을 기반으로 BezierAppearance를 반환합니다.
  // NOTE: `UIUserInterfaceStyle.unspecified`는 특정하지 않은 기본 system 테마입니다.
  // overrideUserInterfaceStyle 을 통해 override 하지 않은 상태로 os의 light dark 와 관계 없이 unspecified 가 기본 설정입니다.
  // 다만, 현재 userInterfaceStyle 을 요청할 경우 실제로 보이는 테마 값을 반환합니다.
  public var appearance: BezierAppearance {
    switch self {
    case .light: return .light
    case .dark: return .dark
    case .system:
      switch UITraitCollection.current.userInterfaceStyle {
      case .light: return .light
      case .dark: return .dark
      default: return .light
      }
    }
  }
}
