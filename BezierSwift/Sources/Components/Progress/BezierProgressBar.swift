//
//  BezierProgressBar.swift
//
//
//  Created by Tom on 9/16/24.
//

import SwiftUI

private enum Constant {
  static let maxProgress: CGFloat = 1.0
}

// - MARK: BezierProgressBar
public struct BezierProgressBar: View {
  // MARK: Size
  public enum Size {
    case small
    case medium
  }
  
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
    case overBackground
  }
  
  // MARK: Properties
  private let progress: CGFloat
  private let size: Size
  private let variant: Variant
  
  // MARK: Initializer
  /// - Parameters:
  ///   - progress: 진행 상태를 나타내는 값으로, 0.0에서 1.0 사이의 값을 사용합니다.
  ///   - size: 일반적으로 `medium` 사이즈를 사용하되, 영역이 좁은 경우 `small` 을 사용합니다.
  ///   - badge: `primary`을 일반적으로 사용하나, 중요도가 이보다 낮거나 시각적으로 너무 튀는 경우에는 `secondary` 를 사용할 수 있습니다. dimmed layer 와 함께 조합해서 사용되는 경우에는 bg 컬러가 다른 `overBackground`를 사용합니다.
  public init(
    progress: CGFloat,
    size: Size = .small,
    variant: Variant = .primary
  ) {
    self.progress = progress
    self.size = size
    self.variant = variant
  }
  
  // MARK: Body
  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        Capsule(style: .circular)
          .fill(self.trackColor.color)
          .frame(maxWidth: .infinity)
          .frame(height: self.height)
        Capsule(style: .circular)
          .fill(self.fillStyle)
          .frame(height: self.height)
          .frame(minWidth: self.minWidth)
          .frame(
            width: (proxy.size.width + self.minWidth) * min(self.progress, Constant.maxProgress),
            alignment: .leading
          )
      }
    }
  }
}

// - MARK: Style
extension BezierProgressBar {
  private var fillStyle: some ShapeStyle {
    switch self.variant {
    case .primary: BezierGradient.fgGreen.leadingToTrailing
    case .secondary: BezierGradient.fgBlack.leadingToTrailing
    case .overBackground: BezierGradient.fgGreen.leadingToTrailing
    }
  }
  
  private var trackColor: BezierColor {
    switch self.variant {
    case .primary: .bgBlackLight
    case .secondary: .bgBlackLight
    case .overBackground: .bgAbsoluteWhiteNormal
    }
  }
  
  private var height: CGFloat {
    switch self.size {
    case .small: 4
    case .medium: 6
    }
  }
  
  private var minWidth: CGFloat {
    self.progress.isZero ? 0 : self.height
  }
}

#Preview {
  BezierProgressBar(progress: 0.2, size: .medium)
}
