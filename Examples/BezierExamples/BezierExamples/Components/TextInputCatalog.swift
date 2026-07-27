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

  func makeUIView(context: Context) -> BezierTextInput {
    let input = BezierTextInput(placeholder: "예: hong@company.com")
    input.onTextChanged = { self.text = $0 }
    return input
  }

  func updateUIView(_ input: BezierTextInput, context: Context) {
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

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierTextInput, context: Context) -> CGSize? {
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
