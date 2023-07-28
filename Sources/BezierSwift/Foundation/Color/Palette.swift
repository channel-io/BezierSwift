//
//  Palette.swift
//  
//
//  Created by Jam on 2022/12/01.
//

import SwiftUI

fileprivate extension Color {
  init(r: Double, g: Double, b: Double, alpha: Double) {
    self = Color(red: r / 255, green: g / 255, blue: b / 255, opacity: alpha)
  }
}

public struct ColorComponentsWithAlpha: Equatable {
  var red: Double
  var green: Double
  var blue: Double
  var alpha: Double
  
  var color: Color {
    Color(red: self.red / 255, green: self.green / 255, blue: self.blue / 255, opacity: alpha)
  }
  
  var uiColor: UIColor {
    UIColor(red: self.red / 255, green: self.green / 255, blue: self.blue / 255, alpha: alpha)
  }
}

public enum Palette {
  public static let white = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 1.0)
  public static let white_90 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.9)
  public static let white_80 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.8)
  public static let white_60 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.6)
  public static let white_40 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.4)
  public static let white_20 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.2)
  public static let white_12 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.12)
  public static let white_8 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.08)
  public static let white_5 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.05)
  public static let white_0 = ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0)
  
  public static let black = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 1.0)
  public static let black_85 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.85)
  public static let black_60 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.60)
  public static let black_40 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.40)
  public static let black_30 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.30)
  public static let black_22 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.22)
  public static let black_20 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.20)
  public static let black_15 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.15)
  public static let black_8 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.08)
  public static let black_5 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.05)
  public static let black_3 = ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.03)
  
  public static let grey900 = ColorComponentsWithAlpha(red: 36, green: 36, blue: 40, alpha: 1.0)
  public static let grey900_90 = ColorComponentsWithAlpha(red: 36, green: 36, blue: 40, alpha: 0.9)
  public static let grey850 = ColorComponentsWithAlpha(red: 42, green: 43, blue: 45, alpha: 1.0)
  public static let grey850_80 = ColorComponentsWithAlpha(red: 42, green: 43, blue: 45, alpha: 0.8)
  public static let grey800 = ColorComponentsWithAlpha(red: 49, green: 50, blue: 52, alpha: 1.0)
  public static let grey800_90 = ColorComponentsWithAlpha(red: 49, green: 50, blue: 52, alpha: 0.9)
  public static let grey800_80 = ColorComponentsWithAlpha(red: 49, green: 50, blue: 52, alpha: 0.8)
  public static let grey700 = ColorComponentsWithAlpha(red: 70, green: 71, blue: 72, alpha: 1.0)
  public static let grey700_80 = ColorComponentsWithAlpha(red: 70, green: 71, blue: 72, alpha: 0.8)
  public static let grey500 = ColorComponentsWithAlpha(red: 167, green: 167, blue: 170, alpha: 1.0)
  public static let grey200 = ColorComponentsWithAlpha(red: 239, green: 239, blue: 240, alpha: 1.0)
  public static let grey200_80 = ColorComponentsWithAlpha(red: 239, green: 239, blue: 240, alpha: 0.8)
  public static let grey100 = ColorComponentsWithAlpha(red: 247, green: 247, blue: 248, alpha: 1.0)
  public static let grey100_90 = ColorComponentsWithAlpha(red: 247, green: 247, blue: 248, alpha: 0.9)
  public static let grey100_80 = ColorComponentsWithAlpha(red: 247, green: 247, blue: 248, alpha: 0.8)
  public static let grey50 = ColorComponentsWithAlpha(red: 252, green: 252, blue: 252, alpha: 1.0)
  public static let grey50_80 = ColorComponentsWithAlpha(red: 252, green: 252, blue: 252, alpha: 0.8)
  
  public static let blue500 = ColorComponentsWithAlpha(red: 78, green: 64, blue: 201, alpha: 1.0)
  public static let blue400 = ColorComponentsWithAlpha(red: 94, green: 86, blue: 240, alpha: 1.0)
  public static let blue400_40 = ColorComponentsWithAlpha(red: 94, green: 86, blue: 240, alpha: 0.4)
  public static let blue400_30 = ColorComponentsWithAlpha(red: 94, green: 86, blue: 240, alpha: 0.3)
  public static let blue400_20 = ColorComponentsWithAlpha(red: 94, green: 86, blue: 240, alpha: 0.2)
  public static let blue400_10 = ColorComponentsWithAlpha(red: 94, green: 86, blue: 240, alpha: 0.1)
  public static let blue300 = ColorComponentsWithAlpha(red: 102, green: 135, blue: 255, alpha: 1.0)
  public static let blue300_40 = ColorComponentsWithAlpha(red: 102, green: 135, blue: 255, alpha: 0.4)
  public static let blue300_30 = ColorComponentsWithAlpha(red: 102, green: 135, blue: 255, alpha: 0.3)
  public static let blue300_20 = ColorComponentsWithAlpha(red: 102, green: 135, blue: 255, alpha: 0.2)
  
  public static let cobalt500 = ColorComponentsWithAlpha(red: 50, green: 122, blue: 184, alpha: 1.0)
  public static let cobalt400 = ColorComponentsWithAlpha(red: 50, green: 155, blue: 231, alpha: 1.0)
  public static let cobalt400_40 = ColorComponentsWithAlpha(red: 50, green: 155, blue: 231, alpha: 0.4)
  public static let cobalt400_30 = ColorComponentsWithAlpha(red: 50, green: 155, blue: 231, alpha: 0.3)
  public static let cobalt400_20 = ColorComponentsWithAlpha(red: 50, green: 155, blue: 231, alpha: 0.2)
  public static let cobalt400_10 = ColorComponentsWithAlpha(red: 50, green: 155, blue: 231, alpha: 0.1)
  public static let cobalt300 = ColorComponentsWithAlpha(red: 71, green: 200, blue: 255, alpha: 1.0)
  public static let cobalt300_40 = ColorComponentsWithAlpha(red: 71, green: 200, blue: 255, alpha: 0.4)
  public static let cobalt300_30 = ColorComponentsWithAlpha(red: 71, green: 200, blue: 255, alpha: 0.3)
  public static let cobalt300_20 = ColorComponentsWithAlpha(red: 71, green: 200, blue: 255, alpha: 0.2)
  
  public static let teal500 = ColorComponentsWithAlpha(red: 68, green: 156, blue: 138, alpha: 1.0)
  public static let teal400 = ColorComponentsWithAlpha(red: 15, green: 179, blue: 163, alpha: 1.0)
  public static let teal400_40 = ColorComponentsWithAlpha(red: 15, green: 179, blue: 163, alpha: 0.4)
  public static let teal400_30 = ColorComponentsWithAlpha(red: 15, green: 179, blue: 163, alpha: 0.3)
  public static let teal400_20 = ColorComponentsWithAlpha(red: 15, green: 179, blue: 163, alpha: 0.2)
  public static let teal400_10 = ColorComponentsWithAlpha(red: 15, green: 179, blue: 163, alpha: 0.1)
  public static let teal300 = ColorComponentsWithAlpha(red: 60, green: 221, blue: 205, alpha: 1.0)
  public static let teal300_40 = ColorComponentsWithAlpha(red: 60, green: 221, blue: 205, alpha: 0.4)
  public static let teal300_30 = ColorComponentsWithAlpha(red: 60, green: 221, blue: 205, alpha: 0.3)
  public static let teal300_20 = ColorComponentsWithAlpha(red: 60, green: 221, blue: 205, alpha: 0.2)
  
  public static let green500 = ColorComponentsWithAlpha(red: 65, green: 144, blue: 79, alpha: 1.0)
  public static let green400 = ColorComponentsWithAlpha(red: 49, green: 165, blue: 82, alpha: 1.0)
  public static let green400_40 = ColorComponentsWithAlpha(red: 49, green: 165, blue: 82, alpha: 0.4)
  public static let green400_30 = ColorComponentsWithAlpha(red: 49, green: 165, blue: 82, alpha: 0.3)
  public static let green400_20 = ColorComponentsWithAlpha(red: 49, green: 165, blue: 82, alpha: 0.2)
  public static let green400_10 = ColorComponentsWithAlpha(red: 49, green: 165, blue: 82, alpha: 0.1)
  public static let green300 = ColorComponentsWithAlpha(red: 58, green: 207, blue: 90, alpha: 1.0)
  public static let green300_40 = ColorComponentsWithAlpha(red: 58, green: 207, blue: 90, alpha: 0.4)
  public static let green300_30 = ColorComponentsWithAlpha(red: 58, green: 207, blue: 90, alpha: 0.3)
  public static let green300_20 = ColorComponentsWithAlpha(red: 58, green: 207, blue: 90, alpha: 0.2)
  
  public static let olive500 = ColorComponentsWithAlpha(red: 129, green: 134, blue: 40, alpha: 1.0)
  public static let olive400 = ColorComponentsWithAlpha(red: 160, green: 165, blue: 64, alpha: 1.0)
  public static let olive400_40 = ColorComponentsWithAlpha(red: 160, green: 165, blue: 64, alpha: 0.4)
  public static let olive400_30 = ColorComponentsWithAlpha(red: 160, green: 165, blue: 64, alpha: 0.3)
  public static let olive400_20 = ColorComponentsWithAlpha(red: 160, green: 165, blue: 64, alpha: 0.2)
  public static let olive400_10 = ColorComponentsWithAlpha(red: 160, green: 165, blue: 64, alpha: 0.1)
  public static let olive300 = ColorComponentsWithAlpha(red: 202, green: 213, blue: 72, alpha: 1.0)
  public static let olive300_40 = ColorComponentsWithAlpha(red: 202, green: 213, blue: 72, alpha: 0.4)
  public static let olive300_30 = ColorComponentsWithAlpha(red: 202, green: 213, blue: 72, alpha: 0.3)
  public static let olive300_20 = ColorComponentsWithAlpha(red: 202, green: 213, blue: 72, alpha: 0.2)
  
  public static let yellow500 = ColorComponentsWithAlpha(red: 195, green: 158, blue: 55, alpha: 1.0)
  public static let yellow400 = ColorComponentsWithAlpha(red: 237, green: 188, blue: 64, alpha: 1.0)
  public static let yellow400_40 = ColorComponentsWithAlpha(red: 237, green: 188, blue: 64, alpha: 0.4)
  public static let yellow400_30 = ColorComponentsWithAlpha(red: 237, green: 188, blue: 64, alpha: 0.3)
  public static let yellow400_20 = ColorComponentsWithAlpha(red: 237, green: 188, blue: 64, alpha: 0.2)
  public static let yellow400_10 = ColorComponentsWithAlpha(red: 237, green: 188, blue: 64, alpha: 0.1)
  public static let yellow300 = ColorComponentsWithAlpha(red: 253, green: 211, blue: 83, alpha: 1.0)
  public static let yellow300_40 = ColorComponentsWithAlpha(red: 253, green: 211, blue: 83, alpha: 0.4)
  public static let yellow300_30 = ColorComponentsWithAlpha(red: 253, green: 211, blue: 83, alpha: 0.3)
  public static let yellow300_20 = ColorComponentsWithAlpha(red: 253, green: 211, blue: 83, alpha: 0.2)
  
  public static let orange500 = ColorComponentsWithAlpha(red: 197, green: 116, blue: 23, alpha: 1.0)
  public static let orange400 = ColorComponentsWithAlpha(red: 244, green: 128, blue: 11, alpha: 1.0)
  public static let orange400_40 = ColorComponentsWithAlpha(red: 244, green: 128, blue: 11, alpha: 0.4)
  public static let orange400_30 = ColorComponentsWithAlpha(red: 244, green: 128, blue: 11, alpha: 0.3)
  public static let orange400_20 = ColorComponentsWithAlpha(red: 244, green: 128, blue: 11, alpha: 0.2)
  public static let orange400_10 = ColorComponentsWithAlpha(red: 244, green: 128, blue: 11, alpha: 0.1)
  public static let orange300 = ColorComponentsWithAlpha(red: 255, green: 171, blue: 92, alpha: 1.0)
  public static let orange300_40 = ColorComponentsWithAlpha(red: 255, green: 171, blue: 92, alpha: 0.4)
  public static let orange300_30 = ColorComponentsWithAlpha(red: 255, green: 171, blue: 92, alpha: 0.3)
  public static let orange300_20 = ColorComponentsWithAlpha(red: 255, green: 171, blue: 92, alpha: 0.2)
  
  public static let red500 = ColorComponentsWithAlpha(red: 172, green: 62, blue: 70, alpha: 1.0)
  public static let red400 = ColorComponentsWithAlpha(red: 233, green: 78, blue: 88, alpha: 1.0)
  public static let red400_40 = ColorComponentsWithAlpha(red: 233, green: 78, blue: 88, alpha: 0.4)
  public static let red400_30 = ColorComponentsWithAlpha(red: 233, green: 78, blue: 88, alpha: 0.3)
  public static let red400_20 = ColorComponentsWithAlpha(red: 233, green: 78, blue: 88, alpha: 0.2)
  public static let red400_10 = ColorComponentsWithAlpha(red: 233, green: 78, blue: 88, alpha: 0.1)
  public static let red300 = ColorComponentsWithAlpha(red: 255, green: 92, blue: 92, alpha: 1.0)
  public static let red300_40 = ColorComponentsWithAlpha(red: 255, green: 92, blue: 92, alpha: 0.4)
  public static let red300_30 = ColorComponentsWithAlpha(red: 255, green: 92, blue: 92, alpha: 0.3)
  public static let red300_20 = ColorComponentsWithAlpha(red: 255, green: 92, blue: 92, alpha: 0.2)
  
  public static let pink500 = ColorComponentsWithAlpha(red: 163, green: 46, blue: 146, alpha: 1.0)
  public static let pink400 = ColorComponentsWithAlpha(red: 203, green: 72, blue: 173, alpha: 1.0)
  public static let pink400_40 = ColorComponentsWithAlpha(red: 203, green: 72, blue: 173, alpha: 0.4)
  public static let pink400_30 = ColorComponentsWithAlpha(red: 203, green: 72, blue: 173, alpha: 0.3)
  public static let pink400_20 = ColorComponentsWithAlpha(red: 203, green: 72, blue: 173, alpha: 0.2)
  public static let pink400_10 = ColorComponentsWithAlpha(red: 203, green: 72, blue: 173, alpha: 0.1)
  public static let pink300 = ColorComponentsWithAlpha(red: 236, green: 111, blue: 211, alpha: 1.0)
  public static let pink300_40 = ColorComponentsWithAlpha(red: 236, green: 111, blue: 211, alpha: 0.4)
  public static let pink300_30 = ColorComponentsWithAlpha(red: 236, green: 111, blue: 211, alpha: 0.3)
  public static let pink300_20 = ColorComponentsWithAlpha(red: 236, green: 111, blue: 211, alpha: 0.2)
  
  public static let purple500 = ColorComponentsWithAlpha(red: 107, green: 35, blue: 179, alpha: 1.0)
  public static let purple400 = ColorComponentsWithAlpha(red: 145, green: 92, blue: 224, alpha: 1.0)
  public static let purple400_40 = ColorComponentsWithAlpha(red: 145, green: 92, blue: 224, alpha: 0.4)
  public static let purple400_30 = ColorComponentsWithAlpha(red: 145, green: 92, blue: 224, alpha: 0.3)
  public static let purple400_20 = ColorComponentsWithAlpha(red: 145, green: 92, blue: 224, alpha: 0.2)
  public static let purple400_10 = ColorComponentsWithAlpha(red: 145, green: 92, blue: 224, alpha: 0.1)
  public static let purple300 = ColorComponentsWithAlpha(red: 181, green: 112, blue: 255, alpha: 1.0)
  public static let purple300_40 = ColorComponentsWithAlpha(red: 181, green: 112, blue: 255, alpha: 0.4)
  public static let purple300_30 = ColorComponentsWithAlpha(red: 181, green: 112, blue: 255, alpha: 0.3)
  public static let purple300_20 = ColorComponentsWithAlpha(red: 181, green: 112, blue: 255, alpha: 0.2)
  
  public static let navy500 = ColorComponentsWithAlpha(red: 51, green: 61, blue: 91, alpha: 1.0)
  public static let navy400 = ColorComponentsWithAlpha(red: 58, green: 79, blue: 141, alpha: 1.0)
  public static let navy400_40 = ColorComponentsWithAlpha(red: 58, green: 79, blue: 141, alpha: 0.4)
  public static let navy400_30 = ColorComponentsWithAlpha(red: 58, green: 79, blue: 141, alpha: 0.3)
  public static let navy400_20 = ColorComponentsWithAlpha(red: 58, green: 79, blue: 141, alpha: 0.2)
  public static let navy400_10 = ColorComponentsWithAlpha(red: 58, green: 79, blue: 141, alpha: 0.1)
  public static let navy300 = ColorComponentsWithAlpha(red: 100, green: 124, blue: 201, alpha: 1.0)
  public static let navy300_40 = ColorComponentsWithAlpha(red: 100, green: 124, blue: 201, alpha: 0.4)
  public static let navy300_30 = ColorComponentsWithAlpha(red: 100, green: 124, blue: 201, alpha: 0.3)
  public static let navy300_20 = ColorComponentsWithAlpha(red: 100, green: 124, blue: 201, alpha: 0.2)
}

