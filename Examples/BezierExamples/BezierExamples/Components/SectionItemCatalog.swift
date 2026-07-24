import SwiftUI
import UIKit
import BezierSwift

struct SectionItemCatalog: View {
  private enum LeadingKind: String, CaseIterable {
    case none
    case icon
    case avatar
    case custom
  }

  private enum AccessoryKind: String, CaseIterable {
    case none
    case navigation
    case outlink
    case select
    case multiselect
    case display
    case toggle
    case custom
  }

  @State private var size: BezierSectionItemSize = .medium
  @State private var leadingKind: LeadingKind = .icon
  @State private var accessoryKind: AccessoryKind = .navigation
  @State private var hasDescription = false
  @State private var isDestructive = false
  @State private var isEnabled = true
  @State private var isToggleOn = true

  var body: some View {
    CatalogScreen(title: "SectionItem") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("size", selection: self.$size) {
        ForEach(BezierSectionItemSize.allCases, id: \.self) { size in
          Text(self.sizeLabel(size)).tag(size)
        }
      }
      .pickerStyle(.segmented)

      Picker("leading", selection: self.$leadingKind) {
        ForEach(LeadingKind.allCases, id: \.self) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      HStack {
        Text("accessory")
        Spacer()
        Picker("accessory", selection: self.$accessoryKind) {
          ForEach(AccessoryKind.allCases, id: \.self) { kind in
            Text(kind.rawValue).tag(kind)
          }
        }
        .pickerStyle(.menu)
      }

      Toggle("hasDescription", isOn: self.$hasDescription)
      Toggle("isDestructive", isOn: self.$isDestructive)
      Toggle("isEnabled", isOn: self.$isEnabled)
      if self.accessoryKind == .toggle {
        Toggle("toggle isOn", isOn: self.$isToggleOn)
      }
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 16) {
      SUBezierSectionItem(
        size: self.size,
        content: "단일 아이템",
        description: self.hasDescription ? "보조 설명 텍스트입니다. 기본은 줄바꿈으로 이어집니다." : nil,
        leading: self.swiftUILeading,
        accessory: self.swiftUIAccessory,
        isDestructive: self.isDestructive,
        onTap: {}
      )
      .disabled(!self.isEnabled)

      SUBezierSectionItem(
        size: self.size,
        content: "centerSlot 데모",
        onTap: {},
        centerSlot: {
          Circle().fill(Color.red).frame(width: 6, height: 6)
        }
      )

      SUBezierSectionItem(
        size: self.size,
        content: "",
        leading: .custom(AnyView(RoundedRectangle(cornerRadius: 4).fill(Color.orange.opacity(0.6)))),
        customCenterContent: AnyView(
          HStack(spacing: 4) {
            Text("커스텀 센터")
            Text("BETA").font(.caption2).foregroundStyle(.secondary)
          }
        ),
        onTap: {}
      )

      Text("SUBezierSection(card) 조합")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SUBezierSection(
        ["태그 관리", "고객 노트", "첨부파일"],
        id: \.self,
        variant: .card,
        labelText: "고객 정보"
      ) { title in
        SUBezierSectionItem(
          size: self.size,
          content: title,
          description: self.hasDescription ? "보조 설명" : nil,
          leading: self.swiftUILeading,
          accessory: self.swiftUIAccessory,
          isDestructive: self.isDestructive,
          onTap: {}
        )
      }
    }
  }

  private var swiftUILeading: BezierSectionItemLeading<AnyView> {
    switch self.leadingKind {
    case .none:
      return .none
    case .icon:
      return .icon(.personCircle)
    case .avatar:
      return .avatar(AnyView(Circle().fill(Color.gray.opacity(0.4))))
    case .custom:
      return .custom(AnyView(RoundedRectangle(cornerRadius: 4).fill(Color.orange.opacity(0.6))))
    }
  }

  private var swiftUIAccessory: BezierSectionItemAccessory<AnyView>? {
    switch self.accessoryKind {
    case .none: return nil
    case .navigation: return .navigation
    case .outlink: return .outlink
    case .select: return .select(value: "한국어")
    case .multiselect: return .multiselect(values: ["운영", "개발"])
    case .display: return .display(value: "값")
    case .toggle: return .toggle(isOn: self.isToggleOn)
    case .custom:
      return .custom(
        AnyView(
          Text("커스텀")
            .font(.caption)
            .foregroundStyle(.secondary)
        )
      )
    }
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    SectionItemUIKitRepresentable(
      size: self.size,
      leadingKind: self.leadingKind.rawValue,
      accessoryKind: self.accessoryKind.rawValue,
      hasDescription: self.hasDescription,
      isDestructive: self.isDestructive,
      isEnabled: self.isEnabled,
      isToggleOn: self.isToggleOn
    )
  }

  private func sizeLabel(_ size: BezierSectionItemSize) -> String {
    switch size {
    case .small: return "small"
    case .medium: return "medium"
    case .large: return "large"
    }
  }
}

private struct SectionItemUIKitRepresentable: UIViewRepresentable {
  let size: BezierSectionItemSize
  let leadingKind: String
  let accessoryKind: String
  let hasDescription: Bool
  let isDestructive: Bool
  let isEnabled: Bool
  let isToggleOn: Bool

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: wrapper.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])

    ["단일 아이템", "두 번째 아이템"].forEach { title in
      stackView.addArrangedSubview(BezierSectionItem(content: title, onTap: {}))
    }
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let stackView = wrapper.subviews.first as? UIStackView else { return }
    for case let item as BezierSectionItem in stackView.arrangedSubviews {
      item.size = self.size
      item.itemDescription = self.hasDescription ? "보조 설명 텍스트입니다." : nil
      item.leading = self.uiKitLeading
      item.accessory = self.uiKitAccessory
      item.isDestructive = self.isDestructive
      item.isEnabled = self.isEnabled
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

  private var uiKitLeading: BezierSectionItemLeading<UIView> {
    switch self.leadingKind {
    case "icon":
      return .icon(.personCircle)
    case "avatar":
      let view = UIView()
      view.backgroundColor = .systemGray3
      view.layer.cornerRadius = 10
      return .avatar(view)
    case "custom":
      let view = UIView()
      view.backgroundColor = .systemOrange.withAlphaComponent(0.6)
      view.layer.cornerRadius = 4
      return .custom(view)
    default:
      return .none
    }
  }

  private var uiKitAccessory: BezierSectionItemAccessory<UIView>? {
    switch self.accessoryKind {
    case "navigation": return .navigation
    case "outlink": return .outlink
    case "select": return .select(value: "한국어")
    case "multiselect": return .multiselect(values: ["운영", "개발"])
    case "display": return .display(value: "값")
    case "toggle": return .toggle(isOn: self.isToggleOn)
    case "custom":
      let label = UILabel()
      label.text = "커스텀"
      label.font = .preferredFont(forTextStyle: .caption1)
      label.textColor = .secondaryLabel
      return .custom(label)
    default:
      return nil
    }
  }
}
