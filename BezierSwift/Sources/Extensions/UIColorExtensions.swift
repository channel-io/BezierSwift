//
//  UIColorExtensions.swift
//
//
//  Created by Tom on 3/20/24.
//

import UIKit

extension UIColor {
  /// Initializes a UIColor object from a HEX string.
  /// - Parameter hex: The HEX string representing the color (e.g., "#FFFFFF", "#FFFFFFFF").
  convenience init(hex: String) {
    let rgba = hex.toRGBA()
    self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
  }
}
