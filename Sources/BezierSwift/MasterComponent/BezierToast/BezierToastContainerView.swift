//
//  BezierToastContainerView.swift
//
//
//  Created by woody on 2023/03/31.
//

import SwiftUI

private enum Metric {
  static let topPadding = CGFloat(5)
}

struct BezierToastContainerView: View {
  @StateObject private var viewModel: BezierToastViewModel
  
  init(viewModel: BezierToastViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.clear
      ForEach(self.viewModel.toastItems) { item in
        BezierToast(param: item.param)
          .transition(.toast(position: item.param.toastPosition))
      }
    }
    .padding(.top, Metric.topPadding)
    .allowsHitTesting(false)
  }
}

