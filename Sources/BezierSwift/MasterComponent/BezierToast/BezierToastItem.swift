//
//  BezierToastItem.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI

public struct BezierToastItem: Identifiable {
  let param: BezierToastParam
  let onDismiss: (() -> Void)?
  public let id = UUID()

  public init(param: BezierToastParam, onDismiss: (() -> Void)? = nil) {
    self.param = param
    self.onDismiss = onDismiss
  }
}
