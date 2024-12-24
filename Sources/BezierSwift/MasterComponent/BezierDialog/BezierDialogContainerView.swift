//
//  BezierDialogContainerView.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

private enum Metric {
  static let dialogHorizontalPadding = 40.f
}

private enum ZIndex {
  static let dim = 1.0
  static let dialog = 2.0
}

struct BezierDialogContainerView: View {
  @StateObject private var viewModel: BezierDialogViewModel
  
  init(viewModel: BezierDialogViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack {
      if self.viewModel.item.isNotNil {
        BezierColor.bgAbsoluteBlackLighter.color
          .ignoresSafeArea()
          .zIndex(ZIndex.dim)
      }
      
      if let item = self.viewModel.item {
        BezierDialog(param: item.param)
          .padding(.horizontal, Metric.dialogHorizontalPadding)
          .zIndex(ZIndex.dialog)
      }
    }
  }
}

