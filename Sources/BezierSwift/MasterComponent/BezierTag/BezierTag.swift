//
//  BezierTag.swift
//  BezierSwift
//

import UIKit

public final class BezierTag: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var size: BezierTagSize = .small {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  public var variant: BezierTagVariant = .default {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  public var label: String? {
    didSet { if oldValue != self.label { self.refreshContent() } }
  }

  /// Trailing 위치에 표시되는 close 아이콘 (SPEC §6). 기본값은 `BezierIcon.cancelSmall`.
  /// `onDelete` 핸들러가 설정되어 있을 때만 표시된다.
  public var closeIcon: UIImage? = BezierIcon.cancelSmall.uiImage {
    didSet { self.refreshContent() }
  }

  /// `onDelete` 콜백이 설정되어 있으면 trailing close 아이콘이 노출되고, 탭 시 호출된다.
  /// `nil`이면 읽기 전용.
  public var onDelete: (() -> Void)? {
    didSet { self.refreshContent() }
  }

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.isUserInteractionEnabled = true
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let titleLabel: BezierTagPaddedLabel = {
    let label = BezierTagPaddedLabel()
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()

  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentMode = .scaleAspectFit
    button.imageView?.contentMode = .scaleAspectFit
    button.addTarget(self, action: #selector(self.handleCloseTap), for: .touchUpInside)
    return button
  }()

  // MARK: - Layout Constraints

  private var heightConstraint: NSLayoutConstraint?
  private var contentLeadingConstraint: NSLayoutConstraint?
  private var contentTrailingConstraint: NSLayoutConstraint?
  private var closeButtonWidthConstraint: NSLayoutConstraint?
  private var closeButtonHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    size: BezierTagSize = .small,
    variant: BezierTagVariant = .default
  ) {
    self.size = size
    self.variant = variant
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

    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.closeButton)

    self.addSubview(self.contentStackView)

    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.height)
    let contentLeadingConstraint = self.contentStackView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: self.size.horizontalPadding
    )
    let contentTrailingConstraint = self.contentStackView.trailingAnchor.constraint(
      equalTo: self.trailingAnchor,
      constant: -self.size.horizontalPadding
    )
    let closeButtonWidthConstraint = self.closeButton.widthAnchor.constraint(
      equalToConstant: self.size.closeIconLength
    )
    let closeButtonHeightConstraint = self.closeButton.heightAnchor.constraint(
      equalToConstant: self.size.closeIconLength
    )

    NSLayoutConstraint.activate([
      heightConstraint,
      contentLeadingConstraint,
      contentTrailingConstraint,
      closeButtonWidthConstraint,
      closeButtonHeightConstraint,
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.heightConstraint = heightConstraint
    self.contentLeadingConstraint = contentLeadingConstraint
    self.contentTrailingConstraint = contentTrailingConstraint
    self.closeButtonWidthConstraint = closeButtonWidthConstraint
    self.closeButtonHeightConstraint = closeButtonHeightConstraint

    self.refreshLayout()
    self.refreshAppearance()
  }

  // MARK: - Layout Update

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
    self.contentLeadingConstraint?.constant = self.size.horizontalPadding
    self.contentTrailingConstraint?.constant = -self.size.horizontalPadding

    self.titleLabel.contentInsets = UIEdgeInsets(
      top: 0,
      left: self.size.textHorizontalPadding,
      bottom: 0,
      right: self.size.textHorizontalPadding
    )

    self.refreshContent()
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshContent() {
    let foregroundColor = self.variant.foregroundToken.palette(self)

    if let label = self.label, !label.isEmpty {
      // TYPO-MIGRATION: Figma raw 값을 직접 사용. 추후 BTSemanticToken으로 통합 예정 (BezierTagSpec.swift 참고).
      let font = UIFont.systemFont(
        ofSize: self.size.fontSize,
        weight: self.size.fontWeight.uiKitWeight
      )
      self.titleLabel.attributedText = label.applyBezierFont(
        height: self.size.lineHeight,
        font: font,
        color: foregroundColor,
        letterSpacing: self.size.letterSpacing,
        alignment: .center
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    // closeIcon이 nil이면 onDelete가 설정되어 있어도 빈 탭 영역이 노출되므로 close button을 숨긴다.
    let showCloseButton = self.onDelete != nil && self.closeIcon != nil
    self.closeButton.isHidden = !showCloseButton
    // UIStackView가 hidden된 arranged subview를 0pt로 압축할 때 required 고정 제약과 충돌하지 않도록,
    // close button의 width/height constant도 hidden 여부에 따라 함께 전환한다.
    let closeLength = showCloseButton ? self.size.closeIconLength : 0
    self.closeButtonWidthConstraint?.constant = closeLength
    self.closeButtonHeightConstraint?.constant = closeLength
    if showCloseButton {
      self.closeButton.setImage(self.closeIcon?.withRenderingMode(.alwaysTemplate), for: .normal)
      self.closeButton.tintColor = foregroundColor
    }
  }

  private func refreshAppearance() {
    self.backgroundColor = self.variant.backgroundToken.palette(self)
    self.refreshContent()
  }

  // MARK: - Actions

  @objc private func handleCloseTap() {
    self.onDelete?()
  }
}

// MARK: - Padded Label

final class BezierTagPaddedLabel: UILabel {
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
