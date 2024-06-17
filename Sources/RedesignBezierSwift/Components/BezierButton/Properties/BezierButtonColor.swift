//
//  BezierButtonColor.swift
//
//
//  Created by 구본욱 on 6/17/24.
//

import Foundation

public enum BezierButtonColor {
  case blue
  case cobalt
  case red
  case green
  case orange
  case darkGrey
  case lightGrey
  case white
  case pink
  case purple
}

// MARK: - Methods for Colors
extension BezierButtonColor {
  public func backgroundColor(with variant: BezierButtonVariant) -> BezierColor {
    return variant.backgroundColor(with: self)
  }

  public func textColor(with variant: BezierButtonVariant) -> BezierColor {
    return variant.textColor(with: self)
  }

  public func affixColor(with variant: BezierButtonVariant) -> BezierColor {
    return variant.affixColor(with: self)
  }
}
