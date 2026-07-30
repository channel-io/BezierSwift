import SwiftUI
import UIKit
import BezierSwift

struct FormCatalog: View {
  @State private var showLabel = true
  @State private var showDescription = true
  @State private var isRequired = true
  @State private var hasError = false
  @State private var hasCustomContent = false
  @State private var isEnabled = true
  @State private var swiftUIIntro = ""
  @State private var swiftUIEmail = ""
  @State private var swiftUIChecked: BezierCheckboxChecked = .unchecked
  @State private var uiKitIntro = ""
  @State private var uiKitEmail = ""

  private let introDescription = "프로필에 표시할 소개를 입력해요"
  private let introError = "소개글을 입력해주세요"
  private let inlineDescription = "다른 언어로 자동 번역해요"

  var body: some View {
    CatalogScreen(title: "Form") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("showLabel (1번 · inline 필드)", isOn: self.$showLabel)
      Toggle("showDescription", isOn: self.$showDescription)
      Toggle("isRequired", isOn: self.$isRequired)
      Toggle("hasError", isOn: self.$hasError)
      Toggle("hasCustomContent (inline 필드)", isOn: self.$hasCustomContent)
      Toggle("isEnabled", isOn: self.$isEnabled)

      Button("키보드 내리기") {
        UIApplication.shared.sendAction(
          #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
        )
      }
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    SUBezierForm {
      SUBezierFormField(
        labelText: self.showLabel ? "소개글" : nil,
        description: self.showDescription ? self.introDescription : nil,
        isRequired: self.isRequired,
        errorText: self.hasError ? self.introError : nil
      ) {
        SUBezierTextInput(
          text: self.$swiftUIIntro,
          placeholder: "Placeholder",
          hasError: self.hasError
        )
      }

      SUBezierFormField(labelText: "이메일") {
        SUBezierTextInput(
          text: self.$swiftUIEmail,
          placeholder: "예: hong@company.com"
        )
      }

      self.swiftUIInlineField
    }
    .disabled(!self.isEnabled)
  }

  // customContent 슬롯 유무는 제네릭 타입(EmptyView 여부)으로 판정되므로, 조건부 뷰를
  // 슬롯 안에 넣으면 Optional<View>가 되어 빈 상태에서도 슬롯이 살아있는 것으로 잡힌다.
  // 이니셜라이저 자체를 분기해 CustomContent == EmptyView를 성립시킨다.
  @ViewBuilder
  private var swiftUIInlineField: some View {
    if self.hasCustomContent {
      SUBezierFormField(
        labelPosition: .left,
        labelText: self.showLabel ? "번역" : nil,
        description: self.showDescription ? self.inlineDescription : nil,
        control: { self.swiftUIInlineControl },
        customContent: {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.red.opacity(0.08))
            .frame(height: 100)
            .overlay(
              Text("customContent")
                .font(.caption2)
                .foregroundColor(.secondary)
            )
        }
      )
    } else {
      SUBezierFormField(
        labelPosition: .left,
        labelText: self.showLabel ? "번역" : nil,
        description: self.showDescription ? self.inlineDescription : nil,
        control: { self.swiftUIInlineControl }
      )
    }
  }

  private var swiftUIInlineControl: some View {
    SUBezierCheckbox(label: "사용", checked: self.swiftUIChecked) { checked in
      self.swiftUIChecked = checked
    }
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    FormUIKitRepresentable(
      introText: self.$uiKitIntro,
      emailText: self.$uiKitEmail,
      showLabel: self.showLabel,
      showDescription: self.showDescription,
      isRequired: self.isRequired,
      hasError: self.hasError,
      hasCustomContent: self.hasCustomContent,
      isEnabled: self.isEnabled,
      introDescription: self.introDescription,
      introError: self.introError,
      inlineDescription: self.inlineDescription
    )
    .disabled(!self.isEnabled)
  }
}

private struct FormUIKitRepresentable: UIViewRepresentable {
  @Binding var introText: String
  @Binding var emailText: String
  let showLabel: Bool
  let showDescription: Bool
  let isRequired: Bool
  let hasError: Bool
  let hasCustomContent: Bool
  let isEnabled: Bool
  let introDescription: String
  let introError: String
  let inlineDescription: String

  final class Coordinator {
    var introField: BezierFormField?
    var inlineField: BezierFormField?
    var introInput: BezierTextInput?
    var emailInput: BezierTextInput?
    var checkbox: BezierCheckbox?
    var customContentView: UIView?
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  // BezierForm은 intrinsic width가 없어 UIKitWrap(fittingSizeLevel)에서는 폭이 hug로 접힌다.
  // wrapper에 pin하고 sizeThatFits에서 proposal.width를 그대로 반환해 전체 폭을 확보한다.
  func makeUIView(context: Context) -> UIView {
    let introInput = BezierTextInput(placeholder: "Placeholder")
    introInput.onTextChanged = { self.introText = $0 }
    let introField = BezierFormField(control: introInput)

    let emailInput = BezierTextInput(placeholder: "예: hong@company.com")
    emailInput.onTextChanged = { self.emailText = $0 }
    let emailField = BezierFormField(labelText: "이메일", control: emailInput)

    let checkbox = BezierCheckbox(label: "사용")
    checkbox.onCheckedChange = { [weak checkbox] checked in
      checkbox?.checked = checked
    }
    let customContentView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor.systemRed.withAlphaComponent(0.08)
      view.layer.cornerRadius = 8
      view.heightAnchor.constraint(equalToConstant: 100).isActive = true
      return view
    }()
    let inlineField = BezierFormField(
      labelPosition: .left,
      labelText: self.showLabel ? "번역" : nil,
      control: checkbox
    )

    let form = BezierForm(fields: [introField, emailField, inlineField])

    context.coordinator.introField = introField
    context.coordinator.inlineField = inlineField
    context.coordinator.introInput = introInput
    context.coordinator.emailInput = emailInput
    context.coordinator.checkbox = checkbox
    context.coordinator.customContentView = customContentView

    let wrapper = UIView()
    wrapper.addSubview(form)
    NSLayoutConstraint.activate([
      form.topAnchor.constraint(equalTo: wrapper.topAnchor),
      form.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      form.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      form.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    let coordinator = context.coordinator
    guard
      let introField = coordinator.introField,
      let inlineField = coordinator.inlineField,
      let introInput = coordinator.introInput,
      let emailInput = coordinator.emailInput,
      let checkbox = coordinator.checkbox
    else { return }

    introField.labelText = self.showLabel ? "소개글" : nil
    introField.fieldDescription = self.showDescription ? self.introDescription : nil
    introField.isRequired = self.isRequired
    introField.errorText = self.hasError ? self.introError : nil
    introInput.hasError = self.hasError
    introInput.isEnabled = self.isEnabled
    if introInput.text != self.introText { introInput.text = self.introText }

    emailInput.isEnabled = self.isEnabled
    if emailInput.text != self.emailText { emailInput.text = self.emailText }

    inlineField.labelText = self.showLabel ? "번역" : nil
    inlineField.fieldDescription = self.showDescription ? self.inlineDescription : nil
    inlineField.customContent = self.hasCustomContent ? coordinator.customContentView : nil
    checkbox.isEnabled = self.isEnabled
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
