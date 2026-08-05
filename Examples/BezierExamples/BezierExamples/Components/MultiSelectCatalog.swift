import SwiftUI
import UIKit
import BezierSwift

private enum MultiSelectLeadingKind: String, CaseIterable {
  case none
  case icon
  case avatar
  case custom
}

private enum MultiSelectOptionSpec {
  static let titles = ["긴급", "VIP 고객", "재문의"]
  static let icons: [BezierIcon] = [.tag, .star, .person]
  static let descriptions = ["즉시 응대가 필요한 문의", "결제 이력 상위 10%", "같은 주제로 다시 문의함"]
}

struct MultiSelectCatalog: View {
  @State private var container: BezierMultiSelectContainer = .page
  @State private var leadingKind: MultiSelectLeadingKind = .icon
  @State private var selectedIndices: Set<Int> = [0, 1]
  @State private var showsMultiSelectLabel = true
  @State private var showsGroup = true
  @State private var showsGroupLabel = true
  @State private var hasDescription = false
  @State private var hasCenterSlot = false
  @State private var isEnabled = true

  var body: some View {
    CatalogScreen(title: "MultiSelect") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("container", selection: self.$container) {
        ForEach(BezierMultiSelectContainer.allCases, id: \.self) { container in
          Text(String(describing: container)).tag(container)
        }
      }
      .pickerStyle(.segmented)

      Picker("leading", selection: self.$leadingKind) {
        ForEach(MultiSelectLeadingKind.allCases, id: \.self) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      // 복수 선택이라 단일 Picker로는 표현할 수 없어 항목별 토글을 나열한다.
      HStack(spacing: 8) {
        ForEach(MultiSelectOptionSpec.titles.indices, id: \.self) { index in
          Button(MultiSelectOptionSpec.titles[index]) { self.toggle(index) }
            .buttonStyle(.bordered)
            .tint(self.selectedIndices.contains(index) ? .accentColor : .gray)
        }
      }

      Toggle("multiSelect label", isOn: self.$showsMultiSelectLabel)
      Toggle("group", isOn: self.$showsGroup)
      Toggle("group label", isOn: self.$showsGroupLabel)
      Toggle("hasDescription", isOn: self.$hasDescription)
      Toggle("hasCenterSlot", isOn: self.$hasCenterSlot)
      Toggle("isEnabled", isOn: self.$isEnabled)
    }
    .font(.caption)
  }

  private func toggle(_ index: Int) {
    if self.selectedIndices.contains(index) {
      self.selectedIndices.remove(index)
    } else {
      self.selectedIndices.insert(index)
    }
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    SUBezierMultiSelect(
      container: self.container,
      labelText: self.showsMultiSelectLabel ? "태그" : nil
    ) {
      if self.showsGroup {
        SUBezierMultiSelectGroup(labelText: self.showsGroupLabel ? "최근 사용" : nil) {
          self.options
        }
      } else {
        self.options
      }
    }
    .disabled(!self.isEnabled)
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }

  @ViewBuilder
  private var options: some View {
    ForEach(MultiSelectOptionSpec.titles.indices, id: \.self) { index in
      SUBezierMultiSelectOption(
        title: MultiSelectOptionSpec.titles[index],
        description: self.hasDescription ? MultiSelectOptionSpec.descriptions[index] : nil,
        leading: self.swiftUILeading(icon: MultiSelectOptionSpec.icons[index]),
        isSelected: self.selectedIndices.contains(index),
        onToggle: { self.toggle(index) },
        centerSlot: {
          // 40pt 정사각을 넘겨 슬롯의 클리핑 높이(24pt)를 눈으로 잴 수 있게 한다.
          if self.hasCenterSlot {
            RoundedRectangle(cornerRadius: 4).fill(Color.orange).frame(width: 40, height: 40)
          }
        }
      )
    }
  }

  private func swiftUILeading(icon: BezierIcon) -> BezierMultiSelectOptionLeading<AnyView> {
    switch self.leadingKind {
    case .none:
      return .none
    case .icon:
      return .icon(icon)
    case .avatar:
      return .avatar(AnyView(SUBezierAvatar(image: Image("AvatarSample"), size: .size24)))
    case .custom:
      return .custom(AnyView(Circle().fill(Color.orange.opacity(0.4))))
    }
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    MultiSelectUIKitRepresentable(
      container: self.container,
      leadingKind: self.leadingKind,
      selectedIndices: self.$selectedIndices,
      showsMultiSelectLabel: self.showsMultiSelectLabel,
      showsGroup: self.showsGroup,
      showsGroupLabel: self.showsGroupLabel,
      hasDescription: self.hasDescription,
      hasCenterSlot: self.hasCenterSlot,
      isEnabled: self.isEnabled
    )
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }
}

