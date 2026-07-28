import SwiftUI
import UIKit
import BezierSwift

struct CardCatalog: View {
  @State private var rowCount = 2
  @State private var showsFreeContent = true

  private static let rowTitles = ["운영시간 설정", "휴무일 설정", "부재중 메시지", "자동 응답", "상담 분배"]

  private var rows: [String] {
    Array(Self.rowTitles.prefix(self.rowCount))
  }

  var body: some View {
    CatalogScreen(title: "Card") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Stepper("rows: \(self.rowCount)", value: self.$rowCount, in: 1...Self.rowTitles.count)
      Toggle("자유 콘텐츠 카드", isOn: self.$showsFreeContent)
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("리스트 콘텐츠")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SUBezierCard {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(self.rows, id: \.self) { title in
            self.swiftUIRow(title)
          }
        }
      }

      if self.showsFreeContent {
        Text("자유 콘텐츠")
          .font(.caption2)
          .foregroundStyle(.secondary)

        SUBezierCard {
          VStack(alignment: .leading, spacing: 4) {
            Text("운영시간")
              .font(.system(size: 15, weight: .semibold))
            Text("설정한 운영시간에만 상담을 받습니다.")
              .font(.system(size: 13))
              .foregroundStyle(.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(16)
        }
      }
    }
  }

  private func swiftUIRow(_ title: String) -> some View {
    SUBezierBaseItem(
      title: title,
      onTap: {},
      leading: {
        BezierIcon.settings.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundColor(.secondary)
      },
      trailing: {
        BezierIcon.chevronSmallRight.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.secondary)
      }
    )
  }

  // MARK: - UIKit

  private var uiKitPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("BezierCard")
        .font(.caption2)
        .foregroundStyle(.secondary)

      CardRepresentable(rows: self.rows)
    }
  }
}

// MARK: - Representable

private struct CardRepresentable: UIViewRepresentable {
  let rows: [String]

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let card = BezierCard(content: Self.makeContentStackView())
    self.apply(to: card)
    wrapper.addSubview(card)
    NSLayoutConstraint.activate([
      card.topAnchor.constraint(equalTo: wrapper.topAnchor),
      card.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
      card.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor),
      card.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ wrapper: UIView, context: Context) {
    guard let card = wrapper.subviews.first as? BezierCard else { return }
    self.apply(to: card)
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

  private func apply(to card: BezierCard) {
    guard let stackView = card.content as? UIStackView else { return }

    if stackView.arrangedSubviews.count != self.rows.count {
      stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
      self.rows.map(Self.makeRow).forEach(stackView.addArrangedSubview)
    } else {
      for case let (row, title) in zip(stackView.arrangedSubviews, self.rows) {
        (row as? BezierBaseItem)?.title = title
      }
    }
  }

  private static func makeContentStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }

  private static func makeRow(_ title: String) -> BezierBaseItem {
    let item = BezierBaseItem(title: title, onTap: {})
    let imageView = UIImageView(
      image: BezierIcon.settings.uiImage?.withRenderingMode(.alwaysTemplate)
    )
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .secondaryLabel
    item.leadingContent = imageView
    return item
  }
}
