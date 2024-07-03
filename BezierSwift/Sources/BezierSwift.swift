//
//  File.swift
//  
//
//  Created by Tom on 7/3/24.
//

import UIKit

public protocol BezierSwiftDelegate: AnyObject {
  func windowsForThemeUpdate() -> [UIWindow]
}

public final class BezierSwift {
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
