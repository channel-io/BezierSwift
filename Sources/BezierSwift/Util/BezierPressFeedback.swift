//
//  BezierPressFeedback.swift
//  BezierSwift
//

import SwiftUI
import UIKit

/// 아이템형 컴포넌트가 공유하는 탭 press 피드백. 눌린 동안 콘텐츠가 `0.97`로 축소되고, 뗄 때 살짝 오버슈트하며 원래 크기로 돌아온다.
///
/// **적용 대상은 콘텐츠 뷰만이다.** 배경(pressed 하이라이트)은 축소하지 않고 full-size로 유지해야 한다 — 배경까지 함께 줄면 눌릴 때마다 행의 시각적 경계가 안쪽으로 수축해 리스트가 출렁인다. 그래서 UIKit은 배경을 그리는 컴포넌트 루트(`self`)가 아니라 그 안의 콘텐츠 스택뷰를, SwiftUI는 `.background(...)`를 붙이기 **전**의 콘텐츠를 대상으로 삼는다.
///
/// Reduce Motion이 켜져 있으면 축소 없이 원래 크기를 유지한다.
///
/// UIKit `UIControl`에서는 `isHighlighted` 변화에 맞춰 호출하고, 탭을 받지 않는 상태에서는 `reset(_:)`으로 되돌린다.
/// ```swift
/// public override var isHighlighted: Bool {
///   didSet { self.refreshPressScale() }
/// }
///
/// private func refreshPressScale() {
///   guard self.onTap != nil else {
///     BezierPressFeedback.reset(self.rootStackView)
///     return
///   }
///   BezierPressFeedback.apply(isPressed: self.isHighlighted, to: self.rootStackView)
/// }
/// ```
///
/// SwiftUI에서는 `View.bezierPressScale(isPressed:)`를 사용한다.
///
/// Figma에 대응 정의가 없는 코드 전용 동작이다 (협의 적용 · 원 패턴은 ch-desk-ios `ListItemPressFeedback`).
public enum BezierPressFeedback {
  static let pressScale: CGFloat = 0.97
  static let pressInDuration: TimeInterval = 0.10
  static let releaseDuration: TimeInterval = 0.40
  static let releaseScaleValues: [NSNumber] = [0.97, 1.004, 1.0]
  static let releaseScaleKeyTimes: [NSNumber] = [0, 0.55, 1.0]
  static let springResponse: Double = 0.34
  static let springDampingFraction: Double = 0.62

  private static let releaseAnimationKey = "bezierPressFeedbackRelease"

  // MARK: - UIKit

  /// `contentView`에 press 피드백을 적용한다. `isPressed`가 `true`면 축소하고, `false`면 오버슈트하며 원래 크기로 복귀한다.
  ///
  /// - Parameters:
  ///   - isPressed: 눌린 상태 여부. `UIControl`이면 `isHighlighted`를 그대로 넘긴다.
  ///   - contentView: 축소할 **콘텐츠** 뷰. 배경을 그리는 컴포넌트 루트가 아니라 그 안의 콘텐츠 컨테이너를 넘긴다.
  @MainActor
  public static func apply(isPressed: Bool, to contentView: UIView) {
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

  /// 진행 중인 press 애니메이션을 제거하고 `contentView`를 원래 크기로 되돌린다. 탭을 받지 않는(비인터랙티브) 상태로 바뀔 때 호출한다.
  @MainActor
  public static func reset(_ contentView: UIView) {
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
  /// 눌린 동안 콘텐츠를 `0.97`로 축소하는 press 피드백을 건다. 계약과 근거는 `BezierPressFeedback` 참조.
  ///
  /// **`.padding`·`.background`보다 앞(콘텐츠 쪽)에 붙여야 한다.** 뒤에 붙이면 pressed 배경까지 함께 축소된다.
  /// ```swift
  /// func makeBody(configuration: Configuration) -> some View {
  ///   configuration.label
  ///     .bezierPressScale(isPressed: configuration.isPressed)          // 콘텐츠만 축소
  ///     .padding(.horizontal, 6)
  ///     .background(configuration.isPressed ? pressedColor : .clear)   // 배경은 full-size 유지
  /// }
  /// ```
  ///
  /// - Parameter isPressed: 눌린 상태 여부. `ButtonStyle`이면 `configuration.isPressed`를 그대로 넘긴다.
  public func bezierPressScale(isPressed: Bool) -> some View {
    self.modifier(BezierPressScaleModifier(isPressed: isPressed))
  }
}
