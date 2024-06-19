//
//  UIKitExampleView.swift
//  SwiftUIExample
//
//  Created by 구본욱 on 6/19/24.
//

import SwiftUI

struct UIKitExampleView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UIKitExampleViewController {
    return UIKitExampleViewController()
  }
  
  func updateUIViewController(_ uiViewController: UIKitExampleViewController, context: Context) {
  }
}
