//
//  BezierFormSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Label Position

/// FormField의 라벨-컨트롤 배치. Figma `Internal/FormField` 컴포넌트의 `labelPosition` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierFormFieldLabelPosition: CaseIterable {
  /// 라벨 아래에 컨트롤이 전체 폭으로 깔리는 stacked 배치 (기본값). TextInput처럼 넓은 컨트롤에 쓴다.
  case top
  /// 라벨 좌측 · 컨트롤 우측의 inline 배치. Switch·Select처럼 compact한 컨트롤에 쓴다. 컨트롤 영역은 최소 120pt · 최대 200pt 폭으로 우측 정렬된다. 라벨을 전제로 한 배치라 라벨을 비워도 라벨 영역은 자리를 유지한다.
  case left
}

// MARK: - Constant

/// Form 계열의 Figma 실측 레이아웃 상수. 폼 주변에 커스텀 뷰를 붙일 때 간격을 맞추는 용도로 공개한다.
public enum BezierFormConstant {
  /// Form이 필드 사이에 주는 간격. 필드 간 여백은 `fieldBottomPadding`이 담당하므로 0이다.
  public static let fieldSpacing: CGFloat = 0
  /// FormField 루트 세로 간격 (Content · customContent · 에러 메시지 사이).
  public static let fieldContentSpacing: CGFloat = 6
  /// FormField 하단 패딩. 폼 안에서 필드 간 실질 간격이 된다.
  public static let fieldBottomPadding: CGFloat = 24
  /// `top` 배치에서 라벨 영역과 컨트롤 사이 간격.
  public static let labelToControlSpacing: CGFloat = 8
  /// 라벨 영역 좌측 패딩.
  public static let labelAreaLeadingPadding: CGFloat = 2
  /// 라벨과 필수 마커(`*`) 사이 간격.
  public static let labelRowSpacing: CGFloat = 2
  /// 라벨과 설명 텍스트 사이 간격.
  public static let labelToDescriptionSpacing: CGFloat = 2
  /// `left` 배치에서 컨트롤 영역 최소 폭.
  public static let inlineControlMinWidth: CGFloat = 120
  /// `left` 배치에서 컨트롤 영역 최대 폭.
  public static let inlineControlMaxWidth: CGFloat = 200
  /// 에러 메시지의 아이콘과 텍스트 사이 간격.
  public static let errorMessageSpacing: CGFloat = 4
  /// 에러 메시지 좌측 패딩 (라벨 영역 좌측 패딩과 정렬).
  public static let errorMessageLeadingPadding: CGFloat = 2
  /// 에러 메시지 행의 코너 반경. 배경이 없어 시각 결과는 없고 Figma 값 보존용이다.
  public static let errorMessageCornerRadius: CGFloat = 8
  /// 에러 아이콘을 감싸는 박스 높이. 아이콘은 이 안에서 수직 중앙 정렬된다.
  public static let errorIconBoxHeight: CGFloat = 16
  /// 에러 아이콘 한 변 길이.
  public static let errorIconLength: CGFloat = 10

  static let requiredMarkerText = "*"
  static let errorIcon: BezierIcon = .errorDiamondFilled

  static let labelTypography: BTSemanticToken = .labelLarge
  static let descriptionTypography: BTSemanticToken = .textXSmall(weight: .regular)
  static let errorMessageTypography: BTSemanticToken = .captionMedium(weight: .regular)

  static let labelColor: BCSemanticToken = .textNeutral
  static let requiredMarkerColor: BCSemanticToken = .textAccentOrange
  static let descriptionColor: BCSemanticToken = .textNeutralLighter
  static let errorMessageTextColor: BCSemanticToken = .textAccentOrange
  static let errorMessageIconColor: BCSemanticToken = .iconAccentOrange
}
