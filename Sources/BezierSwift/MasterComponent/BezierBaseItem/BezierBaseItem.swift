//
//  BezierBaseItem.swift
//  BezierSwift
//

import UIKit

public final class BezierBaseItem: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierBaseItemSize = .medium {
    didSet { if oldValue != self.size { self.refreshSize() } }
  }

  public var title: String = "" {
    didSet { if oldValue != self.title { self.refreshText() } }
  }

  public var itemDescription: String? {
    didSet { if oldValue != self.itemDescription { self.refreshText() } }
  }

  public var onTap: (() -> Void)? {
    didSet { self.refreshInteraction() }
  }

  public var leadingContent: UIView? {
    didSet { self.updateSlot(container: self.leadingContainer, old: oldValue, new: self.leadingContent, fill: true) }
  }

  public var centerSlot: UIView? {
    didSet { self.updateSlot(container: self.centerSlotContainer, old: oldValue, new: self.centerSlot, fill: true) }
  }

  public var trailingContent: UIView? {
    didSet { self.updateSlot(container: self.trailingContainer, old: oldValue, new: self.trailingContent, fill: true) }
  }

  // MARK: - State

  public override var isHighlighted: Bool {
    didSet {
      if oldValue != self.isHighlighted {
        self.refreshAppearance()
        self.refreshPressScale()
      }
    }
  }

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierBaseItemConstant.slotSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.isUserInteractionEnabled = false
    return stackView
  }()

  private let leadingContainer = UIView()

  private let centerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierBaseItemConstant.centerLeadingInset,
      bottom: 0,
      trailing: 0
    )
    return stackView
  }()

  private let titleRowStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierBaseItemConstant.titleRowSpacing
    return stackView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let centerSlotContainer = UIView()
  private let titleSpacer = UIView()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  private let trailingContainer = UIView()

  // MARK: - Constraints

  private var leadingWidthConstraint: NSLayoutConstraint?
  private var leadingHeightConstraint: NSLayoutConstraint?
  private var minHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierBaseItemSize = .medium,
    title: String,
    description: String? = nil,
    onTap: (() -> Void)? = nil
  ) {
    self.size = size
    self.title = title
    self.itemDescription = description
    self.onTap = onTap
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
    self.layer.cornerRadius = BezierBaseItemConstant.cornerRadius
    self.layer.masksToBounds = true

    self.setUpLeading()
    self.setUpCenter()
    self.setUpTrailing()

    self.rootStackView.addArrangedSubview(self.leadingContainer)
    self.rootStackView.addArrangedSubview(self.centerStackView)
    self.rootStackView.addArrangedSubview(self.trailingContainer)
    self.addSubview(self.rootStackView)

    let margins = self.layoutMarginsGuide
    let minHeightConstraint = self.heightAnchor.constraint(
      greaterThanOrEqualToConstant: self.size.minHeight
    )
    self.minHeightConstraint = minHeightConstraint
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: margins.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
      minHeightConstraint,
    ])

    self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)

    self.refreshSize()
    self.refreshText()
    self.refreshInteraction()
    self.refreshEnabled()
    self.refreshAppearance()
  }

  private func setUpLeading() {
    self.leadingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.leadingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    let widthConstraint = self.leadingContainer.widthAnchor.constraint(
      equalToConstant: self.size.leadingLength
    )
    let heightConstraint = self.leadingContainer.heightAnchor.constraint(
      equalToConstant: self.size.leadingLength
    )
    self.leadingWidthConstraint = widthConstraint
    self.leadingHeightConstraint = heightConstraint
    NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    self.leadingContainer.isHidden = true
  }

  private func setUpCenter() {
    // center가 남은 가로 공간을 채워 trailing을 오른쪽 끝으로 밀도록 hugging을 최저로 낮춘다.
    let expandingPriority = UILayoutPriority(1)
    self.centerStackView.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.centerStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.centerSlotContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.centerSlotContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    // titleSpacer가 라벨 우측 여백을 흡수해 라벨을 HUG로 유지한다.
    self.titleSpacer.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.titleSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.titleRowStackView.addArrangedSubview(self.titleLabel)
    self.titleRowStackView.addArrangedSubview(self.centerSlotContainer)
    self.titleRowStackView.addArrangedSubview(self.titleSpacer)

    self.centerStackView.addArrangedSubview(self.titleRowStackView)
    self.centerStackView.addArrangedSubview(self.descriptionLabel)

    self.centerSlotContainer.isHidden = true
    self.descriptionLabel.isHidden = true
  }

  private func setUpTrailing() {
    self.trailingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.trailingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.trailingContainer.isHidden = true
  }

  // MARK: - Slot

  private func updateSlot(container: UIView, old: UIView?, new: UIView?, fill: Bool) {
    old?.removeFromSuperview()
    guard let new = new else {
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

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshSize() {
    self.leadingWidthConstraint?.constant = self.size.leadingLength
    self.leadingHeightConstraint?.constant = self.size.leadingLength
    self.minHeightConstraint?.constant = self.size.minHeight
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: self.size.verticalPadding,
      leading: BezierBaseItemConstant.horizontalPadding,
      bottom: self.size.verticalPadding,
      trailing: BezierBaseItemConstant.horizontalPadding
    )
    self.refreshText()
    self.setNeedsLayout()
  }

  private func refreshText() {
    if !self.title.isEmpty {
      self.titleLabel.attributedText = BezierBaseItemConstant.titleTypography.attributedString(
        self,
        text: self.title,
        semanticColorToken: BezierBaseItemConstant.titleColor,
        alignment: .left,
        lineBreakMode: .byTruncatingTail
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    // SPEC §2: description은 medium·large만 지원 (small variant엔 description 노드 자체가 없음)
    if self.size != .small, let itemDescription = self.itemDescription, !itemDescription.isEmpty {
      self.descriptionLabel.attributedText = BezierBaseItemConstant.descriptionTypography.attributedString(
        self,
        text: itemDescription,
        semanticColorToken: BezierBaseItemConstant.descriptionColor,
        alignment: .left,
        lineBreakMode: .byWordWrapping
      )
      self.descriptionLabel.isHidden = false
    } else {
      self.descriptionLabel.attributedText = nil
      self.descriptionLabel.isHidden = true
    }
  }

  private static let pressReleaseAnimationKey = "bezierBaseItemPressRelease"

  private func refreshInteraction() {
    self.isUserInteractionEnabled = self.onTap != nil
    if self.onTap == nil {
      self.rootStackView.layer.removeAnimation(forKey: Self.pressReleaseAnimationKey)
      self.rootStackView.transform = .identity
    }
  }

  // 콘텐츠(rootStackView)만 press scale — 배경(self)은 full-size 유지.
  // ch-desk-ios ListItemPressFeedback와 동일: press-in 축소 → release 시 오버슈트 복귀.
  private func refreshPressScale() {
    guard self.onTap != nil, !UIAccessibility.isReduceMotionEnabled else {
      self.rootStackView.layer.removeAnimation(forKey: Self.pressReleaseAnimationKey)
      self.rootStackView.transform = .identity
      return
    }

    if self.isHighlighted {
      self.rootStackView.layer.removeAnimation(forKey: Self.pressReleaseAnimationKey)
      UIView.animate(
        withDuration: BezierBaseItemConstant.pressInDuration,
        delay: 0,
        options: [.curveEaseInOut, .beginFromCurrentState]
      ) {
        self.rootStackView.transform = CGAffineTransform(
          scaleX: BezierBaseItemConstant.pressScale,
          y: BezierBaseItemConstant.pressScale
        )
      }
    } else {
      self.rootStackView.transform = .identity
      let keyframe = CAKeyframeAnimation(keyPath: "transform.scale")
      keyframe.values = BezierBaseItemConstant.releaseScaleValues
      keyframe.keyTimes = BezierBaseItemConstant.releaseScaleKeyTimes
      keyframe.duration = BezierBaseItemConstant.releaseDuration
      keyframe.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      keyframe.isRemovedOnCompletion = true
      self.rootStackView.layer.add(keyframe, forKey: Self.pressReleaseAnimationKey)
    }
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierBaseItemConstant.disabledOpacity
  }

  private func refreshAppearance() {
    self.backgroundColor = self.isHighlighted
      ? BezierBaseItemConstant.pressedBackgroundColor.palette(self)
      : .clear
    self.refreshText()
  }

  // MARK: - Action

  @objc private func handleTap() {
    self.onTap?()
  }
}
