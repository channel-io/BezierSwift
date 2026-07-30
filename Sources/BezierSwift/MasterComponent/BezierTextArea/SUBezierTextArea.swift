//
//  SUBezierTextArea.swift
//  BezierSwift
//

import SwiftUI
import UIKit

/// 여러 줄 텍스트 입력 영역 (SwiftUI). 설명·메모·답변 템플릿처럼 여러 줄이거나 길이를 예측할 수 없는 텍스트를 입력받을 때 쓴다. 한 줄로 충분한 입력(이름·이메일 등)에는 `SUBezierTextInput`을 사용한다. UIKit에서는 `BezierTextArea`를 사용한다.
///
/// 너비는 컨테이너가 결정한다 — 기본으로 부모 폭을 채운다.
/// 높이는 기본 64pt(2행)에서 내용에 따라 최대 160pt(6행)까지 자동 확장되고, 초과분은 내부 스크롤로 표시된다.
/// Return은 줄 바꿈이다 — 제출 동작이 없으므로 `onSubmit`은 호출되지 않는다.
public struct SUBezierTextArea: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.isEnabled) private var isEnabled
  @State private var isFocused = false

  @Binding private var text: String
  private let placeholder: String
  private let hasError: Bool
  private let isReadOnly: Bool
  private let keyboardType: UIKeyboardType

  /// 입력값 바인딩과 상태를 지정해 생성한다.
  ///
  /// - `hasError`: 에러 보더 표시. 원인·해결 방법 메시지를 함께 노출해야 한다.
  /// - `isReadOnly`: 편집만 차단하고 텍스트 선택·복사는 유지한다.
  /// - `keyboardType`: 올릴 키보드 종류. 내부 텍스트 뷰에 그대로 전달된다.
  public init(
    text: Binding<String>,
    placeholder: String = "",
    hasError: Bool = false,
    isReadOnly: Bool = false,
    keyboardType: UIKeyboardType = .default
  ) {
    self._text = text
    self.placeholder = placeholder
    self.hasError = hasError
    self.isReadOnly = isReadOnly
    self.keyboardType = keyboardType
  }

  public var body: some View {
    self.fieldView
      .frame(
        minHeight: BezierTextAreaConstant.minHeight,
        maxHeight: BezierTextAreaConstant.maxHeight,
        alignment: .topLeading
      )
      .frame(minWidth: BezierBaseInputConstant.minWidth, maxWidth: .infinity, alignment: .topLeading)
      .background(
        RoundedRectangle(cornerRadius: BezierTextAreaConstant.cornerRadius)
          .fill(self.palette(BezierBaseInputAppearance.backgroundColor(variant: .primary, state: self.state)))
      )
      .clipShape(RoundedRectangle(cornerRadius: BezierTextAreaConstant.cornerRadius))
      .overlay { self.borderOverlay }
      // opacity는 per-view 곱이라 배경·보더가 겹치는 링 영역이 이중 블렌딩됨 — 합성 후 1회 적용 (UIKit self.alpha와 동일 결과)
      .compositingGroup()
      .opacity(self.state == .disabled ? BezierBaseInputConstant.disabledOpacity : 1)
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
        .padding(.horizontal, BezierBaseInputConstant.horizontalPadding)
        .padding(.vertical, BezierTextAreaConstant.verticalPadding)
    } else {
      BezierTextAreaTextEntry(
        text: self.$text,
        textColor: UIColor(self.palette(BezierBaseInputConstant.textColor)),
        keyboardType: self.keyboardType,
        isEnabled: self.isEnabled,
        onFocusChanged: { self.isFocused = $0 }
      )
      // 텍스트 뷰가 패딩까지 포함해 라운드 박스 전체를 채우므로 placeholder도 같은 패딩으로 맞춘다
      // (UIKit placeholderLabel의 top/leading 제약과 동형)
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
        // 2행 블록은 lineSpacing이 실려 48pt인데 제안 높이는 그보다 짧을 수 있다 — 제안을 그대로
        // 받으면 2행을 못 채우고 1행에서 잘린다
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.horizontal, BezierBaseInputConstant.horizontalPadding)
        .padding(.vertical, BezierTextAreaConstant.verticalPadding)
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

// MARK: - Text Entry

