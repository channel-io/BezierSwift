//
//  BezierImage.swift
//
//
//  Created by Tom on 9/4/24.
//

import SwiftUI

public enum BezierImage: String {
  case `fallback` = "fallback"
}

extension BezierImage {
  public var image: Image {
    Image(self.rawValue, bundle: Bundle.module).resizable()
  }

  public var uiImage: UIImage? {
    UIImage(named: self.rawValue, in: Bundle.module, with: nil)
  }
}
