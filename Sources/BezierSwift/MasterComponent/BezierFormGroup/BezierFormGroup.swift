//
//  BezierFormGroup.swift
//  BezierSwift
//

import UIKit

/// 독립 상태 컨트롤 여러 개를 묶을 때의 간격·정렬을 정의하는 레이아웃 그룹 (UIKit). 컨트롤을 세로로 4pt 간격·좌측 정렬로 쌓는다. 그룹 라벨을 렌더링하지 않으며(그룹 설명 텍스트는 상위 폼 필드 영역 책임), 선택 상태도 소유하지 않는다 — 각 컨트롤이 자기 상태를 관리한다. 현재 스코프의 자식은 `BezierCheckbox` 전용으로, 입력·동의 폼의 체크박스 묶음이나 「전체 선택」(indeterminate) 헤더를 포함한 그룹에 쓴다. 목록에서 항목을 고르는 다중선택 리스트에는 쓰지 않는다. SwiftUI에서는 `SUBezierFormGroup`을 사용한다.
public final class BezierFormGroup: UIView {
  // MARK: - Public Properties

  /// 컨트롤 간 세로 간격 (기본값 4pt).
  public var spacing: CGFloat = BezierFormGroupConstant.contentSpacing {
    didSet { if oldValue != self.spacing { self.contentStackView.spacing = self.spacing } }
  }

  /// 현재 표시 중인 컨트롤 뷰 배열. 읽기 전용이며 `setItems(_:)`/`addItem(_:)`으로 변경한다.
  public private(set) var items: [UIView] = []

  // MARK: - Subviews

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .fill
    stackView.spacing = BezierFormGroupConstant.contentSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  // MARK: - Init

  /// 초기 컨트롤 배열과 간격을 지정해 생성한다. 컨트롤은 이후 `setItems(_:)`/`addItem(_:)`으로 교체·추가할 수 있다.
  public init(
    spacing: CGFloat = BezierFormGroupConstant.contentSpacing,
    items: [UIView] = []
  ) {
    self.spacing = spacing
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
    self.shouldGroupAccessibilityChildren = true

    self.addSubview(self.contentStackView)
    NSLayoutConstraint.activate([
      self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.contentStackView.spacing = self.spacing
    self.rebuildItems()
  }

  // MARK: - Items

  /// 컨트롤 배열을 통째로 교체한다.
  public func setItems(_ items: [UIView]) {
    self.items = items
    self.rebuildItems()
  }

  /// 컨트롤을 끝에 하나 추가한다.
  public func addItem(_ item: UIView) {
    self.items.append(item)
    self.contentStackView.addArrangedSubview(item)
  }

  // MARK: - Rebuild

  private func rebuildItems() {
    self.contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.items.forEach { self.contentStackView.addArrangedSubview($0) }
  }
}
