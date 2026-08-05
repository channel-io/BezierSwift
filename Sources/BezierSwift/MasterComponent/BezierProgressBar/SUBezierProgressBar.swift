//
//  SUBezierProgressBar.swift
//  BezierSwift
//

import SwiftUI

/// 작업의 진행률을 0~1 범위의 색상 바로 시각화하는 컴포넌트 (SwiftUI). 진행률을 모르는 불확정 로딩에는 `SUBezierSpinner`를 사용한다. 가로 폭은 부모가 제안한 너비를 채운다. UIKit에서는 `BezierProgressBar`를 사용한다.
public struct SUBezierProgressBar: View, Themeable {
  private let value: CGFloat
  private let variant: BezierProgressBarVariant
  private let size: BezierProgressBarSize

  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  /// 진행률(0~1, 범위 밖 값은 clamp)·색상 변형·크기를 지정해 생성한다. `value` 변경 시 진행 바 너비가 easeInOut으로 전환되며, 시스템 Reduce Motion이 켜져 있으면 애니메이션을 생략한다.
  public init(
    value: CGFloat,
    variant: BezierProgressBarVariant = .default,
    size: BezierProgressBarSize = .medium
  ) {
    self.value = min(max(value, 0), 1)
    self.variant = variant
    self.size = size
  }

  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: self.size.cornerRadius)
          .fill(self.palette(self.variant.trackColorToken))
        RoundedRectangle(cornerRadius: self.size.cornerRadius)
          .fill(self.palette(self.variant.activeColorToken))
          .frame(width: proxy.size.width * self.value)
      }
      .animation(
        self.reduceMotion ? nil : .easeInOut(duration: BezierProgressBarConstant.animationDuration),
        value: self.value
      )
    }
    .frame(height: self.size.height)
  }
}

struct SUBezierProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      ForEach(BezierProgressBarVariant.allCases, id: \.self) { variant in
        ForEach(BezierProgressBarSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 4) {
            Text("\(variant.rawValue) / \(size.rawValue)")
              .font(.caption2)
              .foregroundColor(.secondary)
            SUBezierProgressBar(value: 0.6, variant: variant, size: size)
          }
        }
      }
    }
    .padding()
  }
}
