//
//  ViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/27.
//

import UIKit
import BezierSwift

class ViewController: UIViewController, BezierComponentable {
  var colorTheme: BezierColorTheme = .light
  var componentTheme: BezierComponentTheme = .normal
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = SemanticColor.bgtxtRedDark.palette(self)
  }
}

