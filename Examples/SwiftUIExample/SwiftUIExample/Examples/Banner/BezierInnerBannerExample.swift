//
//  BezierInnerBannerExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/19/24.
//

import SwiftUI

import BezierSwift

struct BezierInnerBannerExample: View {
  var body: some View {
    BezierInnerBanner(
      sematic: .error,
      icon: .android,
      title: "Title text (optional)",
      description: "description",
      actionType: .chevronIcon {
        print("BezierInnerBanner")
      }
    )
  }
}

#Preview {
  BezierInnerBannerExample()
}
