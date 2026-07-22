//
//  BezierToastSpec.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierToastPreset: String, CaseIterable {
  case success
  case error
  case info

  /// preset별 leading 아이콘. `info`는 아이콘 없음(nil).
  public var icon: BezierIcon? {
    switch self {
    case .success: return .checkCircleFilled
    case .error: return .errorDiamondFilled
    case .info: return nil
    }
  }

  /// leading 아이콘 tint. Figma export SVG 기준 success·error 모두 `iconNeutralHeavy`(#ffffff99, white opacity 0.6).
  /// `info`는 아이콘이 없어 사용되지 않는다.
  public var iconColor: BCSemanticToken {
    .iconNeutralHeavy
  }
}

public enum BezierToastSpec {
  public static let backgroundToken: BCSemanticToken = .fillGreyHeavier
  public static let textToken: BCSemanticToken = .textNeutral
  public static let typographyToken: BTSemanticToken = .textMedium(weight: .bold)

  public static let maxWidth: CGFloat = 460
  public static let minHeight: CGFloat = 40
  public static let iconLength: CGFloat = 20
  public static let iconTextGap: CGFloat = 6
  public static let verticalPadding: CGFloat = 10
  public static let horizontalPaddingWithIcon: CGFloat = 12
  public static let horizontalPaddingTextOnly: CGFloat = 14
  public static let textLineLimit: Int = 2
}
