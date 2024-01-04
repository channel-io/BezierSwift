//
//  BezierDialogViewModel.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

final class BezierDialogViewModel: ObservableObject {
  @Published var item: BezierDialogItem?
  
  func update(item: BezierDialogItem) {
    guard
      self.item.isNil
        || item.param.priority.rawValue < self.item?.param.priority.rawValue ?? 0
    else {
      item.onDismiss?()
      return
    }
    
    animationWithCompletion(.easeInOut) { [weak self] in
      self?.clearItem()
    } completion: { [weak self] in
      withAnimation(.easeInOut) { [weak self] in
        self?.item = item
      }
    }
  }
  
  func dismiss(with id: UUID) {
    guard self.item?.id == id else { return }
    
    withAnimation(.easeInOut) { [weak self] in
      self?.clearItem()
    }
  }
  
  func dismiss() {
    withAnimation(.easeInOut) { [weak self] in
      self?.clearItem()
    }
  }
  
  private func clearItem() {
    self.item?.onDismiss?()
    self.item = nil
  }
}
