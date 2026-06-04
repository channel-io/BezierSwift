//
//  SUBezierSpinner.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierSpinner: View, Themeable {
  private let size: BezierSpinnerSize
  private let fillColorOverride: Color?

  @Environment(\.colorScheme) public var colorScheme
  @State private var isRotating = false

  public init(size: BezierSpinnerSize = .size12) {
    self.size = size
    self.fillColorOverride = nil
  }

  init(size: BezierSpinnerSize, fillColorOverride: Color?) {
    self.size = size
    self.fillColorOverride = fillColorOverride
  }

  public var body: some View {
    SpinnerArcShape()
      .fill(self.fillColorOverride ?? self.palette(BCSemanticToken.borderNeutral))
      .frame(width: self.size.length, height: self.size.length)
      .rotationEffect(.degrees(self.isRotating ? 360 : 0))
      .animation(
        .linear(duration: BezierSpinnerConstant.rotationDuration).repeatForever(autoreverses: false),
        value: self.isRotating
      )
      .onAppear { self.isRotating = true }
  }
}

// MARK: - Arc Shape

private struct SpinnerArcShape: Shape {
  private enum Metric {
    static let arcStartAngle = Angle.degrees(135)
    static let arcEndAngle = Angle.degrees(45)
  }

  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let outerRadius = min(rect.width, rect.height) / 2
    let innerRadius = outerRadius * BezierSpinnerConstant.innerRadiusRatio

    var path = Path()
    // SwiftUI Path의 clockwise 파라미터는 y-up 좌표계 기준이라 화면(y-down)에서는 반대로 동작한다.
    // 화면상 시계방향(135° → 45°, 270° 호)으로 그리기 위해 clockwise: false를 사용한다.
    path.addArc(
      center: center,
      radius: outerRadius,
      startAngle: Metric.arcStartAngle,
      endAngle: Metric.arcEndAngle,
      clockwise: false
    )
    path.addArc(
      center: center,
      radius: innerRadius,
      startAngle: Metric.arcEndAngle,
      endAngle: Metric.arcStartAngle,
      clockwise: true
    )
    path.closeSubpath()
    return path
  }
}

struct SUBezierSpinner_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 24) {
        ForEach(BezierSpinnerSize.allCases, id: \.self) { size in
          VStack(spacing: 8) {
            SUBezierSpinner(size: size)
            Text(size.rawValue)
              .font(.caption2)
              .foregroundColor(.secondary)
          }
        }
      }
      .padding()
    }
  }
}
