//
//  BezierDropdownMenuItem.swift
//  BezierSwift
//

import UIKit

/// `BezierDropdownMenu` 안에 넣는 단일 액션 항목 (UIKit). leading(아이콘/커스텀) · 제목 · description · centerSlot · trailing으로 구성되며 탭·pressed·disabled 상호작용을 지원한다. 메뉴 밖 일반 리스트 행에는 `BezierBaseItem`을 쓴다. SwiftUI에서는 `SUBezierDropdownMenuItem`을 사용한다.
public final class BezierDropdownMenuItem: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.baseItem.componentTheme = self.componentTheme
      self.refreshAppearance()
    }
  }

  // MARK: - Public Properties

  /// 항목 색 변형(neutral/destructive) (기본값 `.neutral`).
  public var variant: BezierDropdownMenuItemVariant = .neutral {
    didSet { if oldValue != self.variant { self.refreshAppearance() } }
  }

  /// 항목 제목. 빈 문자열이면 제목을 숨긴다.
  public var title: String {
    get { self.baseItem.title }
    set { self.baseItem.title = newValue }
  }

  /// 제목 아래 보조 설명. `nil`/빈 문자열이면 숨긴다. 스캔 속도를 해치므로 꼭 필요할 때만 한 줄 이내로 쓴다.
  public var itemDescription: String? {
    get { self.baseItem.itemDescription }
    set { self.baseItem.itemDescription = newValue }
  }

  /// leading 콘텐츠 유형(none/icon/custom) (기본값 `.none`). icon의 색은 `variant`가 결정한다.
  public var leading: BezierDropdownMenuItemLeading<UIView> = .none {
    didSet { self.refreshLeading() }
  }

  /// 제목 우측에 인라인으로 붙는 슬롯 뷰(높이 24, 초과 시 잘린다). `nil`이면 비운다.
  public var centerSlot: UIView? {
    didSet {
      self.baseItem.centerSlot = self.centerSlot.map {
        self.makeFixedHeightSlot($0, alignment: .leading)
      }
    }
  }

  /// 우측 슬롯 뷰(높이 24) — 단축키 텍스트·배지 등 읽기 전용 보조 정보 전용. `nil`이면 비운다.
  public var trailingContent: UIView? {
    didSet {
      self.baseItem.trailingContent = self.trailingContent.map {
        self.makeFixedHeightSlot($0, alignment: .trailing)
      }
    }
  }

  /// 항목 탭 핸들러. `nil`이면 비인터랙티브(pressed 없음)가 된다.
  public var onTap: (() -> Void)? {
    get { self.baseItem.onTap }
    set { self.baseItem.onTap = newValue }
  }

  /// 항목 활성 여부. `false`면 흐리게(opacity 0.4) 표시되고 입력이 차단된다 (기본값 `true`).
  public var isEnabled: Bool {
    get { self.baseItem.isEnabled }
    set { self.baseItem.isEnabled = newValue }
  }

  // MARK: - Subviews

  private let baseItem: BezierBaseItem

  private let leadingIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  // MARK: - Init

  /// variant·제목·description·leading·탭 핸들러로 항목을 만든다. centerSlot·trailing 슬롯은 생성 후 프로퍼티로 지정한다.
  public init(
    variant: BezierDropdownMenuItemVariant = .neutral,
    title: String,
    description: String? = nil,
    leading: BezierDropdownMenuItemLeading<UIView> = .none,
    onTap: (() -> Void)? = nil
  ) {
    self.variant = variant
    self.leading = leading
    self.baseItem = BezierBaseItem(
      size: .small,
      title: title,
      description: description,
      onTap: onTap
    )
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.baseItem = BezierBaseItem(size: .small, title: "")
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.baseItem)
    NSLayoutConstraint.activate([
      self.baseItem.topAnchor.constraint(equalTo: self.topAnchor),
      self.baseItem.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.baseItem.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.baseItem.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.refreshLeading()
    self.refreshAppearance()
  }

  // MARK: - Slot

  private enum SlotAlignment {
    case leading
    case trailing
  }

  // 슬롯 컨테이너는 intrinsic width가 없어 BaseItem 행의 여분 폭이 hugging 설정과 무관하게
  // 이 컨테이너로 분배될 수 있다 (시뮬레이터 실측). 콘텐츠를 컨테이너 안에서 슬롯 방향으로
  // 정렬해 컨테이너가 늘어나도 시각 결과가 Figma(trailing 우측 끝·centerSlot label 옆)와 같게 한다.
  private func makeFixedHeightSlot(_ view: UIView, alignment: SlotAlignment) -> UIView {
    let container = UIView()
    container.clipsToBounds = true
    container.setContentHuggingPriority(.required, for: .horizontal)
    container.setContentCompressionResistancePriority(.required, for: .horizontal)
    view.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(view)

    var constraints = [
      container.heightAnchor.constraint(equalToConstant: BezierDropdownMenuItemConstant.slotHeight),
      view.centerYAnchor.constraint(equalTo: container.centerYAnchor),
    ]
    switch alignment {
    case .leading:
      constraints.append(view.leadingAnchor.constraint(equalTo: container.leadingAnchor))
      constraints.append(view.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor))
    case .trailing:
      constraints.append(view.trailingAnchor.constraint(equalTo: container.trailingAnchor))
      constraints.append(view.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor))
    }
    NSLayoutConstraint.activate(constraints)
    return container
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLeading() {
    switch self.leading {
    case .none:
      self.baseItem.leadingContent = nil
    case .icon(let icon):
      self.leadingIconImageView.image = icon.uiImage?.withRenderingMode(.alwaysTemplate)
      self.baseItem.leadingContent = self.leadingIconImageView
    case .custom(let view):
      self.baseItem.leadingContent = view
    }
    self.refreshAppearance()
  }

  private func refreshAppearance() {
    self.baseItem.style = BezierDropdownMenuItemConstant.baseItemStyle(variant: self.variant)
    if case .icon = self.leading {
      self.leadingIconImageView.tintColor = self.variant.iconColor.palette(self)
    }
  }
}
