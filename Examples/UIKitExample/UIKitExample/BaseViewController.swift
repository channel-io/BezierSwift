//
//  BaseViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/28.
//

import UIKit
import LegacyBezierSwift

class BaseViewController: UIViewController, BezierComponentable {
  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal
}
