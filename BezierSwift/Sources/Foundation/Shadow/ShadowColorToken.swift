//
//  ShadowColorToken.swift
//
//
//  Created by Tom on 8/16/24.
//

import SwiftUI

struct ShadowColorToken {
  private let globalColorToken: GlobalColorToken
  
  private init(globalColorToken: GlobalColorToken) {
    self.globalColorToken = globalColorToken
  }
  
  var color: Color {
    return Color(self.uiColor)
  }
  
  var uiColor: UIColor {
    return UIColor(hex: self.globalColorToken.hex)
  }
  
  var cgColor: CGColor {
    return self.uiColor.cgColor
  }
}

extension ShadowColorToken {
  static var xlarge = ShadowColorToken(globalColorToken: .black30)
  static var large = ShadowColorToken(globalColorToken: .black22)
  static var medium = ShadowColorToken(globalColorToken: .black15)
  static var small = ShadowColorToken(globalColorToken: .black8)
  static var base = ShadowColorToken(globalColorToken: .black5)
  static var baseInner = ShadowColorToken(globalColorToken: .white12)
}
