//
//  BezierDialogItem.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

public struct BezierDialogItem: Identifiable {
  let param: BezierDialogParam
  let onDismiss: (() -> Void)?
  public let id = UUID()

  public init(param: BezierDialogParam, onDismiss: (() -> Void)? = nil) {
    self.param = param
    self.onDismiss = onDismiss
  }
}
