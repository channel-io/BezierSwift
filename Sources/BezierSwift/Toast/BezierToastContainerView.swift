//
//  BezierToastContainerView.swift
//  BezierSwift
//

import SwiftUI

private enum Metric {
  static let topPadding = CGFloat(5)
}

struct BezierToastContainerView: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  @StateObject private var viewModel: BezierToastViewModel

  init(viewModel: BezierToastViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    ZStack(alignment: .top) {
      Color.clear
      ForEach(self.viewModel.toastPresentations) { presentation in
        self.cell(for: presentation)
          .transition(.toast(position: presentation.position))
      }
    }
    .padding(.top, Metric.topPadding)
    .allowsHitTesting(false)
  }

  @ViewBuilder
  private func cell(for presentation: BezierToastPresentation) -> some View {
    switch presentation.content {
    case .legacy(let param):
      LegacyBezierToast(param: param)
    case .v3(let preset, let title):
      SUBezierToast(preset: preset, title: title)
    }
  }
}
