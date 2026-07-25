//
//  BezierBannerSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Variant

/// 배너의 색상 계열(상황 톤). Figma `Banner` 컴포넌트의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값). Figma에서는 variant별 기본 아이콘이 정해져 있으나, Swift에서는 `leadingIcon`으로 지정한다.
public enum BezierBannerVariant: CaseIterable {
  /// 중립 정보. 특별한 감정 톤이 필요 없는 일반 안내에 쓴다.
  case `default`
  /// 일반 안내·추천 정보에 쓴다.
  case blue
  /// 시스템 상태·진행 중 안내에 쓴다.
  case cobalt
  /// 성공·완료를 알릴 때 쓴다.
  case green
  /// 경고·주의가 필요할 때 쓴다.
  case orange
  /// 오류·차단·위험을 알릴 때 쓴다.
  case red

  var backgroundColor: BCSemanticToken {
    switch self {
    case .default: return .fillNeutralLighter
    case .blue: return .fillAccentBlue
    case .cobalt: return .fillAccentCobalt
    case .green: return .fillAccentGreen
    case .orange: return .fillAccentOrange
    case .red: return .fillAccentRed
    }
  }

  var iconColor: BCSemanticToken {
    switch self {
    case .default: return .iconNeutral
    case .blue: return .iconAccentBlue
    case .cobalt: return .iconAccentCobalt
    case .green: return .iconAccentGreen
    case .orange: return .iconAccentOrange
    case .red: return .iconAccentRed
    }
  }

  var textColor: BCSemanticToken {
    switch self {
    case .default: return .textNeutralLight
    case .blue: return .textAccentBlue
    case .cobalt: return .textAccentCobalt
    case .green: return .textAccentGreen
    case .orange: return .textAccentOrange
    case .red: return .textAccentRed
    }
  }
}

// MARK: - ClickArea

/// 배너의 클릭(탭) 동작 영역. 선택에 따라 우측 trailing 아이콘도 함께 결정된다.
public enum BezierBannerClickArea {
  /// 클릭이 없는 정보 표시용. trailing 아이콘이 없다.
  case none
  /// 배너 전체를 탭 영역으로 쓴다. trailing에 chevron 아이콘이 노출된다.
  case full(onClick: () -> Void)
  /// 우측 액션 아이콘만 탭 영역으로 쓴다. trailing에 close 아이콘이 노출된다.
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

public enum BezierBannerConstant {
  public static let horizontalPadding: CGFloat = 8
  public static let verticalPadding: CGFloat = 10
  public static let cornerRadius: CGFloat = 16

  public static let leadingIconLeadingPadding: CGFloat = 4
  public static let leadingIconTrailingPadding: CGFloat = 2
  public static let leadingIconVerticalPadding: CGFloat = 5
  public static let iconLength: CGFloat = 20

  public static let contentPadding: CGFloat = 6
  public static let contentSpacing: CGFloat = 4

  public static let actionIconContainerLength: CGFloat = 30
  public static let actionIconPadding: CGFloat = 5

  static let titleTypography: BTSemanticToken = .textMedium(weight: .bold)
  static let descriptionTypography: BTSemanticToken = .textMedium(weight: .regular)
}
