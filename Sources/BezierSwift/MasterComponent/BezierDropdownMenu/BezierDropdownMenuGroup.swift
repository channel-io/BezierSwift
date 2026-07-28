//
//  BezierDropdownMenuGroup.swift
//  BezierSwift
//

import UIKit

/// `BezierDropdownMenu` 오버레이 안에서 항목을 카테고리별로 묶는 그룹 컨테이너 (UIKit). 선택적 라벨 + 항목 목록 + 선택적 하단 구분선으로 구성된다. 단일 그룹이면 그룹 없이 `BezierDropdownMenuItem`을 직접 나열한다. SwiftUI에서는 `SUBezierDropdownMenuGroup`을 사용한다.
public final class BezierDropdownMenuGroup: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.sectionLabel.componentTheme = self.componentTheme
      self.divider.componentTheme = self.componentTheme
    }
  }

  // MARK: - Public Properties

  /// 그룹 라벨 텍스트. `nil`이면 라벨을 숨긴다 (기본값 `nil`) — 복수 그룹일 때만 지정한다.
  public var labelText: String? {
    didSet { if oldValue != self.labelText { self.refreshLabel() } }
  }

  /// 그룹 하단 구분선 표시 여부 (기본값 `false`).
  public var showsDivider: Bool = false {
    didSet { self.divider.isHidden = !self.showsDivider }
  }

  /// 현재 표시 중인 항목 뷰 배열. 교체하면 목록을 다시 만든다.
  public var items: [UIView] = [] {
    didSet { self.rebuildItems() }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let sectionLabel = BezierSectionLabel(text: "", color: .neutralLight)

  private let itemsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()

  private let divider = BezierDivider()

  // MARK: - Init

  /// 라벨 텍스트·구분선 여부·초기 항목 배열로 그룹을 만든다.
  public init(
    labelText: String? = nil,
    showsDivider: Bool = false,
    items: [UIView] = []
  ) {
    self.labelText = labelText
    self.showsDivider = showsDivider
    self.items = items
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

    self.rootStackView.addArrangedSubview(self.sectionLabel)
    self.rootStackView.addArrangedSubview(self.itemsStackView)
    self.rootStackView.addArrangedSubview(self.divider)
    self.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.divider.isHidden = !self.showsDivider
    self.refreshLabel()
    self.rebuildItems()
  }

  // MARK: - Refresh

  private func refreshLabel() {
    self.sectionLabel.text = self.labelText ?? ""
    self.sectionLabel.isHidden = (self.labelText?.isEmpty ?? true)
  }

  private func rebuildItems() {
    self.itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.items.forEach { self.itemsStackView.addArrangedSubview($0) }
  }
}
