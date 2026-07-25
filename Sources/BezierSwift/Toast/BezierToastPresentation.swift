//
//  BezierToastPresentation.swift
//  BezierSwift
//

import Foundation

/// 전역 Toast 파이프라인이 렌더할 콘텐츠 종류. 큐/애니메이션/호스팅 인프라는 이 종류에 무관하게 동작한다.
enum BezierToastContentKind {
  case legacy(LegacyBezierToastParam)
  case v3(preset: BezierToastPreset, title: String)
}

/// 큐에 적재되는 Toast 표시 단위. 콘텐츠(kind)와 표시 위치, dismiss 콜백을 담는 content-agnostic 컨테이너.
struct BezierToastPresentation: Identifiable {
  let id = UUID()
  let content: BezierToastContentKind
  let position: BezierToastPosition
  let onDismiss: (() -> Void)?

  init(
    content: BezierToastContentKind,
    position: BezierToastPosition = .top,
    onDismiss: (() -> Void)? = nil
  ) {
    self.content = content
    self.position = position
    self.onDismiss = onDismiss
  }
}
