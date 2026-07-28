//
//  SUBezierTextArea.swift
//  BezierSwift
//

import SwiftUI

/// 여러 줄 텍스트 입력 영역 (SwiftUI). 설명·메모·답변 템플릿처럼 여러 줄이거나 길이를 예측할 수 없는 텍스트를 입력받을 때 쓴다. 한 줄로 충분한 입력(이름·이메일 등)에는 `SUBezierTextInput`을 사용한다. UIKit에서는 `BezierTextArea`를 사용한다.
///
/// 너비는 컨테이너가 결정한다 — 기본으로 부모 폭을 채운다.
/// 높이는 기본 64pt(2행)에서 내용에 따라 최대 160pt(6행)까지 자동 확장되고, 초과분은 내부 스크롤로 표시된다.
/// 키보드 옵션은 표준 modifier(`.keyboardType` 등)를 밖에서 적용하면 내부 텍스트 필드로 전파된다.
public struct SUBezierTextArea: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled
  @FocusState private var isFocused: Bool

  @Binding private var text: String
  private let placeholder: String
  private let hasError: Bool
  private let isReadOnly: Bool

  /// 입력값 바인딩과 상태를 지정해 생성한다.
  ///
  /// - `hasError`: 에러 보더 표시. 원인·해결 방법 메시지를 함께 노출해야 한다.
  /// - `isReadOnly`: 편집만 차단하고 텍스트 선택·복사는 유지한다.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    hasError: Bool = false,
    isReadOnly: Bool = false
  ) {
    self._text = text
    self.placeholder = placeholder
    self.hasError = hasError
    self.isReadOnly = isReadOnly
  }

  public var body: some View {
    self.fieldView
      .frame(
        minHeight: BezierTextAreaConstant.minHeight - BezierTextAreaConstant.verticalPadding * 2,
        maxHeight: BezierTextAreaConstant.maxHeight - BezierTextAreaConstant.verticalPadding * 2,
        alignment: .topLeading
      )
      .padding(.horizontal, BezierBaseInputConstant.horizontalPadding)
      .padding(.vertical, BezierTextAreaConstant.verticalPadding)
      .frame(minWidth: BezierBaseInputConstant.minWidth, maxWidth: .infinity, alignment: .topLeading)
      .background(
        RoundedRectangle(cornerRadius: BezierTextAreaConstant.cornerRadius)
          .fill(self.palette(BezierBaseInputAppearance.backgroundColor(variant: .primary, state: self.state)))
      )
      .overlay { self.borderOverlay }
      // opacity는 per-view 곱이라 배경·보더가 겹치는 링 영역이 이중 블렌딩됨 — 합성 후 1회 적용 (UIKit self.alpha와 동일 결과)
      .compositingGroup()
      .opacity(self.state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1)
      .contentShape(Rectangle())
      .onTapGesture {
        guard self.isEnabled, !self.isReadOnly else { return }
        self.isFocused = true
      }
  }

  // MARK: - State

  private var state: BezierBaseInputState {
    .resolve(
      isEnabled: self.isEnabled,
      isReadOnly: self.isReadOnly,
      hasError: self.hasError,
      isFocused: self.isFocused
    )
  }

  private var readOnlyMaxLineCount: Int {
    self.text.isEmpty ? BezierTextAreaConstant.minLineCount : BezierTextAreaConstant.maxLineCount
  }

  // MARK: - Subviews

  @ViewBuilder
  private var fieldView: some View {
    if self.isReadOnly {
      Text(self.text.isEmpty ? self.placeholder : self.text)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: self.text.isEmpty
            ? BezierBaseInputConstant.placeholderColor
            : BezierBaseInputAppearance.textColor(state: self.state)
        )
        // 값이 없을 때 그리는 건 placeholder다 — 값과 달리 컨테이너를 키우면 안 되므로 2행에 고정한다
        // (UIKit은 placeholder가 textView 밖 별도 라벨이라 애초에 높이에 관여하지 않는다)
        .lineLimit(BezierTextAreaConstant.minLineCount...self.readOnlyMaxLineCount)
        .truncationMode(.tail)
        .textSelection(.enabled)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    } else {
      TextField("", text: self.$text, axis: .vertical)
        .focused(self.$isFocused)
        .textFieldStyle(.plain)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: BezierBaseInputConstant.textColor
        )
        // 상한을 lineLimit으로 걸면 안 된다 — TextField는 상한 행 수를 폰트 고유 행높이(16pt
        // 기준 약 19pt)로 예산 잡는데 실제 렌더는 lineSpacing이 실려 24pt 피치라, 6행을 지정해도
        // 5행만 보인다. 상한은 컨테이너의 pt 높이(maxHeight)로만 건다
        .lineLimit(BezierTextAreaConstant.minLineCount...)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        // TextField의 prompt는 Text만 받아 lineSpacing을 실을 수 없다 — 여러 줄 placeholder의
        // 행 높이를 24pt로 맞추려면 별도 오버레이로 그려야 한다 (UIKit placeholderLabel과 동형)
        .overlay(alignment: .topLeading) { self.placeholderOverlay }
    }
  }

  @ViewBuilder
  private var placeholderOverlay: some View {
    if self.text.isEmpty {
      Text(self.placeholder)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: BezierBaseInputConstant.placeholderColor
        )
        // 오버레이는 클립되지 않는다 — 값이 비어 있는 동안 컨테이너가 머무는 2행으로 직접 막지 않으면
        // 라운드 박스 밖으로 그려진다
        .lineLimit(BezierTextAreaConstant.minLineCount)
        .truncationMode(.tail)
        // 오버레이에는 TextField 자신의 높이(빈 값일 때 폰트 고유 행높이 기준 약 38pt)가 제안되는데
        // 실제 2행은 lineSpacing이 실려 48pt다 — 제안을 그대로 받으면 2행을 못 채우고 1행에서 잘린다
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .allowsHitTesting(false)
    }
  }

  @ViewBuilder
  private var borderOverlay: some View {
    if let borderColor = BezierBaseInputAppearance.borderColor(variant: .primary, state: self.state) {
      RoundedRectangle(cornerRadius: BezierTextAreaConstant.cornerRadius)
        .strokeBorder(self.palette(borderColor), lineWidth: BezierBaseInputConstant.borderWidth)
    }
  }
}

struct SUBezierTextArea_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      SUBezierTextArea(text: .constant(""), placeholder: "채널의 특징을 간략히 소개해보세요")
      SUBezierTextArea(text: .constant("여러 줄 입력 값\n두 번째 줄"))
      SUBezierTextArea(text: .constant("잘못된 값"), hasError: true)
      SUBezierTextArea(text: .constant("읽기 전용 값"), isReadOnly: true)
      SUBezierTextArea(text: .constant("비활성 값"))
        .disabled(true)
    }
    .padding()
  }
}
