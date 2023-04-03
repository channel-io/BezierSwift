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
      withAnimation(.toastRemoval) {
        let toastItem = self.toastItems.removeFirst()
        toastItem.binding?.wrappedValue = nil
        self.timerCancelBags[toastItem.uuid]?.cancel()
        self.timerCancelBags[toastItem.uuid] = nil
      }
    }
    
    withAnimation(.toastInsertion) {
      self.toastItems.append(item)
    }
    
    self.timerCancelBags[item.uuid] = Timer.publish(every: Constant.autoDismissTime, on: .main, in: .default)
      .autoconnect()
      .prefix(1)
      .sink { _ in
        guard let index = self.toastItems.firstIndex(where: { $0.uuid == item.uuid }) else { return }
        
        withAnimation(.toastRemoval) {
          self.toastItems.remove(at: index)
          self.timerCancelBags[item.uuid] = nil
        }
      }
  }
}
