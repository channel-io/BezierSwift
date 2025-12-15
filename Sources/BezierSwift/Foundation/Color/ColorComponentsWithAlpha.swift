//
//  ColorComponentsWithAlpha.swift
//  BezierSwift
//
//  Created by 구본욱 on 12/10/25.
//

import SwiftUI
import UIKit

fileprivate extension Color {
  init(r: Double, g: Double, b: Double, alpha: Double) {
    self = Color(red: r / 255, green: g / 255, blue: b / 255, opacity: alpha)
  }
}

public struct ColorComponentsWithAlpha: Equatable {
  private let red: Double
  private let green: Double
  private let blue: Double
  private let alpha: Double
  
  public init(red: Double, green: Double, blue: Double, alpha: Double) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
  
  public var color: Color {
    Color(red: self.red / 255, green: self.green / 255, blue: self.blue / 255, opacity: alpha)
  }
  
  public var uiColor: UIColor {
    UIColor(red: self.red / 255, green: self.green / 255, blue: self.blue / 255, alpha: alpha)
  }
}
