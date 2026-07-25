//
//  BezierSectionLabel.swift
//  BezierSwift
//

import UIKit

/// 섹션 헤더 bar (UIKit). 선택적 좌측 아이콘 · 텍스트 · 우측 액션 슬롯을 담는 `BezierSection` 전용 헤더다. 단독으로 쓰지 말고 항상 `BezierSection`의 헤더로 사용한다. SwiftUI에서는 `SUBezierSectionLabel`을 사용한다.
public final class BezierSectionLabel: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 헤더 텍스트. 빈 문자열이면 텍스트를 숨긴다 (기본값 `""`).
  public var text: String = "" {
    didSet { if oldValue != self.text { self.refreshText() } }
  }

  /// 라벨 색(neutralDark/neutralLight) (기본값 `.neutralDark`).
  public var color: BezierSectionLabelColor = .neutralDark {
    didSet { if oldValue != self.color { self.refreshText() } }
  }

  /// 좌측 20×20 슬롯 뷰(아이콘 등). `nil`이면 비운다.
  public var leadingContent: UIView? {
    didSet { self.updateSlot(container: self.leadingContainer, old: oldValue, new: self.leadingContent) }
  }

  /// 우측 슬롯 뷰(높이 20, 우측 정렬 액션). `nil`이면 비운다.
  public var trailingContent: UIView? {
    didSet { self.updateSlot(container: self.trailingContainer, old: oldValue, new: self.trailingContent) }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = BezierSectionConstant.labelTrailingSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let leadingCenterStackView: UIStackView = {
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

  private let trailingContainer = UIView()

  // MARK: - Init

  /// 라벨 텍스트와 색으로 헤더를 만든다. 좌우 슬롯은 생성 후 `leadingContent`/`trailingContent`로 채운다.
  public init(text: String, color: BezierSectionLabelColor = .neutralDark) {
    self.text = text
    self.color = color
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
    self.layer.cornerRadius = BezierSectionConstant.labelCornerRadius
    self.layer.masksToBounds = true
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierSectionConstant.labelHorizontalPadding,
      bottom: 0,
      trailing: BezierSectionConstant.labelHorizontalPadding
    )

    let expandingPriority = UILayoutPriority(1)
    self.leadingCenterStackView.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.leadingCenterStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.textLabel.setContentHuggingPriority(expandingPriority, for: .horizontal)
    self.textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.leadingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.leadingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.trailingContainer.setContentHuggingPriority(.required, for: .horizontal)
    self.trailingContainer.setContentCompressionResistancePriority(.required, for: .horizontal)

    self.leadingContainer.isHidden = true
    self.trailingContainer.isHidden = true

    self.leadingCenterStackView.addArrangedSubview(self.leadingContainer)
    self.leadingCenterStackView.addArrangedSubview(self.textLabel)
    self.rootStackView.addArrangedSubview(self.leadingCenterStackView)
    self.rootStackView.addArrangedSubview(self.trailingContainer)
    self.addSubview(self.rootStackView)

    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      self.rootStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      self.rootStackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
      self.rootStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierSectionConstant.labelHeight),
      self.leadingContainer.widthAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelLeadingContentLength
      ),
      self.leadingContainer.heightAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelLeadingContentLength
      ),
      self.trailingContainer.heightAnchor.constraint(
        equalToConstant: BezierSectionConstant.labelTrailingContentHeight
      ),
    ])

    self.refreshText()
  }

  // MARK: - Layout

  public override var intrinsicContentSize: CGSize {
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

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.refreshText()
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
}
