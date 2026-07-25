//
//  LegacyBezierToastItem.swift
//  BezierSwift
//

import SwiftUI

public struct LegacyBezierToastItem: Identifiable {
  let param: LegacyBezierToastParam
  let onDismiss: (() -> Void)?
  public let id = UUID()

  public init(param: LegacyBezierToastParam, onDismiss: (() -> Void)? = nil) {
    self.param = param
    self.onDismiss = onDismiss
  }
}
