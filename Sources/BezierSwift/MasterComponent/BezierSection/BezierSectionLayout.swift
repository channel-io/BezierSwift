//
//  BezierSectionLayout.swift
//  BezierSwift
//

import UIKit

// MARK: - Decoration Element Kind

// decoration view는 UIKit이 dequeue해 소비자가 직접 componentTheme를 주입할 수 없으므로,
// variant × componentTheme 조합을 elementKind 문자열에 인코딩해 전달한다.
enum BezierSectionDecorationKind: CaseIterable {
  case solidNormal
  case solidInverted
  case cardNormal
  case cardInverted

  init(variant: BezierSectionVariant, componentTheme: BezierComponentTheme) {
    switch (variant, componentTheme) {
    case (.solid, .normal): self = .solidNormal
    case (.solid, .inverted): self = .solidInverted
    case (.card, .normal): self = .cardNormal
    case (.card, .inverted): self = .cardInverted
    }
  }

  init?(elementKind: String) {
    guard let kind = Self.allCases.first(where: { $0.elementKind == elementKind }) else {
      return nil
    }
    self = kind
  }

  var variant: BezierSectionVariant {
    switch self {
    case .solidNormal, .solidInverted: return .solid
    case .cardNormal, .cardInverted: return .card
    }
  }

  var componentTheme: BezierComponentTheme {
    switch self {
    case .solidNormal, .cardNormal: return .normal
    case .solidInverted, .cardInverted: return .inverted
    }
  }

  var elementKind: String {
    switch self {
    case .solidNormal: return "BezierSectionLayout.background.solid.normal"
    case .solidInverted: return "BezierSectionLayout.background.solid.inverted"
    case .cardNormal: return "BezierSectionLayout.background.card.normal"
    case .cardInverted: return "BezierSectionLayout.background.card.inverted"
    }
  }
}

// MARK: - Layout Builder

public enum BezierSectionLayout {
  public static let labelElementKind = "BezierSectionLayout.label"

  public static func register(in layout: UICollectionViewCompositionalLayout) {
    for kind in BezierSectionDecorationKind.allCases {
      layout.register(
        BezierSectionBackgroundView.self,
        forDecorationViewOfKind: kind.elementKind
      )
    }
  }

  public static func makeSection(
    variant: BezierSectionVariant,
    numberOfItems: Int,
    showsLabel: Bool = false,
    componentTheme: BezierComponentTheme = .normal,
    layoutEnvironment: NSCollectionLayoutEnvironment
  ) -> NSCollectionLayoutSection {
    let appearance = variant.appearance

    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.backgroundColor = .clear
    configuration.showsSeparators = appearance.divider != nil

    if let divider = appearance.divider {
      var separatorConfiguration = UIListSeparatorConfiguration(listAppearance: .plain)
      separatorConfiguration.color = UIColor { traitCollection in
        let isDarkTrait = traitCollection.userInterfaceStyle == .dark
        let usesDarkPalette = componentTheme == .normal ? isDarkTrait : !isDarkTrait
        return usesDarkPalette ? divider.color.dark.uiColor : divider.color.light.uiColor
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
        elementKind: BezierSectionDecorationKind(
          variant: variant,
          componentTheme: componentTheme
        ).elementKind
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
      let kind = BezierSectionDecorationKind(elementKind: elementKind)
    else { return }
    self.variant = kind.variant
    self.componentTheme = kind.componentTheme
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
