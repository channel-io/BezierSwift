//
//  SUBezierSelectGroup.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierSelect` 안에서 선택지를 카테고리별로 묶는 그룹 컨테이너 (SwiftUI). 선택적 라벨 + 선택지 목록 + 선택적 하단 구분선으로 구성된다. 단일 그룹이면 그룹 없이 `SUBezierSelectOption`을 직접 나열한다. UIKit에서는 `BezierSelectGroup`을 사용한다.
public struct SUBezierSelectGroup<Content: View>: View {
  private let labelText: String?
  private let showsDivider: Bool
  private let content: Content

  /// 라벨 텍스트·구분선 여부·선택지 빌더로 그룹을 만든다. 라벨은 복수 그룹일 때만 지정한다.
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

struct SUBezierSelectGroup_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 0) {
      SUBezierSelectGroup(labelText: "최근 사용", showsDivider: true) {
        SUBezierSelectOption(title: "한국어", isSelected: true, onSelect: {})
        SUBezierSelectOption(title: "English", onSelect: {})
      }
      SUBezierSelectGroup(labelText: "전체") {
        SUBezierSelectOption(title: "日本語", onSelect: {})
        SUBezierSelectOption(title: "Español", onSelect: {})
      }
    }
    .padding()
  }
}
