//
//  BezierCollapsibleSectionSpec.swift
//  BezierSwift
//

import Foundation
import CoreGraphics

// MARK: - Constant

public enum BezierCollapsibleSectionConstant {
  /// 헤더 chevron 아이콘 한 변 길이 (Figma `chevron` 16×16).
  public static let chevronLength: CGFloat = 16

  static let openAnimationDuration: TimeInterval = 0.25

  static let labelPressedBackgroundColor: BCSemanticToken = .fillNeutralLighter

  static func chevronIcon(isOpen: Bool) -> BezierIcon {
    isOpen ? .chevronSmallDown : .chevronSmallRight
  }
}

// MARK: - Chevron Color

extension BezierSectionLabelColor {
  var chevronColor: BCSemanticToken {
    switch self {
    case .neutralDark: return .iconNeutralHeavier
    case .neutralLight: return .iconNeutral
    }
  }
}
