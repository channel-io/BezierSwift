//
//  BezierElevationTestView.swift
//  SwiftUIExample
//
//  Created by Tom on 2023/07/28.
//

import SwiftUI

struct BezierElevationTestView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
        .frame(width: 200, height: 100)
        .applyBezierElevation(.mEv4)
    }
}

struct BezierElevationTestView_Previews: PreviewProvider {
    static var previews: some View {
        BezierElevationTestView()
    }
}
