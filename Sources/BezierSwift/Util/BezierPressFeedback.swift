//
//  BezierPressFeedback.swift
//  BezierSwift
//

import SwiftUI
import UIKit

// 아이템형 컴포넌트 공통 press 피드백 (Figma 외 · 협의 — ch-desk-ios ListItemPressFeedback 참조)
// 콘텐츠가 눌림 시 0.97로 축소되고, 뗄 때 살짝 오버슈트하며 복귀한다.
// 대상은 콘텐츠 뷰만 — pressed 배경은 컴포넌트가 full-size로 유지한다.
// public 승격 + BezierBaseItem 마이그레이션은 MOB-6471에서 다룬다.
enum BezierPressFeedback {
  static let pressScale: CGFloat = 0.97
  static let pressInDuration: TimeInterval = 0.10
  static let releaseDuration: TimeInterval = 0.40
  static let releaseScaleValues: [NSNumber] = [0.97, 1.004, 1.0]
  static let releaseScaleKeyTimes: [NSNumber] = [0, 0.55, 1.0]
  static let springResponse: Double = 0.34
  static let springDampingFraction: Double = 0.62

  private static let releaseAnimationKey = "bezierPressFeedbackRelease"

  // MARK: - UIKit

  @MainActor
  static func apply(isPressed: Bool, to contentView: UIView) {
    guard !UIAccessibility.isReduceMotionEnabled else {
      self.reset(contentView)
      return
    }

    if isPressed {
      contentView.layer.removeAnimation(forKey: self.releaseAnimationKey)
      UIView.animate(
        withDuration: self.pressInDuration,
        delay: 0,
        options: [.curveEaseInOut, .beginFromCurrentState]
      ) {
        contentView.transform = CGAffineTransform(
          scaleX: self.pressScale,
          y: self.pressScale
        )
      }
    } else {
      contentView.transform = .identity
      let keyframe = CAKeyframeAnimation(keyPath: "transform.scale")
      keyframe.values = self.releaseScaleValues
      keyframe.keyTimes = self.releaseScaleKeyTimes
      keyframe.duration = self.releaseDuration
      keyframe.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      keyframe.isRemovedOnCompletion = true
      contentView.layer.add(keyframe, forKey: self.releaseAnimationKey)
    }
  }

  @MainActor
  static func reset(_ contentView: UIView) {
    contentView.layer.removeAnimation(forKey: self.releaseAnimationKey)
    contentView.transform = .identity
  }
}

// MARK: - SwiftUI

struct BezierPressScaleModifier: ViewModifier {
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .scaleEffect(
        (self.isPressed && !self.reduceMotion) ? BezierPressFeedback.pressScale : 1
      )
      .animation(
        .spring(
          response: BezierPressFeedback.springResponse,
          dampingFraction: BezierPressFeedback.springDampingFraction
        ),
        value: self.isPressed
      )
  }
}

extension View {
  func bezierPressScale(isPressed: Bool) -> some View {
    self.modifier(BezierPressScaleModifier(isPressed: isPressed))
  }
}
