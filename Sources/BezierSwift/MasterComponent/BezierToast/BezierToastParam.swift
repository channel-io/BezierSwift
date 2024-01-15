//
//  BezierToastParam.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI

public struct BezierToastParam: Equatable {
  let title: String
  let toastPosition: BezierToastPosition
  let leftItem: BezierToastLeftItem?
  
  public init(title: String, leftItem: BezierToastLeftItem? = nil) {
    self.title = title
    self.toastPosition = .top
    self.leftItem = leftItem
  }
}

public enum BezierToastLeftItem: Equatable {
  // TODO: 추후 이모지 지원 작업하기
  // by woody 2003.31
  // case emoji(name: String)
  case icon(image: Image, color: SemanticColor)

  var length: CGFloat { return 20 }
  var top: CGFloat { return 3 }
  
  public static func == (lhs: BezierToastLeftItem, rhs: BezierToastLeftItem) -> Bool {
    switch (lhs, rhs) {
    case (.icon(let lhsImage, let lhsColor), .icon(let rhsImage, let rhsColor)):
      return lhsImage == rhsImage
      && lhsColor.light == rhsColor.light
      && lhsColor.dark == rhsColor.dark
    }
  }
}

public enum BezierToastPosition: Equatable {
  case top

  var startOffsetY: CGFloat {
    switch self {
    case .top: return -16
    }
  }

  var endOffsetY: CGFloat {
    switch self {
    case .top: return 4
    }
  }
}
