import SwiftUI
import UIKit
import BezierSwift

private enum SelectLeadingKind: String, CaseIterable {
  case none
  case icon
  case avatar
  case custom
}

private enum SelectOptionSpec {
  static let titles = ["한국어", "English", "日本語"]
  static let icons: [BezierIcon] = [.globe, .translate, .star]
  static let descriptions = ["기본 언어", "영어로 표시", "일본어로 표시"]
}

struct SelectCatalog: View {
  @State private var container: BezierSelectContainer = .page
  @State private var leadingKind: SelectLeadingKind = .icon
  @State private var selectedIndex = 0
  @State private var showsSelectLabel = true
  @State private var showsGroup = true
  @State private var showsGroupLabel = true
  @State private var showsDivider = false
  @State private var hasDescription = false
  @State private var hasCenterSlot = false
  @State private var isEnabled = true

  var body: some View {
    CatalogScreen(title: "Select") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("container", selection: self.$container) {
        ForEach(BezierSelectContainer.allCases, id: \.self) { container in
          Text(String(describing: container)).tag(container)
        }
      }
      .pickerStyle(.segmented)

      Picker("leading", selection: self.$leadingKind) {
        ForEach(SelectLeadingKind.allCases, id: \.self) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Picker("selected", selection: self.$selectedIndex) {
        ForEach(SelectOptionSpec.titles.indices, id: \.self) { index in
          Text(SelectOptionSpec.titles[index]).tag(index)
        }
      }
      .pickerStyle(.segmented)

      Toggle("select label", isOn: self.$showsSelectLabel)
      Toggle("group", isOn: self.$showsGroup)
      Toggle("group label", isOn: self.$showsGroupLabel)
      Toggle("showsDivider", isOn: self.$showsDivider)
      Toggle("hasDescription", isOn: self.$hasDescription)
      Toggle("hasCenterSlot", isOn: self.$hasCenterSlot)
      Toggle("isEnabled", isOn: self.$isEnabled)
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    SUBezierSelect(
      container: self.container,
      labelText: self.showsSelectLabel ? "언어" : nil
    ) {
      if self.showsGroup {
        SUBezierSelectGroup(
          labelText: self.showsGroupLabel ? "최근 사용" : nil,
          showsDivider: self.showsDivider
        ) {
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
    ForEach(SelectOptionSpec.titles.indices, id: \.self) { index in
      SUBezierSelectOption(
        title: SelectOptionSpec.titles[index],
        description: self.hasDescription ? SelectOptionSpec.descriptions[index] : nil,
        leading: self.swiftUILeading(icon: SelectOptionSpec.icons[index]),
        isSelected: self.selectedIndex == index,
        onSelect: { self.selectedIndex = index },
        centerSlot: {
          // 40pt 정사각을 넘겨 슬롯의 클리핑 높이(24pt)를 눈으로 잴 수 있게 한다.
          if self.hasCenterSlot {
            RoundedRectangle(cornerRadius: 4).fill(Color.orange).frame(width: 40, height: 40)
          }
        }
      )
    }
  }

  private func swiftUILeading(icon: BezierIcon) -> BezierSelectOptionLeading<AnyView> {
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
    SelectUIKitRepresentable(
      container: self.container,
      leadingKind: self.leadingKind,
      selectedIndex: self.$selectedIndex,
      showsSelectLabel: self.showsSelectLabel,
      showsGroup: self.showsGroup,
      showsGroupLabel: self.showsGroupLabel,
      showsDivider: self.showsDivider,
      hasDescription: self.hasDescription,
      hasCenterSlot: self.hasCenterSlot,
      isEnabled: self.isEnabled
    )
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }
}

private struct SelectUIKitRepresentable: UIViewRepresentable {
  let container: BezierSelectContainer
  let leadingKind: SelectLeadingKind
  @Binding var selectedIndex: Int
  let showsSelectLabel: Bool
  let showsGroup: Bool
  let showsGroupLabel: Bool
  let showsDivider: Bool
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
    let select = BezierSelect()
    select.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(select)
    NSLayoutConstraint.activate([
      select.topAnchor.constraint(equalTo: wrapper.topAnchor),
      select.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    context.coordinator.fillConstraints = [
      select.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      select.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
    ]
    context.coordinator.centerConstraints = [
      select.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
      select.leadingAnchor.constraint(greaterThanOrEqualTo: wrapper.leadingAnchor),
      select.trailingAnchor.constraint(lessThanOrEqualTo: wrapper.trailingAnchor),
    ]
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let select = wrapper.subviews.compactMap({ $0 as? BezierSelect }).first else { return }

    switch self.container {
    case .page:
      NSLayoutConstraint.deactivate(context.coordinator.centerConstraints)
      NSLayoutConstraint.activate(context.coordinator.fillConstraints)
    case .overlay:
      NSLayoutConstraint.deactivate(context.coordinator.fillConstraints)
      NSLayoutConstraint.activate(context.coordinator.centerConstraints)
    }

    select.container = self.container
    select.labelText = self.showsSelectLabel ? "언어" : nil

    let options: [UIView] = SelectOptionSpec.titles.indices.map { index in
      let option = BezierSelectOption(
        title: SelectOptionSpec.titles[index],
        description: self.hasDescription ? SelectOptionSpec.descriptions[index] : nil,
        leading: self.uiKitLeading(icon: SelectOptionSpec.icons[index]),
        isSelected: self.selectedIndex == index,
        onSelect: { self.selectedIndex = index }
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
      select.contents = [
        BezierSelectGroup(
          labelText: self.showsGroupLabel ? "최근 사용" : nil,
          showsDivider: self.showsDivider,
          options: options
        )
      ]
    } else {
      select.contents = options
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

  private func uiKitLeading(icon: BezierIcon) -> BezierSelectOptionLeading<UIView> {
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
