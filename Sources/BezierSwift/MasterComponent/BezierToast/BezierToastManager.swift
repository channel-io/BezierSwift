//
//  BezierToastManager.swift
//  
//
//  Created by woody on 2023/03/31.
//

import SwiftUI

public final class BezierToastManager {
  static let shared = BezierToastManager()
  
  private var isPrepared = false
  private let viewModel = BezierToastViewModel()
  
  private init() { }
  
  func prepare() {
    DispatchQueue.main.async {
      guard !self.isPrepared else { return }
      
      let keyWindow = UIApplication.shared.connectedScenes
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .first { $0.isKeyWindow }
      
      guard let keyWindow = keyWindow else { return }
      
      let bezierContainerView = BezierToastContainerView(viewModel: self.viewModel)
      let controller = BezierToastHostingController(rootView: bezierContainerView)
          
      guard let toastUIView = controller.view else { return }
      
      keyWindow.addSubview(toastUIView)
      
      NSLayoutConstraint.activate([
        toastUIView.topAnchor.constraint(equalTo: keyWindow.topAnchor),
        toastUIView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
        toastUIView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
        toastUIView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
      ])
      
      self.isPrepared = true
    }
  }
  
  public static func show(param: BezierToastParam) {
    DispatchQueue.main.async {
      BezierToastManager.shared.prepare()
      BezierToastManager.shared.viewModel.appendToastItem(BezierToastItem(param: param))
    }
  }
  
  static func show(item: BezierToastItem) {
    DispatchQueue.main.async {
      BezierToastManager.shared.prepare()
      BezierToastManager.shared.viewModel.appendToastItem(item)
    }
  }
}
