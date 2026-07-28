import SwiftUI
import UIKit
import BezierSwift

struct TextAreaCatalog: View {
  @State private var hasError = false
  @State private var isReadOnly = false
  @State private var isEnabled = true
  @State private var swiftUIText = ""
  @State private var uiKitText = ""
  @State private var useLongPlaceholder = false

  private static let longSampleText = (1...8)
    .map { "여러 줄 샘플 텍스트 \($0)행" }
    .joined(separator: "\n")

  private static let shortPlaceholder = "채널의 특징을 간략히 소개해보세요"
  private static let longPlaceholder =
    "채널의 특징을 간략히 소개해보세요. 여기에 적은 내용은 고객에게 그대로 노출되니 " +
    "너무 길지 않게 두세 문장으로 정리해 주세요."

  private var placeholder: String {
    self.useLongPlaceholder ? Self.longPlaceholder : Self.shortPlaceholder
  }

  var body: some View {
    CatalogScreen(title: "TextArea") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("hasError", isOn: self.$hasError)
      Toggle("isReadOnly", isOn: self.$isReadOnly)
      Toggle("isEnabled", isOn: self.$isEnabled)
      Toggle("긴 placeholder (2행 말줄임 확인)", isOn: self.$useLongPlaceholder)

      HStack(spacing: 12) {
        Button("긴 텍스트 채우기") {
          self.swiftUIText = Self.longSampleText
          self.uiKitText = Self.longSampleText
        }
        Button("비우기") {
          self.swiftUIText = ""
          self.uiKitText = ""
        }
        Button("키보드 내리기") {
          UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
          )
        }
      }
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      SUBezierTextArea(
        text: self.$swiftUIText,
        placeholder: self.placeholder,
        hasError: self.hasError,
        isReadOnly: self.isReadOnly
      )
      .disabled(!self.isEnabled)

      Text("글자 수: \(self.swiftUIText.count)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }

  private var uiKitPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      TextAreaUIKitRepresentable(
        text: self.$uiKitText,
        placeholder: self.placeholder,
        hasError: self.hasError,
        isReadOnly: self.isReadOnly,
        isEnabled: self.isEnabled
      )

      Text("글자 수: \(self.uiKitText.count)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }
}

private struct TextAreaUIKitRepresentable: UIViewRepresentable {
  @Binding var text: String
  let placeholder: String
  let hasError: Bool
  let isReadOnly: Bool
  let isEnabled: Bool

  // BezierTextArea를 representable 루트로 직접 반환하면 SwiftUI가 프레임을 직접 지정하는 과정에서
  // 내부 제약이 재해석되지 않아 콘텐츠가 hug 폭으로 붙는다. wrapper에 pin해 우회한다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let textArea = BezierTextArea(placeholder: self.placeholder)
    textArea.onTextChanged = { self.text = $0 }
    wrapper.addSubview(textArea)
    NSLayoutConstraint.activate([
      textArea.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      textArea.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      textArea.topAnchor.constraint(equalTo: wrapper.topAnchor),
      textArea.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let textArea = wrapper.subviews.compactMap({ $0 as? BezierTextArea }).first else { return }
    textArea.placeholder = self.placeholder
    textArea.hasError = self.hasError
    textArea.isReadOnly = self.isReadOnly
    textArea.isEnabled = self.isEnabled
    if textArea.text != self.text {
      textArea.text = self.text
    }
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    let width = proposal.width ?? 320
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: width, height: fitting.height)
  }
}
