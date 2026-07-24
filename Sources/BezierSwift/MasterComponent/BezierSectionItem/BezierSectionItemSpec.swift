//
//  BezierSectionItemSpec.swift
//  BezierSwift
//

import CoreGraphics

// MARK: - Size

public enum BezierSectionItemSize: CaseIterable {
  case small
  case medium
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

public enum BezierSectionItemLeading<Content> {
  case none
  case icon(BezierIcon)
  case avatar(Content)
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

public enum BezierSectionItemAccessory<Content> {
  case navigation
  case outlink
  case select(value: String)
  case multiselect(values: [String])
  case display(value: String)
  case toggle(isOn: Bool)
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
