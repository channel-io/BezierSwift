//
//  BezierCornerRadius+CaseIterable.swift
//  BezierSwift
//

import Foundation

// `roundHalf(length:)`·`roundAvatar(length:)`가 associated value를 가져 컴파일러가 `allCases`를
// 합성하지 못한다. 그래서 배열을 손으로 쓰고, 선언과의 정합성은 테스트가 지킨다.
extension BezierCornerRadius: CaseIterable {
  /// 열거 가능한 고정 corner radius 토큰 11개. 값 오름차순이다.
  ///
  /// `roundHalf(length:)`·`roundAvatar(length:)`는 제외한다. 대상 뷰의 길이에서 반경을
  /// 계산하는 가변 토큰이므로 값이 연속적이고, 따라서 열거 대상이 아니다.
  public static let allCases: [BezierCornerRadius] = [
    .round2, .round3, .round4, .round6, .round8, .round12,
    .round16, .round20, .round22, .round32, .round44,
  ]
}