private struct MultiSelectUIKitRepresentable: UIViewRepresentable {
  let container: BezierMultiSelectContainer
  let leadingKind: MultiSelectLeadingKind
  @Binding var selectedIndices: Set<Int>
  let showsMultiSelectLabel: Bool
  let showsGroup: Bool
  let showsGroupLabel: Bool
  let hasDescription: Bool
  let hasCenterSlot: Bool
  let isEnabled: Bool

  final class Coordinator {
    var fillConstraints: [NSLayoutConstraint] = []
    var centerConstraints: [NSLayoutConstraint] = []
  }

  func makeCoordinator() -> Coordinator { Coordinator() }

  // page는 폭을 채워야 하고 overlay는 240pt 고정이라, 두 제약 세트를 만들어 두고 update에서 갈아끼운다.
  // page에 center 제약을 쓰면 intrinsic width가 없어 콘텐츠 폭으로 접히고 라벨이 잘린다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let multiSelect = BezierMultiSelect()
    multiSelect.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(multiSelect)
    NSLayoutConstraint.activate([
      multiSelect.topAnchor.constraint(equalTo: wrapper.topAnchor),
      multiSelect.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    context.coordinator.fillConstraints = [
      multiSelect.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      multiSelect.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
    ]
    context.coordinator.centerConstraints = [
      multiSelect.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
      multiSelect.leadingAnchor.constraint(greaterThanOrEqualTo: wrapper.leadingAnchor),
      multiSelect.trailingAnchor.constraint(lessThanOrEqualTo: wrapper.trailingAnchor),
    ]
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let multiSelect = wrapper.subviews.compactMap({ $0 as? BezierMultiSelect }).first else { return }

    switch self.container {
    case .page:
      NSLayoutConstraint.deactivate(context.coordinator.centerConstraints)
      NSLayoutConstraint.activate(context.coordinator.fillConstraints)
    case .overlay:
      NSLayoutConstraint.deactivate(context.coordinator.fillConstraints)
      NSLayoutConstraint.activate(context.coordinator.centerConstraints)
    }

    multiSelect.container = self.container
    multiSelect.labelText = self.showsMultiSelectLabel ? "태그" : nil

    let options: [UIView] = MultiSelectOptionSpec.titles.indices.map { index in
      let option = BezierMultiSelectOption(
        title: MultiSelectOptionSpec.titles[index],
        description: self.hasDescription ? MultiSelectOptionSpec.descriptions[index] : nil,
        leading: self.uiKitLeading(icon: MultiSelectOptionSpec.icons[index]),
        isSelected: self.selectedIndices.contains(index),
        onToggle: {
          if self.selectedIndices.contains(index) {
            self.selectedIndices.remove(index)
          } else {
            self.selectedIndices.insert(index)
          }
        }
      )
      // .disabled()는 plain UIView representable 안의 중첩 UIControl까지 내려가지 않으므로 직접 주입한다.
      option.isEnabled = self.isEnabled
      if self.hasCenterSlot {
        // SwiftUI와 동일하게 40pt 정사각을 넘겨 슬롯 클리핑 높이를 잴 수 있게 한다.
        let badge = UIView()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.backgroundColor = .orange
        badge.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
          badge.widthAnchor.constraint(equalToConstant: 40),
          badge.heightAnchor.constraint(equalToConstant: 40),
        ])
        option.centerSlot = badge
      }
      return option
    }

    if self.showsGroup {
      multiSelect.contents = [
        BezierMultiSelectGroup(
          labelText: self.showsGroupLabel ? "최근 사용" : nil,
          options: options
        )
      ]
    } else {
      multiSelect.contents = options
    }
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(
        width: proposal.width ?? BezierOverlayConstant.width,
        height: UIView.layoutFittingCompressedSize.height
      ),
      withHorizontalFittingPriority: .fittingSizeLevel,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: proposal.width ?? fitting.width, height: fitting.height)
  }

  private func uiKitLeading(icon: BezierIcon) -> BezierMultiSelectOptionLeading<UIView> {
    switch self.leadingKind {
    case .none:
      return .none
    case .icon:
      return .icon(icon)
    case .avatar:
      return .avatar(BezierAvatar(image: UIImage(named: "AvatarSample"), size: .size24))
    case .custom:
      let circle = UIView()
      circle.backgroundColor = UIColor.orange.withAlphaComponent(0.4)
      circle.layer.cornerRadius = 12
      return .custom(circle)
    }
  }
}
