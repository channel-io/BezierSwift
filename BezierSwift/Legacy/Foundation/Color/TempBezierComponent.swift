//
//  TempBezierComponent.swift
//  
//
//  Created by woody on 2023/07/27.
//

import Foundation

final class TempBezierComponent: BezierComponentable {
  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal
}
