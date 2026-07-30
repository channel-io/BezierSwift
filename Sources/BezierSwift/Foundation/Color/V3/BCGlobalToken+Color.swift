//
//  BCGlobalToken+Color.swift
//  BezierSwift
//
//  Created by 구본욱 on 7/30/26.
//

import SwiftUI
import UIKit

extension BCGlobalToken {
  public var color: Color {
    self.value.color
  }

  public var uiColor: UIColor {
    self.value.uiColor
  }
}
