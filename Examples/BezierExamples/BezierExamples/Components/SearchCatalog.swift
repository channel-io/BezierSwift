import SwiftUI
import UIKit
import BezierSwift

struct SearchCatalog: View {
  @State private var isEnabled = true
  @State private var allowClear = true
  @State private var showsCancelButton = false
  @State private var swiftUIText = ""
  @State private var uiKitText = ""
  @State private var lastEvent = "-"

  var body: some View {
    CatalogScreen(title: "Search") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("isEnabled", isOn: self.$isEnabled)
      Toggle("allowClear", isOn: self.$allowClear)
      Toggle("showsCancelButton", isOn: self.$showsCancelButton)

      Button("키보드 내리기") {
        UIApplication.shared.sendAction(
          #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
        )
      }

      Text("last event: \(self.lastEvent)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      SUBezierSearch(
        text: self.$swiftUIText,
        placeholder: "Search by name, email, phone",
        allowClear: self.allowClear,
        showsCancelButton: self.showsCancelButton,
        cancelButtonTitle: "Cancel",
        onCancel: { self.lastEvent = "SwiftUI onCancel" }
      )
      .onSubmit { self.lastEvent = "SwiftUI onSubmit: \(self.swiftUIText)" }
      .disabled(!self.isEnabled)

      Text("value: \(self.swiftUIText)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }

  private var uiKitPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      SearchUIKitRepresentable(
        text: self.$uiKitText,
        isEnabled: self.isEnabled,
        allowClear: self.allowClear,
        showsCancelButton: self.showsCancelButton,
        onEvent: { self.lastEvent = $0 }
      )

      Text("value: \(self.uiKitText)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }
}

private struct SearchUIKitRepresentable: UIViewRepresentable {
  @Binding var text: String
  let isEnabled: Bool
  let allowClear: Bool
  let showsCancelButton: Bool
  let onEvent: (String) -> Void

  // BezierSearch를 representable 루트로 직접 반환하면 SwiftUI가 프레임을 직접 지정하는 과정에서
  // 내부 스택의 trailing 제약이 재해석되지 않아 콘텐츠가 hug 폭으로 붙는다. wrapper에 pin해 우회한다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let search = BezierSearch(placeholder: "Search by name, email, phone")
    search.onTextChanged = { self.text = $0 }
    search.onSubmit = { [weak search] in
      self.onEvent("UIKit onSubmit: \(search?.text ?? "")")
    }
    search.onCancel = { self.onEvent("UIKit onCancel") }
    wrapper.addSubview(search)
    NSLayoutConstraint.activate([
      search.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      search.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      search.topAnchor.constraint(equalTo: wrapper.topAnchor),
      search.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let search = wrapper.subviews.compactMap({ $0 as? BezierSearch }).first else { return }
    search.isEnabled = self.isEnabled
    search.allowClear = self.allowClear
    search.showsCancelButton = self.showsCancelButton
    if search.text != self.text {
      search.text = self.text
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
