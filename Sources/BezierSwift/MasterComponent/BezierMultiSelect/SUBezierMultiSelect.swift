//
//  SUBezierMultiSelect.swift
//  BezierSwift
//

import SwiftUI

/// 미리 정의된 선택지 중 여러 개를 고르는 복수 선택 목록 (SwiftUI). 선택적 라벨 + 선택지 목록으로 구성되며, `container`로 인라인 배치(`page`)와 오버레이 카드(`overlay`) 중 하나를 고른다. 목록 콘텐츠에는 `SUBezierMultiSelectGroup`/`SUBezierMultiSelectOption`을 넣는다. 진입 트리거·열림/닫힘·앵커 포지셔닝과 선택 집합 보관은 사용처 책임이다. UIKit에서는 `BezierMultiSelect`를 사용한다.
public struct SUBezierMultiSelect<Content: View>: View {
  private let container: BezierMultiSelectContainer
  private let labelText: String?
  private let content: Content

  /// 표현 방식·라벨 텍스트·목록 빌더로 목록을 만든다. 라벨은 목록 전체의 맥락을 나타내며 `container`가 `.page`일 때만 렌더된다 — `.overlay`에서 라벨이 필요하면 `SUBezierMultiSelectGroup`의 `labelText`를 쓴다.
  public init(
    container: BezierMultiSelectContainer = .page,
    labelText: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.container = container
    self.labelText = labelText
    self.content = content()
  }

  public var body: some View {
    switch self.container {
    case .page:
      self.list(showsLabel: true)
    case .overlay:
      SUBezierOverlay { self.list(showsLabel: false) }
    }
  }

  private func list(showsLabel: Bool) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      if showsLabel, let labelText = self.labelText, !labelText.isEmpty {
        SUBezierSectionLabel(labelText, color: .neutralLight)
      }

      self.content
    }
  }
}

struct SUBezierMultiSelect_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 32) {
      SUBezierMultiSelect(labelText: "태그") {
        SUBezierMultiSelectOption(title: "긴급", isSelected: true, onToggle: {})
        SUBezierMultiSelectOption(title: "VIP 고객", isSelected: true, onToggle: {})
        SUBezierMultiSelectOption(title: "재문의", onToggle: {})
      }

      SUBezierMultiSelect(container: .overlay) {
        SUBezierMultiSelectGroup(labelText: "담당자") {
          SUBezierMultiSelectOption(title: "김하나", leading: .icon(.person), isSelected: true, onToggle: {})
          SUBezierMultiSelectOption(title: "이두리", leading: .icon(.person), onToggle: {})
        }
      }
    }
    .padding()
    .background(Color.gray.opacity(0.15))
  }
}
