//
//  BezierSwift.swift
//
//
//  Created by Tom on 7/3/24.
//

import UIKit

public protocol BezierSwiftDelegate: AnyObject {
  func windowsForThemeUpdate() -> [UIWindow]
}

public final class BezierSwift {
  // TODO: BezierSwift 용 Config 추가 by Tom 2024.07.04
  public private(set) var currentTheme: BezierTheme = .system
  public static var shared = BezierSwift()
  
  public weak var delegate: BezierSwiftDelegate?
  
  private init() {}
  
  public func applyTheme(_ theme: BezierTheme) {
    guard self.currentTheme != theme else { return }
    
    self.currentTheme = theme
    
    self.delegate?.windowsForThemeUpdate().forEach { window in
      window.overrideUserInterfaceStyle = self.currentTheme.userInterfaceStyle
    }
  }
}
