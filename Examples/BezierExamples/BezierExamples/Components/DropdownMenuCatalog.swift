import SwiftUI
import UIKit
import BezierSwift

private enum DropdownMenuLeadingKind: String, CaseIterable {
  case none
  case icon
  case custom
}

struct DropdownMenuCatalog: View {
  @State private var leadingKind: DropdownMenuLeadingKind = .icon
  @State private var isDestructiveGroupShown = true
  @State private var showsTrigger = true
  @State private var showsGroupLabel = true
  @State private var hasDescription = false
  @State private var showsShortcut = true
  @State private var isEnabled = true

  var body: some View {
    CatalogScreen(title: "DropdownMenu") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("leading", selection: self.$leadingKind) {
        ForEach(DropdownMenuLeadingKind.allCases, id: \.self) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Toggle("showsTrigger", isOn: self.$showsTrigger)
      Toggle("group label", isOn: self.$showsGroupLabel)
      Toggle("destructive group", isOn: self.$isDestructiveGroupShown)
      Toggle("hasDescription", isOn: self.$hasDescription)
      Toggle("shortcut trailing", isOn: self.$showsShortcut)
      Toggle("isEnabled", isOn: self.$isEnabled)
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    Group {
      if self.showsTrigger {
        SUBezierDropdownMenu {
          SUBezierIconButton(icon: BezierIcon.moreVertical.image, action: {})
        } content: {
          self.menuContent
        }
      } else {
        SUBezierDropdownMenu {
          self.menuContent
        }
      }
    }
    .disabled(!self.isEnabled)
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }

  @ViewBuilder
  private var menuContent: some View {
    SUBezierDropdownMenuGroup(
      labelText: self.showsGroupLabel ? "편집" : nil,
      showsDivider: self.isDestructiveGroupShown
    ) {
      SUBezierDropdownMenuItem(
        title: "이름 변경",
        description: self.hasDescription ? "팀 전체에 공유됩니다" : nil,
        leading: self.swiftUILeading(icon: .edit),
        onTap: {}
      )
      SUBezierDropdownMenuItem(
        title: "복제",
        leading: self.swiftUILeading(icon: .linkCopy),
        onTap: {},
        trailing: {
          if self.showsShortcut {
            Text("⌘D")
              .font(.caption)
              .foregroundStyle(.secondary)
          }
        }
      )
    }

    if self.isDestructiveGroupShown {
      SUBezierDropdownMenuGroup {
        SUBezierDropdownMenuItem(
          variant: .destructive,
          title: "삭제",
          description: self.hasDescription ? "복구할 수 없어요" : nil,
          leading: self.swiftUILeading(icon: .trash),
          onTap: {}
        )
      }
    }
  }

  private func swiftUILeading(icon: BezierIcon) -> BezierDropdownMenuItemLeading<AnyView> {
    switch self.leadingKind {
    case .none:
      return .none
    case .icon:
      return .icon(icon)
    case .custom:
      return .custom(AnyView(Circle().fill(Color.orange.opacity(0.4))))
    }
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    DropdownMenuUIKitRepresentable(
      leadingKind: self.leadingKind,
      isDestructiveGroupShown: self.isDestructiveGroupShown,
      showsTrigger: self.showsTrigger,
      showsGroupLabel: self.showsGroupLabel,
      hasDescription: self.hasDescription,
      showsShortcut: self.showsShortcut,
      isEnabled: self.isEnabled
    )
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }
}

private struct DropdownMenuUIKitRepresentable: UIViewRepresentable {
  let leadingKind: DropdownMenuLeadingKind
  let isDestructiveGroupShown: Bool
  let showsTrigger: Bool
  let showsGroupLabel: Bool
  let hasDescription: Bool
  let showsShortcut: Bool
  let isEnabled: Bool

  // BezierDropdownMenu는 240pt 고정 폭이라 wrapper에서 center로 배치한다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let menu = BezierDropdownMenu()
    menu.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(menu)
    NSLayoutConstraint.activate([
      menu.topAnchor.constraint(equalTo: wrapper.topAnchor),
      menu.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
      menu.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let menu = wrapper.subviews.compactMap({ $0 as? BezierDropdownMenu }).first else { return }

    if self.showsTrigger {
      let trigger = BezierIconButton()
      trigger.icon = BezierIcon.moreVertical.uiImage
      trigger.isEnabled = self.isEnabled
      menu.trigger = trigger
    } else {
      menu.trigger = nil
    }

    var contents: [UIView] = []

    let renameItem = BezierDropdownMenuItem(
      title: "이름 변경",
      description: self.hasDescription ? "팀 전체에 공유됩니다" : nil,
      leading: self.uiKitLeading(icon: .edit),
      onTap: {}
    )
    renameItem.isEnabled = self.isEnabled

    let duplicateItem = BezierDropdownMenuItem(
      title: "복제",
      leading: self.uiKitLeading(icon: .linkCopy),
      onTap: {}
    )
    duplicateItem.isEnabled = self.isEnabled
    if self.showsShortcut {
      let shortcutLabel = UILabel()
      shortcutLabel.text = "⌘D"
      shortcutLabel.font = .preferredFont(forTextStyle: .caption1)
      shortcutLabel.textColor = .secondaryLabel
      duplicateItem.trailingContent = shortcutLabel
    }

    contents.append(
      BezierDropdownMenuGroup(
        labelText: self.showsGroupLabel ? "편집" : nil,
        showsDivider: self.isDestructiveGroupShown,
        items: [renameItem, duplicateItem]
      )
    )

    if self.isDestructiveGroupShown {
      let deleteItem = BezierDropdownMenuItem(
        variant: .destructive,
        title: "삭제",
        description: self.hasDescription ? "복구할 수 없어요" : nil,
        leading: self.uiKitLeading(icon: .trash),
        onTap: {}
      )
      deleteItem.isEnabled = self.isEnabled
      contents.append(BezierDropdownMenuGroup(items: [deleteItem]))
    }

    menu.contents = contents
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(width: BezierOverlayConstant.width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .fittingSizeLevel,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: proposal.width ?? fitting.width, height: fitting.height)
  }

  private func uiKitLeading(icon: BezierIcon) -> BezierDropdownMenuItemLeading<UIView> {
    switch self.leadingKind {
    case .none:
      return .none
    case .icon:
      return .icon(icon)
    case .custom:
      let circle = UIView()
      circle.backgroundColor = UIColor.orange.withAlphaComponent(0.4)
      circle.layer.cornerRadius = 12
      return .custom(circle)
    }
  }
}
