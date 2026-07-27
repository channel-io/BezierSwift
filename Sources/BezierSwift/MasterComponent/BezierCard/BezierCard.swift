//
//  BezierCard.swift
//  BezierSwift
//

import UIKit

/// 콘텐츠를 하나의 독립 묶음으로 감싸는 카드 컨테이너 (UIKit). `surface` 배경 + 1pt `borderNeutral` 테두리 + radius 16의 외형만 소유하고 내용은 `content` 슬롯에 위임한다. 너비는 소비자 제약으로 정하고 높이는 콘텐츠에 맞게 늘어난다. SwiftUI에서는 `SUBezierCard`를 사용한다.
public final class BezierCard: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 카드 안(contentSlot)에 넣을 뷰. 패딩 안쪽을 가득 채우며 `nil`이면 비운다 (기본값 `nil`).
  public var content: UIView? {
    didSet { self.updateContent(old: oldValue, new: self.content) }
  }

  // MARK: - Init

  /// 콘텐츠 뷰로 카드를 만든다. 콘텐츠는 이후 `content`로 교체할 수 있다.
  public init(content: UIView? = nil) {
    self.content = content
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
    self.layer.cornerRadius = BezierCardConstant.cornerRadius
    self.layer.borderWidth = BezierCardConstant.borderWidth
    self.insetsLayoutMarginsFromSafeArea = false
    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: BezierCardConstant.verticalPadding,
      leading: BezierCardConstant.horizontalPadding,
      bottom: BezierCardConstant.verticalPadding,
      trailing: BezierCardConstant.horizontalPadding
    )

    self.updateContent(old: nil, new: self.content)
    self.refreshAppearance()
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func updateContent(old: UIView?, new: UIView?) {
    old?.removeFromSuperview()
    guard let new = new else { return }

    new.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(new)
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      new.topAnchor.constraint(equalTo: margins.topAnchor),
      new.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      new.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      new.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
    ])
  }

  private func refreshAppearance() {
    self.backgroundColor = BezierCardConstant.backgroundColor.palette(self)
    self.layer.borderColor = BezierCardConstant.borderColor.palette(self).cgColor
  }
}