// SwiftUI의 여러 줄 입력 프리미티브는 둘 다 이 컴포넌트의 SSOT를 만족시키지 못한다 —
// TextField(axis: .vertical)는 하드웨어 Return을 제출로 처리해 §8-7("Enter = 줄 바꿈")을 어기고
// 포커스까지 잃으며(iOS 16 최소 지원이라 onKeyPress로 가로챌 수도 없다), TextEditor는 내부
// textContainerInset·lineFragmentPadding을 노출하지 않아 §2의 10/8pt 패딩을 맞출 수 없고
// (contentMargins는 iOS 17+) 콘텐츠 높이로 hug하지도 않는다. UITextView를 직접 감싼다
private struct BezierTextAreaTextEntry: UIViewRepresentable {
  @Binding var text: String
  let textColor: UIColor
  let keyboardType: UIKeyboardType
  let isEnabled: Bool
  let onFocusChanged: (Bool) -> Void

  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }

  func makeUIView(context: Context) -> UITextView {
    // TextKit 2(iOS 16+ UITextView 기본값)는 paragraphStyle의 minimumLineHeight를 무시해 행 피치가
    // 폰트 고유값(약 22.7pt)으로 좁아진다 — 160pt 안에 6행이 아니라 7행이 걸치고 UIKit 구현과도 어긋난다
    let textView = UITextView(usingTextLayoutManager: false)
    textView.delegate = context.coordinator
    textView.backgroundColor = .clear
    textView.textContainerInset = UIEdgeInsets(
      top: BezierTextAreaConstant.verticalPadding,
      left: BezierBaseInputConstant.horizontalPadding,
      bottom: BezierTextAreaConstant.verticalPadding,
      right: BezierBaseInputConstant.horizontalPadding
    )
    textView.textContainer.lineFragmentPadding = 0
    textView.alwaysBounceVertical = false
    textView.showsVerticalScrollIndicator = false
    textView.typingAttributes = self.attributes
    return textView
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    context.coordinator.parent = self

    uiView.keyboardType = self.keyboardType
    uiView.isEditable = self.isEnabled
    uiView.isUserInteractionEnabled = self.isEnabled

    // isUserInteractionEnabled = false는 first responder를 해제하는 게 아니라 유예한다 — 명시적으로
    // resign하지 않으면 비활성 상태에서도 키보드가 남고 하드웨어 입력이 반영된다. 갱신 사이클 안에서
    // resign하면 델리게이트가 뷰 업데이트 도중 @State를 바꾸므로 다음 런루프로 미룬다
    if !self.isEnabled, uiView.isFirstResponder {
      DispatchQueue.main.async { uiView.resignFirstResponder() }
    }

    let attributes = self.attributes
    uiView.typingAttributes = attributes

    let isTextOutdated = uiView.text != self.text
    if isTextOutdated {
      uiView.text = self.text
    }

    // 입력 중에는 스토리지를 건드리지 않는다 — 삽입된 글자는 typingAttributes를 상속하므로 재지정이
    // 불필요한데, 전 구간 setAttributes는 TextKit 1에서 전체 레이아웃을 무효화해 캐럿이 한 프레임 동안
    // 미완성 레이아웃 위에 그려졌다가 제자리로 돌아간다.
    // 반대로 프로그래밍 방식 대입은 UITextView가 스토리지 속성을 자체 기본값으로 덮고, 색 변경(다크
    // 모드 전환)은 이미 굳은 속성을 갱신하지 못하므로 그때만 전 구간 재지정한다
    guard isTextOutdated || context.coordinator.appliedTextColor != self.textColor else { return }
    context.coordinator.appliedTextColor = self.textColor

    // 한글 등 IME 조합 중 textStorage 속성을 갈아끼우면 조합이 끊긴다 — 조합 중에는 typingAttributes만 갱신
    if uiView.markedTextRange == nil {
      let fullRange = NSRange(location: 0, length: uiView.textStorage.length)
      uiView.textStorage.beginEditing()
      uiView.textStorage.setAttributes(attributes, range: fullRange)
      uiView.textStorage.endEditing()
    }
  }

  func sizeThatFits(
    _ proposal: ProposedViewSize,
    uiView: UITextView,
    context: Context
  ) -> CGSize? {
    let proposedWidth = proposal.width ?? BezierBaseInputConstant.minWidth
    let width = proposedWidth.isFinite
      ? max(proposedWidth, BezierBaseInputConstant.minWidth)
      : BezierBaseInputConstant.minWidth
    let fittingHeight = uiView.sizeThatFits(
      CGSize(width: width, height: .greatestFiniteMagnitude)
    ).height

    return CGSize(
      width: width,
      height: min(
        max(fittingHeight, BezierTextAreaConstant.minHeight),
        BezierTextAreaConstant.maxHeight
      )
    )
  }

  private var attributes: [NSAttributedString.Key: Any] {
    var attributes = BezierBaseInputConstant.textTypography.sizeAttributes()
    attributes[.foregroundColor] = self.textColor
    return attributes
  }

  final class Coordinator: NSObject, UITextViewDelegate {
    var parent: BezierTextAreaTextEntry
    var appliedTextColor: UIColor?

    init(parent: BezierTextAreaTextEntry) {
      self.parent = parent
    }

    func textViewDidChange(_ textView: UITextView) {
      self.parent.text = textView.text
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
      self.parent.onFocusChanged(true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      self.parent.onFocusChanged(false)
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
