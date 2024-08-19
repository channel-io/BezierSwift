//
//  BezierDialogParam.swift
//
//
//  Created by woody on 12/11/23.
//

import Foundation

public struct BezierDialogParam {
  var priority: BezierDialogPriority
  var title: String
  var description: String
  var imageUrl: URL?
  var buttonInfo: BezierDialogButtonInfo?
  
  public init(
    priority: BezierDialogPriority,
    title: String?,
    description: String?,
    imageUrl: URL?,
    buttonInfo: BezierDialogButtonInfo?
  ) {
    self.priority = priority
    self.title = title ?? ""
    self.description = description ?? ""
    self.imageUrl = imageUrl
    self.buttonInfo = buttonInfo
  }
  
  public init(
    priority: BezierDialogPriority,
    title: String?,
    description: String?,
    buttonInfo: BezierDialogButtonInfo?
  ) {
    self.priority = priority
    self.title = title ?? ""
    self.description = description ?? ""
    self.buttonInfo = buttonInfo
  }
}

public enum BezierDialogButtonInfo {
  case vertical([BezierButton])
  case horizontal([BezierButton])
}

public enum BezierDialogPriority {
  case high
  case normal
  case low
  case custom(Int)
 
  var rawValue: Int {
    switch self {
    case .high: return 1
    case .normal: return 3
    case .low: return 5
    case .custom(let priority): return priority
    }
  }
}
