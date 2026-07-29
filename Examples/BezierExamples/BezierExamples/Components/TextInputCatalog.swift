import SwiftUI
import UIKit
import BezierSwift

struct TextInputCatalog: View {
  enum SlotKind: String, CaseIterable, Identifiable {
    case none, icon, affix
    var id: String { self.rawValue }
  }

  @State private var variant: BezierTextInputVariant = .primary
  @State private var size: BezierTextInputSize = .medium
  @State private var hasError = false
  @State private var isReadOnly = false
  @State private var isEnabled = true
  @State private var allowClear = true
  @State private var leadingKind: SlotKind = .icon
  @State private var trailingKind: SlotKind = .none
  @State private var swiftUIText = ""
  @State private var uiKitText = ""

  var body: some View {
    CatalogScreen(title: "TextInput") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("variant", selection: self.$variant) {
        ForEach(BezierTextInputVariant.allCases, id: \.self) { variant in
          Text(self.variantLabel(variant)).tag(variant)
        }
      }
      .pickerStyle(.segmented)

      Picker("size", selection: self.$size) {
        ForEach(BezierTextInputSize.allCases, id: \.self) { size in
          Text(self.sizeLabel(size)).tag(size)
        }
      }
      .pickerStyle(.segmented)

      Toggle("hasError", isOn: self.$hasError)
      Toggle("isReadOnly", isOn: self.$isReadOnly)
      Toggle("isEnabled", isOn: self.$isEnabled)
      Toggle("allowClear", isOn: self.$allowClear)

      Picker("leading", selection: self.$leadingKind) {
        ForEach(SlotKind.allCases) { kind in
          Text("leading: \(kind.rawValue)").tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Picker("trailing", selection: self.$trailingKind) {
        ForEach(SlotKind.allCases) { kind in
          Text("trailing: \(kind.rawValue)").tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Button("키보드 내리기") {
        UIApplication.shared.sendAction(
          #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
        )
      }
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      SUBezierTextInput(
        text: self.$swiftUIText,
        placeholder: "예: hong@company.com",
        variant: self.variant,
        size: self.size,
        hasError: self.hasError,
        isReadOnly: self.isReadOnly,
        allowClear: self.allowClear,
        leadingContent: { self.leadingSlot },
        trailingContent: { self.trailingSlot }
      )
      .disabled(!self.isEnabled)

      Text("value: \(self.swiftUIText)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }

  @ViewBuilder
  private var leadingSlot: some View {
    switch self.leadingKind {
    case .none:
      EmptyView()
    case .icon:
      BezierIcon.email.image
        .scaledToFit()
        .foregroundColor(.secondary)
    case .affix:
      SUBezierTextInputAffix(text: "https://")
    }
  }

  @ViewBuilder
  private var trailingSlot: some View {
    switch self.trailingKind {
    case .none:
      EmptyView()
    case .icon:
      BezierIcon.lock.image
        .scaledToFit()
        .foregroundColor(.secondary)
    case .affix:
      SUBezierTextInputAffix(text: "%")
    }
  }

  private var uiKitPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      TextInputUIKitRepresentable(
        text: self.$uiKitText,
        variant: self.variant,
        size: self.size,
        hasError: self.hasError,
        isReadOnly: self.isReadOnly,
        isEnabled: self.isEnabled,
        allowClear: self.allowClear,
        leadingKind: self.leadingKind,
        trailingKind: self.trailingKind
      )

      Text("value: \(self.uiKitText)")
        .font(.caption2)
        .foregroundColor(.secondary)
    }
  }

  private func variantLabel(_ variant: BezierTextInputVariant) -> String {
    switch variant {
    case .primary: return "primary"
    case .secondary: return "secondary"
    }
  }

  private func sizeLabel(_ size: BezierTextInputSize) -> String {
    switch size {
    case .small: return "small"
    case .medium: return "medium"
    }
  }
}

private struct TextInputUIKitRepresentable: UIViewRepresentable {
  @Binding var text: String
  let variant: BezierTextInputVariant
  let size: BezierTextInputSize
  let hasError: Bool
  let isReadOnly: Bool
  let isEnabled: Bool
  let allowClear: Bool
  let leadingKind: TextInputCatalog.SlotKind
  let trailingKind: TextInputCatalog.SlotKind

  final class Coordinator {
    var leadingKind: TextInputCatalog.SlotKind?
    var trailingKind: TextInputCatalog.SlotKind?
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  // BezierTextInput을 representable 루트로 직접 반환하면 SwiftUI가 프레임을 직접 지정하는 과정에서
  // 내부 스택의 trailing 제약이 재해석되지 않아 콘텐츠가 hug 폭으로 붙는다. wrapper에 pin해 우회한다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let input = BezierTextInput(placeholder: "예: hong@company.com")
    input.onTextChanged = { self.text = $0 }
    wrapper.addSubview(input)
    NSLayoutConstraint.activate([
      input.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      input.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      input.topAnchor.constraint(equalTo: wrapper.topAnchor),
      input.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let input = wrapper.subviews.compactMap({ $0 as? BezierTextInput }).first else { return }
    input.variant = self.variant
    input.size = self.size
    input.hasError = self.hasError
    input.isReadOnly = self.isReadOnly
    input.isEnabled = self.isEnabled
    input.allowClear = self.allowClear
    if input.text != self.text {
      input.text = self.text
    }

    if context.coordinator.leadingKind != self.leadingKind {
      context.coordinator.leadingKind = self.leadingKind
      input.leadingContent = Self.makeSlotView(kind: self.leadingKind, icon: .email, affixText: "https://")
    }
    if context.coordinator.trailingKind != self.trailingKind {
      context.coordinator.trailingKind = self.trailingKind
      input.trailingContent = Self.makeSlotView(kind: self.trailingKind, icon: .lock, affixText: "%")
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

  private static func makeSlotView(
    kind: TextInputCatalog.SlotKind,
    icon: BezierIcon,
    affixText: String
  ) -> UIView? {
    switch kind {
    case .none:
      return nil
    case .icon:
      let imageView = UIImageView(image: icon.uiImage)
      imageView.contentMode = .scaleAspectFit
      imageView.tintColor = .secondaryLabel
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
      return imageView
    case .affix:
      return BezierTextInputAffix(text: affixText)
    }
  }
}
