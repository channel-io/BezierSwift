//
//  SwiftUIView.swift
//  
//
//  Created by Tom on 9/3/24.
//

import SwiftUI

private enum Constant {
  static let cornerRadiusRatio = 0.42
  static let minSize = 16.0
}

public struct BezierAvatarShape: Shape {
  public func path(in rect: CGRect) -> Path {
    // NOTE: Bezier v1 스펙으로 16 size 이하에서는 Smooth radius 대신 Circle 로 변경됩니다.
    if min(rect.width, rect.height) > Constant.minSize {
      RoundedRectangle(cornerRadius: min(rect.width, rect.height) * Constant.cornerRadiusRatio, style: .continuous)
        .path(in: rect)
    } else {
      Circle()
        .path(in: rect)
    }
  }
}
