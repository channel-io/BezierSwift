//
//  BezierToastContainerView.swift
//  
//
//  Created by woody on 2023/03/31.
//

import Foundation
import SwiftUI

import Combine

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

private enum Metric {
  static let topPadding = CGFloat(5)
}

public struct BezierToastContainerView: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @StateObject private var viewModel: BezierToastViewModel
  
  public init(viewModel: BezierToastViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ZStack(alignment: .top) {
      Color.clear
      ForEach(self.viewModel.toastItems) { item in
        BezierToast(item: item)
          .transition(.toast(position: item.param.toastPosition))
      }
    }
    .padding(.top, Metric.topPadding)
    .allowsHitTesting(false)
  }
}

