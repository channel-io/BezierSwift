//
//  BezierColorType.swift
//
//
//  Created by Tom on 4/24/24.
//

import SwiftUI
import UIKit

public protocol BezierColorType {
  func color(for bezierTheme: BezierTheme) -> Color
  func uiColor(for bezierTheme: BezierTheme) -> UIColor
}
