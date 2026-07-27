import SwiftUI
import UIKit
import BezierSwift

struct CheckboxCatalog: View {
  @State private var hasError = false
  @State private var isEnabled = true
  @State private var firstChecked = false
  @State private var secondChecked = true

  var body: some View {
    CatalogScreen(title: "Checkbox") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("hasError", isOn: self.$hasError)
      Toggle("isEnabled", isOn: self.$isEnabled)
    }
    .font(.caption)
  }

  private var headerChecked: BezierCheckboxChecked {
    switch (self.firstChecked, self.secondChecked) {
    case (true, true): return .checked
    case (false, false): return .unchecked
    default: return .indeterminate
    }
  }

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 0) {
      SUBezierCheckbox(
        label: "전체 선택",
        checked: self.headerChecked,
        hasError: self.hasError,
        onCheckedChange: { newValue in
          let isChecked = newValue == .checked
          self.firstChecked = isChecked
          self.secondChecked = isChecked
        }
      )
      SUBezierCheckbox(
        label: "마케팅 정보 수신 동의",
        checked: self.firstChecked ? .checked : .unchecked,
        hasError: self.hasError,
        onCheckedChange: { self.firstChecked = $0 == .checked }
      )
      SUBezierCheckbox(
        label: "이용약관 동의",
        checked: self.secondChecked ? .checked : .unchecked,
        hasError: self.hasError,
        onCheckedChange: { self.secondChecked = $0 == .checked }
      )
    }
    .disabled(!self.isEnabled)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var uiKitPreview: some View {
    // UIViewRepresentable 안 UIControl.isEnabled는 SwiftUI가 environment로 강제 동기화하므로
    // updateUIView 수동 주입 대신 .disabled()로 제어한다.
    CheckboxUIKitRepresentable(hasError: self.hasError)
      .disabled(!self.isEnabled)
  }
}

private struct CheckboxUIKitRepresentable: UIViewRepresentable {
  let hasError: Bool

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: wrapper.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])

    let header = BezierCheckbox(label: "전체 선택", checked: .indeterminate)
    let first = BezierCheckbox(label: "마케팅 정보 수신 동의", checked: .unchecked)
    let second = BezierCheckbox(label: "이용약관 동의", checked: .checked)

    header.onCheckedChange = { [weak first, weak second] newValue in
      let childChecked: BezierCheckboxChecked = newValue == .checked ? .checked : .unchecked
      first?.checked = childChecked
      second?.checked = childChecked
    }
    let syncHeader: (BezierCheckboxChecked) -> Void = { [weak header, weak first, weak second] _ in
      guard let first, let second else { return }
      switch (first.checked, second.checked) {
      case (.checked, .checked): header?.checked = .checked
      case (.unchecked, .unchecked): header?.checked = .unchecked
      default: header?.checked = .indeterminate
      }
    }
    first.onCheckedChange = syncHeader
    second.onCheckedChange = syncHeader

    stackView.addArrangedSubview(header)
    stackView.addArrangedSubview(first)
    stackView.addArrangedSubview(second)
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let stackView = wrapper.subviews.first as? UIStackView else { return }
    for case let checkbox as BezierCheckbox in stackView.arrangedSubviews {
      checkbox.hasError = self.hasError
      // root가 UIControl이 아니라 SwiftUI의 isEnabled 자동 동기화가 nested control까지 닿지 않음
      // → environment 값을 직접 주입 (.disabled() modifier와 일관)
      checkbox.isEnabled = context.environment.isEnabled
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
