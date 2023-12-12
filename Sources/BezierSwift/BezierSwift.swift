//
//  BezierSwift.swift
//
//
//  Created by Jam on 2022/12/02.
//

import UIKit

public final class BezierSwift {
  static let shared = BezierSwift()
  
  private init() { }
  
  let toastViewModel = BezierToastViewModel()
  let dialogViewModel = BezierDialogViewModel()

  var bezierWindow: BezierWindow?
  var canInitialize: Bool { self.bezierWindow.isNil }
  var allowHitTest: Bool { self.dialogViewModel.item.isNotNil }
}

extension BezierSwift {
  @available(iOS, deprecated: 16.0)
  @MainActor
  public static func initializeWindow(windowLevel: UIWindow.Level = .statusBar - 1) {
    guard BezierSwift.shared.canInitialize else { return }
            
    BezierSwift.shared.bezierWindow = BezierWindow(frame: UIScreen.main.bounds)
  }
  
  @MainActor
  public static func initializeWindow(windowScene: UIWindowScene, windowLevel: UIWindow.Level = .statusBar - 1) {
    guard BezierSwift.shared.canInitialize else { return }
    
    BezierSwift.shared.bezierWindow = BezierWindow(windowScene: windowScene)
  }
}

extension BezierSwift {
  public static func showToast(param: BezierToastParam) {
    BezierSwift.shared.toastViewModel.appendToastItem(BezierToastItem(param: param))
  }
  
  public static func showToast(item: BezierToastItem) {
    BezierSwift.shared.toastViewModel.appendToastItem(item)
  }
}

extension BezierSwift {
  public static func showDialog(param: BezierDialogParam) {
    BezierSwift.shared.dialogViewModel.update(item: BezierDialogItem(param: param))
  }
  
  public static func showDialog(item: BezierDialogItem) {
    BezierSwift.shared.dialogViewModel.update(item: item)
  }
  
  public static func dismissDialog(id: UUID) {
    BezierSwift.shared.dialogViewModel.dismiss(with: id)
  }
  
  public static func dismissDialog() {
    BezierSwift.shared.dialogViewModel.dismiss()
  }
}
 
