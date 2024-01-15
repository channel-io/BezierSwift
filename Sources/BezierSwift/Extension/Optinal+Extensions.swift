//
//  Optional+Extensions.swift
//  
//
//  Created by Jam on 2022/12/02.
//

extension Optional {
  var isNil: Bool { self == nil }
  var isNotNil: Bool { self != nil }
}

extension Optional where Wrapped == Bool {
  var beTrue: Bool { self == true }
  var beFalse: Bool { self == false }
}

extension Optional where Wrapped == String {
  var nilOrEmpty: Bool {
    guard let self = self else { return true }

    return self.isEmpty
  }
}
