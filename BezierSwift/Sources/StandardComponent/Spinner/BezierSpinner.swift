//
//  BezierSpinner.swift
//
//
//  Created by Tom on 6/29/24.
//

import SwiftUI

private enum Constant {
  static let delayPoint: Double = 0.5
  static let maxFillPoint: Double = 0.999
  static let animationDuration: Double = 2.2
  static let fullCircle: Double = 360
}

public struct BezierSpinner: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @State private var fillPoint = 0.0
  @State private var isRotating = false
  
  private let configuration: BezierSpinnerConfiguration
  
  public init(configuration: BezierSpinnerConfiguration) {
    self.configuration = configuration
  }
  
  public var body: some View {
    ZStack {
      Ring(configuration: self.configuration)
        .stroke(self.palette(self.configuration.trackColor), lineWidth: configuration.lineWidth)
      
      Ring(fillPoint: fillPoint, configuration: self.configuration)
        .stroke(
          self.palette(self.configuration.indicatorColor),
          style: StrokeStyle(lineWidth: configuration.lineWidth, lineCap: .round)
        )
        .rotationEffect(.degrees(-90))
        .rotationEffect(Angle(degrees: self.isRotating ? Constant.fullCircle : .zero))
        .onAppear() {
          withAnimation(
            Animation.timingCurve(0.4, 0.0, 0.2, 1.0, duration: Constant.animationDuration)
              .repeatForever(autoreverses: false)
          ) {
            self.fillPoint = Constant.maxFillPoint
          }
          
          withAnimation(
            Animation.linear(duration: Constant.animationDuration)
              .repeatForever(autoreverses: false)
          ) {
            self.isRotating = true
          }
        }
    }
    .frame(
      width: self.configuration.spinnerSize.width,
      height: self.configuration.spinnerSize.height
    )
  }
}

private struct Ring: Shape {
  var fillPoint: Double
  let configuration: BezierSpinnerConfiguration
  
  var animatableData: Double {
    get { return self.fillPoint }
    set { self.fillPoint = newValue }
  }
  
  init(fillPoint: Double = 1, configuration: BezierSpinnerConfiguration) {
    self.fillPoint = fillPoint
    self.configuration = configuration
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addArc(
      center: CGPoint(
        x: self.configuration.spinnerSize.width / 2,
        y: self.configuration.spinnerSize.height / 2
      ),
      radius: self.configuration.spinnerRadius,
      startAngle: .degrees(self.fillPoint > Constant.delayPoint ? (2 * self.fillPoint) * Constant.fullCircle : .zero),
      endAngle: .degrees(Constant.fullCircle * self.fillPoint),
      clockwise: false
    )
    
    return path
  }
}

#Preview {
  BezierSpinner(configuration: .init(variant: .primary, size: .medium))
}
