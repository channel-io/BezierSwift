//
//  ColorExtensions.swift
//
//
//  Created by Tom on 3/20/24.
//

import SwiftUI

extension Color {
  /// Initializes a Color object from a HEX string.
  /// - Parameter hex: The HEX string representing the color (e.g., "#FFFFFF", "#FFFFFFFF").
  init(hex: String) {
    let rgba = hex.toRGBA()
    self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
  }
}
