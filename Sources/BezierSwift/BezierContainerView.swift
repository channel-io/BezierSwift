//
//  BezierContainerView.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

public struct BezierContainerView: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  
  public var body: some View {
    ZStack {
      BezierDialogContainerView(viewModel: BezierSwift.shared.dialogViewModel)
      BezierToastContainerView(viewModel: BezierSwift.shared.toastViewModel)
    }
  }
}

