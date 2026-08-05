//
//  SUBezierMultiSelectOption.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierMultiSelect` 목록 안에 넣는 복수 선택지 (SwiftUI). leading(아이콘/아바타/커스텀) · 제목 · description · centerSlot으로 구성되며, 선택되면 우측에 체크 아이콘이 붙는다. 한 목록에서 여러 항목이 동시에 선택될 수 있다 — 하나만 고르게 하려면 `SUBezierSelectOption`을, 선택이 값으로 남지 않고 일회성 액션을 실행한다면 `SUBezierDropdownMenuItem`을 쓴다. UIKit에서는 `BezierMultiSelectOption`을 사용한다.
public struct SUBezierMultiSelectOption<CenterSlot: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let title: String
  private let itemDescription: String?
  private let leading: BezierMultiSelectOptionLeading<AnyView>
  private let isSelected: Bool
  private let onToggle: (() -> Void)?
  private let centerSlot: CenterSlot

  /// 제목·description·leading·선택 여부·토글 핸들러와 centerSlot 빌더로 선택지를 만든다. 복수 선택이므로 여러 항목이 동시에 `isSelected`일 수 있고, 선택 집합의 보관과 토글은 사용처 책임이다.
  public init(
    title: String,
    description: String? = nil,
    leading: BezierMultiSelectOptionLeading<AnyView> = .none,
    isSelected: Bool = false,
    onToggle: (() -> Void)? = nil,
    @ViewBuilder centerSlot: () -> CenterSlot
  ) {
    self.title = title
    self.itemDescription = description
    self.leading = leading
    self.isSelected = isSelected
    self.onToggle = onToggle
    self.centerSlot = centerSlot()
  }

  public var body: some View {
    // 빈 슬롯은 리터럴 EmptyView 타입으로 넘겨야 한다 — BaseItem이 슬롯 타입으로 렌더를 거르는데
    // @ViewBuilder의 if는 결과를 Optional로 감싸 EmptyView로 특수화되지 않고, 그러면 BaseItem이
    // 슬롯을 제거하지 못한다. leading은 여기서, centerSlot은 item(leading:)에서 분기한다.
    switch self.leading {
    case .none:
      self.item(leading: { EmptyView() })
    case .icon(let icon):
      self.item(leading: { self.iconView(icon) })
    case .avatar(let view), .custom(let view):
      self.item(leading: { view })
    }
  }

  @ViewBuilder
  private func item<Leading: View>(
    @ViewBuilder leading: () -> Leading
  ) -> some View {
    if CenterSlot.self == EmptyView.self {
      self.baseItem(leading: leading, centerSlot: { EmptyView() })
    } else {
      self.baseItem(leading: leading, centerSlot: { self.centerSlotView })
    }
  }

  private func baseItem<Leading: View, Center: View>(
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder centerSlot: () -> Center
  ) -> some View {
    SUBezierBaseItem(
      style: BezierMultiSelectOptionConstant.baseItemStyle,
      size: .medium,
      title: self.title,
      description: self.itemDescription,
      onTap: self.onToggle,
      leading: leading,
      centerSlot: centerSlot,
      trailing: { self.checkView }
    )
  }

  private func iconView(_ icon: BezierIcon) -> some View {
    icon.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .foregroundColor(self.palette(BezierMultiSelectOptionConstant.leadingIconColor))
  }

  private var centerSlotView: some View {
    self.centerSlot
      .frame(height: BezierMultiSelectOptionConstant.centerSlotHeight)
      .clipped()
  }

  @ViewBuilder
  private var checkView: some View {
    if self.isSelected {
      BezierIcon.check.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(
          width: BezierMultiSelectOptionConstant.checkIconLength,
          height: BezierMultiSelectOptionConstant.checkIconLength
        )
        .foregroundColor(self.palette(BezierMultiSelectOptionConstant.checkIconColor))
    }
  }
}

// MARK: - Convenience init (centerSlot 생략)

extension SUBezierMultiSelectOption where CenterSlot == EmptyView {
  /// centerSlot 없이 만드는 편의 이니셜라이저.
  public init(
    title: String,
    description: String? = nil,
    leading: BezierMultiSelectOptionLeading<AnyView> = .none,
    isSelected: Bool = false,
    onToggle: (() -> Void)? = nil
  ) {
    self.init(
      title: title,
      description: description,
      leading: leading,
      isSelected: isSelected,
      onToggle: onToggle,
      centerSlot: { EmptyView() }
    )
  }
}

struct SUBezierMultiSelectOption_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierMultiSelectOption(title: "한국어", isSelected: true, onToggle: {})
      SUBezierMultiSelectOption(title: "English", isSelected: true, onToggle: {})
      SUBezierMultiSelectOption(title: "日本語", onToggle: {})
      SUBezierMultiSelectOption(
        title: "긴급",
        leading: .icon(.tag),
        isSelected: true,
        onToggle: {}
      )
      SUBezierMultiSelectOption(
        title: "VIP 고객",
        description: "결제 이력이 상위 10%인 고객",
        leading: .icon(.star),
        onToggle: {}
      )
      SUBezierMultiSelectOption(title: "비활성 항목", leading: .icon(.lock), onToggle: {})
        .disabled(true)
    }
    .padding()
  }
}
