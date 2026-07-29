//
//  SUBezierFormGroup.swift
//  BezierSwift
//

import SwiftUI

/// 독립 상태 컨트롤 여러 개를 묶을 때의 간격·정렬을 정의하는 레이아웃 그룹 (SwiftUI). 컨트롤을 세로로 4pt 간격·좌측 정렬로 쌓는다. 그룹 라벨을 렌더링하지 않으며(그룹 설명 텍스트는 상위 폼 필드 영역 책임), 선택 상태도 소유하지 않는다 — 각 컨트롤이 자기 상태를 관리한다. 현재 스코프의 자식은 `SUBezierCheckbox` 전용으로, 입력·동의 폼의 체크박스 묶음이나 「전체 선택」(indeterminate) 헤더를 포함한 그룹에 쓴다. 목록에서 항목을 고르는 다중선택 리스트에는 쓰지 않는다. UIKit에서는 `BezierFormGroup`을 사용한다.
public struct SUBezierFormGroup<Content: View>: View {
  private let spacing: CGFloat
  private let content: Content

  /// 간격과 컨트롤 목록을 지정해 생성한다. `content`의 각 뷰가 세로로 `spacing` 간격으로 쌓인다.
  public init(
    spacing: CGFloat = BezierFormGroupConstant.contentSpacing,
    @ViewBuilder content: () -> Content
  ) {
    self.spacing = spacing
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: self.spacing) {
      self.content
    }
    .accessibilityElement(children: .contain)
  }
}

struct SUBezierFormGroup_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 32) {
      SUBezierFormGroup {
        SUBezierCheckbox(label: "전체 선택", checked: .indeterminate, onCheckedChange: { _ in })
        SUBezierCheckbox(label: "마케팅 정보 수신 동의", checked: .checked, onCheckedChange: { _ in })
        SUBezierCheckbox(label: "이용약관 동의", checked: .unchecked, onCheckedChange: { _ in })
      }

      SUBezierFormGroup {
        SUBezierCheckbox(label: "이메일 알림", checked: .unchecked, onCheckedChange: { _ in })
        SUBezierCheckbox(label: "SMS 알림", checked: .unchecked, onCheckedChange: { _ in })
      }
      .disabled(true)
    }
    .padding()
  }
}
