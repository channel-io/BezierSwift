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
  
  var bezierWindow: BezierWindow?
  var canInitialize: Bool { self.bezierWindow == nil }
}

extension BezierSwift {
  @available(iOS, deprecated: 16.0)
  @MainActor
  public static func initializeWindow() {
    guard BezierSwift.shared.canInitialize else { return }
            
    BezierSwift.shared.bezierWindow = BezierWindow(frame: UIScreen.main.bounds)
  }
  
  @MainActor
  public static func initializeWindow(windowScene: UIWindowScene) {
    guard BezierSwift.shared.canInitialize else { return }
    
    BezierSwift.shared.bezierWindow = BezierWindow(windowScene: windowScene)
  }
}

extension BezierSwift {
  public static func showToast(with param: BezierToastParam) {
    BezierSwift.shared.toastViewModel.appendToastItem(BezierToastItem(param: param))
  }
}
