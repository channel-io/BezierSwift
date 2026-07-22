//
//  BezierToastViewModel.swift
//  BezierSwift
//

import SwiftUI
import Combine

private enum Constant {
  static let maxToastCount = 1
  static let autoDismissTime = CGFloat(3)
}

/// 전역 Toast 큐/타이머 관리자. Legacy·V3 콘텐츠 모두 `BezierToastPresentation`으로 담아 동일하게 처리한다.
final class BezierToastViewModel: ObservableObject {
  @Published private(set) var toastPresentations: [BezierToastPresentation] = []
  private var timerCancelBags: [UUID: AnyCancellable] = [:]

  func append(_ presentation: BezierToastPresentation) {
    while self.toastPresentations.count >= Constant.maxToastCount {
      self.remove(index: 0)
    }

    withAnimation(.toastInsertion) { [weak self] in
      self?.toastPresentations.append(presentation)
    }

    self.timerCancelBags[presentation.id] = Timer.publish(every: Constant.autoDismissTime, on: .main, in: .common)
      .autoconnect()
      .prefix(1)
      .sink { [weak self] _ in
        guard let self, let index = self.toastPresentations.firstIndex(where: { $0.id == presentation.id }) else { return }

        self.remove(index: index)
      }
  }

  private func remove(index: Int) {
    withAnimation(.toastRemoval) { [weak self] in
      guard let self, index < self.toastPresentations.count else { return }

      let presentation = self.toastPresentations.remove(at: index)
      presentation.onDismiss?()
      self.timerCancelBags[presentation.id]?.cancel()
      self.timerCancelBags[presentation.id] = nil
    }
  }
}
