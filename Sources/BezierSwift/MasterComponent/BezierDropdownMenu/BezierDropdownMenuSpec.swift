//
//  BezierDropdownMenuSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Item Variant

/// 드롭다운 메뉴 항목의 색 변형. Figma `Internal/DropdownMenuItem`의 `variant` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierDropdownMenuItemVariant: CaseIterable {
  /// 일반 액션 항목에 쓰는 기본값.
  case neutral
  /// 삭제·초기화 등 되돌릴 수 없는 파괴적 액션 전용. 텍스트·아이콘을 red로 강조한다. 해당 항목은 별도 그룹으로 분리해 목록 맨 아래에 배치한다.
  case destructive

  var titleColor: BCSemanticToken {
    switch self {
    case .neutral: return .textNeutral
    case .destructive: return .textAccentRed
    }
  }

  var iconColor: BCSemanticToken {
    switch self {
    case .neutral: return .iconNeutralHeavy
    case .destructive: return .iconAccentRed
    }
  }
}

// MARK: - Item Leading

/// 드롭다운 메뉴 항목의 leading(좌측) 콘텐츠 유형. Figma `Internal/DropdownMenuItem`의 `leadingType` 프로퍼티에 대응 (case 이름 = Figma 값). `Content`는 custom 슬롯에 넣을 뷰 타입이다.
public enum BezierDropdownMenuItemLeading<Content> {
  /// leading 없이 텍스트만 시작하는 항목.
  case none
  /// `BezierIcon` 자산을 leading 아이콘으로 표시한다. 색은 `variant`가 결정한다 (Figma `leadingIconSource`).
  case icon(BezierIcon)
  /// 임의의 뷰를 24×24 leading 슬롯에 배치한다 (Figma `leadingContent` SLOT).
  case custom(Content)

  var hasLeadingContent: Bool {
    if case .none = self { return false }
    return true
  }
}

// MARK: - Constant

public enum BezierDropdownMenuConstant {
  public static let triggerSpacing: CGFloat = 4
}

public enum BezierDropdownMenuItemConstant {
  public static let horizontalPadding: CGFloat = 10
  public static let cornerRadius: CGFloat = 16
  public static let slotHeight: CGFloat = 24

  static func baseItemStyle(variant: BezierDropdownMenuItemVariant) -> BezierBaseItemStyle {
    BezierBaseItemStyle(
      horizontalPadding: self.horizontalPadding,
      cornerRadius: self.cornerRadius,
      centerLeadingInset: 0,
      titleColor: variant.titleColor,
      allowsSmallDescription: true
    )
  }
}
