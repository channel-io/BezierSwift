//
//  ViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/27.
//

import UIKit
import BezierSwift
import SnapKit

final class ViewController: UIViewController {
  private var clickCount = 1

  lazy var bezierButton = UIBezierButton(
    configuration: BezierButtonConfiguration(
      text: "퓨어 버튼 \(self.clickCount)",
      variant: .primary,
      color: .blue
    )
  )

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = BezierColor.bgWhiteNormal.uiColor
    self.view.addSubview(self.bezierButton)

    self.bezierButton.snp.makeConstraints {
      $0.center.equalToSuperview()
    }

    self.bezierButton.addAction(
      UIAction { _ in  self.bezierButtonTapped() },
      for: .touchUpInside
    )
  }

  private func bezierButtonTapped() {
    self.bezierButton.isLoading = true
    let remainder = self.clickCount % 3

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.clickCount += 1

      self.bezierButton.update { configuration in
        switch remainder {
        case 0:
          configuration.variant = .secondary
          configuration.color = .blue
          configuration.size = .large
          configuration.text = "Secondary 블루 라지 (\(self.clickCount))"
          configuration.prefixContent = .icon(.bot)
          configuration.suffixContent = .icon(.api)
        case 1:
          configuration.variant = .tertiary
          configuration.color = .cobalt
          configuration.size = .small
          configuration.text = "Tertiary 코발트 스몰 (\(self.clickCount))"
          configuration.prefixContent = .icon(.wifi)
          configuration.suffixContent = nil
        case 2:
          configuration.variant = .primary
          configuration.color = .orange
          configuration.size = .medium
          configuration.text = "Primary 오랜지 미디엄 (\(self.clickCount))"
          configuration.prefixContent = nil
          configuration.suffixContent = .icon(.chatBubble)
        default: break
        }
      }

      self.bezierButton.isLoading = false
    }
  }
}
