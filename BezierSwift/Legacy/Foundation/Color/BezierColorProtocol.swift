//
//  BezierColorProtocol.swift
//  
//
//  Created by Tom on 2023/06/27.
//

import UIKit

public enum BezierColorTheme {
  case light
  case dark
  
  static public func systemBezierColorTheme() -> Self {
    return UITraitCollection.current.userInterfaceStyle != .dark ? .light : .dark
  }
}

public enum BezierComponentTheme {
  case normal
  case inverted
}

public protocol BezierComponentable: AnyObject {
  var colorTheme: BezierColorTheme { get }
  var componentTheme: BezierComponentTheme { get }
}
