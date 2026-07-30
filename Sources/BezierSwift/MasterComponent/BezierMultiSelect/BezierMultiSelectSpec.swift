//
//  BezierMultiSelectSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Container

/// 선택 목록을 화면에 어떻게 얹을지 정하는 표현 방식. Figma `MultiSelect`의 `container` 프로퍼티에 대응 (case 이름 = Figma 값). Figma의 `bottomsheet`는 대응 쉘 컴포넌트가 없어 제공하지 않는다 — bottom sheet 안에서는 `.page`를 시트 콘텐츠로 넣고 Cancel/Save 버튼은 시트 쪽에서 붙인다.
public enum BezierMultiSelectContainer: CaseIterable {
  /// 화면에 인라인으로 목록을 그대로 배치한다. bottom sheet·전체 화면 등 이미 확보된 영역 안에 넣을 때 쓰는 기본값이다.
  case page
  /// `BezierOverlay` 카드(240pt 고정 폭)로 감싼다. 트리거 근처에 backdrop 없이 띄우는 앵커형 팝오버 맥락(태블릿·넓은 화면)에 쓴다. 이 맥락에서는 항목 탭이 그 자리에서 즉시 반영되므로 확정 버튼을 두지 않는다.
  case overlay
}

// MARK: - Option Leading

/// 선택 항목의 leading(좌측) 콘텐츠 유형. Figma `Internal/MultiSelectOption`의 `leadingType` 프로퍼티에 대응 (case 이름 = Figma 값). `Content`는 슬롯에 넣을 뷰 타입이다. 한 목록 안에서는 전 항목에 일관되게 쓰거나 전부 생략한다 — 일부만 넣으면 텍스트 시작 위치가 어긋난다.
public enum BezierMultiSelectOptionLeading<Content> {
  /// leading 없이 텍스트만 시작하는 항목. 텍스트만으로 선택지가 충분히 구분될 때 쓴다.
  case none
  /// `BezierIcon` 자산을 leading 아이콘으로 표시한다 (Figma `leadingIconSource`). 아이콘이 선택지의 유형·의미를 대표할 때 쓴다.
  case icon(BezierIcon)
  /// 사람·엔티티를 고르는 목록에서 `BezierAvatar`를 24×24 leading 슬롯에 배치한다 (Figma `leadingType=avatar`).
  case avatar(Content)
  /// 위 셋으로 표현되지 않는 임의의 뷰를 24×24 leading 슬롯에 배치한다 (Figma `leadingContent` SLOT).
  case custom(Content)
}

// MARK: - Constant

/// 선택 항목(`BezierMultiSelectOption` / `SUBezierMultiSelectOption`)의 레이아웃 상수. Figma `Internal/MultiSelectOption` 실측값이다.
public enum BezierMultiSelectOptionConstant {
  /// 항목 좌우 패딩.
  public static let horizontalPadding: CGFloat = 10
  /// 항목 상하 패딩. 최소 높이 48을 넘기는 경우(description 표시)에만 실제 높이에 반영된다.
  public static let verticalPadding: CGFloat = 6
  /// 항목 배경 corner radius. pressed 배경과 콘텐츠 클리핑에 함께 쓰인다.
  public static let cornerRadius: CGFloat = 16
  /// 선택 표시 체크 아이콘의 한 변 길이.
  public static let checkIconLength: CGFloat = 20
  /// 제목 우측 인라인 슬롯의 고정 높이. 초과하는 콘텐츠는 잘린다.
  public static let centerSlotHeight: CGFloat = 24

  static let leadingIconColor: BCSemanticToken = .iconNeutralHeavy
  static let checkIconColor: BCSemanticToken = .iconNeutralHeavier

  static let baseItemStyle = BezierBaseItemStyle(
    horizontalPadding: BezierMultiSelectOptionConstant.horizontalPadding,
    verticalPadding: BezierMultiSelectOptionConstant.verticalPadding,
    cornerRadius: BezierMultiSelectOptionConstant.cornerRadius,
    centerLeadingInset: 0
  )
}
