//
//  BezierConfirmModalSpec.swift
//  BezierSwift
//

import UIKit

public struct BezierConfirmModalAction {
  public let title: String
  public let handler: () -> Void

  public init(title: String, handler: @escaping () -> Void = {}) {
    self.title = title
    self.handler = handler
  }
}

public enum BezierConfirmModalType {
  case `default`
  case destructive

  public var confirmButtonSemantic: BezierButtonSemantic {
    switch self {
    case .default: return .primary
    case .destructive: return .destructive
    }
  }
}

// horizontal + altAction 조합은 SPEC 금지 규칙이라 타입 구조로 배제한다
public enum BezierConfirmModalButtonLayout {
  case vertical(altAction: BezierConfirmModalAction?)
  case horizontal
}

public enum BezierConfirmModalSpec {
  public static let contentSpacing: CGFloat = 10
  public static let contentBottomPadding: CGFloat = 8
  public static let buttonsTopPadding: CGFloat = 12
  public static let horizontalButtonSpacing: CGFloat = 8
  public static let verticalButtonSpacing: CGFloat = 10
  public static let buttonSize: BezierButtonSize = .large
  public static let buttonVariant: BezierButtonVariant = .filled
  public static let cancelSemantic: BezierButtonSemantic = .secondary
  public static let titleTypography: BTSemanticToken = .headingXSmall
  public static let descriptionTypography: BTSemanticToken = .textLarge(weight: .regular)
  public static let textColorToken: BCSemanticToken = .textNeutral
}
