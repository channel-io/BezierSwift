//
//  withAnimation.swift
//
//
//  Created by woody on 12/12/23.
//

import SwiftUI

func animationWithCompletion(
  _ animation: Animation? = .default,
  duration: TimeInterval = 0.15,
  _ body: () throws -> Void,
  completion: @escaping () -> Void
) rethrows {
  if #available(iOS 17.0, *) {
    try withAnimation(animation, body, completion: completion)
  } else {
    try withAnimation(animation, body)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      completion()
    }
  }
}
