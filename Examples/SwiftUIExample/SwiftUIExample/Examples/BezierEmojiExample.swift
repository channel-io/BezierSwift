//
//  BezierEmojiExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/20/24.
//

import SwiftUI

import BezierSwift

struct BezierEmojiExample: View {
  var body: some View {
    BezierEmoji(
      name: "+1",
      size: .pt24,
      badge: .chat
    )
  }
}

#Preview {
  BezierEmojiExample()
}
