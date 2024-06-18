//
//  File.swift
//  
//
//  Created by Tom on 4/24/24.
//

import UIKit
import SwiftUI

internal extension Color {
  init(globalColorToken: GlobalColorToken) {
    self.init(hex: globalColorToken.hex)
  }
}

internal extension UIColor {
  convenience init(globalColorToken: GlobalColorToken) {
    self.init(hex: globalColorToken.hex)
  }
}
