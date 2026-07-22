import SwiftUI
import UIKit
import BezierSwift

struct FloatingBannerCatalog: View {
  enum ClickAreaKind: String, CaseIterable, Identifiable {
    case none, full, actionIcon
    var id: String { self.rawValue }
  }

  @State private var clickAreaKind: ClickAreaKind = .actionIcon
  @State private var showLeadingIcon = true
  @State private var tintLeadingIcon = false
  @State private var showTitle = true

  var body: some View {
    CatalogScreen(title: "FloatingBanner") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("clickArea", selection: self.$clickAreaKind) {
        ForEach(ClickAreaKind.allCases) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Toggle("leadingIcon", isOn: self.$showLeadingIcon)
      Toggle("leadingIcon tint (green)", isOn: self.$tintLeadingIcon)
      Toggle("hasTitle", isOn: self.$showTitle)
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    SUBezierFloatingBanner(
      leadingIcon: self.showLeadingIcon ? .plus : nil,
      leadingIconColor: self.leadingIconColor,
      title: self.showTitle ? "Banner Title" : nil,
      description: "Banner description text goes here.",
      clickArea: self.floatingClickArea
    )
    .padding(12)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(uiColor: .secondarySystemBackground))
  }

  private var uiKitPreview: some View {
    FloatingBannerUIKitRepresentable(
      leadingIcon: self.showLeadingIcon ? .plus : nil,
      leadingIconColor: self.leadingIconColor,
      title: self.showTitle ? "Banner Title" : nil,
      description: "Banner description text goes here.",
      clickAreaKind: self.clickAreaKind
    )
    .padding(12)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(uiColor: .secondarySystemBackground))
  }

  private var leadingIconColor: BCSemanticToken {
    self.tintLeadingIcon ? .iconAccentGreen : .iconNeutral
  }

  private var floatingClickArea: BezierFloatingBannerClickArea {
    switch self.clickAreaKind {
    case .none: return .none
    case .full: return .full(onClick: {})
    case .actionIcon: return .actionIcon(onClick: {})
    }
  }
}

private struct FloatingBannerUIKitRepresentable: UIViewRepresentable {
  let leadingIcon: BezierIcon?
  let leadingIconColor: BCSemanticToken
  let title: String?
  let description: String
  let clickAreaKind: FloatingBannerCatalog.ClickAreaKind

  // BezierFloatingBanner는 intrinsic width(content hug)를 노출하므로 Representable에 직접 반환하면
  // full-width로 늘어나지 않는다. wrapper에 leading/trailing을 pin해 컨테이너 폭을 채운다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let banner = BezierFloatingBanner(
      leadingIcon: self.leadingIcon,
      leadingIconColor: self.leadingIconColor,
      title: self.title,
      description: self.description,
      clickArea: self.clickArea
    )
    banner.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(banner)
    NSLayoutConstraint.activate([
      banner.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      banner.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      banner.topAnchor.constraint(equalTo: wrapper.topAnchor),
      banner.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let banner = wrapper.subviews.compactMap({ $0 as? BezierFloatingBanner }).first else { return }
    banner.leadingIcon = self.leadingIcon
    banner.leadingIconColor = self.leadingIconColor
    banner.title = self.title
    banner.bannerDescription = self.description
    banner.clickArea = self.clickArea
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

  private var clickArea: BezierFloatingBannerClickArea {
    switch self.clickAreaKind {
    case .none: return .none
    case .full: return .full(onClick: {})
    case .actionIcon: return .actionIcon(onClick: {})
    }
  }
}
