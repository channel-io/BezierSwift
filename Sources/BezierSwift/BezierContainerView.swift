//
//  BezierContainerView.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

private enum Metric {
  static let topPadding = CGFloat(5)
}

public struct BezierContainerView: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  
  public var body: some View {
    ZStack {
      BezierToastContainerView(viewModel: BezierSwift.shared.toastViewModel)
    }
    .padding(.top, Metric.topPadding)
    .background(Color.clear)
  }
}

