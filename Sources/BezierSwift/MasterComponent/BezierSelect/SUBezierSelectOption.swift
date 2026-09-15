//
//  SUBezierSelectOption.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierSelect` 목록 안에 넣는 단일 선택지 (SwiftUI). leading(아이콘/아바타/커스텀) · 제목 · description · centerSlot으로 구성되며, 선택되면 우측에 체크 아이콘이 붙는다. 선택이 값으로 남지 않고 일회성 액션을 실행한다면 `SUBezierDropdownMenuItem`을, 선택 개념이 없는 일반 리스트 행에는 `SUBezierBaseItem`을 쓴다. UIKit에서는 `BezierSelectOption`을 사용한다.
public struct SUBezierSelectOption<CenterSlot: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let title: String
  private let itemDescription: String?
  private let leading: BezierSelectOptionLeading<AnyView>
  private let isSelected: Bool
  private let onSelect: (() -> Void)?
  private let centerSlot: CenterSlot

  /// 제목·description·leading·선택 여부·선택 핸들러와 centerSlot 빌더로 선택지를 만든다. 한 목록에서 동시에 하나만 `isSelected`가 되도록 하는 것은 사용처 책임이다.
  public init(
    title: String,
    description: String? = nil,
    leading: BezierSelectOptionLeading<AnyView> = .none,
    isSelected: Bool = false,
    onSelect: (() -> Void)? = nil,
    @ViewBuilder centerSlot: () -> CenterSlot
  ) {
    self.title = title
    self.itemDescription = description
    self.leading = leading
    self.isSelected = isSelected
    self.onSelect = onSelect
    self.centerSlot = centerSlot()
  }

  public var body: some View {
    // leading 유무를 여기서 분기해 빈 슬롯이 리터럴 EmptyView 타입이 되게 한다
    // (BaseItem이 타입으로 슬롯 렌더를 거르므로, 옵셔널 뷰를 넘기면 빈 24pt 박스가 남는다).
    switch self.leading {
    case .none:
      self.item(leading: { EmptyView() })
    case .icon(let icon):
      self.item(leading: { self.iconView(icon) })
    case .avatar(let view), .custom(let view):
      self.item(leading: { view })
    }
  }

  private func item<Leading: View>(
    @ViewBuilder leading: () -> Leading
  ) -> some View {
    SUBezierBaseItem(
      style: BezierSelectOptionConstant.baseItemStyle,
      size: .medium,
      title: self.title,
      description: self.itemDescription,
      onTap: self.onSelect,
      leading: leading,
      centerSlot: { self.centerSlotView },
      trailing: { self.checkView }
    )
  }

  private func iconView(_ icon: BezierIcon) -> some View {
    icon.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .foregroundColor(self.palette(BezierSelectOptionConstant.leadingIconColor))
  }

  @ViewBuilder
  private var centerSlotView: some View {
    if CenterSlot.self != EmptyView.self {
      self.centerSlot
        .frame(height: BezierSelectOptionConstant.centerSlotHeight)
        .clipped()
    }
  }

  @ViewBuilder
  private var checkView: some View {
    if self.isSelected {
      BezierIcon.check.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(
          width: BezierSelectOptionConstant.checkIconLength,
          height: BezierSelectOptionConstant.checkIconLength
        )
        .foregroundColor(self.palette(BezierSelectOptionConstant.checkIconColor))
    }
  }
}

// MARK: - Convenience init (centerSlot 생략)

extension SUBezierSelectOption where CenterSlot == EmptyView {
  /// centerSlot 없이 만드는 편의 이니셜라이저.
  public init(
    title: String,
    description: String? = nil,
    leading: BezierSelectOptionLeading<AnyView> = .none,
    isSelected: Bool = false,
    onSelect: (() -> Void)? = nil
  ) {
    self.init(
      title: title,
      description: description,
      leading: leading,
      isSelected: isSelected,
      onSelect: onSelect,
      centerSlot: { EmptyView() }
    )
  }
}

struct SUBezierSelectOption_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierSelectOption(title: "한국어", isSelected: true, onSelect: {})
      SUBezierSelectOption(title: "English", onSelect: {})
      SUBezierSelectOption(
        title: "최신순",
        leading: .icon(.arrowUp),
        isSelected: true,
        onSelect: {}
      )
      SUBezierSelectOption(
        title: "오래된순",
        description: "가장 먼저 등록된 항목부터",
        leading: .icon(.arrowDown),
        onSelect: {}
      )
      SUBezierSelectOption(title: "비활성 항목", leading: .icon(.lock), onSelect: {})
        .disabled(true)
    }
    .padding()
  }
}
