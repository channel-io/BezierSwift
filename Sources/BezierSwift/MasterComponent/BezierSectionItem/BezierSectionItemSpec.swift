//
//  BezierSectionItemSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Size

/// 섹션 아이템의 크기. Figma `Internal/SectionItem`의 `size` 프로퍼티에 대응 (case 이름 = Figma 값). 행 높이·leading 크기·description 배치 구조를 결정한다.
public enum BezierSectionItemSize: CaseIterable {
  /// 최소 높이 40, leading 24×24. 조밀한 리스트에 쓴다.
  case small
  /// 최소 높이 48, leading 24×24. 대부분의 섹션 행에 쓰는 기본값이다.
  case medium
  /// 최소 높이 52, leading 36×36. description을 label 아래 nested로 배치한다. 아바타·설명이 함께 있는 행에 쓴다.
  case large

  var minHeight: CGFloat {
    switch self {
    case .small: return 40
    case .medium: return 48
    case .large: return 52
    }
  }

  var verticalPadding: CGFloat {
    switch self {
    case .small: return 6
    case .medium: return 8
    case .large: return 6
    }
  }

  var leadingLength: CGFloat {
    switch self {
    case .small, .medium: return 24
    case .large: return 36
    }
  }

  var customLeadingLength: CGFloat {
    switch self {
    case .small, .medium: return 20
    case .large: return 36
    }
  }

  var isDescriptionNested: Bool {
    self == .large
  }
}

// MARK: - Leading

/// 섹션 아이템의 leading(좌측) 콘텐츠 유형. Figma `Internal/SectionItem`의 `leadingType` 프로퍼티에 대응 (case 이름 = Figma 값). `Content`는 avatar/custom 슬롯에 넣을 뷰 타입이다.
public enum BezierSectionItemLeading<Content> {
  /// leading 없이 텍스트만 시작하는 행.
  case none
  /// `BezierIcon` 자산을 leading 아이콘으로 표시한다.
  case icon(BezierIcon)
  /// 아바타 뷰를 leading에 배치한다 (Figma는 Avatar 인스턴스).
  case avatar(Content)
  /// 임의의 뷰를 leading에 배치하는 자유 구조. 이때 label·description·centerSlot 대신 `customCenterContent`로 중앙을 채운다.
  case custom(Content)

  var isCustom: Bool {
    if case .custom = self { return true }
    return false
  }

  var hasLeadingContent: Bool {
    if case .none = self { return false }
    return true
  }

  func leadingLength(size: BezierSectionItemSize) -> CGFloat {
    self.isCustom ? size.customLeadingLength : size.leadingLength
  }
}

// MARK: - Accessory

/// 섹션 아이템 우측 accessory 유형. Figma `Internal/SectionItemAccessory`의 `type` 프로퍼티에 대응 (case 이름 = Figma 값). 모두 탭 불가한 상태 표시자다 (단일 탭 타겟 불변식).
public enum BezierSectionItemAccessory<Content> {
  /// `chevronSmallRight` 아이콘. 다음 화면으로 이동하는 행에 쓴다.
  case navigation
  /// `arrowRightUpSmall` 아이콘. 외부 링크로 나가는 행에 쓴다.
  case outlink
  /// 선택된 값 텍스트 + `chevronUpdown`. 단일 선택 값을 보여줄 때 쓴다.
  case select(value: String)
  /// 값들을 콤마로 이어 붙인 텍스트 + `chevronUpdown`. 다중 선택 값을 보여줄 때 쓴다.
  case multiselect(values: [String])
  /// 값 텍스트만 표시한다. 편집 없이 현재 값만 보여줄 때 쓴다.
  case display(value: String)
  /// 켜짐/꺼짐 상태를 나타내는 비인터랙티브 토글 표시자.
  case toggle(isOn: Bool)
  /// 임의의 뷰를 accessory로 배치한다 (포커서블 컨트롤 금지).
  case custom(Content)
}

// MARK: - Constant

public enum BezierSectionItemConstant {
  public static let horizontalPadding: CGFloat = 10
  public static let slotSpacing: CGFloat = 10
  public static let labelRowSpacing: CGFloat = 4
  public static let centerSlotHeight: CGFloat = 24
  public static let descriptionIndent: CGFloat = 34
  public static let nestedDescriptionSpacing: CGFloat = 2
  public static let accessoryHeight: CGFloat = 32
  public static let accessoryIconLength: CGFloat = 24
  public static let accessoryChevronUpdownLength: CGFloat = 16
  public static let accessoryTextSpacing: CGFloat = 6
  public static let accessoryTextHorizontalPadding: CGFloat = 4
  public static let toggleWidth: CGFloat = 50
  public static let toggleHeight: CGFloat = 28
  public static let toggleCornerRadius: CGFloat = 14
  public static let toggleThumbLength: CGFloat = 24
  public static let toggleThumbInset: CGFloat = 2
  // Figma Switch(1095:19) thumb drop-shadow 실측: offset (0,2) / blur 4 / black 25%
  // CALayer shadowRadius와 SwiftUI .shadow(radius:)는 gaussian σ 단위라 blur 4 = radius 2
  public static let toggleThumbShadowOpacity: Float = 0.25
  public static let toggleThumbShadowOffset = CGSize(width: 0, height: 2)
  public static let toggleThumbShadowRadius: CGFloat = 2

  static let disabledOpacity: CGFloat = BOGlobalToken.disabled

  static let contentTypography: BTSemanticToken = .textXLarge(weight: .regular)
  static let descriptionTypography: BTSemanticToken = .captionMedium(weight: .regular)
  static let accessoryTextTypography: BTSemanticToken = .textLarge(weight: .regular)

  static let contentColor: BCSemanticToken = .textNeutral
  static let descriptionColor: BCSemanticToken = .textNeutralLighter
  static let leadingIconColor: BCSemanticToken = .iconNeutralHeavy
  static let pressedBackgroundColor: BCSemanticToken = .fillNeutralLighter
  static let destructiveContentColor: BCSemanticToken = .textAccentRed
  static let destructiveIconColor: BCSemanticToken = .iconAccentRed

  static let accessoryTextColor: BCSemanticToken = .textNeutralLighter
  static let accessoryIconColor: BCSemanticToken = .iconNeutral
  static let toggleTrackOffColor: BCSemanticToken = .fillNeutralHeavy
  static let toggleTrackOnColor: BCSemanticToken = .fillNeutralHeaviest
  static let toggleThumbColor: BCSemanticToken = .iconInverseHeavier

  static func multiselectText(values: [String]) -> String {
    values.joined(separator: ", ")
  }
}
