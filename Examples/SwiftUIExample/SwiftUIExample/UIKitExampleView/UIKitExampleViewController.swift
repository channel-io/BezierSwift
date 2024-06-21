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
  private lazy var normalButton = UIBezierButton(
    configuration: BezierButtonConfiguration(
      text: "버튼 타이틀",
      variant: .primary,
      color: .cobalt,
      size: .xlarge,
      prefixContent: nil,
      suffixContent: .icon(.chatBubbleAlt)
    )
  )
  private lazy var disabledButton = UIBezierButton(
    configuration: BezierButtonConfiguration(
      text: "Disabled",
      variant: .secondary,
      color: .orange,
      size: .xlarge,
      prefixContent: .icon(.all),
      suffixContent: nil
    )
  )
  private lazy var loadingButton = UIBezierButton(
    configuration: BezierButtonConfiguration(
      text: "Loading",
      variant: .tertiary,
      color: .orange,
      size: .xlarge,
      prefixContent: .icon(.all),
      suffixContent: nil
    )
  )

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.stackView)
    self.stackView.addArrangedSubview(self.normalButton)
    self.stackView.addArrangedSubview(self.disabledButton)
    self.stackView.addArrangedSubview(self.loadingButton)

    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.translatesAutoresizingMaskIntoConstraints = false
    self.stackView.axis = .vertical
    self.stackView.distribution = .fillProportionally
    self.stackView.alignment = .center
    self.stackView.spacing = 10

    self.disabledButton.isEnabled = false
    self.loadingButton.isLoading = true

    self.normalButton.addAction(
      UIAction { _ in self.updateButtonClickCount() },
      for: .touchUpInside
    )

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
    self.normalButton.isLoading = true

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.buttonClickCount += 1
      self.normalButton.isLoading = false

      self.normalButton.update(text: "버튼 클릭 \(self.buttonClickCount)")
    }
  }
}
