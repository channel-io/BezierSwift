//
//  SUBezierSearch.swift
//  BezierSwift
//

import SwiftUI

/// SearchIcon이 고정된 단일 행 검색 입력 필드 (SwiftUI). 리스트 필터링·데이터 탐색처럼 키워드를 입력해 검색을 실행할 때 쓴다. 이름·이메일 등 일반 폼 입력에는 `SUBezierTextInput`을 사용한다. UIKit에서는 `BezierSearch`를 사용한다.
///
/// 너비는 컨테이너가 결정한다 — 기본으로 부모 폭을 채운다. 높이는 40pt로 고정된다 (Figma `Search`는 size 축 없음).
/// placeholder는 검색 범위를 명시한다 (예: `고객 이름, 이메일, 전화번호로 검색`) — `검색` 한 단어만 쓰지 않는다.
/// 검색 실행은 표준 `.onSubmit` modifier를 밖에서 적용하면 내부 텍스트 필드로 전파된다. 리턴 키는 검색(`.search`)으로 고정된다.
public struct SUBezierSearch: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled
  @FocusState private var isFocused: Bool

  @Binding private var text: String
  private let placeholder: String
  private let allowClear: Bool
  private let showsCancelButton: Bool
  private let cancelButtonTitle: String
  private let onCancel: (() -> Void)?

  /// 입력값 바인딩과 placeholder, clear·cancel 버튼 구성을 지정해 생성한다.
  ///
  /// - `allowClear`: 값이 있을 때 값을 한 번에 지우는 clear 버튼을 표시한다. 포커스와 무관하게 값이 있으면 표시된다.
  /// - `showsCancelButton`: 검색 필드 우측 바깥에 검색 모드를 종료하는 cancel 버튼을 표시한다 (Figma `cancelButton`).
  /// - `cancelButtonTitle`: cancel 버튼의 라벨 텍스트. 제품 언어에 맞춰 지정한다.
  /// - `onCancel`: cancel 버튼 탭 시 호출된다. 포커스는 자동으로 해제되며, 입력값 초기화 여부는 호출부가 결정한다.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    allowClear: Bool = false,
    showsCancelButton: Bool = false,
    cancelButtonTitle: String = "Cancel",
    onCancel: (() -> Void)? = nil
  ) {
    self._text = text
    self.placeholder = placeholder
    self.allowClear = allowClear
    self.showsCancelButton = showsCancelButton
    self.cancelButtonTitle = cancelButtonTitle
    self.onCancel = onCancel
  }

  public var body: some View {
    HStack(spacing: BezierSearchConstant.cancelButtonSpacing) {
      self.fieldView
      if self.showsCancelButton {
        self.cancelButtonView
      }
    }
    .frame(height: BezierSearchConstant.metric.height)
    .frame(minWidth: BezierBaseInputConstant.minWidth, maxWidth: .infinity)
    // opacity는 per-view 곱이라 배경·보더가 겹치는 링 영역이 이중 블렌딩됨 — 합성 후 1회 적용 (UIKit self.alpha와 동일 결과)
    .compositingGroup()
    .opacity(self.state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1)
  }

  // MARK: - State

  private var state: BezierBaseInputState {
    .resolve(
      isEnabled: self.isEnabled,
      isReadOnly: false,
      hasError: false,
      isFocused: self.isFocused
    )
  }

  // MARK: - Subviews

  private var fieldView: some View {
    HStack(spacing: BezierBaseInputConstant.contentSpacing) {
      BezierSearchConstant.searchIcon.image
        .foregroundColor(self.palette(BezierBaseInputConstant.iconColor))
        .frame(
          width: BezierSearchConstant.metric.leadingContentLength,
          height: BezierSearchConstant.metric.leadingContentLength
        )

      TextField("", text: self.$text, prompt: self.promptText)
        .focused(self.$isFocused)
        .textFieldStyle(.plain)
        .submitLabel(.search)
        .applyBezierFontStyle(
          BezierBaseInputConstant.textTypography,
          semanticColorToken: BezierBaseInputConstant.textColor
        )
        .frame(maxWidth: .infinity)

      self.clearButtonView
    }
    .padding(.horizontal, BezierBaseInputConstant.horizontalPadding)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      RoundedRectangle(cornerRadius: BezierSearchConstant.metric.cornerRadius)
        .fill(
          self.palette(
            BezierBaseInputAppearance.backgroundColor(
              variant: BezierSearchConstant.variant,
              state: self.state
            )
          )
        )
    )
    .overlay { self.borderOverlay }
    .contentShape(Rectangle())
    .onTapGesture {
      self.isFocused = true
    }
  }

  private var promptText: Text {
    Text(self.placeholder)
      .font(BezierBaseInputConstant.textTypography.font)
      .kerning(BezierBaseInputConstant.textTypography.letterSpacing)
      .foregroundColor(self.palette(BezierBaseInputConstant.placeholderColor))
  }

  @ViewBuilder
  private var clearButtonView: some View {
    if self.allowClear, !self.text.isEmpty, self.isEnabled {
      Button {
        self.text = ""
      } label: {
        BezierSearchConstant.clearIcon.image
          .foregroundColor(self.palette(BezierBaseInputConstant.iconColor))
          .frame(
            width: BezierBaseInputConstant.systemElementLength,
            height: BezierBaseInputConstant.systemElementLength
          )
      }
      .buttonStyle(.plain)
    }
  }

  private var cancelButtonView: some View {
    Button {
      self.isFocused = false
      self.onCancel?()
    } label: {
      Text(self.cancelButtonTitle)
        .applyBezierFontStyle(
          BezierSearchConstant.cancelButtonTypography,
          semanticColorToken: BezierSearchConstant.cancelButtonTextColor
        )
        .lineLimit(1)
        .fixedSize(horizontal: true, vertical: false)
        .padding(.horizontal, BezierSearchConstant.cancelButtonHorizontalPadding)
        .frame(maxHeight: .infinity)
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private var borderOverlay: some View {
    if let borderColor = BezierBaseInputAppearance.borderColor(
      variant: BezierSearchConstant.variant,
      state: self.state
    ) {
      RoundedRectangle(cornerRadius: BezierSearchConstant.metric.cornerRadius)
        .strokeBorder(self.palette(borderColor), lineWidth: BezierBaseInputConstant.borderWidth)
    }
  }
}

struct SUBezierSearch_Previews: PreviewProvider {
  struct Container: View {
    @State private var text = ""
    @State private var filledText = "John Doe"

    var body: some View {
      VStack(spacing: 12) {
        SUBezierSearch(text: self.$text, placeholder: "Search by name, email, phone")
        SUBezierSearch(text: self.$filledText, allowClear: true)
        SUBezierSearch(
          text: self.$filledText,
          allowClear: true,
          showsCancelButton: true,
          cancelButtonTitle: "Cancel"
        )
        SUBezierSearch(text: self.$filledText, allowClear: true)
          .disabled(true)
      }
      .padding()
    }
  }

  static var previews: some View {
    Container()
  }
}
