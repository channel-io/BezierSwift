//
//  ViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/27.
//

import UIKit
import BezierSwift

final class ViewController: BaseViewController {
  private enum Font {
    case title
    
    func attributedString(_ component: BezierComponentable) -> NSAttributedString {
      switch self {
      case .title: return BezierFont.bold22.attributedString(component, text: "hello world")        
      }
    }
  }
  
  private lazy var titleLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 1
    $0.attributedText = Font.title.attributedString(self)
    return $0
  }(UILabel())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = SemanticColor.bgtxtRedDark.palette(self)
    
    self.view.addSubview(self.titleLabel)
    
    NSLayoutConstraint.activate([
      self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
    
    let tap = UITapGestureRecognizer()
    self.view.addGestureRecognizer(tap)
    tap.addTarget(self, action: #selector(tapped))
  }
  
  @objc func tapped() {
    print("👍👍👍👍👍")
    BezierSwift.showToast(with: BezierToastParam(title: "👍👍👍👍👍"))
  }
}

