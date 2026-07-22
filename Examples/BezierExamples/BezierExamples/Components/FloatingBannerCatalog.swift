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

  func makeUIView(context: Context) -> BezierFloatingBanner {
    BezierFloatingBanner(
      leadingIcon: self.leadingIcon,
      leadingIconColor: self.leadingIconColor,
      title: self.title,
      description: self.description,
      clickArea: self.clickArea
    )
  }

  func updateUIView(_ uiView: BezierFloatingBanner, context: Context) {
    uiView.leadingIcon = self.leadingIcon
    uiView.leadingIconColor = self.leadingIconColor
    uiView.title = self.title
    uiView.bannerDescription = self.description
    uiView.clickArea = self.clickArea
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierFloatingBanner, context: Context) -> CGSize? {
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
