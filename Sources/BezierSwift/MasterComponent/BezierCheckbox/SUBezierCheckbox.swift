//
//  SUBezierCheckbox.swift
//  BezierSwift
//

import SwiftUI

/// 입력·동의용 체크박스 (SwiftUI). 라벨이 곧 체크 대상이므로 라벨 없이 쓰지 않는다. 폼 입력·약관 동의에 쓰고, 리스트 다중 선택에는 쓰지 않는다. 탭하면 전환된 다음 값을 `onCheckedChange`로 통지하며 상태 반영은 호출 측 책임이다. UIKit에서는 `BezierCheckbox`를 사용한다.
public struct SUBezierCheckbox: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled

  private let label: String
  private let checked: BezierCheckboxChecked
  private let hasError: Bool
  private let onCheckedChange: ((BezierCheckboxChecked) -> Void)?

  /// 라벨·선택 상태·에러 여부를 지정해 생성한다. 탭하면 `checked.toggled` 값이 `onCheckedChange`로 전달된다.
  public init(
    label: String,
    checked: BezierCheckboxChecked = .unchecked,
    hasError: Bool = false,
    onCheckedChange: ((BezierCheckboxChecked) -> Void)? = nil
  ) {
    self.label = label
    self.checked = checked
    self.hasError = hasError
    self.onCheckedChange = onCheckedChange
  }

  public var body: some View {
    Button {
      self.onCheckedChange?(self.checked.toggled)
    } label: {
      HStack(spacing: BezierCheckboxConstant.contentSpacing) {
        self.boxView
        Text(self.label)
          .applyBezierFontStyle(
            BezierCheckboxConstant.labelTypography,
            semanticColorToken: BezierCheckboxConstant.labelColor
          )
          .fixedSize(horizontal: false, vertical: true)
      }
      .padding(.vertical, BezierCheckboxConstant.verticalPadding)
      .frame(minHeight: BezierCheckboxConstant.minHeight)
      .contentShape(Rectangle())
    }
    .buttonStyle(SUBezierCheckboxButtonStyle())
    .opacity(self.isEnabled ? 1 : BezierCheckboxConstant.disabledOpacity)
  }

  private var boxView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: BezierCheckboxConstant.boxCornerRadius)
        .fill(self.palette(self.boxBackgroundColor))

      if self.checked == .unchecked {
        RoundedRectangle(cornerRadius: BezierCheckboxConstant.boxCornerRadius)
          .strokeBorder(
            self.palette(BezierCheckboxConstant.uncheckedBorderColor),
            lineWidth: BezierCheckboxConstant.boxBorderWidth
          )
      }

      if let icon = self.icon {
        icon.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: BezierCheckboxConstant.iconLength, height: BezierCheckboxConstant.iconLength)
          .foregroundColor(self.palette(BezierCheckboxConstant.iconColor))
      }
    }
    .frame(width: BezierCheckboxConstant.boxLength, height: BezierCheckboxConstant.boxLength)
    .overlay(self.errorRingView)
  }

  private var boxBackgroundColor: BCSemanticToken {
    switch self.checked {
    case .unchecked:
      return self.isEnabled
        ? BezierCheckboxConstant.uncheckedBackgroundColor
        : BezierCheckboxConstant.uncheckedDisabledBackgroundColor
    case .checked, .indeterminate:
      return BezierCheckboxConstant.checkedBackgroundColor
    }
  }

  private var icon: BezierIcon? {
    switch self.checked {
    case .unchecked: return nil
    case .checked: return .checkBold
    case .indeterminate: return .hyphenBold
    }
  }

  @ViewBuilder
  private var errorRingView: some View {
    // SPEC §7: disabled + hasError 조합은 Figma variant에 없어 disabled 시각을 우선하고 링을 숨긴다.
    if self.hasError && self.isEnabled {
      RoundedRectangle(cornerRadius: BezierCheckboxConstant.errorRingCornerRadius)
        .strokeBorder(
          self.palette(BezierCheckboxConstant.errorRingColor),
          lineWidth: BezierCheckboxConstant.errorRingBorderWidth
        )
        .frame(
          width: BezierCheckboxConstant.errorRingLength,
          height: BezierCheckboxConstant.errorRingLength
        )
    }
  }
}

// MARK: - ButtonStyle

private struct SUBezierCheckboxButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}

struct SUBezierCheckbox_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 0) {
      SUBezierCheckbox(label: "마케팅 정보 수신 동의", checked: .unchecked, onCheckedChange: { _ in })
      SUBezierCheckbox(label: "이용약관 동의", checked: .checked, onCheckedChange: { _ in })
      SUBezierCheckbox(label: "전체 선택", checked: .indeterminate, onCheckedChange: { _ in })
      SUBezierCheckbox(label: "필수 약관 동의", checked: .unchecked, hasError: true)
      SUBezierCheckbox(label: "비활성 항목", checked: .checked)
        .disabled(true)
    }
    .padding()
  }
}
