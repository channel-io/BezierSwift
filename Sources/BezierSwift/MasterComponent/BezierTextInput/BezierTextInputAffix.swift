//
//  BezierTextInputAffix.swift
//  BezierSwift
//

import UIKit

/// `BezierTextInput`의 leadingContent/trailingContent 슬롯에 넣는 접사 텍스트 (UIKit). `https://`, `%`, `.channel.io`처럼 짧고 고정된 포맷 힌트에 쓴다. 단독 배치는 금지한다. SwiftUI에서는 `SUBezierTextInputAffix`를 사용한다.
public final class BezierTextInputAffix: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshText() }
  }

  // MARK: - Public Properties

  /// 표시할 접사 텍스트.
  public var text: String {
    didSet { if oldValue != self.text { self.refreshText() } }
  }

  // MARK: - Subviews

  private let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Init

  /// 접사 텍스트를 지정해 생성한다.
  public init(text: String) {
    self.text = text
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.text = ""
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.setContentHuggingPriority(.required, for: .horizontal)
    self.setContentCompressionResistancePriority(.required, for: .horizontal)

    self.addSubview(self.label)
    NSLayoutConstraint.activate([
      self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])

    self.refreshText()
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshText()
  }

  // MARK: - Refresh

  private func refreshText() {
    self.label.attributedText = BezierBaseInputConstant.affixTypography.attributedString(
      self,
      text: self.text,
      semanticColorToken: BezierBaseInputConstant.affixTextColor,
      alignment: .left,
      lineBreakMode: .byClipping
    )
  }
}
