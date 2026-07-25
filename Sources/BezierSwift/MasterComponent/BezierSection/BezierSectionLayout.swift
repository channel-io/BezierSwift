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

/// `UICollectionViewCompositionalLayout`로 항목이 많은 동적 섹션 리스트를 구성하기 위한 헬퍼 (UIKit 전용, Figma에 대응 없음). 섹션 배경·테두리·radius는 background decoration view로, 헤더(`BezierSectionLabel`)는 boundary supplementary로, 행 간 divider는 list separator로 그린다. 정적 소수 항목에는 `BezierSection`을 사용한다.
public enum BezierSectionLayout {
  /// 헤더(SectionLabel) boundary supplementary의 elementKind 문자열. 소비자가 supplementary 등록·dequeue에 쓴다.
  public static let labelElementKind = "BezierSectionLayout.label"

  /// 섹션 배경 decoration view 4종(variant × componentTheme)을 레이아웃에 등록한다. 레이아웃 생성 직후 반드시 호출해야 decoration dequeue 크래시를 막는다.
  public static func register(in layout: UICollectionViewCompositionalLayout) {
    for kind in BezierSectionDecorationKind.allCases {
      layout.register(
        BezierSectionBackgroundView.self,
        forDecorationViewOfKind: kind.elementKind
      )
    }
  }

  /// variant·행 수·헤더 표시 여부·테마에 맞는 `NSCollectionLayoutSection`을 만든다. `numberOfItems`는 마지막 행의 bottom separator를 숨겨 divider 수를 (행 수 − 1)로 맞추는 데 쓴다.
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

/// 컴포지셔널 레이아웃에서 섹션 배경(카드 chrome — 배경색·테두리·radius)을 그리는 decoration view (UIKit 내부용). `BezierSectionLayout`이 dequeue하며 소비자가 직접 생성할 필요는 없다.
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

/// 컴포지셔널 레이아웃 헤더에 `BezierSectionLabel`을 얹는 supplementary view. configure 시점에 `sectionLabel`을 설정해 헤더 내용을 채운다.
public final class BezierSectionLabelReusableView: UICollectionReusableView {
  /// 헤더로 표시되는 `BezierSectionLabel` 인스턴스. 텍스트·색·슬롯·componentTheme를 여기서 설정한다.
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
