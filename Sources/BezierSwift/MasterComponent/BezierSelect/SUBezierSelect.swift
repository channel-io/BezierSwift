//
//  SUBezierSelect.swift
//  BezierSwift
//

import SwiftUI

/// 미리 정의된 선택지 중 하나를 고르는 단일 선택 목록 (SwiftUI). 선택적 라벨 + 선택지 목록으로 구성되며, `container`로 인라인 배치(`page`)와 오버레이 카드(`overlay`) 중 하나를 고른다. 목록 콘텐츠에는 `SUBezierSelectGroup`/`SUBezierSelectOption`을 넣는다. 진입 트리거·열림/닫힘·앵커 포지셔닝은 사용처 책임이다. UIKit에서는 `BezierSelect`를 사용한다.
public struct SUBezierSelect<Content: View>: View {
  private let container: BezierSelectContainer
  private let labelText: String?
  private let content: Content

  /// 표현 방식·라벨 텍스트·목록 빌더로 목록을 만든다. 라벨은 목록 전체의 맥락을 나타내며, 그룹별 라벨이 필요하면 `SUBezierSelectGroup`의 `labelText`를 쓴다.
  public init(
    container: BezierSelectContainer = .page,
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
      self.list
    case .overlay:
      SUBezierOverlay { self.list }
    }
  }

  private var list: some View {
    VStack(alignment: .leading, spacing: 0) {
      if let labelText = self.labelText, !labelText.isEmpty {
        SUBezierSectionLabel(labelText, color: .neutralLight)
      }

      self.content
    }
  }
}

struct SUBezierSelect_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 32) {
      SUBezierSelect(labelText: "언어") {
        SUBezierSelectOption(title: "한국어", isSelected: true, onSelect: {})
        SUBezierSelectOption(title: "English", onSelect: {})
        SUBezierSelectOption(title: "日本語", onSelect: {})
      }

      SUBezierSelect(container: .overlay) {
        SUBezierSelectGroup(labelText: "정렬 기준") {
          SUBezierSelectOption(title: "최신순", leading: .icon(.arrowUp), isSelected: true, onSelect: {})
          SUBezierSelectOption(title: "오래된순", leading: .icon(.arrowDown), onSelect: {})
        }
      }
    }
    .padding()
    .background(Color.gray.opacity(0.15))
  }
}
