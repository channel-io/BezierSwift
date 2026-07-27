//
//  SUBezierTextInput.swift
//  BezierSwift
//

import SwiftUI

/// 단일 행 텍스트 입력 필드 (SwiftUI). 폼 안에서 이름·이메일 등 한 줄 텍스트를 자유 입력받을 때 쓴다. UIKit에서는 `BezierTextInput`을 사용한다.
///
/// 너비는 컨테이너가 결정한다 — 기본으로 부모 폭을 채운다. 높이는 `size`에 따라 고정된다.
/// 키보드 옵션·제출 처리는 표준 modifier(`.keyboardType`, `.onSubmit` 등)를 밖에서 적용하면 내부 텍스트 필드로 전파된다.
public struct SUBezierTextInput<Leading: View, Trailing: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled
  @FocusState private var isFocused: Bool

  @Binding private var text: String
  private let placeholder: String
  private let variant: BezierTextInputVariant
  private let size: BezierTextInputSize
  private let hasError: Bool
  private let isReadOnly: Bool
  private let allowClear: Bool
  private let leading: Leading
  private let trailing: Trailing

  /// 입력값 바인딩과 스타일·상태, leading·trailing 슬롯 뷰를 지정해 생성한다.
  ///
  /// - `hasError`: 에러 보더 표시. 원인·해결 방법 메시지를 함께 노출해야 한다.
  /// - `isReadOnly`: 편집만 차단하고 텍스트 선택·복사는 유지한다.
  /// - `allowClear`: 편집 중 값이 있을 때 값을 한 번에 지우는 clear 버튼을 표시한다.
  /// - 슬롯에는 아이콘 또는 `SUBezierTextInputAffix`를 넣는다.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    variant: BezierTextInputVariant = .primary,
    size: BezierTextInputSize = .medium,
    hasError: Bool = false,
    isReadOnly: Bool = false,
    allowClear: Bool = false,
    @ViewBuilder leadingContent: () -> Leading,
    @ViewBuilder trailingContent: () -> Trailing
  ) {
    self._text = text
    self.placeholder = placeholder
    self.variant = variant
    self.size = size
    self.hasError = hasError
    self.isReadOnly = isReadOnly
    self.allowClear = allowClear
    self.leading = leadingContent()
    self.trailing = trailingContent()
  }

  public var body: some View {
    HStack(spacing: BezierBaseInputConstant.contentSpacing) {
      self.leadingView
      self.fieldView
      self.trailingView
      self.clearButtonView
    }
    .padding(.horizontal, BezierBaseInputConstant.horizontalPadding)
    .frame(height: self.metric.height)
    .frame(minWidth: BezierBaseInputConstant.minWidth, maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: self.metric.cornerRadius)
        .fill(self.palette(BezierBaseInputAppearance.backgroundColor(variant: self.variant.base, state: self.state)))
    )
    .overlay { self.borderOverlay }
    .opacity(self.state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1)
    .contentShape(Rectangle())
    .onTapGesture {
      guard !self.isReadOnly else { return }
      self.isFocused = true
    }
  }

  // MARK: - State

  private var metric: BezierBaseInputMetric { self.size.metric }

  private var state: BezierBaseInputState {
    .resolve(
      isEnabled: self.isEnabled,
      isReadOnly: self.isReadOnly,
      hasError: self.hasError,
      isFocused: self.isFocused
    )
  }

  // MARK: - Subviews

  @ViewBuilder
  private var leadingView: some View {
    if Leading.self != EmptyView.self {
      self.leading
        .frame(height: self.metric.leadingContentLength)
    }
  }

  @ViewBuilder
  private var fieldView: some View {
    if self.isReadOnly {
      Text(self.text.isEmpty ? self.placeholder : self.text)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: self.text.isEmpty
            ? BezierBaseInputConstant.placeholderColor
            : BezierBaseInputConstant.readOnlyTextColor
        )
        .lineLimit(1)
        .truncationMode(.tail)
        .textSelection(.enabled)
        .frame(maxWidth: .infinity, alignment: .leading)
    } else {
      TextField("", text: self.$text, prompt: self.promptText)
        .focused(self.$isFocused)
        .textFieldStyle(.plain)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: BezierBaseInputConstant.textColor
        )
        .frame(maxWidth: .infinity)
    }
  }

  private var promptText: Text {
    Text(self.placeholder)
      .font(BezierBaseInputConstant.textTypography.font)
      .kerning(BezierBaseInputConstant.textTypography.letterSpacing)
      .foregroundColor(self.palette(BezierBaseInputConstant.placeholderColor))
  }

  @ViewBuilder
  private var trailingView: some View {
    if Trailing.self != EmptyView.self {
      self.trailing
        .frame(height: BezierBaseInputConstant.trailingContentLength)
    }
  }

  @ViewBuilder
  private var clearButtonView: some View {
    if self.allowClear, self.isFocused, !self.text.isEmpty, !self.isReadOnly {
      Button {
        self.text = ""
      } label: {
        BezierIcon.cancelCircleFilled.image
          .foregroundColor(self.palette(BezierBaseInputConstant.iconColor))
          .frame(
            width: BezierBaseInputConstant.systemElementLength,
            height: BezierBaseInputConstant.systemElementLength
          )
      }
      .buttonStyle(.plain)
    }
  }

  @ViewBuilder
  private var borderOverlay: some View {
    if let borderColor = BezierBaseInputAppearance.borderColor(variant: self.variant.base, state: self.state) {
      RoundedRectangle(cornerRadius: self.metric.cornerRadius)
        .strokeBorder(self.palette(borderColor), lineWidth: BezierBaseInputConstant.borderWidth)
    }
  }
}

