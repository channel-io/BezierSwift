//
//  BezierTextAreaSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Constant

enum BezierTextAreaConstant {
  static let verticalPadding: CGFloat = 8
  static let cornerRadius: CGFloat = 12
  static let minLineCount = 2
  static let maxLineCount = 6

  /// 64pt — SwiftUI는 `lineLimit` 행 수로, UIKit은 이 pt 값으로 같은 높이를 만든다.
  static let minHeight = Self.height(lineCount: Self.minLineCount)
  /// 160pt — 위와 동일.
  static let maxHeight = Self.height(lineCount: Self.maxLineCount)

  private static func height(lineCount: Int) -> CGFloat {
    CGFloat(lineCount) * BezierBaseInputConstant.textTypography.lineHeight
      + Self.verticalPadding * 2
  }
}
