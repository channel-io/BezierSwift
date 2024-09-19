//
//  BezierLoaderConfiguration.swift
//
//
//  Created by Tom on 6/29/24.
//

import Foundation

// - MARK: BezierLoaderConfiguration
/// 작업의 진행 단계 결정 또는 완료 시점이 확정되지 않은 경우 사용할 수 있는 요소입니다.
public struct BezierLoaderConfiguration: Equatable {
  // MARK: Size
  public enum Size {
    /// Loader length 16
    case xxsmall
    /// Loader length 20
    case xsmall
    /// Loader length 24
    case small
    /// Loader length 28
    case medium
    /// Loader length 50
    case large
  }
  
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
    case onOverlay
  }
  
  // MARK: Properties
  let size: Size
  let variant: Variant
  
  var trackColor: BezierColor {
    switch self.variant {
    case .primary: return .primaryBgLightest
    case .secondary: return .bgBlackLight
    case .onOverlay: return .bgAbsoluteWhiteLightest
    }
  }
  
  var indicatorColor: BezierColor {
    switch self.variant {
    case .primary: return .primaryFgNormal
    case .secondary: return .fgBlackLight
    case .onOverlay: return .bgAbsoluteWhiteLight
    }
  }
  
  var lineWidth: CGFloat {
    return self.loaderLength * 0.12
  }
  
  var loaderRadius: CGFloat {
    return (self.loaderLength - self.lineWidth) / 2
  }
  
  var loaderLength: CGFloat {
    switch self.size {
    case .xxsmall: return 16
    case .xsmall: return 20
    case .small: return 24
    case .medium: return 28
    case .large: return 50
    }
  }
  
  // MARK: Initializer
  /// 작업의 진행 단계 결정 또는 완료 시점이 확정되지 않은 경우 사용할 수 있는 요소입니다.
  /// - Parameters:
  ///   - size: Loader는 `xxsmall`, `xsmall`, `small`, `medium`, `large` 5개의 사이즈를 가질 수 있습니다.
  ///     - `large`, `medium` 은 화면 전체를 로딩할 때, 독립적인 요소로 쓰일 때 사용합니다.
  ///     - 컴포넌트 내 Slot 에 Loader 를 override 해서 사용할 수 있으며 이때는 `xxsmall`, `xsmall`, `small` 을 사용합니다.
  ///   - variant: Loader는 `primary`, `seondary` (default), `onOverlay` 3개의 Variant 옵션을 가질 수 있습니다.
  ///     - primary: 화면 내에서 중요도가 높은 경우에만 사용합니다.
  ///     - seondary(default): 보편적인 경우에 사용합니다.
  ///     - onOverlay: dimmed layer 등과 함께할 때 사용합니다.
  /// - Attention: 한 화면에 여러개의 Loader를 표시하지 않습니다. 이는 유저의 행동을 방해할 수 있으며, 유저에게 필요 이상의 불안정한 상태를 제공합니다.
  public init(
    size: Size,
    variant: Variant = .secondary
  ) {
    self.size = size
    self.variant = variant
  }
}
