//
//  File.swift
//
//
//  Created by Tom on 9/19/24.
//

import Foundation

extension Optional {
  var isNil: Bool { self == nil }
  var isNotNil: Bool { self != nil }
}

extension Optional where Wrapped == Bool {
  var beTrue: Bool { self == true }
  var beFalse: Bool { self == false }
}

extension Optional where Wrapped == String {
  public var isNilOrEmpty: Bool {
    guard let self else { return true }
    
    return self.isEmpty
  }
}
