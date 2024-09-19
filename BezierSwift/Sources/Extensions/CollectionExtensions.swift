//
//  File.swift
//
//
//  Created by Tom on 9/16/24.
//

import Foundation

extension Collection {
  subscript (safe index: Index) -> Element? {
    return self.indices.contains(index) ? self[index] : nil
  }
}
