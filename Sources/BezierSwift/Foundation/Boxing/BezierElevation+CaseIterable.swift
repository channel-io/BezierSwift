//
//  BezierElevation+CaseIterable.swift
//  BezierSwift
//

import CoreGraphics

extension BezierElevation: CaseIterable {
  /// 열거 가능한 elevation 토큰 6개. 그림자가 옅은 것부터다.
  public static let allCases: [BezierElevation] = [
    .mEv1, .mEv2, .mEv3, .mEv4, .mEv5, .mEv6,
  ]

  /// 그림자 구성값. UIKit에서는 `CALayer`의 그림자 프로퍼티에 직접 넣는다.
  /// `color`는 semantic 토큰이므로 `palette(_:)`로 해석해 쓴다.
  ///
  /// SwiftUI에서는 이 값을 직접 쓰지 않고 `applyBezierElevation(_:)`을 쓴다.
  public var shadow: (color: BCSemanticToken, offsetX: CGFloat, offsetY: CGFloat, blur: CGFloat) {
    let raw = self.rawValue
    return (color: raw.semanticColor, offsetX: raw.x, offsetY: raw.y, blur: raw.blur)
  }
}
