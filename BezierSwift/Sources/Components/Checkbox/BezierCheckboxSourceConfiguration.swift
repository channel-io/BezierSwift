//
//  File.swift
//  
//
//  Created by 구본욱 on 8/23/24.
//

import Foundation

protocol BezierCheckboxSourceConfiguration {
  var sourceNeedStroke: Bool { get }
  var sourceStrokeColor: BezierColor { get }
  var sourceBackgroundColor: BezierColor { get }
  var sourceIcon: BezierIcon? { get }
  var sourceIconColor: BezierColor { get }
}
