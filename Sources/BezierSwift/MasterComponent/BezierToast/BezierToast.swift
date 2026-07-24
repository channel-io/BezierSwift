//
//  BezierToast.swift
//  BezierSwift
//

import UIKit

public final class BezierToast: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  // Toast는 항상 dark 표면. colorTheme을 .dark 상수로 고정하여 token.palette(self)가 dark 값을 해석하게 한다.
  public var colorTheme: BezierColorTheme { .dark }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var preset: BezierToastPreset = .info {
    didSet {
      if oldValue != self.preset {
        self.refreshContent()
        self.refreshLayout()
      }
    }
  }

  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = BezierToastSpec.iconTextGap
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.setContentHuggingPriority(.required, for: .horizontal)
    imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = BezierToastSpec.textLineLimit
    label.lineBreakMode = .byTruncatingTail
    return label
  }()

  // MARK: - Constraints

  private var stackLeadingConstraint: NSLayoutConstraint?
  private var stackTrailingConstraint: NSLayoutConstraint?
  private var iconWidthConstraint: NSLayoutConstraint?
  private var iconHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(preset: BezierToastPreset = .info, title: String? = nil) {
    self.preset = preset
    self.title = title
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
    self.overrideUserInterfaceStyle = .dark

    self.contentStackView.addArrangedSubview(self.iconImageView)
    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.addSubview(self.contentStackView)

    let hPadding = self.horizontalPadding
    let stackLeading = self.contentStackView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: hPadding
    )
    let stackTrailing = self.contentStackView.trailingAnchor.constraint(
      equalTo: self.trailingAnchor,
      constant: -hPadding
    )
    let iconWidth = self.iconImageView.widthAnchor.constraint(equalToConstant: BezierToastSpec.iconLength)
    let iconHeight = self.iconImageView.heightAnchor.constraint(equalToConstant: BezierToastSpec.iconLength)

    NSLayoutConstraint.activate([
      stackLeading,
      stackTrailing,
      self.contentStackView.topAnchor.constraint(
        equalTo: self.topAnchor,
        constant: BezierToastSpec.verticalPadding
      ),
      self.contentStackView.bottomAnchor.constraint(
        equalTo: self.bottomAnchor,
        constant: -BezierToastSpec.verticalPadding
      ),
      iconWidth,
      iconHeight,
      self.widthAnchor.constraint(lessThanOrEqualToConstant: BezierToastSpec.maxWidth),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierToastSpec.minHeight),
    ])

    self.stackLeadingConstraint = stackLeading
    self.stackTrailingConstraint = stackTrailing
    self.iconWidthConstraint = iconWidth
    self.iconHeightConstraint = iconHeight

    self.refreshAppearance()
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = self.bounds.height / 2
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  private var horizontalPadding: CGFloat {
    self.preset.icon == nil ? BezierToastSpec.horizontalPaddingTextOnly : BezierToastSpec.horizontalPaddingWithIcon
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.stackLeadingConstraint?.constant = self.horizontalPadding
    self.stackTrailingConstraint?.constant = -self.horizontalPadding
    self.setNeedsLayout()
  }

  private func refreshContent() {
    if let icon = self.preset.icon {
      self.iconImageView.image = icon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.iconImageView.tintColor = self.preset.iconColor.palette(self)
      self.iconImageView.isHidden = false
      self.iconWidthConstraint?.constant = BezierToastSpec.iconLength
      self.iconHeightConstraint?.constant = BezierToastSpec.iconLength
    } else {
      self.iconImageView.image = nil
      self.iconImageView.isHidden = true
      self.iconWidthConstraint?.constant = 0
      self.iconHeightConstraint?.constant = 0
    }

    if let title = self.title, !title.isEmpty {
      self.titleLabel.attributedText = BezierToastSpec.typographyToken.attributedString(
        self,
        text: title,
        semanticColorToken: BezierToastSpec.textToken,
        alignment: .left
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }
  }

  private func refreshAppearance() {
    self.backgroundColor = BezierToastSpec.backgroundToken.palette(self)
    self.refreshContent()
  }
}
