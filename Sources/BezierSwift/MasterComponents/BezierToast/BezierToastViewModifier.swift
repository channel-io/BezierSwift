//
//  BezierToastViewModifier.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

@available(iOS 15.0, *)
struct BezierToastViewModifier: ViewModifier {
  @Binding private var info: BezierToastInfo?
  
  init(info: Binding<BezierToastInfo?>) {
    self._info = info
  }
  
  func body(content: Content) -> some View {
    content
      .onChange(of: self.info) { newValue in
        self.present()
      }
  }
  
  func present() {
    let keyWindow = UIApplication.shared.connectedScenes
      .map { $0 as? UIWindowScene }
      .compactMap { $0 }
      .first?.windows
      .first { $0.isKeyWindow }
    
    guard let keyWindow, let info else { return }
    
    keyWindow.subviews.forEach {
      guard $0 is BezierToastHostingView else { return }
      
      $0.removeFromSuperview()
    }
    
    let toastView = BezierToast(info: info)
    
    guard let toastUIView = BezierToastHostingController(rootView: toastView).view else { return }
    
    keyWindow.addSubview(toastUIView)
    
    let toastConstraints = [
      toastUIView.topAnchor.constraint(equalTo: keyWindow.topAnchor),
      toastUIView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
      toastUIView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
      toastUIView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(toastConstraints)
  }
}
