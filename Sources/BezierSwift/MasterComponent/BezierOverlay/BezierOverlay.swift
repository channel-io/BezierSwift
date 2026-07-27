//
//  BezierOverlay.swift
//  BezierSwift
//

import UIKit

/// floating UI를 직접 구성할 때 쓰는 범용 오버레이 컨테이너 (UIKit). `surfaceHighest` 배경·32pt 라운드·elevation 그림자를 가진 240pt 고정 폭 카드로, `content` 슬롯에 임의 뷰를 담는다. 자식 구조가 정해진 목적형 오버레이(드롭다운 목록 등)로 표현할 수 없는 floating UI에만 쓰며, 열림/닫힘·위치 계산(backdrop 없는 앵커형 팝오버 배치)은 사용처 책임이다. SwiftUI에서는 `SUBezierOverlay`를 사용한다.
public final class BezierOverlay: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// content 슬롯에 담을 뷰. 교체 시 이전 뷰는 제거되며 `nil`이면 슬롯을 비운다 (기본값 `nil`). 슬롯 폭은 220pt(= 240 − 10×2)로 고정되고 높이는 콘텐츠에 맞게 늘어난다.
  public var content: UIView? {
    didSet {
      guard oldValue !== self.content else { return }
      oldValue?.removeFromSuperview()
      if let content = self.content {
        self.attachContent(content)
      }
    }
  }

  // MARK: - Init

  /// content 슬롯 뷰를 지정해 오버레이를 만든다.
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
    self.layer.cornerRadius = BezierOverlayConstant.cornerRadius
    // elevation 그림자를 렌더하려면 masksToBounds = false. 배경은 layer.cornerRadius로 둥글게 유지된다.
    self.layer.masksToBounds = false
    self.insetsLayoutMarginsFromSafeArea = false

    self.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: BezierOverlayConstant.padding,
      leading: BezierOverlayConstant.padding,
      bottom: BezierOverlayConstant.padding,
      trailing: BezierOverlayConstant.padding
    )
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: BezierOverlayConstant.width),
      self.heightAnchor.constraint(greaterThanOrEqualToConstant: BezierOverlayConstant.padding * 2),
    ])

    if let content = self.content {
      self.attachContent(content)
    }
    self.refreshAppearance()
  }

  private func attachContent(_ content: UIView) {
    content.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(content)
    let margins = self.layoutMarginsGuide
    NSLayoutConstraint.activate([
      content.topAnchor.constraint(equalTo: margins.topAnchor),
      content.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      content.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
      content.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
    ])
  }

  // MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    // cornerRadius(32)가 높이/2를 넘으면 CALayer·UIBezierPath가 렌즈형 아티팩트를 그리므로 절반까지로 클램프한다 (Figma 렌더 동작과 동일).
    let cornerRadius = min(BezierOverlayConstant.cornerRadius, self.bounds.height / 2)
    self.layer.cornerRadius = cornerRadius
    self.layer.shadowPath = UIBezierPath(
      roundedRect: self.bounds,
      cornerRadius: cornerRadius
    ).cgPath
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.backgroundColor = BezierOverlayConstant.backgroundColor.palette(self)

    let elevation = BezierOverlayConstant.elevation.rawValue
    self.layer.shadowColor = elevation.semanticColor.palette(self).cgColor
    self.layer.shadowOffset = CGSize(width: elevation.x, height: elevation.y)
    self.layer.shadowRadius = elevation.blur
    self.layer.shadowOpacity = 1
  }
}
