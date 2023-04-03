//
//  BezierToastHostingController.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

final class BezierToastHostingView: UIView { }

final class BezierToastHostingController<Content>: UIViewController where Content: View {
  private var hostingController: UIHostingController<Content>?
  
  init(rootView: Content) {
    self.hostingController = UIHostingController(rootView: rootView)
    
    super.init(nibName: nil, bundle: nil)
    
    self.initViews()
    self.setupLayouts()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initViews() {
    guard let toastView = self.hostingController?.view else { return }
    
    self.view = BezierToastHostingView()
    self.view.addSubview(toastView)
    
    self.view.layer.zPosition = 1
    self.view.backgroundColor = .clear
    self.view.isUserInteractionEnabled = false
    self.view.translatesAutoresizingMaskIntoConstraints = false
    
    toastView.backgroundColor = .clear
    toastView.isUserInteractionEnabled = false
    toastView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupLayouts() {
    guard let toastView = self.hostingController?.view else { return }
    
    let toastConstraints = [
      toastView.topAnchor.constraint(equalTo: self.view.topAnchor),
      toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      toastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(toastConstraints)
  }
}


