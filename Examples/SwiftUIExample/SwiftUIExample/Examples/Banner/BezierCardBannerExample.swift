//
//  BezierCardBannerExample.swift
//  SwiftUIExample
//
//  Created by Tom on 9/19/24.
//

import SwiftUI

import BezierSwift

struct BezierCardBannerExample: View {
  var body: some View {
    VStack {
      BezierCardBanner(
        icon: .info,
        description: "description",
        actionType: .chevronIcon {
          print("BezierFloatingBanner")
        }
      )
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  BezierCardBannerExample()
}
