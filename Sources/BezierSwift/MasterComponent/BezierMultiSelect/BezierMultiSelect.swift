//
//  BezierMultiSelect.swift
//  BezierSwift
//

import UIKit

/// 미리 정의된 선택지 중 여러 개를 고르는 복수 선택 목록 (UIKit). 선택적 라벨 + 선택지 목록으로 구성되며, `container`로 인라인 배치(`page`)와 오버레이 카드(`overlay`) 중 하나를 고른다. 목록 콘텐츠에는 `BezierMultiSelectGroup`/`BezierMultiSelectOption`을 넣는다. 진입 트리거·열림/닫힘·앵커 포지셔닝과 선택 집합 보관은 사용처 책임이다. SwiftUI에서는 `SUBezierMultiSelect`를 사용한다.
public final class BezierMultiSelect: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.sectionLabel.componentTheme = self.componentTheme
      self.overlay.componentTheme = self.componentTheme
    }
  }

  // MARK: - Public Properties

  /// 목록을 화면에 얹는 방식 (기본값 `.page`).
  public var container: BezierMultiSelectContainer = .page {
    didSet { if oldValue != self.container { self.rebuildContainer() } }
  }

  /// 목록 상단 라벨 텍스트. `nil`이면 라벨을 숨긴다 (기본값 `nil`). `container`가 `.overlay`면 렌더되지 않는다 — 오버레이 안에서 라벨이 필요하면 `BezierMultiSelectGroup`의 `labelText`를 쓴다.
  public var labelText: String? {
    didSet { if oldValue != self.labelText { self.refreshLabel() } }
  }

  /// 목록에 표시할 콘텐츠 뷰 배열(그룹 또는 선택지). 교체하면 목록을 다시 만든다.
  public var contents: [UIView] = [] {
    didSet { self.rebuildContents() }
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

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    return stackView
  }()

  private let overlay = BezierOverlay()

  // MARK: - Constraints

  private var containerConstraints: [NSLayoutConstraint] = []

  // MARK: - Init

  /// 표현 방식·라벨 텍스트·목록 콘텐츠(그룹/선택지 배열)로 목록을 만든다.
  public init(
    container: BezierMultiSelectContainer = .page,
    labelText: String? = nil,
    contents: [UIView] = []
  ) {
    self.container = container
    self.labelText = labelText
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

    self.rootStackView.addArrangedSubview(self.sectionLabel)
    self.rootStackView.addArrangedSubview(self.contentStackView)

    self.refreshLabel()
    self.rebuildContents()
    self.rebuildContainer()
  }

  // MARK: - Refresh

  private func rebuildContents() {
    self.contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.contents.forEach { self.contentStackView.addArrangedSubview($0) }
  }

  private func refreshLabel() {
    let text = self.labelText ?? ""
    self.sectionLabel.text = text
    self.sectionLabel.isHidden = text.isEmpty || self.container != .page
  }

  private func rebuildContainer() {
    NSLayoutConstraint.deactivate(self.containerConstraints)
    self.containerConstraints = []
    self.overlay.content = nil
    self.rootStackView.removeFromSuperview()
    self.overlay.removeFromSuperview()

    switch self.container {
    case .page:
      self.addSubview(self.rootStackView)
      self.containerConstraints = [
        self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
        self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      ]
    case .overlay:
      self.overlay.content = self.rootStackView
      self.addSubview(self.overlay)
      self.containerConstraints = [
        self.overlay.topAnchor.constraint(equalTo: self.topAnchor),
        self.overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      ]
    }
    NSLayoutConstraint.activate(self.containerConstraints)
    self.refreshLabel()
  }
}
