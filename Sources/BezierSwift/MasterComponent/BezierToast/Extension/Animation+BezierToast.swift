//
//  Animation+BezierToast.swift
//  
//
//  Created by woody on 2023/04/03.
//

import SwiftUI

extension Animation {
  static var toastInsertion: Animation { .easeIn(duration: 0.3) }
  static var toastRemoval: Animation { .easeOut(duration: 0.3) }
}
