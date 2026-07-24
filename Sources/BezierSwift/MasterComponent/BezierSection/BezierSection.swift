//
//  BezierSection.swift
//  BezierSwift
//

import UIKit

/// 관련 리스트 항목을 의미 단위로 묶는 섹션 컨테이너 (UIKit). 헤더(`BezierSectionLabel`) + 행 목록으로 구성되며 행에는 `BezierSectionItem`을 넣는다. 정적 소수 항목용이며, 항목이 많은 동적 리스트는 `BezierSectionLayout`(컴포지셔널 레이아웃)을 쓴다. SwiftUI에서는 `SUBezierSection`을 사용한다.
public final class BezierSection: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.sectionLabel.componentTheme = self.componentTheme
      self.itemsStackView.arrangedSubviews
        .compactMap { $0 as? BezierSectionRowDivider }
        .forEach { $0.componentTheme = self.componentTheme }
      self.refreshAppearance()
    }
  }

  // MARK: - Public Properties

  /// 섹션 스타일(solid/card) (기본값 `.solid`).
  public var variant: BezierSectionVariant = .solid {
    didSet { if oldValue != self.variant { self.refreshVariant() } }
  }

  /// 헤더 라벨 텍스트. `nil`이면 헤더를 숨긴다 (기본값 `nil`).
  public var labelText: String? {
    didSet { if oldValue != self.labelText { self.refreshLabel() } }
  }

  /// 헤더 라벨 색(neutralDark/neutralLight) (기본값 `.neutralDark`).
  public var labelColor: BezierSectionLabelColor = .neutralDark {
    didSet { if oldValue != self.labelColor { self.sectionLabel.color = self.labelColor } }
  }

  /// 헤더 라벨 좌측 슬롯에 넣을 20×20 뷰(아이콘 등). `nil`이면 비운다.
  public var labelLeadingContent: UIView? {
    didSet { self.sectionLabel.leadingContent = self.labelLeadingContent }
  }

  /// 헤더 라벨 우측 슬롯에 넣을 액션 뷰(높이 20). `nil`이면 비운다.
  public var labelTrailingContent: UIView? {
    didSet { self.sectionLabel.trailingContent = self.labelTrailingContent }
  }

  /// 현재 표시 중인 행 뷰 배열. 읽기 전용이며 `setItems(_:)`/`addItem(_:)`으로 변경한다.
  public private(set) var items: [UIView] = []

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierSectionConstant.labelToContentSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let sectionLabel = BezierSectionLabel(text: "")

  private let chromeView: UIView = {
    let view = UIView()
    view.layer.masksToBounds = true
    view.insetsLayoutMarginsFromSafeArea = false
    return view
  }()

  private let itemsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  // MARK: - Init

  /// variant·헤더 텍스트/색·초기 행 배열로 섹션을 만든다. 행은 이후 `setItems(_:)`/`addItem(_:)`으로 교체·추가할 수 있다.
  public init(
    variant: BezierSectionVariant = .solid,
    labelText: String? = nil,
    labelColor: BezierSectionLabelColor = .neutralDark,
    items: [UIView] = []
  ) {
    self.variant = variant
    self.labelText = labelText
    self.labelColor = labelColor
    self.items = items
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false

    self.chromeView.addSubview(self.itemsStackView)
    let chromeMargins = self.chromeView.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.itemsStackView.topAnchor.constraint(equalTo: chromeMargins.topAnchor),
      self.itemsStackView.leadingAnchor.constraint(equalTo: chromeMargins.leadingAnchor),
      self.itemsStackView.trailingAnchor.constraint(equalTo: chromeMargins.trailingAnchor),
      self.itemsStackView.bottomAnchor.constraint(equalTo: chromeMargins.bottomAnchor),
    ])

    self.rootStackView.addArrangedSubview(self.sectionLabel)
    self.rootStackView.addArrangedSubview(self.chromeView)
    self.addSubview(self.rootStackView)
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.sectionLabel.color = self.labelColor
    self.refreshLabel()
    self.refreshVariant()
  }

  // MARK: - Items

  /// 행 배열을 통째로 교체하고 divider를 다시 그린다.
  public func setItems(_ items: [UIView]) {
    self.items = items
    self.rebuildRows()
  }

  /// 행을 끝에 하나 추가하고 divider를 다시 그린다.
  public func addItem(_ item: UIView) {
    self.items.append(item)
    self.rebuildRows()
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshVariant() {
    let contentInsets = self.variant.appearance.contentInsets
    self.chromeView.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: contentInsets.top,
      leading: contentInsets.leading,
      bottom: contentInsets.bottom,
      trailing: contentInsets.trailing
    )
    self.rebuildRows()
    self.refreshAppearance()
  }

  private func refreshLabel() {
    if let labelText = self.labelText {
      self.sectionLabel.text = labelText
      self.sectionLabel.isHidden = false
    } else {
      self.sectionLabel.text = ""
      self.sectionLabel.isHidden = true
    }
  }

  private func rebuildRows() {
    self.itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    let divider = self.variant.appearance.divider
    for (index, item) in self.items.enumerated() {
      self.itemsStackView.addArrangedSubview(item)

      if let divider, index < self.items.count - 1 {
        let dividerView = BezierSectionRowDivider()
        dividerView.componentTheme = self.componentTheme
        dividerView.apply(divider)
        self.itemsStackView.addArrangedSubview(dividerView)
      }
    }
  }

  private func refreshAppearance() {
    let appearance = self.variant.appearance

    if let backgroundColor = appearance.backgroundColor {
      self.chromeView.backgroundColor = backgroundColor.palette(self)
    } else {
      self.chromeView.backgroundColor = .clear
    }
    self.chromeView.layer.cornerRadius = appearance.cornerRadius

    if let border = appearance.border {
      self.chromeView.layer.borderWidth = border.width
      self.chromeView.layer.borderColor = border.color.palette(self).cgColor
    } else {
      self.chromeView.layer.borderWidth = 0
      self.chromeView.layer.borderColor = nil
    }
  }
}
