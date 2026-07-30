//
//  BezierCornerRadius+CaseIterable.swift
//  BezierSwift
//

import CoreGraphics

extension BezierCornerRadius: CaseIterable {
  /// 열거 가능한 고정 corner radius 토큰 11개. 값 오름차순이다.
  ///
  /// `roundHalf(length:)`·`roundAvatar(length:)`는 제외한다. 대상 뷰의 길이에서 반지름을
  /// 계산하는 가변 토큰이므로 값이 연속적이고, 따라서 열거 대상이 아니다.
  public static let allCases: [BezierCornerRadius] = [
    .round2, .round3, .round4, .round6, .round8, .round12,
    .round16, .round20, .round22, .round32, .round44,
  ]

  /// corner radius 실측값(pt). UIKit에서는 `layer.cornerRadius`에 직접 넣는다.
  ///
  /// SwiftUI에서는 이 값을 직접 쓰지 않고 `applyBezierCornerRadius(type:)`을 쓴다.
  public var pointValue: CGFloat { self.rawValue }
}
