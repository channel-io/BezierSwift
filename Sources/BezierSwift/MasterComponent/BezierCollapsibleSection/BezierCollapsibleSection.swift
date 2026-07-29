//
//  BezierCollapsibleSection.swift
//  BezierSwift
//

import UIKit

/// 헤더 탭으로 콘텐츠를 접고 펼치는 인터랙티브 섹션 컨테이너 (UIKit). 헤더(라벨·chevron) + 행 목록으로 구성되며 행에는 `BezierSectionItem`을 넣는다. Figma `CollapsibleSection`의 `open` 프로퍼티가 `isOpen`에 대응한다. 정적 그룹핑만 필요하면 `BezierSection`을 사용한다. SwiftUI에서는 `SUBezierCollapsibleSection`을 사용한다.
public final class BezierCollapsibleSection: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.headerLabel.componentTheme = self.componentTheme }
  }

  // MARK: - Public Properties

  /// 펼침 상태 (기본값 `true`). 대입 시 애니메이션 없이 즉시 반영되며 `onOpenChange`는 호출되지 않는다. 애니메이션이 필요하면 `setOpen(_:animated:)`를 사용한다.
  public var isOpen: Bool {
    get { self.openState }
    set { self.setOpen(newValue, animated: false) }
  }

  /// 사용자가 헤더를 탭해 펼침 상태가 바뀔 때 호출되는 클로저. 프로그래매틱 변경(`isOpen`/`setOpen`)에는 호출되지 않는다.
  public var onOpenChange: ((Bool) -> Void)?

  /// 헤더 라벨 텍스트. 헤더는 필수 파트라 항상 표시된다.
  public var labelText: String {
    didSet { if oldValue != self.labelText { self.headerLabel.text = self.labelText } }
  }

  /// 헤더 라벨·chevron 색(neutralDark/neutralLight) (기본값 `.neutralDark`).
  public var labelColor: BezierSectionLabelColor = .neutralDark {
    didSet { if oldValue != self.labelColor { self.headerLabel.color = self.labelColor } }
  }

  /// 헤더 라벨 좌측 슬롯에 넣을 20×20 뷰(아이콘 등). `nil`이면 비운다.
  public var labelLeadingContent: UIView? {
    didSet { self.headerLabel.leadingContent = self.labelLeadingContent }
  }

  /// 헤더 라벨 우측 슬롯에 넣을 액션 뷰(높이 20). 헤더 탭(토글)과 별개의 액션을 배치한다. `nil`이면 비운다.
  public var labelTrailingContent: UIView? {
    didSet { self.headerLabel.trailingContent = self.labelTrailingContent }
  }

  /// 현재 표시 중인 행 뷰 배열. 읽기 전용이며 `setItems(_:)`/`addItem(_:)`으로 변경한다.
  public private(set) var items: [UIView] = []

  // MARK: - Private Properties

  private var openState: Bool

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierSectionConstant.labelToContentSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let headerLabel: BezierCollapsibleSectionLabel

  private let contentContainer: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    return view
  }()

  private let itemsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  // MARK: - Init

  /// 헤더 텍스트·색·초기 펼침 상태·초기 행 배열로 섹션을 만든다. 행은 이후 `setItems(_:)`/`addItem(_:)`으로 교체·추가할 수 있다.
  public init(
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    isOpen: Bool = true,
    items: [UIView] = []
  ) {
    self.labelText = labelText
    self.labelColor = labelColor
    self.openState = isOpen
    self.items = items
    self.headerLabel = BezierCollapsibleSectionLabel(text: labelText, color: labelColor)
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.labelText = ""
    self.openState = true
    self.headerLabel = BezierCollapsibleSectionLabel()
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false

    self.contentContainer.addSubview(self.itemsStackView)
    NSLayoutConstraint.activate([
      self.itemsStackView.topAnchor.constraint(equalTo: self.contentContainer.topAnchor),
      self.itemsStackView.leadingAnchor.constraint(equalTo: self.contentContainer.leadingAnchor),
      self.itemsStackView.trailingAnchor.constraint(equalTo: self.contentContainer.trailingAnchor),
      self.itemsStackView.bottomAnchor.constraint(equalTo: self.contentContainer.bottomAnchor),
    ])

    self.rootStackView.addArrangedSubview(self.headerLabel)
    self.rootStackView.addArrangedSubview(self.contentContainer)
    self.addSubview(self.rootStackView)
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.headerLabel.isOpen = self.openState
    self.headerLabel.onTap = { [weak self] in
      self?.handleHeaderTap()
    }

    self.rebuildRows()
    self.applyContentVisibility(animated: false)
  }

  // MARK: - Open State

  /// 펼침 상태를 변경한다. `animated`가 `true`면 콘텐츠 영역이 접히고 펼쳐지는 전환을 애니메이션한다 (Reduce Motion 활성 시 생략). `onOpenChange`는 호출되지 않는다.
  public func setOpen(_ isOpen: Bool, animated: Bool) {
    guard isOpen != self.openState else { return }
    self.openState = isOpen
    self.headerLabel.isOpen = isOpen
    self.applyContentVisibility(animated: animated && !UIAccessibility.isReduceMotionEnabled)
  }

  private func handleHeaderTap() {
    let newValue = !self.openState
    self.setOpen(newValue, animated: true)
    self.onOpenChange?(newValue)
  }

  private func applyContentVisibility(animated: Bool) {
    let hidden = !self.openState

    guard animated, self.window != nil else {
      self.contentContainer.isHidden = hidden
      self.contentContainer.alpha = hidden ? 0 : 1
      return
    }

    UIView.animate(
      withDuration: BezierCollapsibleSectionConstant.openAnimationDuration,
      delay: 0,
      options: [.curveEaseInOut, .beginFromCurrentState]
    ) {
      self.contentContainer.isHidden = hidden
      self.contentContainer.alpha = hidden ? 0 : 1
      self.rootStackView.layoutIfNeeded()
    }
  }

  // MARK: - Items

  /// 행 배열을 통째로 교체한다.
  public func setItems(_ items: [UIView]) {
    self.items = items
    self.rebuildRows()
  }

  /// 행을 끝에 하나 추가한다.
  public func addItem(_ item: UIView) {
    self.items.append(item)
    self.rebuildRows()
  }

  private func rebuildRows() {
    self.itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.items.forEach { self.itemsStackView.addArrangedSubview($0) }
  }
}
