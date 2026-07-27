//
//  SUBezierSwitch.swift
//  BezierSwift
//

import SwiftUI

/// ON/OFF 설정 토글 컴포넌트 (SwiftUI). 라벨 없이 `50×28pt` 단일 크기로 제공되며, 라벨과 배치는 컨테이너(행)가 소유한다. UIKit에서는 `BezierSwitch`를 사용한다.
public struct SUBezierSwitch: View, Themeable {
  @Binding private var isOn: Bool
  private let hasError: Bool

  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.accessibilityReduceMotion) private var reduceMotion
  @Environment(\.colorScheme) public var colorScheme

  /// ON 상태 바인딩과 오류 표시 여부를 지정해 스위치를 만든다. `hasError`는 Figma `hasError` 프로퍼티에 대응하며 `true`면 트랙 외곽에 warning ring이 나타난다. 비활성화는 `.disabled(true)`로 제어한다.
  public init(isOn: Binding<Bool>, hasError: Bool = false) {
    self._isOn = isOn
    self.hasError = hasError
  }

  public var body: some View {
    Button(action: { self.isOn.toggle() }) {
      ZStack(alignment: self.isOn ? .trailing : .leading) {
        RoundedRectangle(cornerRadius: BezierSwitchConstant.trackCornerRadius)
          .fill(
            self.palette(
              self.isOn
                ? BezierSwitchConstant.trackOnColor
                : BezierSwitchConstant.trackOffColor
            )
          )

        Circle()
          .fill(self.palette(BezierSwitchConstant.thumbColor))
          .frame(
            width: BezierSwitchConstant.thumbLength,
            height: BezierSwitchConstant.thumbLength
          )
          .shadow(
            color: Color.black.opacity(Double(BezierSwitchConstant.thumbShadowOpacity)),
            radius: BezierSwitchConstant.thumbShadowRadius,
            x: BezierSwitchConstant.thumbShadowOffset.width,
            y: BezierSwitchConstant.thumbShadowOffset.height
          )
          .padding(BezierSwitchConstant.thumbInset)
      }
      .frame(
        width: BezierSwitchConstant.trackWidth,
        height: BezierSwitchConstant.trackHeight
      )
      .overlay(self.errorRing)
      .animation(
        self.reduceMotion
          ? nil
          : .easeInOut(duration: BezierSwitchConstant.toggleAnimationDuration),
        value: self.isOn
      )
    }
    .buttonStyle(SUBezierSwitchButtonStyle())
    // compositingGroup 없이는 opacity가 per-view 곱으로 렌더돼 thumb 아래 트랙이 비침 — Figma·UIKit(그룹 opacity)과 동일한 flatten 강제
    .compositingGroup()
    .opacity(self.isEnabled ? 1 : BezierSwitchConstant.disabledOpacity)
  }

  @ViewBuilder
  private var errorRing: some View {
    if self.hasError {
      Capsule()
        .strokeBorder(
          self.palette(BezierSwitchConstant.errorRingColor),
          lineWidth: BezierSwitchConstant.errorRingWidth
        )
        .padding(-BezierSwitchConstant.errorRingSpacing)
    }
  }
}

private struct SUBezierSwitchButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}

struct SUBezierSwitch_Previews: PreviewProvider {
  private struct Container: View {
    @State private var isOn = true
    @State private var isOff = false

    var body: some View {
      VStack(spacing: 16) {
        HStack(spacing: 12) {
          SUBezierSwitch(isOn: self.$isOff)
          SUBezierSwitch(isOn: self.$isOn)
        }

        HStack(spacing: 12) {
          SUBezierSwitch(isOn: self.$isOff)
            .disabled(true)
          SUBezierSwitch(isOn: self.$isOn)
            .disabled(true)
        }

        HStack(spacing: 12) {
          SUBezierSwitch(isOn: self.$isOff, hasError: true)
          SUBezierSwitch(isOn: self.$isOn, hasError: true)
        }
      }
      .padding()
    }
  }

  static var previews: some View {
    Container()
  }
}
