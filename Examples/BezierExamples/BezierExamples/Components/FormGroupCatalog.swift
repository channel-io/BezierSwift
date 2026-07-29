import SwiftUI
import UIKit
import BezierSwift

struct FormGroupCatalog: View {
  @State private var isEnabled = true
  @State private var hasError = false
  @State private var spacing = BezierFormGroupConstant.contentSpacing
  @State private var firstChecked = false
  @State private var secondChecked = true

  var body: some View {
    CatalogScreen(title: "FormGroup") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("isEnabled", isOn: self.$isEnabled)
      Toggle("hasError", isOn: self.$hasError)
      Picker("spacing", selection: self.$spacing) {
        Text("spacing 4 (기본)").tag(CGFloat(4))
        Text("spacing 12").tag(CGFloat(12))
      }
      .pickerStyle(.segmented)
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
    SUBezierFormGroup(spacing: self.spacing) {
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
    FormGroupUIKitRepresentable(spacing: self.spacing, hasError: self.hasError)
      .disabled(!self.isEnabled)
  }
}

private struct FormGroupUIKitRepresentable: UIViewRepresentable {
  let spacing: CGFloat
  let hasError: Bool

  func makeUIView(context: Context) -> BezierFormGroup {
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

    return BezierFormGroup(items: [header, first, second])
  }

  func updateUIView(_ formGroup: BezierFormGroup, context: Context) {
    formGroup.spacing = self.spacing
    for case let checkbox as BezierCheckbox in formGroup.items {
      checkbox.hasError = self.hasError
      // root가 UIControl이 아니라 SwiftUI의 isEnabled 자동 동기화가 nested control까지 닿지 않음
      // → environment 값을 직접 주입 (.disabled() modifier와 일관)
      checkbox.isEnabled = context.environment.isEnabled
    }
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierFormGroup, context: Context) -> CGSize? {
    let width = proposal.width ?? 320
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: width, height: fitting.height)
  }
}
