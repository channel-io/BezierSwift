//
//  BezierSection.swift
//  BezierSwift
//

import UIKit

public final class BezierSection: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var variant: BezierSectionVariant = .solid {
    didSet { if oldValue != self.variant { self.refreshVariant() } }
  }

  public var labelText: String? {
    didSet { if oldValue != self.labelText { self.refreshLabel() } }
  }

  public var labelColor: BezierSectionLabelColor = .neutralDark {
    didSet { if oldValue != self.labelColor { self.sectionLabel.color = self.labelColor } }
  }

  public var labelLeadingContent: UIView? {
    didSet { self.sectionLabel.leadingContent = self.labelLeadingContent }
  }

  public var labelTrailingContent: UIView? {
    didSet { self.sectionLabel.trailingContent = self.labelTrailingContent }
  }

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

  public func setItems(_ items: [UIView]) {
    self.items = items
    self.rebuildRows()
  }

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
