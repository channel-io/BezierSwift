//
//  BTSemanticToken+CaseIterable.swift
//  BezierSwift
//

import Foundation

extension BTSemanticToken: CaseIterable {
  /// 열거 가능한 타이포 semantic 토큰 22개. 선언 순서(Display → Heading → Text → Label →
  /// Caption → Code)를 따른다.
  ///
  /// `text*`·`caption*`은 `weight` 파라미터를 갖는 가변 토큰이므로 기본값 `.regular` 기준으로
  /// 담는다. bold 변형은 `boldPair`로 얻는다.
  public static let allCases: [BTSemanticToken] = [
    .displayLarge, .displayMedium,
    .headingXLarge, .headingLarge, .headingMedium, .headingSmall, .headingXSmall, .headingXXSmall,
    .textXXLarge(), .textXLarge(), .textLarge(), .textMedium(), .textSmall(), .textXSmall(),
    .textXXSmall(),
    .labelLarge, .labelMedium, .labelSmall,
    .captionMedium(), .captionSmall(),
    .codeMedium, .codeSmall,
  ]
}
