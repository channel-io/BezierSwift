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

  /// 접기/펼치기 전환 시간(초). 소비자가 `isOpen`을 외부에서 토글할 때 컴포넌트와 같은 리듬으로
  /// 애니메이션하려면 이 값을 `withAnimation`에 전달한다.
  public static let openAnimationDuration: TimeInterval = 0.25

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
