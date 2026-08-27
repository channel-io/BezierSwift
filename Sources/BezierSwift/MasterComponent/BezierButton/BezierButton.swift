//
//  BezierButton.swift
//  BezierSwift
//

import UIKit

/// Bezier 디자인 시스템 V3 버튼 (UIKit). `size`·`variant`·`semantic` 세 축으로 형태를 지정하고,
/// 아이콘과 로딩 상태를 지원한다. SwiftUI에서는 `SUBezierButton`을 사용한다.
///
/// ## 폭 배치 — hug / fill
///
/// 폭을 정하는 프로퍼티는 없다(`resizing`·`isFullWidth` 같은 축을 두지 않는다). 버튼은
/// 콘텐츠 크기(``intrinsicContentSize``)를 기본 폭으로 갖고, **늘릴지 말지는 컨테이너가
/// 제약으로 정한다.** 둘의 차이는 "폭을 확정하는 제약을 걸었는가" 하나뿐이다.
///
/// | 목적 | 거는 제약 | 쓰는 곳 |
/// |---|---|---|
/// | **hug** — 콘텐츠 폭 | 폭을 확정하지 않는다. `centerX`(또는 `leading =`) + `leading >=` / `trailing <=`, 혹은 세로 `UIStackView`의 `alignment = .center` | 카드·리스트 행 안의 보조 액션 (`.small` / `.outlined`) |
/// | **fill** — 컨테이너 폭 | 폭을 확정한다. `leading =` + `trailing =`, 세로 `UIStackView`의 `alignment = .fill`, 가로 `UIStackView`의 `distribution = .fillEqually` | 하단 CTA·모달 버튼 (`.large` / `.filled`) |
///
/// ```swift
/// // hug — 셀 폭이 얼마든 "더 보기"만큼만 차지한다
/// NSLayoutConstraint.activate([
///   button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
///   button.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 16),
///   button.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -16),
/// ])
///
/// // fill — 컨테이너 폭을 채운다
/// NSLayoutConstraint.activate([
///   button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
///   button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
/// ])
/// ```
///
/// hug 쪽에서 부등호 제약을 **빠뜨리면** 안 된다. 최소 폭(`size.minWidth`)만 남아 컨테이너가
/// 좁을 때 라벨이 잘린다. 반대로 fill을 원하면서 부등호만 걸면 콘텐츠 폭으로 hug 된다.
///
/// `SUBezierButton`(SwiftUI)의 public API는 hug 전용이다 — fill은 모듈 내부 전용 축이라,
/// SwiftUI에서 폭을 채워야 하면 컨테이너 쪽에서 레이아웃을 잡는다.
public final class BezierButton: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 버튼 크기. 기본값 `.medium`.
  public var size: BezierButtonSize = .medium {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  /// 시각적 강조도. 기본값 `.filled`.
  public var variant: BezierButtonVariant = .filled {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  /// 의미론적 색상 역할. 기본값 `.primary`.
  public var semantic: BezierButtonSemantic = .primary {
    didSet { if oldValue != self.semantic { self.refreshAppearance() } }
  }

  /// 버튼 라벨. `nil`이거나 빈 문자열이면 텍스트를 숨긴다.
  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  /// 라벨 왼쪽에 표시되는 아이콘. `nil`이면 숨긴다.
  public var leadingIcon: UIImage? {
    didSet { self.refreshContent() }
  }

  /// 라벨 오른쪽에 표시되는 아이콘. `nil`이면 숨긴다.
  public var trailingIcon: UIImage? {
    didSet { self.refreshContent() }
  }

  /// `true`면 스피너를 표시하고 콘텐츠를 숨기며 탭을 차단한다. 비동기 작업 트리거 시 사용.
  public var isLoading: Bool = false {
    didSet { if oldValue != self.isLoading { self.refreshLoading() } }
  }

  public override var isEnabled: Bool {
    didSet { if oldValue != self.isEnabled { self.refreshEnabled() } }
  }

  public override var isHighlighted: Bool {
    didSet { self.refreshHighlight() }
  }

  // MARK: - Subviews

  private let backgroundView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.isUserInteractionEnabled = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let leadingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let trailingImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: BezierButtonPaddedLabel = {
    let label = BezierButtonPaddedLabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()

  private let spinner: BezierSpinner = {
    let spinner = BezierSpinner()
    spinner.isHidden = true
    return spinner
  }()

  // MARK: - Layout Constraints (mutable)

  private var heightConstraint: NSLayoutConstraint?
  private var minWidthConstraint: NSLayoutConstraint?
  private var leadingImageWidthConstraint: NSLayoutConstraint?
  private var leadingImageHeightConstraint: NSLayoutConstraint?
  private var trailingImageWidthConstraint: NSLayoutConstraint?
  private var trailingImageHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// 버튼을 생성한다. 콘텐츠(`title`·`leadingIcon`·`trailingIcon`)와 상태(`isLoading` 등)는
  /// 생성 후 property로 설정한다.
  public init(
    size: BezierButtonSize = .medium,
    variant: BezierButtonVariant = .filled,
    semantic: BezierButtonSemantic = .primary
  ) {
    self.size = size
    self.variant = variant
    self.semantic = semantic
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

    self.layer.masksToBounds = true
    self.layer.borderWidth = 0

    self.contentStackView.addArrangedSubview(self.leadingImageView)
    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.trailingImageView)

    self.addSubview(self.backgroundView)
    self.addSubview(self.contentStackView)
    self.addSubview(self.spinner)

    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.height)
    let minWidthConstraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.size.minWidth)

    let leadingImageWidthConstraint = self.leadingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let leadingImageHeightConstraint = self.leadingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)
    let trailingImageWidthConstraint = self.trailingImageView.widthAnchor.constraint(equalToConstant: self.size.iconLength)
    let trailingImageHeightConstraint = self.trailingImageView.heightAnchor.constraint(equalToConstant: self.size.iconLength)

    NSLayoutConstraint.activate([
      heightConstraint,
      minWidthConstraint,
      leadingImageWidthConstraint,
      leadingImageHeightConstraint,
      trailingImageWidthConstraint,
      trailingImageHeightConstraint,
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.contentStackView.leadingAnchor.constraint(
        greaterThanOrEqualTo: self.leadingAnchor,
        constant: self.size.horizontalPadding
      ).withIdentifier("contentLeading"),
      self.contentStackView.trailingAnchor.constraint(
        lessThanOrEqualTo: self.trailingAnchor,
        constant: -self.size.horizontalPadding
      ).withIdentifier("contentTrailing"),
      self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
      self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    ])

    self.heightConstraint = heightConstraint
    self.minWidthConstraint = minWidthConstraint
    self.leadingImageWidthConstraint = leadingImageWidthConstraint
    self.leadingImageHeightConstraint = leadingImageHeightConstraint
    self.trailingImageWidthConstraint = trailingImageWidthConstraint
    self.trailingImageHeightConstraint = trailingImageHeightConstraint

    self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    self.refreshLayout()
    self.refreshContent()
    self.refreshAppearance()
    self.refreshLoading()
    self.refreshEnabled()
  }

  // MARK: - Layout Update

  /// 콘텐츠(아이콘·라벨)와 `size`의 패딩·간격으로 계산한 자연 크기. 폭의 하한은 `size.minWidth`다.
  ///
  /// 배치는 컨테이너 책임이므로 이 값은 기본 폭일 뿐이다. 컨테이너가 `equalTo` 제약이나
  /// stretch 정렬(`UIStackView`의 `.fill`, `distribution = .fillEqually`)을 걸면 그쪽이 이긴다.
  ///
  /// `isLoading`은 반영하지 않는다 — 스피너로 전환될 때 버튼 폭이 흔들리면 안 되기 때문이다.
  public override var intrinsicContentSize: CGSize {
    var width = self.size.horizontalPadding * 2
    var visibleContentCount = 0

    if !self.leadingImageView.isHidden {
      width += self.size.iconLength
      visibleContentCount += 1
    }
    if !self.titleLabel.isHidden {
      width += self.titleLabel.intrinsicContentSize.width
      visibleContentCount += 1
    }
    if !self.trailingImageView.isHidden {
      width += self.size.iconLength
      visibleContentCount += 1
    }
    if visibleContentCount > 1 {
      width += self.size.contentSpacing * CGFloat(visibleContentCount - 1)
    }

    return CGSize(width: max(width, self.size.minWidth), height: self.size.height)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.heightConstraint?.constant = self.size.height
    self.minWidthConstraint?.constant = self.size.minWidth
    self.leadingImageWidthConstraint?.constant = self.size.iconLength
    self.leadingImageHeightConstraint?.constant = self.size.iconLength
    self.trailingImageWidthConstraint?.constant = self.size.iconLength
    self.trailingImageHeightConstraint?.constant = self.size.iconLength

    for constraint in self.constraints {
      if constraint.identifier == "contentLeading" {
        constraint.constant = self.size.horizontalPadding
      } else if constraint.identifier == "contentTrailing" {
        constraint.constant = -self.size.horizontalPadding
      }
    }

    self.contentStackView.spacing = self.size.contentSpacing
    self.titleLabel.contentInsets = UIEdgeInsets(
      top: 0,
      left: self.size.textHorizontalPadding,
      bottom: 0,
      right: self.size.textHorizontalPadding
    )
    self.spinner.size = self.size.spinnerSize
    self.refreshContent()
    self.setNeedsLayout()
  }

  private func refreshContent() {
    self.leadingImageView.image = self.leadingIcon?.withRenderingMode(.alwaysTemplate)
    self.leadingImageView.isHidden = self.leadingIcon == nil

    self.trailingImageView.image = self.trailingIcon?.withRenderingMode(.alwaysTemplate)
    self.trailingImageView.isHidden = self.trailingIcon == nil

    let foregroundToken = self.variant.foregroundToken(self.semantic)
    let foregroundColor = foregroundToken.palette(self)

    self.leadingImageView.tintColor = foregroundColor
    self.trailingImageView.tintColor = foregroundColor

    if let title = self.title, !title.isEmpty {
      let font = self.size.uiFont
      self.titleLabel.attributedText = title.applyBezierFont(
        height: self.size.lineHeight,
        font: font,
        color: foregroundColor,
        letterSpacing: 0,
        alignment: .center,
        baselineOffset: (self.size.lineHeight - font.lineHeight) / 2
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    self.invalidateIntrinsicContentSize()
  }

  private func refreshAppearance() {
    self.refreshBackground()

    if let borderToken = self.variant.borderToken(self.semantic) {
      self.layer.borderWidth = BezierButtonConstant.borderWidth
      self.layer.borderColor = borderToken.palette(self).cgColor
    } else {
      self.layer.borderWidth = 0
      self.layer.borderColor = nil
    }

    let foregroundColor = self.variant.foregroundToken(self.semantic).palette(self)
    self.leadingImageView.tintColor = foregroundColor
    self.trailingImageView.tintColor = foregroundColor
    self.spinner.fillColorOverride = self.variant.loadingSpinnerToken(self.semantic).palette(self)

    self.refreshContent()
  }

  private func refreshBackground() {
    if self.isHighlighted, self.isEnabled, !self.isLoading {
      self.backgroundView.backgroundColor = self.variant.pressedBackgroundToken(self.semantic).palette(self)
    } else if let backgroundToken = self.variant.backgroundToken(self.semantic) {
      self.backgroundView.backgroundColor = backgroundToken.palette(self)
    } else {
      self.backgroundView.backgroundColor = .clear
    }

    self.backgroundView.alpha = self.isLoading ? BezierButtonConstant.disabledOpacity : 1
  }

  private func refreshLoading() {
    self.isUserInteractionEnabled = !self.isLoading
    self.contentStackView.isHidden = self.isLoading
    self.spinner.isHidden = !self.isLoading
    self.refreshBackground()
  }

  private func refreshEnabled() {
    self.alpha = self.isEnabled ? 1 : BezierButtonConstant.disabledOpacity
  }

  private func refreshHighlight() {
    UIView.animate(withDuration: 0.1) {
      self.refreshBackground()
    }
  }

  // MARK: - Touch

  public override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
    guard !self.isLoading else { return }
    super.sendAction(action, to: target, for: event)
  }
}

// MARK: - Padded Label

final class BezierButtonPaddedLabel: UILabel {
  var contentInsets: UIEdgeInsets = .zero {
    didSet {
      self.invalidateIntrinsicContentSize()
      self.setNeedsDisplay()
    }
  }

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: self.contentInsets))
  }

  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(
      width: size.width + self.contentInsets.left + self.contentInsets.right,
      height: size.height + self.contentInsets.top + self.contentInsets.bottom
    )
  }
}

// MARK: - NSLayoutConstraint Identifier Helper

private extension NSLayoutConstraint {
  func withIdentifier(_ identifier: String) -> NSLayoutConstraint {
    self.identifier = identifier
    return self
  }
}
