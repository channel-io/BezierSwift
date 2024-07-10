//
//  BezierLoader.swift
//
//
//  Created by Tom on 6/29/24.
//

import SwiftUI

private enum Constant {
  static let delayPoint: Double = 0.8
  static let maxFillPoint: Double = 1.0
  static let animationDuration: Double = 2.0
  static let fullCircle: Double = 360
  static let minAngle: Double = 1
  static let maxAngle: Double = 359
}

public struct BezierLoader: View {
  @Environment(\.colorScheme) public var colorScheme
  @State private var fillPoint = 0.0
  @State private var isRotating = false
  
  private let configuration: BezierLoaderConfiguration
  
  public init(configuration: BezierLoaderConfiguration) {
    self.configuration = configuration
  }
  
  public var body: some View {
    ZStack {
      Track(configuration: self.configuration)
        .stroke(self.configuration.trackColor.color, lineWidth: self.configuration.lineWidth)
      
      Indicator(fillPoint: self.fillPoint, configuration: self.configuration)
        .stroke(
          self.configuration.indicatorColor.color,
          style: StrokeStyle(lineWidth: self.configuration.lineWidth, lineCap: .round)
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
      width: self.configuration.loaderSize.width,
      height: self.configuration.loaderSize.height
    )
  }
}

private struct Indicator: Shape {
  var fillPoint: Double
  let configuration: BezierLoaderConfiguration
  
  var animatableData: Double {
    get { return self.fillPoint }
    set { self.fillPoint = newValue }
  }
  
  init(fillPoint: Double = 1, configuration: BezierLoaderConfiguration) {
    self.fillPoint = fillPoint
    self.configuration = configuration
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let startAngle = self.fillPoint > Constant.delayPoint
    ? ((self.fillPoint - Constant.delayPoint) / (1.0 - Constant.delayPoint)) * Constant.fullCircle
    : .zero
    
    let endAngle = Constant.fullCircle * self.fillPoint
    
    path.addArc(
      center: CGPoint(
        x: self.configuration.loaderSize.width / 2,
        y: self.configuration.loaderSize.height / 2
      ),
      radius: self.configuration.loaderRadius,
      startAngle: .degrees(min(startAngle, Constant.maxAngle)),
      endAngle: .degrees(max(endAngle, Constant.minAngle)),
      clockwise: false
    )
    
    return path
  }
}

private struct Track: Shape {
  let configuration: BezierLoaderConfiguration
  
  init(configuration: BezierLoaderConfiguration) {
    self.configuration = configuration
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.addArc(
      center: CGPoint(
        x: self.configuration.loaderSize.width / 2,
        y: self.configuration.loaderSize.height / 2
      ),
      radius: self.configuration.loaderRadius,
      startAngle: .degrees(.zero),
      endAngle: .degrees(Constant.fullCircle),
      clockwise: false
    )
    
    return path
  }
}

#Preview {
  BezierLoader(configuration: .init(variant: .primary, size: .medium))
}
