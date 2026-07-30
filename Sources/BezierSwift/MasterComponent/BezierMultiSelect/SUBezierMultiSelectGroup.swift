//
//  SUBezierMultiSelectGroup.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierMultiSelect` 안에서 선택지를 카테고리별로 묶는 그룹 컨테이너 (SwiftUI). 선택적 라벨 + 선택지 목록으로 구성된다. 단일 그룹이면 그룹 없이 `SUBezierMultiSelectOption`을 직접 나열한다. 구분선은 이 컨테이너가 제공하지 않으므로 필요하면 사용처가 `SUBezierDivider`를 형제로 배치한다. UIKit에서는 `BezierMultiSelectGroup`을 사용한다.
public struct SUBezierMultiSelectGroup<Content: View>: View {
  private let labelText: String?
  private let content: Content

  /// 라벨 텍스트·선택지 빌더로 그룹을 만든다. 라벨은 복수 그룹일 때만 지정한다.
  public init(
    labelText: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.labelText = labelText
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if let labelText = self.labelText, !labelText.isEmpty {
        SUBezierSectionLabel(labelText, color: .neutralLight)
      }

      self.content
    }
  }
}

struct SUBezierMultiSelectGroup_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierMultiSelectGroup(labelText: "우선순위") {
        SUBezierMultiSelectOption(title: "긴급", isSelected: true, onToggle: {})
        SUBezierMultiSelectOption(title: "높음", isSelected: true, onToggle: {})
      }
      SUBezierDivider()
      SUBezierMultiSelectGroup(labelText: "카테고리") {
        SUBezierMultiSelectOption(title: "결제", onToggle: {})
        SUBezierMultiSelectOption(title: "배송", isSelected: true, onToggle: {})
      }
    }
    .padding()
  }
}
