//
//  BezierAvatarGroup.swift
//
//
//  Created by Tom on 9/16/24.
//

import SwiftUI

private enum Metric {
  static let countSpacing: CGFloat = 4
}

private enum Constant {
  static let maxOverflowCount: Int = 99
}

public struct BezierAvatarGroup: View {
  public enum GroupType {
    case spread
    case stack
  }
  
  public enum EllipsisType {
    case icon
    case count
  }
  
  public let images: [BezierImageSource]
  private let type: GroupType
  private let size: BezierAvatar.Size
  private let max: Int
  private let ellipsisType: EllipsisType
  
  public init(
    images: [BezierImageSource],
    type: GroupType,
    size: BezierAvatar.Size = .pt24,
    max: Int = 5,
    ellipsisType: EllipsisType
  ) {
    self.images = images
    self.type = type
    self.size = size
    self.max = max
    self.ellipsisType = ellipsisType
  }
  
  public var body: some View {
    HStack(spacing: Metric.countSpacing) {
      HStack(spacing: self.groupSpacing) {
        ForEach(0..<min(self.max, self.images.count), id: \.self) { i in
          if let image = self.images[safe: i] {
            BezierAvatar(image: image, size: self.size)
              .outlineBorder(self.shouldShowOutlineBorder)
              .ellipsis(self.shouldShowEllipsisIcon(for: i))
          }
        }
      }
      if self.ellipsisType == .count, let overflowCount {
        Text("+\(overflowCount)")
          .applyBezierFontStyle(.caption2SemiBold, bezierColor: .fgBlackDark)
      }
    }
  }
}

// - MARK: Style
extension BezierAvatarGroup {
  private var groupSpacing: CGFloat {
    switch self.type {
    case .spread: return 4
    case .stack:
      switch self.size {
      case .pt120: return -20
      case .pt72: return -14
      case .pt24: return -4
      case .pt20: return -2
      default: return 0
      }
    }
  }
  
  private var shouldShowOutlineBorder: Bool {
    return self.type == .stack
  }
  
  private var overflowCount: Int? {
    return self.images.count > self.max 
    ? min(self.images.count - self.max, Constant.maxOverflowCount)
    : nil
  }
  
  private func shouldShowEllipsisIcon(for index: Int) -> Bool {
    return self.ellipsisType == .icon
    && self.overflowCount != nil
    && index >= self.max - 1
  }
}
