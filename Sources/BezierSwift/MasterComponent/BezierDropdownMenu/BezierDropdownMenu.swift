//
//  BezierDropdownMenu.swift
//  BezierSwift
//

import UIKit

/// 트리거 뒤에 액션 목록을 감췄다가 항목 선택 시 곧바로 실행하는 컨텍스트 메뉴 (UIKit). 선택적 트리거 슬롯 + `BezierOverlay` 패널로 구성된 240pt 고정 폭 컴포넌트로, 패널 콘텐츠에는 `BezierDropdownMenuGroup`/`BezierDropdownMenuItem`을 넣는다. 열림/닫힘·앵커 포지셔닝·외부 탭 닫힘은 사용처 책임이다. SwiftUI에서는 `SUBezierDropdownMenu`를 사용한다.
public final class BezierDropdownMenu: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.overlay.componentTheme = self.componentTheme }
  }

  // MARK: - Public Properties

  /// 메뉴를 여는 트리거 뷰. 패널 위에 우측 정렬로 배치되며, `nil`이면 트리거 행 없이 패널만 표시한다 — 화면의 기존 요소를 트리거로 외부 제어할 때 비운다 (기본값 `nil`).
  public var trigger: UIView? {
    didSet {
      guard oldValue !== self.trigger else { return }
      oldValue?.removeFromSuperview()
      self.refreshTrigger()
    }
  }

  /// 패널에 표시할 콘텐츠 뷰 배열(그룹 또는 항목). 교체하면 목록을 다시 만든다.
  public var contents: [UIView] = [] {
    didSet { self.rebuildContents() }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierDropdownMenuConstant.triggerSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let triggerRow = UIView()

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()

  private let overlay = BezierOverlay()

  // MARK: - Init

  /// 트리거·패널 콘텐츠(그룹/항목 배열)로 메뉴를 만든다.
  public init(trigger: UIView? = nil, contents: [UIView] = []) {
    self.trigger = trigger
    self.contents = contents
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

    self.overlay.content = self.contentStackView

    self.rootStackView.addArrangedSubview(self.triggerRow)
    self.rootStackView.addArrangedSubview(self.overlay)
    self.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.refreshTrigger()
    self.rebuildContents()
  }

  // MARK: - Refresh

  private func refreshTrigger() {
    guard let trigger = self.trigger else {
      self.triggerRow.isHidden = true
      return
    }
    trigger.translatesAutoresizingMaskIntoConstraints = false
    self.triggerRow.addSubview(trigger)
    NSLayoutConstraint.activate([
      trigger.topAnchor.constraint(equalTo: self.triggerRow.topAnchor),
      trigger.bottomAnchor.constraint(equalTo: self.triggerRow.bottomAnchor),
      trigger.trailingAnchor.constraint(equalTo: self.triggerRow.trailingAnchor),
      trigger.leadingAnchor.constraint(greaterThanOrEqualTo: self.triggerRow.leadingAnchor),
    ])
    self.triggerRow.isHidden = false
  }

  private func rebuildContents() {
    self.contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.contents.forEach { self.contentStackView.addArrangedSubview($0) }
  }
}
