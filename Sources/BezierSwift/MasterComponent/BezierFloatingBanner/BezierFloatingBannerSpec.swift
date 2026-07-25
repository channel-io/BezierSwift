//
//  BezierFloatingBannerSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - ClickArea

/// 플로팅 배너의 탭 동작. 코드 전용 축으로, Figma `Banner`(Type=Floating)의 `close` 불리언과 Android `onClick` 패턴을 하나의 enum으로 합친 것이다 (Figma에 단일 대응 프로퍼티는 없다).
public enum BezierFloatingBannerClickArea {
  /// 탭 상호작용이 없는 순수 안내 배너. trailing 아이콘도 표시하지 않는다.
  case none
  /// 배너 전체를 탭 영역으로 만들고 우측에 `chevronSmallRight`를 표시한다. 배너를 눌러 상세로 이동시킬 때 쓴다 (Android `onClick` 패턴).
  case full(onClick: () -> Void)
  /// 우측에 닫기용 `cancelSmall` 아이콘만 탭 가능하게 둔다. 사용자가 배너를 닫게 할 때 쓴다 (Figma `close=true`).
  case actionIcon(onClick: () -> Void)

  var trailingIcon: BezierIcon? {
    switch self {
    case .none: return nil
    case .full: return .chevronSmallRight
    case .actionIcon: return .cancelSmall
    }
  }
}

// MARK: - Constant

public enum BezierFloatingBannerConstant {
  public static let leadingPadding: CGFloat = 10
  public static let trailingPadding: CGFloat = 8
  public static let verticalPadding: CGFloat = 10
  public static let cornerRadius: CGFloat = 16
  public static let minHeight: CGFloat = 30

  public static let leadingIconLeadingPadding: CGFloat = 2
  public static let leadingIconVerticalPadding: CGFloat = 5
  public static let iconLength: CGFloat = 20

  public static let contentPadding: CGFloat = 6
  public static let contentSpacing: CGFloat = 4

  public static let actionIconContainerLength: CGFloat = 30
  public static let actionIconPadding: CGFloat = 5

  public static let elevation: BezierElevation = .mEv3

  static let backgroundColor: BCSemanticToken = .surfaceHighest
  static let textColor: BCSemanticToken = .textNeutralLight
  static let actionIconColor: BCSemanticToken = .iconNeutral
  public static let defaultLeadingIconColor: BCSemanticToken = .iconNeutral

  static let titleTypography: BTSemanticToken = .textMedium(weight: .bold)
  static let descriptionTypography: BTSemanticToken = .textMedium(weight: .regular)
}
