//
//  File.swift
//  
//
//  Created by 구본욱 on 8/23/24.
//

import Foundation

// MARK: - BezierCheckboxVariant
public enum BezierCheckboxVariant {
  case primary
  case secondary
}

// MARK: - BezierCheckboxColor
public enum BezierCheckboxColor {
  case green
  case blue
}

// MARK: - BezierCheckboxChecked
public enum BezierCheckboxChecked {
  case checked
  case unchecked
  case indeterminate
}

// MARK: - BezierCheckboxConfiguration
public protocol BezierCheckboxConfiguration {
  var variant: BezierCheckboxVariant { get }
}
