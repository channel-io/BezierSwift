//
//  BaseViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/28.
//

import UIKit
import BezierSwift

class BaseViewController: UIViewController, BezierComponentable {
  var colorTheme: BezierColorTheme = .light
  var componentTheme: BezierComponentTheme = .normal
}
