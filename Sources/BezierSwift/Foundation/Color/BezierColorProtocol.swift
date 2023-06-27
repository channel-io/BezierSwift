//
//  File.swift
//  
//
//  Created by Tom on 2023/06/27.
//

public enum BezierColorTheme {
  case light
  case dark
}

public enum BezierComponentTheme {
  case normal
  case inverted
}

public protocol BezierComponentable: AnyObject {
  var colorTheme: BezierColorTheme { get }
  var componentTheme: BezierComponentTheme { get }
}
