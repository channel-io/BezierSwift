//
//  BezierFormFieldErrorMessage.swift
//  BezierSwift
//

import UIKit

/// FormField 하단에 붙는 에러 메시지 행 (UIKit, internal). `BezierFormField`의 `errorText`가 설정될 때만 표시되며 단독 사용하지 않는다.
final class BezierFormFieldErrorMessage: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Properties

  var text: String = "" {
    didSet { if oldValue != self.text { self.refreshText() } }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = BezierFormConstant.errorMessageSpacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierFormConstant.errorMessageLeadingPadding,
      bottom: 0,
      trailing: 0
    )
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let iconBox = UIView()

  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = BezierFormConstant.errorIcon.uiImage?.withRenderingMode(.alwaysTemplate)
    return imageView
  }()

  private let textLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  // MARK: - Init

  init(text: String = "") {
    self.text = text
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
    self.layer.cornerRadius = BezierFormConstant.errorMessageCornerRadius

    self.iconBox.setContentHuggingPriority(.required, for: .horizontal)
    self.iconBox.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    self.textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
    self.iconBox.addSubview(self.iconImageView)
    self.rootStackView.addArrangedSubview(self.iconBox)
    self.rootStackView.addArrangedSubview(self.textLabel)
    self.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.iconBox.widthAnchor.constraint(equalToConstant: BezierFormConstant.errorIconLength),
      self.iconBox.heightAnchor.constraint(equalToConstant: BezierFormConstant.errorIconBoxHeight),
      self.iconImageView.widthAnchor.constraint(equalToConstant: BezierFormConstant.errorIconLength),
      self.iconImageView.heightAnchor.constraint(equalToConstant: BezierFormConstant.errorIconLength),
      self.iconImageView.centerXAnchor.constraint(equalTo: self.iconBox.centerXAnchor),
      self.iconImageView.centerYAnchor.constraint(equalTo: self.iconBox.centerYAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.refreshAppearance()
  }

  // MARK: - Trait

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.iconImageView.tintColor = BezierFormConstant.errorMessageIconColor.palette(self)
    self.refreshText()
  }

  private func refreshText() {
    self.textLabel.attributedText = BezierFormConstant.errorMessageTypography.attributedString(
      self,
      text: self.text,
      semanticColorToken: BezierFormConstant.errorMessageTextColor,
      alignment: .left
    )
  }
}
