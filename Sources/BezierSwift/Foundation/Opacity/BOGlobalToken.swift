//
//  BOGlobalToken.swift
//  BezierSwift
//

import CoreGraphics

/// Bezier Opacity V3 Global Token
/// Figma `opacity/*` 변수 대응. internal — 컴포넌트 내부에서만 참조하며 외부로 노출하지 않는다.
enum BOGlobalToken {
  /// Figma `opacity/disabled` = 40% → 0.4
  static let disabled: CGFloat = 0.4
}
