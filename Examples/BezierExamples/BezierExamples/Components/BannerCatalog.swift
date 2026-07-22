import SwiftUI
import UIKit
import BezierSwift

struct BannerCatalog: View {
  enum ClickAreaKind: String, CaseIterable, Identifiable {
    case none, full, actionIcon
    var id: String { self.rawValue }
  }

  @State private var variant: BezierBannerVariant = .default
  @State private var clickAreaKind: ClickAreaKind = .actionIcon
  @State private var showLeadingIcon = true
  @State private var showTitle = true

  var body: some View {
    CatalogScreen(title: "Banner") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("variant", selection: self.$variant) {
        ForEach(BezierBannerVariant.allCases, id: \.self) { variant in
          Text(self.variantLabel(variant)).tag(variant)
        }
      }
      .pickerStyle(.menu)

      Picker("clickArea", selection: self.$clickAreaKind) {
        ForEach(ClickAreaKind.allCases) { kind in
          Text(kind.rawValue).tag(kind)
        }
      }
      .pickerStyle(.segmented)

      Toggle("leadingIcon", isOn: self.$showLeadingIcon)
      Toggle("hasTitle", isOn: self.$showTitle)
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    SUBezierBanner(
      variant: self.variant,
      leadingIcon: self.showLeadingIcon ? .info : nil,
      title: self.showTitle ? "Banner Title" : nil,
      description: "Banner description text goes here.",
      clickArea: self.bannerClickArea
    )
  }

  private var uiKitPreview: some View {
    BannerUIKitRepresentable(
      variant: self.variant,
      leadingIcon: self.showLeadingIcon ? .info : nil,
      title: self.showTitle ? "Banner Title" : nil,
      description: "Banner description text goes here.",
      clickAreaKind: self.clickAreaKind
    )
  }

  private var bannerClickArea: BezierBannerClickArea {
    switch self.clickAreaKind {
    case .none: return .none
    case .full: return .full(onClick: {})
    case .actionIcon: return .actionIcon(onClick: {})
    }
  }

  private func variantLabel(_ variant: BezierBannerVariant) -> String {
    switch variant {
    case .default: return "default"
    case .blue: return "blue"
    case .cobalt: return "cobalt"
    case .green: return "green"
    case .orange: return "orange"
    case .red: return "red"
    }
  }
}

private struct BannerUIKitRepresentable: UIViewRepresentable {
  let variant: BezierBannerVariant
  let leadingIcon: BezierIcon?
  let title: String?
  let description: String
  let clickAreaKind: BannerCatalog.ClickAreaKind

  func makeUIView(context: Context) -> BezierBanner {
    BezierBanner(
      variant: self.variant,
      leadingIcon: self.leadingIcon,
      title: self.title,
      description: self.description,
      clickArea: self.clickArea
    )
  }

  func updateUIView(_ uiView: BezierBanner, context: Context) {
    uiView.variant = self.variant
    uiView.leadingIcon = self.leadingIcon
    uiView.title = self.title
    uiView.bannerDescription = self.description
    uiView.clickArea = self.clickArea
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierBanner, context: Context) -> CGSize? {
    let width = proposal.width ?? 320
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: width, height: fitting.height)
  }

  private var clickArea: BezierBannerClickArea {
    switch self.clickAreaKind {
    case .none: return .none
    case .full: return .full(onClick: {})
    case .actionIcon: return .actionIcon(onClick: {})
    }
  }
}
