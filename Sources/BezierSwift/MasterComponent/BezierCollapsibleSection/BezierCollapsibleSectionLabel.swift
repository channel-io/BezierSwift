//
//  BezierCollapsibleSectionLabel.swift
//  BezierSwift
//

import UIKit

// Figma Internal/CollapsibleSectionLabel — "Do not place standalone" 정책에 따라 internal.
final class BezierCollapsibleSectionLabel: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Internal Properties

  var text: String = "" {
    didSet { if oldValue != self.text { self.refreshText() } }
  }

  var color: BezierSectionLabelColor = .neutralDark {
    didSet { if oldValue != self.color { self.refreshAppearance() } }
  }

  var isOpen: Bool = true {
    didSet { if oldValue != self.isOpen { self.refreshChevron() } }
  }

  var leadingContent: UIView? {
    didSet { self.updateSlot(container: self.leadingContainer, old: oldValue, new: self.leadingContent) }
  }

  var trailingContent: UIView? {
    didSet { self.updateSlot(container: self.trailingContainer, old: oldValue, new: self.trailingContent) }
  }

  var onTap: (() -> Void)?

  // MARK: - State

  override var isHighlighted: Bool {
    didSet {
      if oldValue != self.isHighlighted {
        self.refreshPressed()
      }
    }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.isUserInteractionEnabled = false
    return stackView
  }()

  private let centerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionConstant.labelLeadingSpacing
    return stackView
  }()

  private let leadingContainer = UIView()

  private let textLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let chevronImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let spacerView = UIView()

  private let trailingContainer = UIView()

  // MARK: - Init

  init(text: String = "", color: BezierSectionLabelColor = .neutralDark) {
    self.text = text
    self.color = color
    super.init(frame: .zero)
    self.setUp()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = BezierSectionConstant.labelCornerRadius
    self.layer.masksToBounds = true
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierSectionConstant.labelHorizontalPadding,
      bottom: 0,
      trailing: BezierSectionConstant.labelHorizontalPadding
    )

    // spacer가 남는 가로 공간을 흡수해 텍스트·chevron이 좌측에 붙고 trailing이 우측 끝으로 밀린다.
    let expandingPriority = UILayoutPriority(1)
    self.spacerView.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.spacerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.centerStackView.setContentHuggingPriority(.required, for: .horizontal)
    self.textLabel.setContentHuggingPriority(.required, for: .horizontal)
    self.textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.leadingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.leadingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.chevronImageView.setContentHuggingPriority(.required, for: .horizontal)
    self.chevronImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.trailingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.trailingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)

    self.leadingContainer.isHidden = true
    self.trailingContainer.isHidden = true

    self.centerStackView.addArrangedSubview(self.leadingContainer)
    self.centerStackView.addArrangedSubview(self.textLabel)
    self.centerStackView.addArrangedSubview(self.chevronImageView)
    self.rootStackView.addArrangedSubview(self.centerStackView)
    self.rootStackView.addArrangedSubview(self.spacerView)
    self.rootStackView.addArrangedSubview(self.trailingContainer)
    self.addSubview(self.rootStackView)

    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
      self.rootStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierSectionConstant.labelHeight),
      self.spacerView.widthAnchor.constraint(
        greaterThanOrEqualToConstant: BezierSectionConstant.labelTrailingSpacing
      ),
      self.leadingContainer.widthAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelLeadingContentLength
      ),
      self.leadingContainer.heightAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelLeadingContentLength
      ),
      self.chevronImageView.widthAnchor.constraint(
        equalToConstant: BezierCollapsibleSectionConstant.chevronLength
      ),
      self.chevronImageView.heightAnchor.constraint(
        equalToConstant: BezierCollapsibleSectionConstant.chevronLength
      ),
      self.trailingContainer.heightAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelTrailingContentHeight
      ),
    ])

    self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)

    self.refreshText()
    self.refreshChevron()
  }

  // MARK: - Layout

  override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: BezierSectionConstant.labelHeight)
  }

  // MARK: - Slot

  private func updateSlot(container: UIView, old: UIView?, new: UIView?) {
    old?.removeFromSuperview()
    guard let new else {
      container.isHidden = true
      return
    }
    new.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(new)
    NSLayoutConstraint.activate([
      new.topAnchor.constraint(equalTo: container.topAnchor),
      new.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      new.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      new.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    container.isHidden = false
  }

  // MARK: - Trait

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.refreshText()
    self.refreshChevron()
    self.refreshPressed()
  }

  private func refreshText() {
    if !self.text.isEmpty {
      self.textLabel.attributedText = BezierSectionConstant.labelTypography.attributedString(
        self,
        text: self.text,
        semanticColorToken: self.color.textColor,
        alignment: .left,
        lineBreakMode: .byTruncatingTail
      )
      self.textLabel.isHidden = false
    } else {
      self.textLabel.attributedText = nil
      self.textLabel.isHidden = true
    }
  }

  private func refreshChevron() {
    self.chevronImageView.image = BezierCollapsibleSectionConstant
      .chevronIcon(isOpen: self.isOpen)
      .uiImage?
      .withRenderingMode(.alwaysTemplate)
    self.chevronImageView.tintColor = self.color.chevronColor.palette(self)
  }

  private func refreshPressed() {
    self.backgroundColor = self.isHighlighted
      ? BezierCollapsibleSectionConstant.labelPressedBackgroundColor.palette(self)
      : .clear
    BezierPressFeedback.apply(isPressed: self.isHighlighted, to: self.rootStackView)
  }

  // MARK: - Action

  @objc private func handleTap() {
    self.onTap?()
  }
}
