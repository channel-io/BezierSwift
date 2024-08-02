//
//  BezierIconView.swift
//
//
//  Created by Tom on 7/30/24.
//

import SwiftUI

public struct BezierIconView: View {
  let bezierIcon: BezierIcon
  
  public init(bezierIcon: BezierIcon) {
    self.bezierIcon = bezierIcon
  }
  
  public var body: some View {
    self.bezierIcon.image
      .tintable()
  }
}
