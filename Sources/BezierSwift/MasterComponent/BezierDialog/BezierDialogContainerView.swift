//
//  BezierDialogContainerView.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

struct BezierDialogContainerView: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @StateObject private var viewModel: BezierDialogViewModel
  
  public init(viewModel: BezierDialogViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    if let item = self.viewModel.item {
      BezierDialog(param: item.param)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}

