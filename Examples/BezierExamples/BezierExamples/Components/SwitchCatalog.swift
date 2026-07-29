import SwiftUI
import UIKit
import BezierSwift

struct SwitchCatalog: View {
  @State private var isOn: Bool = false
  @State private var hasError: Bool = false
  @State private var isEnabled: Bool = true

  var body: some View {
    CatalogScreen(title: "Switch") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Matrix (isOn × state)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIMatrix }
      CatalogSection(.uiKit) { self.uiKitMatrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      Toggle("On", isOn: self.$isOn).font(.callout)
      Toggle("Has Error", isOn: self.$hasError).font(.callout)
      Toggle("Enabled", isOn: self.$isEnabled).font(.callout)
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierSwitch(isOn: self.$isOn, hasError: self.hasError)
        .disabled(!self.isEnabled)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        {
          let bezierSwitch = BezierSwitch()
          bezierSwitch.addAction(
            UIAction { [weak bezierSwitch] _ in
              guard let bezierSwitch else { return }
              self.isOn = bezierSwitch.isOn
            },
            for: .valueChanged
          )
          return bezierSwitch
        },
        update: { (bezierSwitch: BezierSwitch) in
          bezierSwitch.setOn(self.isOn, animated: true)
          bezierSwitch.hasError = self.hasError
        }
      )
      .fixedSize()
      // SwiftUI가 environment isEnabled를 UIControl.isEnabled로 강제 동기화 — 직접 설정 대신 .disabled로 제어
      .disabled(!self.isEnabled)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      self.matrixRow(title: "default") { isOn in
        SUBezierSwitch(isOn: .constant(isOn))
      }
      self.matrixRow(title: "disabled") { isOn in
        SUBezierSwitch(isOn: .constant(isOn))
          .disabled(true)
      }
      self.matrixRow(title: "hasError") { isOn in
        SUBezierSwitch(isOn: .constant(isOn), hasError: true)
      }
    }
  }

  private var uiKitMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      self.matrixRow(title: "default") { isOn in
        UIKitWrap({ BezierSwitch(isOn: isOn) })
          .fixedSize()
      }
      self.matrixRow(title: "disabled") { isOn in
        UIKitWrap({ BezierSwitch(isOn: isOn) })
          .fixedSize()
          // SwiftUI가 environment isEnabled를 UIControl.isEnabled로 강제 동기화 — 직접 설정 대신 .disabled로 제어
          .disabled(true)
      }
      self.matrixRow(title: "hasError") { isOn in
        UIKitWrap({ BezierSwitch(isOn: isOn, hasError: true) })
          .fixedSize()
      }
    }
  }

  private func matrixRow(
    title: String,
    @ViewBuilder content: @escaping (Bool) -> some View
  ) -> some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(title).font(.caption2).foregroundStyle(.secondary)
      HStack(spacing: 12) {
        content(false)
        content(true)
        Spacer(minLength: 0)
      }
    }
  }
}
