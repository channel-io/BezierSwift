import SwiftUI
import UIKit
import BezierSwift

struct CollapsibleSectionCatalog: View {
  @State private var labelColor: BezierSectionLabelColor = .neutralDark
  @State private var rowCount = 3
  @State private var basicOpen = true
  @State private var slotOpen = false
  @State private var uikitOpen = true

  private static let rowTitles = ["태그 관리", "고객 노트", "첨부파일", "담당자 지정", "메시지 번역"]

  private var rows: [String] {
    Array(Self.rowTitles.prefix(self.rowCount))
  }

  var body: some View {
    CatalogScreen(title: "CollapsibleSection") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("labelColor", selection: self.$labelColor) {
        ForEach(BezierSectionLabelColor.allCases, id: \.self) { color in
          Text(self.labelColorLabel(color)).tag(color)
        }
      }
      .pickerStyle(.segmented)

      Stepper("rows: \(self.rowCount)", value: self.$rowCount, in: 1...Self.rowTitles.count)
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 16) {
      SUBezierCollapsibleSection(
        self.rows,
        id: \.self,
        isOpen: self.$basicOpen,
        labelText: "고객 정보",
        labelColor: self.labelColor
      ) { title in
        self.swiftUIRow(title)
      }

      Text("labelLeading + labelTrailing 슬롯")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SUBezierCollapsibleSection(
        self.rows,
        id: \.self,
        isOpen: self.$slotOpen,
        labelText: "첨부파일",
        labelColor: self.labelColor,
        labelLeading: {
          BezierIcon.folder.image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundColor(.secondary)
        },
        labelTrailing: {
          BezierIcon.plus.image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(.secondary)
        }
      ) { title in
        self.swiftUIRow(title)
      }
    }
  }

  private func swiftUIRow(_ title: String) -> some View {
    SUBezierBaseItem(
      title: title,
      onTap: {},
      leading: {
        BezierIcon.personCircle.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundColor(.secondary)
      },
      trailing: { EmptyView() }
    )
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("isOpen (setOpen 프로그래매틱 제어)", isOn: self.$uikitOpen)
        .font(.caption)

      CollapsibleSectionRepresentable(
        isOpen: self.$uikitOpen,
        labelColor: self.labelColor,
        rows: self.rows
      )
    }
  }

  private func labelColorLabel(_ color: BezierSectionLabelColor) -> String {
    switch color {
    case .neutralDark: return "neutralDark"
    case .neutralLight: return "neutralLight"
    }
  }
}

// MARK: - UIKit Representable

private struct CollapsibleSectionRepresentable: UIViewRepresentable {
  @Binding var isOpen: Bool
  let labelColor: BezierSectionLabelColor
  let rows: [String]

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let section = BezierCollapsibleSection(labelText: "고객 정보", isOpen: self.isOpen)
    section.onOpenChange = { open in
      withAnimation(.easeInOut(duration: 0.25)) {
        self.isOpen = open
      }
    }
    self.apply(to: section)
    wrapper.addSubview(section)
    NSLayoutConstraint.activate([
      section.topAnchor.constraint(equalTo: wrapper.topAnchor),
      section.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      section.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      section.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let section = wrapper.subviews.first as? BezierCollapsibleSection else { return }
    self.apply(to: section)
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

  private func apply(to section: BezierCollapsibleSection) {
    section.labelColor = self.labelColor
    section.setOpen(self.isOpen, animated: false)

    if section.items.count != self.rows.count {
      section.setItems(self.rows.map(Self.makeRow))
    } else {
      for case let (row, title) in zip(section.items, self.rows) {
        (row as? BezierBaseItem)?.title = title
      }
    }
  }

  private static func makeRow(_ title: String) -> BezierBaseItem {
    let item = BezierBaseItem(title: title, onTap: {})
    let imageView = UIImageView(
      image: BezierIcon.personCircle.uiImage?.withRenderingMode(.alwaysTemplate)
    )
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .secondaryLabel
    item.leadingContent = imageView
    return item
  }
}
