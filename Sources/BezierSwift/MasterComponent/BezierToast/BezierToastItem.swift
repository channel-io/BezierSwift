//
//  BezierToastItem.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI

struct BezierToastItem: Identifiable {
  let param: BezierToastParam
  let binding: Binding<BezierToastParam?>?
  let uuid = UUID()
  var id: UUID { self.uuid }
  
  init(param: BezierToastParam, binding: Binding<BezierToastParam?>? = nil) {
    self.param = param
    self.binding = binding
  }
}
