//
//  SUBezierDropdownMenuGroup.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierDropdownMenu` 오버레이 안에서 항목을 카테고리별로 묶는 그룹 컨테이너 (SwiftUI). 선택적 라벨 + 항목 목록 + 선택적 하단 구분선으로 구성된다. 단일 그룹이면 그룹 없이 `SUBezierDropdownMenuItem`을 직접 나열한다. UIKit에서는 `BezierDropdownMenuGroup`을 사용한다.
public struct SUBezierDropdownMenuGroup<Content: View>: View {
  private let labelText: String?
  private let showsDivider: Bool
  private let content: Content

  /// 라벨 텍스트·구분선 여부·항목 빌더로 그룹을 만든다. 라벨은 복수 그룹일 때만 지정한다.
  public init(
    labelText: String? = nil,
    showsDivider: Bool = false,
    @ViewBuilder content: () -> Content
  ) {
    self.labelText = labelText
    self.showsDivider = showsDivider
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if let labelText = self.labelText, !labelText.isEmpty {
        SUBezierSectionLabel(labelText, color: .neutralLight)
      }

      self.content

      if self.showsDivider {
        SUBezierDivider()
      }
    }
  }
}

struct SUBezierDropdownMenuGroup_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierDropdownMenuGroup(labelText: "편집", showsDivider: true) {
        SUBezierDropdownMenuItem(title: "이름 변경", onTap: {})
        SUBezierDropdownMenuItem(title: "복제", onTap: {})
      }
      SUBezierDropdownMenuGroup {
        SUBezierDropdownMenuItem(variant: .destructive, title: "삭제", onTap: {})
      }
    }
    .padding()
  }
}
