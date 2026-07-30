//
//  BezierSelectOption.swift
//  BezierSwift
//

import UIKit

/// `BezierSelect` 목록 안에 넣는 단일 선택지 (UIKit). leading(아이콘/아바타/커스텀) · 제목 · description · centerSlot으로 구성되며, 선택되면 우측에 체크 아이콘이 붙는다. 선택이 값으로 남지 않고 일회성 액션을 실행한다면 `BezierDropdownMenuItem`을, 선택 개념이 없는 일반 리스트 행에는 `BezierBaseItem`을 쓴다. SwiftUI에서는 `SUBezierSelectOption`을 사용한다.
public final class BezierSelectOption: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.baseItem.componentTheme = self.componentTheme
      self.refreshAppearance()
    }
  }

  // MARK: - Public Properties

  /// 선택지 제목. 빈 문자열이면 제목을 숨긴다.
  public var title: String {
    get { self.baseItem.title }
    set { self.baseItem.title = newValue }
  }

  /// 제목 아래 보조 설명. `nil`/빈 문자열이면 숨긴다.
  public var itemDescription: String? {
    get { self.baseItem.itemDescription }
    set { self.baseItem.itemDescription = newValue }
  }

  /// leading 콘텐츠 유형(none/icon/avatar/custom) (기본값 `.none`).
  public var leading: BezierSelectOptionLeading<UIView> = .none {
    didSet { self.refreshLeading() }
  }

  /// 제목 우측에 인라인으로 붙는 슬롯 뷰(높이 24, 초과 시 잘린다). `nil`이면 비운다.
  public var centerSlot: UIView? {
    didSet {
      self.baseItem.centerSlot = self.centerSlot.map { self.makeCenterSlotContainer($0) }
    }
  }

  /// 현재 선택된 항목인지 여부. `true`면 우측에 체크 아이콘이 표시된다 (기본값 `false`). 한 목록에서 동시에 하나만 `true`가 되도록 하는 것은 사용처 책임이다.
  public var isSelected: Bool = false {
    didSet { if oldValue != self.isSelected { self.refreshSelection() } }
  }

  /// 항목을 탭했을 때 실행되는 선택 핸들러. `nil`이면 비인터랙티브(pressed 없음)가 된다.
  public var onSelect: (() -> Void)? {
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

  private let checkImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: BezierSelectOptionConstant.checkIconLength),
      imageView.heightAnchor.constraint(equalToConstant: BezierSelectOptionConstant.checkIconLength),
    ])
    return imageView
  }()

  // MARK: - Init

  /// 제목·description·leading·선택 여부·선택 핸들러로 선택지를 만든다. centerSlot은 생성 후 프로퍼티로 지정한다.
  public init(
    title: String,
    description: String? = nil,
    leading: BezierSelectOptionLeading<UIView> = .none,
    isSelected: Bool = false,
    onSelect: (() -> Void)? = nil
  ) {
    self.leading = leading
    self.isSelected = isSelected
    self.baseItem = BezierBaseItem(
      size: .medium,
      title: title,
      description: description,
      onTap: onSelect
    )
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.baseItem = BezierBaseItem(size: .medium, title: "")
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.baseItem.style = BezierSelectOptionConstant.baseItemStyle
    self.addSubview(self.baseItem)
    NSLayoutConstraint.activate([
      self.baseItem.topAnchor.constraint(equalTo: self.topAnchor),
      self.baseItem.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.baseItem.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.baseItem.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.checkImageView.image = BezierIcon.check.uiImage?.withRenderingMode(.alwaysTemplate)

    self.refreshLeading()
    self.refreshSelection()
    self.refreshAppearance()
  }

  // MARK: - Slot

  // 슬롯 컨테이너는 intrinsic width가 없어 BaseItem 행의 여분 폭이 hugging 설정과 무관하게
  // 이 컨테이너로 분배될 수 있다. 콘텐츠를 leading으로 정렬해 컨테이너가 늘어나도 시각 결과가
  // Figma(centerSlot이 label 바로 옆)와 같게 한다.
  private func makeCenterSlotContainer(_ view: UIView) -> UIView {
    let container = UIView()
    container.clipsToBounds = true
    container.setContentHuggingPriority(.required, for: .horizontal)
    container.setContentCompressionResistancePriority(.required, for: .horizontal)
    view.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(view)
    NSLayoutConstraint.activate([
      container.heightAnchor.constraint(equalToConstant: BezierSelectOptionConstant.centerSlotHeight),
      view.centerYAnchor.constraint(equalTo: container.centerYAnchor),
      view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      view.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor),
    ])
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
    case .avatar(let view), .custom(let view):
      self.baseItem.leadingContent = view
    }
    self.refreshAppearance()
  }

  private func refreshSelection() {
    self.baseItem.trailingContent = self.isSelected ? self.checkImageView : nil
  }

  private func refreshAppearance() {
    if case .icon = self.leading {
      self.leadingIconImageView.tintColor = BezierSelectOptionConstant.leadingIconColor.palette(self)
    }
    self.checkImageView.tintColor = BezierSelectOptionConstant.checkIconColor.palette(self)
  }
}
