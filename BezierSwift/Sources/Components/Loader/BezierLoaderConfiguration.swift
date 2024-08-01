//
//  BezierLoaderConfiguration.swift
//
//
//  Created by Tom on 6/29/24.
//

import Foundation

// - MARK: BezierLoaderConfiguration
/// 작업의 진행 단계 결정 또는 완료 시점이 확정되지 않은 경우 사용할 수 있는 요소입니다.
/// - Parameters:
///   - size: Loader는 small, medium 2개의 사이즈를 가질 수 있습니다.
///     - medium: 화면 전체를 로딩할 때, 독립적인 요소로 쓰일 때 사용합니다.
///     - small: 다른 요소와 나란히 쓰일 때 사용합니다.
///       - 컴포넌트 위에 사용하는 경우에는 Icon 자리에 override 해서 사용할 것을 권장하며, 사이즈는 scale 되는 것으로 지정된 사이즈를 지키지 않아도 무방합니다.
///   - variant: Loader는 primary, seondary (default), on overlay 3개의 Variant 옵션을 가질 수 있습니다.
///     - primary: 화면 내에서 중요도가 높은 경우에만 사용합니다.
///     - seondary(default): 보편적인 경우에 사용합니다.
///     - onOverlay: dimmed layer 등과 함께할 때 사용합니다.
/// - Attention: 한 화면에 여러개의 Loader를 표시하지 않습니다. 이는 유저의 행동을 방해할 수 있으며, 유저에게 필요 이상의 불안정한 상태를 제공합니다.
public struct BezierLoaderConfiguration: Sendable, Equatable {
  // MARK: Size
  public enum Size: Sendable {
    case small
    case medium
  }
  
  // MARK: Variant
  public enum Variant: Sendable {
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
    switch self.size {
    case .small: return 4
    case .medium: return 6
    }
  }
  
  var loaderRadius: CGFloat {
    return (self.loaderLength - self.lineWidth) / 2
  }
  
  var loaderLength: CGFloat {
    switch self.size {
    case .small: return 28
    case .medium: return 50
    }
  }
  
  // MARK: Initializer
  /// 작업의 진행 단계 결정 또는 완료 시점이 확정되지 않은 경우 사용할 수 있는 요소입니다.
  /// - Parameters:
  ///   - size: Loader는 small, medium 2개의 사이즈를 가질 수 있습니다.
  ///     - medium: 화면 전체를 로딩할 때, 독립적인 요소로 쓰일 때 사용합니다.
  ///     - small: 다른 요소와 나란히 쓰일 때 사용합니다.
  ///       - 컴포넌트 위에 사용하는 경우에는 Icon 자리에 override 해서 사용할 것을 권장하며, 사이즈는 scale 되는 것으로 지정된 사이즈를 지키지 않아도 무방합니다.
  ///   - variant: Loader는 primary, seondary (default), on overlay 3개의 Variant 옵션을 가질 수 있습니다.
  ///     - primary: 화면 내에서 중요도가 높은 경우에만 사용합니다.
  ///     - seondary(default): 보편적인 경우에 사용합니다.
  ///     - onOverlay: dimmed layer 등과 함께할 때 사용합니다.
  /// - Attention: 한 화면에 여러개의 Loader를 표시하지 않습니다. 이는 유저의 행동을 방해할 수 있으며, 유저에게 필요 이상의 불안정한 상태를 제공합니다.
  public init(
    size: Size,
    variant: Variant
  ) {
    self.size = size
    self.variant = variant
  }
  
  // MARK: Initializer
  /// 작업의 진행 단계 결정 또는 완료 시점이 확정되지 않은 경우 사용할 수 있는 요소입니다.
  /// - Parameters:
  ///   - size: Loader는 small, medium 2개의 사이즈를 가질 수 있습니다.
  ///     - medium: 화면 전체를 로딩할 때, 독립적인 요소로 쓰일 때 사용합니다.
  ///     - small: 다른 요소와 나란히 쓰일 때 사용합니다.
  ///       - 컴포넌트 위에 사용하는 경우에는 Icon 자리에 override 해서 사용할 것을 권장하며, 사이즈는 scale 되는 것으로 지정된 사이즈를 지키지 않아도 무방합니다.
  ///   - variant: Loader는 primary, seondary (default), on overlay 3개의 Variant 옵션을 가질 수 있습니다.
  ///     - primary: 화면 내에서 중요도가 높은 경우에만 사용합니다.
  ///     - seondary(default): 보편적인 경우에 사용합니다.
  ///     - onOverlay: dimmed layer 등과 함께할 때 사용합니다.
  /// - Attention: 한 화면에 여러개의 Loader를 표시하지 않습니다. 이는 유저의 행동을 방해할 수 있으며, 유저에게 필요 이상의 불안정한 상태를 제공합니다.
  public init(size: Size) {
    self.init(size: size, variant: .secondary)
  }
}

