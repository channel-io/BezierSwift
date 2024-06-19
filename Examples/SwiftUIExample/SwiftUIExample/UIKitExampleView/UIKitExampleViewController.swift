//
//  UIKitExampleViewController.swift
//  SwiftUIExample
//
//  Created by 구본욱 on 6/19/24.
//

import UIKit
import BezierSwift

class UIKitExampleViewController: UIViewController {

  private let scrollView = UIScrollView()
  private let stackView = UIStackView()
  private let label = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(self.label)

    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.axis = .vertical
    self.stackView.distribution = .fillProportionally
    self.stackView.alignment = .leading
    self.stackView.spacing = 10

    self.label.text = "UIKit 예시를 위한 뷰"

    NSLayoutConstraint.activate([
      self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.stackView.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
      self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor),
      self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor),
      self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor)
    ])
  }
}
