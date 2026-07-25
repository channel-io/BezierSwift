import SwiftUI
import UIKit
import BezierSwift

struct SectionCatalog: View {
  @State private var variant: BezierSectionVariant = .card
  @State private var hasLabel = true
  @State private var labelColor: BezierSectionLabelColor = .neutralDark
  @State private var rowCount = 3

  private static let rowTitles = ["태그 관리", "고객 노트", "첨부파일", "담당자 지정", "메시지 번역"]

  private var rows: [String] {
    Array(Self.rowTitles.prefix(self.rowCount))
  }

  var body: some View {
    CatalogScreen(title: "Section") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) {
        self.uiKitStaticPreview
        self.uiKitCompositionalPreview
      }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Picker("variant", selection: self.$variant) {
        ForEach(BezierSectionVariant.allCases, id: \.self) { variant in
          Text(self.variantLabel(variant)).tag(variant)
        }
      }
      .pickerStyle(.segmented)

      Picker("labelColor", selection: self.$labelColor) {
        ForEach(BezierSectionLabelColor.allCases, id: \.self) { color in
          Text(self.labelColorLabel(color)).tag(color)
        }
      }
      .pickerStyle(.segmented)

      Toggle("hasLabel", isOn: self.$hasLabel)

      Stepper("rows: \(self.rowCount)", value: self.$rowCount, in: 1...Self.rowTitles.count)
    }
    .font(.caption)
  }

  // MARK: - SwiftUI

  private var swiftUIPreview: some View {
    VStack(alignment: .leading, spacing: 16) {
      SUBezierSection(
        self.rows,
        id: \.self,
        variant: self.variant,
        labelText: self.hasLabel ? "고객 정보" : nil,
        labelColor: self.labelColor
      ) { title in
        self.swiftUIRow(title)
      }

      Text("labelTrailing 슬롯")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SUBezierSection(
        self.rows,
        id: \.self,
        variant: self.variant,
        labelText: self.hasLabel ? "첨부파일" : nil,
        labelColor: self.labelColor,
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

  private var uiKitStaticPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("BezierSection (정적 컨테이너)")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SectionStaticRepresentable(
        variant: self.variant,
        hasLabel: self.hasLabel,
        labelColor: self.labelColor,
        rows: self.rows
      )
    }
  }

  private var uiKitCompositionalPreview: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("UICollectionViewCompositionalLayout (BezierSectionLayout)")
        .font(.caption2)
        .foregroundStyle(.secondary)

      SectionCompositionalRepresentable(
        variant: self.variant,
        hasLabel: self.hasLabel,
        labelColor: self.labelColor,
        rows: self.rows
      )
      .frame(height: 500)
    }
  }

  private func variantLabel(_ variant: BezierSectionVariant) -> String {
    switch variant {
    case .solid: return "solid"
    case .card: return "card"
    }
  }

  private func labelColorLabel(_ color: BezierSectionLabelColor) -> String {
    switch color {
    case .neutralDark: return "neutralDark"
    case .neutralLight: return "neutralLight"
    }
  }
}

// MARK: - 정적 컨테이너 Representable

private struct SectionStaticRepresentable: UIViewRepresentable {
  let variant: BezierSectionVariant
  let hasLabel: Bool
  let labelColor: BezierSectionLabelColor
  let rows: [String]

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let section = BezierSection()
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
    guard let section = wrapper.subviews.first as? BezierSection else { return }
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

