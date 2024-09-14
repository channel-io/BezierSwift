//
//  BezierAvatarExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/14/24.
//

import SwiftUI

import BezierSwift

struct BezierAvatarExample: View {
  
  var body: some View {
    BezierAvatar(url: URL(string: ""), badge: .chat)
  }
}

#Preview {
  BezierAvatarExample()
}
