//
//  BezierAvatarGroupExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/16/24.
//

import SwiftUI

import BezierSwift

struct BezierAvatarGroupExample: View {
  var body: some View {
    BezierAvatarGroup(
      images: [
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300")),
        .url(URL(string: "https://picsum.photos/200/300"))
      ],
      type: .stack,
      ellipsisType: .icon
    )
  }
}

#Preview {
  BezierAvatarGroupExample()
}



