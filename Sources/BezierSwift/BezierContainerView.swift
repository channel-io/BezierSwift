//
//  BezierContainerView.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

private enum ZIndex {
  static let toast = 1.0
  static let dialog = 2.0
}

struct BezierContainerView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    ZStack {
      BezierToastContainerView(viewModel: BezierSwift.shared.toastViewModel)
        .zIndex(ZIndex.toast)
      BezierDialogContainerView(viewModel: BezierSwift.shared.dialogViewModel)
        .zIndex(ZIndex.dialog)
    }
  }
}

