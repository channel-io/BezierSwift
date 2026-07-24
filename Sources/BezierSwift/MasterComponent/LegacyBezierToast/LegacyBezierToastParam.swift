//
//  LegacyBezierToastParam.swift
//  BezierSwift
//

import SwiftUI

public struct LegacyBezierToastParam: Equatable {
  let title: String
  let toastPosition: BezierToastPosition
  let leftItem: LegacyBezierToastLeftItem?

  public init(title: String, leftItem: LegacyBezierToastLeftItem? = nil) {
    self.title = title
    self.toastPosition = .top
    self.leftItem = leftItem
  }
}

public enum LegacyBezierToastLeftItem: Equatable {
  case icon(image: Image, color: SemanticColor)

  var length: CGFloat { return 20 }
  var top: CGFloat { return 3 }

  public static func == (lhs: LegacyBezierToastLeftItem, rhs: LegacyBezierToastLeftItem) -> Bool {
    switch (lhs, rhs) {
    case (.icon(let lhsImage, let lhsColor), .icon(let rhsImage, let rhsColor)):
      return lhsImage == rhsImage
      && lhsColor.light == rhsColor.light
      && lhsColor.dark == rhsColor.dark
    }
  }
}
