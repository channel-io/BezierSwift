//
//  BezierToastSpec.swift
//  BezierSwift
//

import CoreGraphics
import UIKit

/// 토스트의 표시 유형. Figma `Toast`(Mobile Components) 컴포넌트의 `preset` 프로퍼티(`success` / `error` / `info`)에 대응한다.
public enum BezierToastPreset: String, CaseIterable {
  /// 저장·삭제 등 액션 완료 결과를 알린다. 3초 후 자동 해제된다.
  case success
  /// 액션 실패 결과를 알린다.
  case error
  /// 아이콘 없는 중립 알림에 쓴다.
  case info

  /// preset별 leading 아이콘. `info`는 아이콘 없음(nil).
  public var icon: BezierIcon? {
    switch self {
    case .success: return .checkCircleFilled
    case .error: return .errorDiamondFilled
    case .info: return nil
    }
  }

  /// leading 아이콘 tint. Figma export SVG 기준 success는 `iconAccentGreen`, error는 `iconAccentRed`.
  /// `info`는 아이콘이 없어 nil.
  public var iconColor: BCSemanticToken? {
    switch self {
    case .success: return .iconAccentGreen
    case .error: return .iconAccentRed
    case .info: return nil
    }
  }
}

public enum BezierToastSpec {
  public static let backgroundToken: BCSemanticToken = .surfaceGlass
  public static let textToken: BCSemanticToken = .textNeutral
  public static let typographyToken: BTSemanticToken = .textMedium(weight: .bold)

  public static let cornerRadius: BezierCornerRadius = .round20
  public static let maxWidth: CGFloat = 460
  public static let minHeight: CGFloat = 40
  public static let iconLength: CGFloat = 20
  public static let iconTextGap: CGFloat = 6
  public static let verticalPadding: CGFloat = 12
  public static let horizontalPaddingWithIcon: CGFloat = 12
  public static let horizontalPaddingTextOnly: CGFloat = 14
  public static let textVerticalPadding: CGFloat = 1
  public static let textLineLimit: Int = 2

  static func blurEffectStyle(for colorTheme: BezierColorTheme) -> UIBlurEffect.Style {
    switch colorTheme {
    case .light: return .systemUltraThinMaterialLight
    case .dark: return .systemUltraThinMaterialDark
    }
  }
}
