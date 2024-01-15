//
//  BezierDialogViewModel.swift
//
//
//  Created by woody on 12/11/23.
//

import SwiftUI

private enum Constant {
  static let animationDuration = 0.35.f
}

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
    
    guard self.item.isNotNil else {
      withAnimation(.easeInOut(duration: Constant.animationDuration)) { [weak self] in
        self?.item = item
      }
      return
    }
    
    animationWithCompletion(.easeInOut(duration: Constant.animationDuration)) { [weak self] in
      self?.clearItem()
    } completion: { [weak self] in
      withAnimation(.easeInOut(duration: Constant.animationDuration)) { [weak self] in
        self?.item = item
      }
    }
  }
  
  func dismiss(with id: UUID) {
    guard self.item?.id == id else { return }
    
    withAnimation(.easeInOut(duration: Constant.animationDuration)) { [weak self] in
      self?.clearItem()
    }
  }
  
  func dismiss() {
    withAnimation(.easeInOut(duration: Constant.animationDuration)) { [weak self] in
      self?.clearItem()
    }
  }
  
  private func clearItem() {
    self.item?.onDismiss?()
    self.item = nil
  }
  
  private func animationWithCompletion(
    _ animation: Animation,
    _ body: () throws -> Void,
    completion: @escaping () -> Void
  ) rethrows {
    if #available(iOS 17.0, *) {
      try withAnimation(animation, body, completion: completion)
    } else {
      try withAnimation(animation, body)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + Constant.animationDuration) {
        completion()
      }
    }
  }
}
