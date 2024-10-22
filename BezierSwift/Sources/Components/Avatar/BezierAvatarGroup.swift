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
  
  private let images: [BezierImageSource]
  private let type: GroupType
  private let size: BezierAvatar.Size
  private let max: Int
  private let ellipsisType: EllipsisType
  
  // MARK: Initializer
  /// - Parameters:
  ///   - images: 아바타는 사용자가 업로드한 이미지를 표현합니다. 이미지가 없을 경우 `fallback` 이미지를 표현합니다.
  ///   - type: 아바타 그룹에서 아바타를 배치하는 기본 구성방식입니다.
  ///     - spread: 일정 간격을 두고 아바타를 배치하는 기본 구성방식입니다.
  ///     - stack: 아바타를 서로 겹치게 두는 구성방식으로 좁은 공간에서도 효율적으로 사용할 수 있습니다.
  ///   - size: 아바타의 사이즈는 `16pt`, `20pt`, `24pt`, `30pt`, `36pt`, `42pt`, `48pt`, `72pt`, `90pt`, `120pt` 로 총 10개 사이즈를 가집니다. 주변 요소와의 균형감, 아바타 요소의 중요도에 따라 적절한 사이즈를 선택합니다. 아바타 그룹에서는 `20pt`, `24pt`를 권장합니다.
  ///   - max: 아바타가 보여지는 최대 개수를 의미합니다. 5개를 기본으로 합니다.
  ///   - ellipsisType: 생략된 아바타가 있음을 표시합니다.
  ///     - icon: 생략된 아바타가 있음을 more icon 으로 생략하여 표시합니다. 숫자가 연속해서 등장하는 경우에 권장됩니다.
  ///     - count: 생략된 아바타의 개수를 숫자로 표시하여 정확한 수를 알 수 있습니다.
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
    .compositingGroup()
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

#Preview("Stack + Icon") {
  BezierAvatarGroup(
    images: Array(repeating: .avatar(url: URL(string: "")), count: 10),
    type: .stack,
    ellipsisType: .icon
  )
}

#Preview("Spread + Count") {
  BezierAvatarGroup(
    images: Array(repeating: .avatar(url: URL(string: "")), count: 10),
    type: .spread,
    ellipsisType: .count
  )
}
