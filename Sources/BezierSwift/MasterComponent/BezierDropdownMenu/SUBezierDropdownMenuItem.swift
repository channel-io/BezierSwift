//
//  SUBezierDropdownMenuItem.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierDropdownMenu` 안에 넣는 단일 액션 항목 (SwiftUI). leading(아이콘/커스텀) · 제목 · description · centerSlot · trailing으로 구성되며 탭·pressed·disabled를 지원한다. 메뉴 밖 일반 리스트 행에는 `SUBezierBaseItem`을 쓴다. UIKit에서는 `BezierDropdownMenuItem`을 사용한다.
public struct SUBezierDropdownMenuItem<CenterSlot: View, Trailing: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let variant: BezierDropdownMenuItemVariant
  private let title: String
  private let itemDescription: String?
  private let leading: BezierDropdownMenuItemLeading<AnyView>
  private let onTap: (() -> Void)?
  private let centerSlot: CenterSlot
  private let trailing: Trailing

  /// variant·제목·description·leading·탭 핸들러와 centerSlot·trailing 슬롯 빌더로 항목을 만든다. `trailing`에는 단축키 텍스트·배지 등 읽기 전용 보조 정보만 넣는다.
  public init(
    variant: BezierDropdownMenuItemVariant = .neutral,
    title: String,
    description: String? = nil,
    leading: BezierDropdownMenuItemLeading<AnyView> = .none,
    onTap: (() -> Void)? = nil,
    @ViewBuilder centerSlot: () -> CenterSlot,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.variant = variant
    self.title = title
    self.itemDescription = description
    self.leading = leading
    self.onTap = onTap
    self.centerSlot = centerSlot()
    self.trailing = trailing()
  }

  public var body: some View {
    switch self.leading {
    case .none:
      SUBezierBaseItem(
        style: BezierDropdownMenuItemConstant.baseItemStyle(variant: self.variant),
        size: .small,
        title: self.title,
        description: self.itemDescription,
        onTap: self.onTap,
        leading: { EmptyView() },
        centerSlot: { self.centerSlotView },
        trailing: { self.trailingView }
      )
    case .icon(let icon):
      SUBezierBaseItem(
        style: BezierDropdownMenuItemConstant.baseItemStyle(variant: self.variant),
        size: .small,
        title: self.title,
        description: self.itemDescription,
        onTap: self.onTap,
        leading: { self.iconView(icon) },
        centerSlot: { self.centerSlotView },
        trailing: { self.trailingView }
      )
    case .custom(let view):
      SUBezierBaseItem(
        style: BezierDropdownMenuItemConstant.baseItemStyle(variant: self.variant),
        size: .small,
        title: self.title,
        description: self.itemDescription,
        onTap: self.onTap,
        leading: { view },
        centerSlot: { self.centerSlotView },
        trailing: { self.trailingView }
      )
    }
  }

  private func iconView(_ icon: BezierIcon) -> some View {
    icon.image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .foregroundColor(self.palette(self.variant.iconColor))
  }

  @ViewBuilder
  private var centerSlotView: some View {
    if CenterSlot.self != EmptyView.self {
      self.centerSlot
        .frame(height: BezierDropdownMenuItemConstant.slotHeight)
        .clipped()
    }
  }

  @ViewBuilder
  private var trailingView: some View {
    if Trailing.self != EmptyView.self {
      self.trailing
        .frame(height: BezierDropdownMenuItemConstant.slotHeight)
        .clipped()
    }
  }
}

// MARK: - Convenience init (centerSlot 생략)

extension SUBezierDropdownMenuItem where CenterSlot == EmptyView {
  /// centerSlot 없이 trailing 슬롯만으로 만드는 편의 이니셜라이저.
  public init(
    variant: BezierDropdownMenuItemVariant = .neutral,
    title: String,
    description: String? = nil,
    leading: BezierDropdownMenuItemLeading<AnyView> = .none,
    onTap: (() -> Void)? = nil,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(
      variant: variant,
      title: title,
      description: description,
      leading: leading,
      onTap: onTap,
      centerSlot: { EmptyView() },
      trailing: trailing
    )
  }
}

extension SUBezierDropdownMenuItem where CenterSlot == EmptyView, Trailing == EmptyView {
  /// centerSlot·trailing 없이 만드는 편의 이니셜라이저.
  public init(
    variant: BezierDropdownMenuItemVariant = .neutral,
    title: String,
    description: String? = nil,
    leading: BezierDropdownMenuItemLeading<AnyView> = .none,
    onTap: (() -> Void)? = nil
  ) {
    self.init(
      variant: variant,
      title: title,
      description: description,
      leading: leading,
      onTap: onTap,
      centerSlot: { EmptyView() },
      trailing: { EmptyView() }
    )
  }
}

struct SUBezierDropdownMenuItem_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierDropdownMenuItem(title: "편집", leading: .icon(.edit), onTap: {})
      SUBezierDropdownMenuItem(
        title: "복제",
        leading: .icon(.linkCopy),
        onTap: {},
        trailing: {
          Text("⌘D").font(.caption).foregroundColor(.secondary)
        }
      )
      SUBezierDropdownMenuItem(
        title: "내보내기",
        description: "팀 전체에 공유됩니다",
        leading: .icon(.arrowRightUpSmall),
        onTap: {}
      )
      SUBezierDropdownMenuItem(title: "비활성 항목", leading: .icon(.lock), onTap: {})
        .disabled(true)
      SUBezierDropdownMenuItem(variant: .destructive, title: "삭제", leading: .icon(.trash), onTap: {})
    }
    .padding()
  }
}
