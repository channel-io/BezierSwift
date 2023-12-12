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
  var buttonInfo: BezierDialogButtonInfo?
  
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
  case networkError
  case versionCheckError
  case unAuthorizedError
  case roleChanged
  case forbidden
  case serverError
  case `default`
  case custom(Int)
 
  var rawValue: Int {
    switch self {
    case .networkError: return 0
    case .versionCheckError: return 1
    case .unAuthorizedError: return 2
    case .roleChanged: return 3
    case .forbidden: return 4
    case .serverError: return 5
    case .`default`: return 6
    case .custom(let priority): return priority
    }
  }
}
