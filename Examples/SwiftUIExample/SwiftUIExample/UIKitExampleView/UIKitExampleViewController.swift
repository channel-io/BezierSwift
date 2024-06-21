//
//  UIKitExampleViewController.swift
//  SwiftUIExample
//
//  Created by 구본욱 on 6/19/24.
//

import UIKit
import BezierSwift

class UIKitExampleViewController: UIViewController {

  private var buttonClickCount: Int = 0

  private let scrollView = UIScrollView()
  private let stackView = UIStackView()
  private lazy var bezierButton = UIBezierButton(
    configuration: BezierButtonConfiguration(
      text: "버튼 타이틀",
      variant: .primary,
      color: .cobalt,
      size: .xlarge,
      prefixContent: nil,
      suffixContent: nil,
      action: { [weak self] in
        self?.updateButtonClickCount()
      }
    )
  )

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(self.bezierButton)

    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.axis = .vertical
    self.stackView.distribution = .fillProportionally
    self.stackView.alignment = .leading
    self.stackView.spacing = 10

    self.bezierButton.isUserInteractionEnabled = true
    self.bezierButton.isEnabled = true

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

  private func updateButtonClickCount() {
    self.buttonClickCount += 1
    self.bezierButton.update(text: "버튼 클릭 \(self.buttonClickCount)")
  }
}
