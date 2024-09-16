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
    BezierAvatar(
      image: .url(URL(string: "https://picsum.photos/200/300")),
      size: .pt48,
      badge: .chat
    )
  }
}

#Preview {
  BezierAvatarExample()
}
