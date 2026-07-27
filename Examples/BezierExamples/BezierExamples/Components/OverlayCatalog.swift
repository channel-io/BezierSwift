import SwiftUI
import UIKit
import BezierSwift

struct OverlayCatalog: View {
  enum ContentKind: String, CaseIterable, Identifiable {
    case menu, freeText, empty
    var id: String { self.rawValue }
  }

  @State private var contentKind: ContentKind = .menu

  var body: some View {
    CatalogScreen(title: "Overlay") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    Picker("content", selection: self.$contentKind) {
      ForEach(ContentKind.allCases) { kind in
        Text(kind.rawValue).tag(kind)
      }
    }
    .pickerStyle(.segmented)
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    SUBezierOverlay {
      switch self.contentKind {
      case .menu:
        VStack(alignment: .leading, spacing: 0) {
          ForEach(Self.menuTitles, id: \.self) { title in
            SUBezierBaseItem(
              title: title,
              onTap: {},
              leading: { EmptyView() },
              trailing: { EmptyView() }
            )
          }
        }
      case .freeText:
        Text("자유 구성 콘텐츠입니다. Overlay는 내부 구조를 강제하지 않는 escape hatch 컨테이너입니다.")
          .font(.caption)
          .padding(8)
      case .empty:
        EmptyView()
      }
    }
    .padding(24)
    .frame(maxWidth: .infinity)
    .background(Color(uiColor: .secondarySystemBackground))
  }

  private var uiKitPreview: some View {
    OverlayUIKitRepresentable(contentKind: self.contentKind)
      .padding(24)
      .frame(maxWidth: .infinity)
      .background(Color(uiColor: .secondarySystemBackground))
  }

  static let menuTitles = ["이름 변경", "복제", "삭제"]
}

private struct OverlayUIKitRepresentable: UIViewRepresentable {
  let contentKind: OverlayCatalog.ContentKind

  final class Coordinator {
    var renderedKind: OverlayCatalog.ContentKind?
  }

  func makeCoordinator() -> Coordinator { Coordinator() }

  // BezierOverlay는 240pt 고정 폭(content hug)이라 wrapper에서 center로 배치한다.
  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let overlay = BezierOverlay()
    overlay.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(overlay)
    NSLayoutConstraint.activate([
      overlay.topAnchor.constraint(equalTo: wrapper.topAnchor),
      overlay.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
      overlay.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let overlay = wrapper.subviews.compactMap({ $0 as? BezierOverlay }).first else { return }
    guard context.coordinator.renderedKind != self.contentKind else { return }
    context.coordinator.renderedKind = self.contentKind
    overlay.content = self.makeContent()
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    let fitting = uiView.systemLayoutSizeFitting(
      CGSize(width: BezierOverlayConstant.width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .fittingSizeLevel,
      verticalFittingPriority: .fittingSizeLevel
    )
    return CGSize(width: proposal.width ?? fitting.width, height: fitting.height)
  }

  private func makeContent() -> UIView? {
    switch self.contentKind {
    case .menu:
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.distribution = .fill
      stackView.spacing = 0
      OverlayCatalog.menuTitles.forEach { title in
        stackView.addArrangedSubview(BezierBaseItem(title: title, onTap: {}))
      }
      return stackView
    case .freeText:
      let label = UILabel()
      label.text = "자유 구성 콘텐츠입니다. Overlay는 내부 구조를 강제하지 않는 escape hatch 컨테이너입니다."
      label.font = .preferredFont(forTextStyle: .caption1)
      label.numberOfLines = 0
      return label
    case .empty:
      return nil
    }
  }
}
