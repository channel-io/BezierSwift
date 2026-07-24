import SwiftUI
import UIKit
import BezierSwift

struct BaseItemCatalog: View {
  @State private var size: BezierBaseItemSize = .medium
  @State private var interactive = true
  @State private var isEnabled = true

  var body: some View {
    CatalogScreen(title: "BaseItem") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("size", selection: self.$size) {
        ForEach(BezierBaseItemSize.allCases, id: \.self) { size in
          Text(self.sizeLabel(size)).tag(size)
        }
      }
      .pickerStyle(.segmented)

      Toggle("interactive (onTap)", isOn: self.$interactive)
      Toggle("isEnabled", isOn: self.$isEnabled)
    }
    .font(.caption)
  }

  private var onTap: (() -> Void)? {
    self.interactive ? {} : nil
  }

  private var swiftUIPreview: some View {
    VStack(spacing: 4) {
      // leading + title
      SUBezierBaseItem(
        size: self.size,
        title: "Leading + title",
        onTap: self.onTap,
        leading: { self.leadingIcon },
        trailing: { EmptyView() }
      )
      // leading + title + description
      SUBezierBaseItem(
        size: self.size,
        title: "Leading + description",
        description: "Secondary description text that can wrap onto a second line.",
        onTap: self.onTap,
        leading: { self.leadingIcon },
        trailing: { EmptyView() }
      )
      // leading + centerSlot + trailing
      SUBezierBaseItem(
        size: self.size,
        title: "Center slot + trailing",
        onTap: self.onTap,
        leading: { self.leadingIcon },
        centerSlot: { Circle().fill(Color.red).frame(width: 6, height: 6) },
        trailing: { self.trailingIcon }
      )
      // no leading + trailing
      SUBezierBaseItem(
        size: self.size,
        title: "No leading + trailing",
        onTap: self.onTap,
        leading: { EmptyView() },
        trailing: { self.trailingIcon }
      )
    }
    .disabled(!self.isEnabled)
  }

  private var leadingIcon: some View {
    BezierIcon.personCircle.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .foregroundColor(.secondary)
  }

  private var trailingIcon: some View {
    BezierIcon.chevronSmallRight.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .frame(width: 20, height: 20)
      .foregroundColor(.secondary)
  }

  private var uiKitPreview: some View {
    BaseItemUIKitRepresentable(
      size: self.size,
      interactive: self.interactive,
      isEnabled: self.isEnabled
    )
  }

  private func sizeLabel(_ size: BezierBaseItemSize) -> String {
    switch size {
    case .small: return "small"
    case .medium: return "medium"
    case .large: return "large"
    }
  }
}

private struct BaseItemUIKitRepresentable: UIViewRepresentable {
  let size: BezierBaseItemSize
  let interactive: Bool
  let isEnabled: Bool

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    wrapper.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: wrapper.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])

    stackView.addArrangedSubview(self.makeItem(title: "Leading + title", hasLeading: true))
    stackView.addArrangedSubview(self.makeItem(
      title: "Leading + description",
      description: "Secondary description text that can wrap onto a second line.",
      hasLeading: true
    ))
    stackView.addArrangedSubview(self.makeItem(title: "Center slot + trailing", hasLeading: true, hasCenterSlot: true, hasTrailing: true))
    stackView.addArrangedSubview(self.makeItem(title: "No leading + trailing", hasLeading: false, hasTrailing: true))
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let stackView = wrapper.subviews.first as? UIStackView else { return }
    for case let item as BezierBaseItem in stackView.arrangedSubviews {
      item.size = self.size
      item.onTap = self.interactive ? {} : nil
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

  private func makeItem(
    title: String,
    description: String? = nil,
    hasLeading: Bool = false,
    hasCenterSlot: Bool = false,
    hasTrailing: Bool = false
  ) -> BezierBaseItem {
    let item = BezierBaseItem(size: self.size, title: title, description: description)
    item.onTap = self.interactive ? {} : nil
    item.isEnabled = self.isEnabled
    if hasLeading {
      let imageView = UIImageView(image: BezierIcon.personCircle.uiImage?.withRenderingMode(.alwaysTemplate))
      imageView.contentMode = .scaleAspectFit
      imageView.tintColor = .secondaryLabel
      item.leadingContent = imageView
    }
    if hasCenterSlot {
      let dot = UIView()
      dot.backgroundColor = .systemRed
      dot.layer.cornerRadius = 3
      dot.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        dot.widthAnchor.constraint(equalToConstant: 6),
        dot.heightAnchor.constraint(equalToConstant: 6),
      ])
      item.centerSlot = dot
    }
    if hasTrailing {
      let imageView = UIImageView(image: BezierIcon.chevronSmallRight.uiImage?.withRenderingMode(.alwaysTemplate))
      imageView.contentMode = .scaleAspectFit
      imageView.tintColor = .secondaryLabel
      imageView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant: 20),
        imageView.heightAnchor.constraint(equalToConstant: 20),
      ])
      item.trailingContent = imageView
    }
    return item
  }
}
