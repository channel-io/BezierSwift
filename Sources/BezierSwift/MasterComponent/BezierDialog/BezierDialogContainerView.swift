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

struct BezierDialogContainerView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  @StateObject private var viewModel: BezierDialogViewModel
  
  init(viewModel: BezierDialogViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack {
      if let item = self.viewModel.item {
        BezierDialog(param: item.param)
          .padding(.horizontal, Metric.dialogHorizontalPadding)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
    .background(
      Group {
        if self.viewModel.item.isNotNil {
          self.palette(.bgtxtAbsoluteBlackLighter)
            .ignoresSafeArea()
        }
      }
    )
  }
}

