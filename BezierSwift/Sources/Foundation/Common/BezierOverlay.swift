//
//  BezierOverlay.swift
//
//
//  Created by Tom on 10/15/24.
//

import SwiftUI

extension View {
  // TODO: 백포트 목적으로 추가 했으며, 최소 버전을 iOS 15 로 올렸을 때 제거가 필요합니다. by Tom 2024.10.15
  public func bezierOverlay<Content: View>(
    alignment: Alignment = .center,
    @ViewBuilder content: () -> Content
  ) -> some View {
    self
      .overlay(content(), alignment: alignment)
  }
}