  private func apply(to section: BezierSection) {
    section.variant = self.variant
    section.labelText = self.hasLabel ? "고객 정보" : nil
    section.labelColor = self.labelColor

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

// MARK: - 컴포지셔널 레이아웃 Representable

private struct SectionCompositionalRepresentable: UIViewRepresentable {
  let variant: BezierSectionVariant
  let hasLabel: Bool
  let labelColor: BezierSectionLabelColor
  let rows: [String]

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  func makeUIView(context: Context) -> UICollectionView {
    let coordinator = context.coordinator
    coordinator.apply(self)

    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = 24
    let layout = UICollectionViewCompositionalLayout(
      sectionProvider: { [weak coordinator] sectionIndex, layoutEnvironment in
        guard let coordinator else { return nil }
        return BezierSectionLayout.makeSection(
          variant: coordinator.variant(at: sectionIndex),
          numberOfItems: coordinator.rows.count,
          showsLabel: coordinator.hasLabel,
          layoutEnvironment: layoutEnvironment
        )
      },
      configuration: configuration
    )
    BezierSectionLayout.register(in: layout)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = coordinator
    return collectionView
  }

  func updateUIView(_ collectionView: UICollectionView, context: Context) {
    context.coordinator.apply(self)
    collectionView.reloadData()
    collectionView.collectionViewLayout.invalidateLayout()
  }

  final class Coordinator: NSObject, UICollectionViewDataSource {
    private(set) var selectedVariant: BezierSectionVariant = .card
    private(set) var hasLabel = true
    private(set) var labelColor: BezierSectionLabelColor = .neutralDark
    private(set) var rows: [String] = []

    private let cellRegistration = UICollectionView.CellRegistration<
      SectionDemoListCell, String
    > { cell, _, title in
      cell.configure(title: title)
    }

    // registration을 dequeue 콜백 안에서 처음 생성(lazy)하면 UIKit이 예외를 던지므로 init에서 미리 만든다.
    private var headerRegistration: UICollectionView.SupplementaryRegistration<BezierSectionLabelReusableView>!

    override init() {
      super.init()
      self.headerRegistration = UICollectionView.SupplementaryRegistration<
        BezierSectionLabelReusableView
      >(elementKind: BezierSectionLayout.labelElementKind) { [weak self] supplementaryView, _, indexPath in
        guard let self else { return }
        supplementaryView.sectionLabel.text = self.variant(at: indexPath.section) == .card
          ? "card 섹션"
          : "solid 섹션"
        supplementaryView.sectionLabel.color = self.labelColor
      }
    }

    func apply(_ representable: SectionCompositionalRepresentable) {
      self.selectedVariant = representable.variant
      self.hasLabel = representable.hasLabel
      self.labelColor = representable.labelColor
      self.rows = representable.rows
    }

    func variant(at sectionIndex: Int) -> BezierSectionVariant {
      sectionIndex == 0 ? self.selectedVariant : self.oppositeVariant
    }

    private var oppositeVariant: BezierSectionVariant {
      self.selectedVariant == .card ? .solid : .card
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }

    func collectionView(
      _ collectionView: UICollectionView,
      numberOfItemsInSection section: Int
    ) -> Int {
      self.rows.count
    }

    func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
      collectionView.dequeueConfiguredReusableCell(
        using: self.cellRegistration,
        for: indexPath,
        item: self.rows[indexPath.item]
      )
    }

    func collectionView(
      _ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath
    ) -> UICollectionReusableView {
      collectionView.dequeueConfiguredReusableSupplementary(
        using: self.headerRegistration,
        for: indexPath
      )
    }
  }
}

private final class SectionDemoListCell: UICollectionViewListCell {
  private let item = BezierBaseItem(title: "")

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  private func setUp() {
    self.backgroundConfiguration = UIBackgroundConfiguration.clear()

    let imageView = UIImageView(
      image: BezierIcon.personCircle.uiImage?.withRenderingMode(.alwaysTemplate)
    )
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .secondaryLabel
    self.item.leadingContent = imageView

    self.contentView.addSubview(self.item)
    NSLayoutConstraint.activate([
      self.item.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.item.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.item.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.item.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

      // separatorLayoutGuide 기본값은 텍스트 기준 자동 정렬이라
      // BezierSectionLayout이 지정한 divider 인셋이 그대로 적용되도록 셀 전체 폭에 고정한다.
      self.separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.separatorLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])
  }

  func configure(title: String) {
    self.item.title = title
  }
}
