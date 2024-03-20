//
//  StringExtensions.swift
//
//
//  Created by Tom on 3/20/24.
//

import Foundation

extension String {
  func toRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    
    if self.hasPrefix("#") {
      let start = self.index(self.startIndex, offsetBy: 1)
      let hexColor = String(self[start...])
      
      if hexColor.count == 6 || hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          if hexColor.count == 8 {
            // RGBA 형태
            return (
              red: CGFloat((hexNumber & 0xFF000000) >> 24) / 255,
              green: CGFloat((hexNumber & 0x00FF0000) >> 16) / 255,
              blue: CGFloat((hexNumber & 0x0000FF00) >> 8) / 255,
              alpha: CGFloat(hexNumber & 0x000000FF) / 255
            )
          } else if hexColor.count == 6 {
            return (
              red: CGFloat((hexNumber & 0xFF000000) >> 24) / 255,
              green: CGFloat((hexNumber & 0x00FF0000) >> 16) / 255,
              blue: CGFloat((hexNumber & 0x0000FF00) >> 8) / 255,
              alpha: 1
            )
          }
        }
      }
    }
    
    return (red: 1, green: 1, blue: 1, alpha: 1)
  }
}
