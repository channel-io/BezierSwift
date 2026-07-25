//
//  BezierConfirmModalSpec.swift
//  BezierSwift
//

import UIKit

/// 확인 모달의 버튼 하나를 나타내는 액션. 버튼 제목과 탭 시 실행할 핸들러를 담는다.
public struct BezierConfirmModalAction {
  /// 버튼에 표시할 제목.
  public let title: String
  /// 버튼을 탭했을 때 실행되는 클로저.
  public let handler: () -> Void

  /// 제목과 핸들러로 액션을 생성한다. 핸들러 기본값은 아무 동작도 하지 않는 빈 클로저다.
  public init(title: String, handler: @escaping () -> Void = {}) {
    self.title = title
    self.handler = handler
  }
}

/// 확인 모달의 시맨틱 프리셋. Figma `ConfirmModal`에는 color/style variant가 없어 이 값은 Figma variant가 아니라 코드 측 시맨틱 프리셋이며, 확인 버튼의 강조 색을 결정한다.
public enum BezierConfirmModalType {
  /// 일반 확인. 확인 버튼이 primary로 강조된다.
  case `default`
  /// 되돌릴 수 없는 파괴적 확인(삭제 등). 확인 버튼이 destructive로 강조된다.
  case destructive

  /// 이 타입에 대응하는 확인 버튼의 시맨틱 색.
  public var confirmButtonSemantic: BezierButtonSemantic {
    switch self {
    case .default: return .primary
    case .destructive: return .destructive
    }
  }
}

// horizontal + altAction 조합은 SPEC 금지 규칙이라 타입 구조로 배제한다
/// 확인 모달의 버튼 배치 방식. Figma `ConfirmModal`의 버튼 레이아웃 규칙(showCancel 조합)에 대응한다.
public enum BezierConfirmModalButtonLayout {
  /// 세로 배치. 세 번째 대체 액션(`altAction`)이 필요할 때 쓴다. 취소 없이 대체 액션만 두는 조합은 무효다.
  case vertical(altAction: BezierConfirmModalAction?)
  /// 기본 가로 배치. 주 액션과 취소 두 버튼을 나란히 둘 때 쓴다.
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