// MARK: - Convenience init (슬롯 생략)

extension SUBezierTextInput where Leading == EmptyView, Trailing == EmptyView {
  /// 슬롯 없이 생성하는 편의 이니셜라이저.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    variant: BezierTextInputVariant = .primary,
    size: BezierTextInputSize = .medium,
    hasError: Bool = false,
    isReadOnly: Bool = false,
    allowClear: Bool = false
  ) {
    self.init(
      text: text,
      placeholder: placeholder,
      variant: variant,
      size: size,
      hasError: hasError,
      isReadOnly: isReadOnly,
      allowClear: allowClear,
      leadingContent: { EmptyView() },
      trailingContent: { EmptyView() }
    )
  }
}

extension SUBezierTextInput where Trailing == EmptyView {
  /// leading 슬롯만 지정하는 편의 이니셜라이저.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    variant: BezierTextInputVariant = .primary,
    size: BezierTextInputSize = .medium,
    hasError: Bool = false,
    isReadOnly: Bool = false,
    allowClear: Bool = false,
    @ViewBuilder leadingContent: () -> Leading
  ) {
    self.init(
      text: text,
      placeholder: placeholder,
      variant: variant,
      size: size,
      hasError: hasError,
      isReadOnly: isReadOnly,
      allowClear: allowClear,
      leadingContent: leadingContent,
      trailingContent: { EmptyView() }
    )
  }
}

extension SUBezierTextInput where Leading == EmptyView {
  /// trailing 슬롯만 지정하는 편의 이니셜라이저.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    variant: BezierTextInputVariant = .primary,
    size: BezierTextInputSize = .medium,
    hasError: Bool = false,
    isReadOnly: Bool = false,
    allowClear: Bool = false,
    @ViewBuilder trailingContent: () -> Trailing
  ) {
    self.init(
      text: text,
      placeholder: placeholder,
      variant: variant,
      size: size,
      hasError: hasError,
      isReadOnly: isReadOnly,
      allowClear: allowClear,
      leadingContent: { EmptyView() },
      trailingContent: trailingContent
    )
  }
}

struct SUBezierTextInput_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      SUBezierTextInput(text: .constant(""), placeholder: "예: hong@company.com")
      SUBezierTextInput(text: .constant("hong@company.com"), size: .small)
      SUBezierTextInput(text: .constant("wrong value"), hasError: true)
      SUBezierTextInput(text: .constant("read only value"), isReadOnly: true)
      SUBezierTextInput(text: .constant("disabled value"))
        .disabled(true)
      SUBezierTextInput(text: .constant(""), placeholder: "url", variant: .secondary, leadingContent: {
        SUBezierTextInputAffix(text: "https://")
      })
      SUBezierTextInput(text: .constant("50"), trailingContent: {
        SUBezierTextInputAffix(text: "%")
      })
    }
    .padding()
  }
}
