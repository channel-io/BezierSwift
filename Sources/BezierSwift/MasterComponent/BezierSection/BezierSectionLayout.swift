//
//  BezierSectionLayout.swift
//  BezierSwift
//

import UIKit

// MARK: - Decoration Element Kind

extension BezierSectionVariant {
  var decorationElementKind: String {
    switch self {
    case .solid: return "BezierSectionLayout.background.solid"
    case .card: return "BezierSectionLayout.background.card"
    }
  }

  init?(decorationElementKind: String) {
    guard let variant = Self.allCases.first(
      where: { $0.decorationElementKind == decorationElementKind }
    ) else { return nil }
    self = variant
  }
}

// MARK: - Layout Builder

public enum BezierSectionLayout {
  public static let labelElementKind = "BezierSectionLayout.label"

  public static func register(in layout: UICollectionViewCompositionalLayout) {
    for variant in BezierSectionVariant.allCases {
      layout.register(
        BezierSectionBackgroundView.self,
        forDecorationViewOfKind: variant.decorationElementKind
      )
    }
  }

  public static func makeSection(
    variant: BezierSectionVariant,
    numberOfItems: Int,
    showsLabel: Bool = false,
    layoutEnvironment: NSCollectionLayoutEnvironment
  ) -> NSCollectionLayoutSection {
    let appearance = variant.appearance

    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.backgroundColor = .clear
    configuration.showsSeparators = appearance.divider != nil

    if let divider = appearance.divider {
      var separatorConfiguration = UIListSeparatorConfiguration(listAppearance: .plain)
      separatorConfiguration.color = UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
          ? divider.color.dark.uiColor
          : divider.color.light.uiColor
      }
      separatorConfiguration.bottomSeparatorInsets = NSDirectionalEdgeInsets(
        top: 0,
        leading: divider.leadingInset,
        bottom: 0,
        trailing: divider.trailingInset
      )
      configuration.separatorConfiguration = separatorConfiguration
      configuration.itemSeparatorHandler = { indexPath, separatorConfiguration in
        var separatorConfiguration = separatorConfiguration
        // top separator까지 그리면 행 사이 divider가 이중으로 그려지므로 bottom만 사용하고,
        // 마지막 행의 bottom을 숨겨 내부 divider를 정확히 (행 수 - 1)개로 만든다.
        separatorConfiguration.topSeparatorVisibility = .hidden
        separatorConfiguration.bottomSeparatorVisibility =
          indexPath.item >= numberOfItems - 1 ? .hidden : .visible
        return separatorConfiguration
      }
    }

    let section = NSCollectionLayoutSection.list(
      using: configuration,
      layoutEnvironment: layoutEnvironment
    )

    section.contentInsets = NSDirectionalEdgeInsets(
      top: appearance.contentInsets.top,
      leading: appearance.contentInsets.leading,
      bottom: appearance.contentInsets.bottom,
      trailing: appearance.contentInsets.trailing
    )
    section.supplementariesFollowContentInsets = false

    let labelAreaHeight = BezierSectionConstant.labelHeight + BezierSectionConstant.labelToContentSpacing

    if showsLabel {
      let header = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .absolute(labelAreaHeight)
        ),
        elementKind: Self.labelElementKind,
        alignment: .top
      )
      section.boundarySupplementaryItems = [header]
    }

    if appearance.hasChrome {
      let decoration = NSCollectionLayoutDecorationItem.background(
        elementKind: variant.decorationElementKind
      )
      // background decoration은 boundary header 영역까지 덮으므로
      // label 높이만큼 top을 밀어 chrome이 콘텐츠 영역에서 시작하게 상쇄한다.
      decoration.contentInsets = NSDirectionalEdgeInsets(
        top: showsLabel ? labelAreaHeight : 0,
        leading: 0,
        bottom: 0,
        trailing: 0
      )
      section.decorationItems = [decoration]
    }

    return section
  }
}

// MARK: - Background Decoration View

public final class BezierSectionBackgroundView: UICollectionReusableView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Private Properties

  private var variant: BezierSectionVariant? {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  // MARK: - Init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.masksToBounds = true
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.layer.masksToBounds = true
  }

  // MARK: - Layout Attributes

  public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    guard
      let elementKind = layoutAttributes.representedElementKind,
      let variant = BezierSectionVariant(decorationElementKind: elementKind)
    else { return }
    self.variant = variant
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    guard let appearance = self.variant?.appearance else { return }

    if let backgroundColor = appearance.backgroundColor {
      self.backgroundColor = backgroundColor.palette(self)
    } else {
      self.backgroundColor = .clear
    }
    self.layer.cornerRadius = appearance.cornerRadius

    if let border = appearance.border {
      self.layer.borderWidth = border.width
      self.layer.borderColor = border.color.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }
  }
}

// MARK: - Label Reusable View

public final class BezierSectionLabelReusableView: UICollectionReusableView {
  public let sectionLabel = BezierSectionLabel(text: "")

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  private func setUp() {
    self.addSubview(self.sectionLabel)
    NSLayoutConstraint.activate([
      self.sectionLabel.topAnchor.constraint(equalTo: self.topAnchor),
      self.sectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.sectionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.sectionLabel.heightAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelHeight
      ),
    ])
  }

  public override func prepareForReuse() {
    super.prepareForReuse()
    self.sectionLabel.leadingContent = nil
    self.sectionLabel.trailingContent = nil
  }
}
