//
//  BezierToastViewModel.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI
import Combine

private enum Constant {
  static let maxToastCount = 1
  static let autoDismissTime = CGFloat(3)
}

public final class BezierToastViewModel: ObservableObject {
  @Published private(set) var toastItems: [BezierToastItem] = []
  private var timerCancelBags: [UUID: AnyCancellable] = [:]
  
  func appendToastItem(_ item: BezierToastItem) {
    while self.toastItems.count >= Constant.maxToastCount {
      self.removeToastItem(index: 0)
    }
    
    withAnimation(.toastInsertion) {
      self.toastItems.append(item)
    }
    
    self.timerCancelBags[item.uuid] = Timer.publish(every: Constant.autoDismissTime, on: .main, in: .default)
      .autoconnect()
      .prefix(1)
      .sink { _ in
        guard let index = self.toastItems.firstIndex(where: { $0.id == item.id }) else { return }
        
        self.removeToastItem(index: index)
      }
  }
  
  private func removeToastItem(index: Int) {
    withAnimation(.toastRemoval) {
      guard index < self.toastItems.count else { return }
      
      let toastItem = self.toastItems.remove(at: index)
      toastItem.binding?.wrappedValue = nil
      self.timerCancelBags[toastItem.id]?.cancel()
      self.timerCancelBags[toastItem.id] = nil
    }
  }
}
