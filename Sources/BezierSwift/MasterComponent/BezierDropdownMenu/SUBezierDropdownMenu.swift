//
//  SUBezierDropdownMenu.swift
//  BezierSwift
//

import SwiftUI

/// 트리거 뒤에 액션 목록을 감췄다가 항목 선택 시 곧바로 실행하는 컨텍스트 메뉴 (SwiftUI). 선택적 트리거 슬롯 + `SUBezierOverlay` 패널로 구성된 240pt 고정 폭 컴포넌트로, 패널 콘텐츠에는 `SUBezierDropdownMenuGroup`/`SUBezierDropdownMenuItem`을 넣는다. 열림/닫힘·앵커 포지셔닝·외부 탭 닫힘은 사용처 책임이다. UIKit에서는 `BezierDropdownMenu`를 사용한다.
public struct SUBezierDropdownMenu<Trigger: View, Content: View>: View {
  private let trigger: Trigger
  private let content: Content

  /// 트리거·패널 콘텐츠 빌더로 메뉴를 만든다. 트리거는 패널 위에 우측 정렬로 배치된다.
  public init(
    @ViewBuilder trigger: () -> Trigger,
    @ViewBuilder content: () -> Content
  ) {
    self.trigger = trigger()
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: BezierDropdownMenuConstant.triggerSpacing) {
      self.triggerRow

      SUBezierOverlay {
        self.content
      }
    }
    .frame(width: BezierOverlayConstant.width)
  }

  @ViewBuilder
  private var triggerRow: some View {
    if Trigger.self != EmptyView.self {
      HStack(spacing: 0) {
        Spacer(minLength: 0)
        self.trigger
      }
    }
  }
}

// MARK: - Convenience init (trigger 생략)

extension SUBezierDropdownMenu where Trigger == EmptyView {
  /// 트리거 없이 패널만 만드는 편의 이니셜라이저 — 화면의 기존 요소를 트리거로 외부 제어할 때 쓴다.
  public init(@ViewBuilder content: () -> Content) {
    self.init(trigger: { EmptyView() }, content: content)
  }
}

struct SUBezierDropdownMenu_Previews: PreviewProvider {
  static var previews: some View {
    SUBezierDropdownMenu {
      Circle()
        .fill(Color.gray.opacity(0.2))
        .frame(width: 32, height: 32)
    } content: {
      SUBezierDropdownMenuGroup(showsDivider: true) {
        SUBezierDropdownMenuItem(title: "편집", leading: .icon(.edit), onTap: {})
        SUBezierDropdownMenuItem(title: "복제", leading: .icon(.linkCopy), onTap: {})
      }
      SUBezierDropdownMenuGroup {
        SUBezierDropdownMenuItem(variant: .destructive, title: "삭제", leading: .icon(.trash), onTap: {})
      }
    }
    .padding()
    .background(Color.gray.opacity(0.15))
  }
}
