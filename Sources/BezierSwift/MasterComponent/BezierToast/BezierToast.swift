//
//  BezierToast.swift
//  BezierSwift
//

import UIKit

/// 짧은 비차단 알림 토스트 컴포넌트 (UIKit/UIView). 확인이 꼭 필요한 오류·영구 메시지는 `BezierBanner`를 쓴다. SwiftUI에서는 `View.bezierToast(param:)` modifier를 사용한다.
public final class BezierToast: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  // Toast 표면은 앱 테마의 반전이다(웹 InvertedThemeProvider 대응). 다른 컴포넌트와 달리 기본값이 .inverted다.
  public var componentTheme: BezierComponentTheme = .inverted {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 토스트의 표시 유형. 기본값 `.info`.
  public var preset: BezierToastPreset = .info {
    didSet {
      if oldValue != self.preset {
        self.refreshContent()
        self.refreshLayout()
      }
    }
  }

  /// 토스트에 표시할 텍스트. 기본값 `nil`.
  public var title: String? {
    didSet { if oldValue != self.title { self.refreshContent() } }
  }

  // MARK: - Subviews

  private let blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

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

  private let titleContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = BezierToastSpec.textLineLimit
    label.lineBreakMode = .byTruncatingTail
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Constraints

  private var stackLeadingConstraint: NSLayoutConstraint?
  private var stackTrailingConstraint: NSLayoutConstraint?
  private var iconWidthConstraint: NSLayoutConstraint?
  private var iconHeightConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// 표시 유형과 텍스트를 지정해 토스트를 생성한다.
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
    self.layer.cornerRadius = BezierToastSpec.cornerRadius.rawValue
    // SwiftUI 쌍(applyBezierCornerRadius)이 .continuous 스타일로 클리핑하므로 UIKit도 곡률을 맞춘다.
    self.layer.cornerCurve = .continuous

    self.addSubview(self.blurView)

    self.titleContainerView.addSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.iconImageView)
    self.contentStackView.addArrangedSubview(self.titleContainerView)
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
      self.blurView.topAnchor.constraint(equalTo: self.topAnchor),
      self.blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
      self.titleLabel.topAnchor.constraint(
        equalTo: self.titleContainerView.topAnchor,
        constant: BezierToastSpec.textVerticalPadding
      ),
      self.titleLabel.bottomAnchor.constraint(
        equalTo: self.titleContainerView.bottomAnchor,
        constant: -BezierToastSpec.textVerticalPadding
      ),
      self.titleLabel.leadingAnchor.constraint(equalTo: self.titleContainerView.leadingAnchor),
      self.titleLabel.trailingAnchor.constraint(equalTo: self.titleContainerView.trailingAnchor),
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
      self.iconImageView.tintColor = self.preset.iconColor?.palette(self)
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
      var attributes = BezierToastSpec.typographyToken.attributes(
        self,
        semanticColorToken: BezierToastSpec.textToken,
        alignment: .left
      )
      // 헬퍼에 lineBreakMode를 인자로 넘기면 .byWordWrapping일 때만 붙는 한글 줄바꿈 전략을 잃는다 —
      // 전략은 남긴 채 말줄임만 켠다 (BezierTextArea와 동일 패턴). attributedText의 paragraphStyle이
      // label.lineBreakMode보다 우선하므로 여기서 켜지 않으면 2줄 초과가 "…" 없이 하드 클립된다.
      if let paragraphStyle = (attributes[.paragraphStyle] as? NSParagraphStyle)?
        .mutableCopy() as? NSMutableParagraphStyle {
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributes[.paragraphStyle] = paragraphStyle
      }
      self.titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
      self.titleContainerView.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleContainerView.isHidden = true
    }
  }

  private func refreshAppearance() {
    // 배경은 반투명 glass fill 아래에 backdrop blur가 깔리는 구조라(SPEC §3) fill을
    // 뷰 자신이 아니라 blur 위 contentView에 칠한다.
    self.blurView.contentView.backgroundColor = BezierToastSpec.backgroundToken.palette(self)
    // UIBlurEffect는 semantic 토큰을 받지 못하므로 palette와 동일한
    // (componentTheme, colorTheme) 스위치로 반전을 직접 해석한다.
    switch (self.componentTheme, self.colorTheme) {
    case (.normal, .light), (.inverted, .dark):
      self.blurView.effect = UIBlurEffect(style: .systemThickMaterialLight)
    case (.normal, .dark), (.inverted, .light):
      self.blurView.effect = UIBlurEffect(style: .systemThickMaterialDark)
    }
    self.refreshContent()
  }
}
