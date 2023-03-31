//
//  BezierToastViewModifier.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

struct BezierToastViewModifier: ViewModifier {
  @Binding private var viewModel: BezierToastViewModel?
  
  init(viewModel: Binding<BezierToastViewModel?>) {
    self._viewModel = viewModel
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: self.viewModel) { viewModel in
        guard let viewModel else { return }
        
        self.present(with: viewModel)
      }
  }
  
  func present(with viewModel: BezierToastViewModel) {
    let keyWindow = UIApplication.shared.connectedScenes
      .map { $0 as? UIWindowScene }
      .compactMap { $0 }
      .first?.windows
      .first { $0.isKeyWindow }
    
    guard let keyWindow else { return }
    
    keyWindow.subviews.forEach {
      guard $0 is BezierToastHostingView else { return }
      
      $0.removeFromSuperview()
    }
    
    let toastView = BezierToast(viewModel: viewModel)
    
    guard let toastUIView = BezierToastHostingController(rootView: toastView).view else { return }
    
    keyWindow.addSubview(toastUIView)
    
    let toastConstraints = [
      toastUIView.topAnchor.constraint(equalTo: keyWindow.topAnchor),
      toastUIView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
      toastUIView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
      toastUIView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(toastConstraints)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
      self.viewModel = nil
    }
  }
}

struct BezierToastViewModifier1: ViewModifier {
  func body(content: Content) -> some View {
    content
  }
}
