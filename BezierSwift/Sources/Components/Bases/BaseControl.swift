//
//  BaseControl.swift
//  
//
//  Created by 구본욱 on 6/18/24.
//

import UIKit

open class BaseControl: UIControl {
  override public init(frame: CGRect) {
    super.init(frame: frame)

    self.initialize()
    self.setLayouts()
  }

  required public init?(coder: NSCoder) {
    super.init(coder: coder)

    self.initialize()
    self.setLayouts()
  }

  func initialize() {}
  func setLayouts() {}
}
