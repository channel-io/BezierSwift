//
//  BezierCheckboxSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Checked

/// 체크박스의 선택 상태. Figma `Checkbox` 컴포넌트의 `checked` 프로퍼티에 대응 (case 이름 = Figma 값).
public enum BezierCheckboxChecked: CaseIterable {
  /// 선택되지 않은 기본 상태. 빈 박스로 표시한다.
  case unchecked
  /// 선택된 상태. check 아이콘을 표시한다.
  case checked
  /// 하위 항목이 일부만 선택된 부분 선택 상태. 「전체 선택」 헤더 체크박스에만 쓴다. hyphen 아이콘을 표시한다.
  case indeterminate

  /// 탭했을 때 전환되는 다음 상태 (`unchecked` → `checked`, `checked` → `unchecked`, `indeterminate` → `checked`).
  public var toggled: BezierCheckboxChecked {
    switch self {
    case .unchecked: return .checked
    case .checked: return .unchecked
    case .indeterminate: return .checked
    }
  }
}

// MARK: - Constant

public enum BezierCheckboxConstant {
  public static let boxLength: CGFloat = 22
  public static let boxCornerRadius: CGFloat = 10
  public static let boxBorderWidth: CGFloat = 2
  public static let iconLength: CGFloat = 18
  public static let contentSpacing: CGFloat = 8
  public static let verticalPadding: CGFloat = 8
  public static let minHeight: CGFloat = 40

  static let errorRingLength: CGFloat = 28
  static let errorRingBorderWidth: CGFloat = 1.5
  static let errorRingCornerRadius: CGFloat = 13

  static let disabledOpacity: CGFloat = BOGlobalToken.disabled

  static let labelTypography: BTSemanticToken = .textXLarge(weight: .regular)

  static let labelColor: BCSemanticToken = .textNeutral
  static let uncheckedBackgroundColor: BCSemanticToken = .fillGreyLight
  static let uncheckedDisabledBackgroundColor: BCSemanticToken = .fillNeutralHeavy
  static let uncheckedBorderColor: BCSemanticToken = .borderNeutralHeavy
  static let checkedBackgroundColor: BCSemanticToken = .fillNeutralHeaviest
  static let iconColor: BCSemanticToken = .iconInverseHeavier
  static let errorRingColor: BCSemanticToken = .stateWarning
}
