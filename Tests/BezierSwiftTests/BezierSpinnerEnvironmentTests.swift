import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierSpinner Environment", .serialized)
@MainActor
struct BezierSpinnerEnvironmentTests {
  @Test("창의 라이트/다크 전환을 반복하면 실제 레이어 색이 갱신된다")
  func followsWindowAppearance() throws {
    let (window, spinner) = makeSpinner()
    defer { window.isHidden = true }
    for index in 0..<20 {
      let dark = index.isMultiple(of: 2)
      window.overrideUserInterfaceStyle = dark ? .dark : .light
      window.layoutIfNeeded()
      #expect(spinner.traitCollection.userInterfaceStyle == (dark ? .dark : .light))
      try expectColor(spinner, white: dark ? 1 : 0, alpha: dark ? 0.12 : 0.08)
    }
  }

  @Test("서로 다른 모드의 두 창은 외부 current traits와 무관하게 각자의 색을 쓴다")
  func resolvesLocalAppearance() throws {
    let (lightWindow, lightSpinner) = makeSpinner()
    let (darkWindow, darkSpinner) = makeSpinner()
    defer { lightWindow.isHidden = true; darkWindow.isHidden = true }
    lightWindow.overrideUserInterfaceStyle = .light
    darkWindow.overrideUserInterfaceStyle = .dark
    lightWindow.layoutIfNeeded()
    darkWindow.layoutIfNeeded()
    for (spinner, dark) in [(lightSpinner, false), (darkSpinner, true)] {
      #expect(spinner.traitCollection.userInterfaceStyle == (dark ? .dark : .light))
      let opposite = UITraitCollection(userInterfaceStyle: dark ? .light : .dark)
      opposite.performAsCurrent { spinner.componentTheme = .inverted }
      try expectColor(spinner, white: dark ? 0 : 1, alpha: dark ? 0.08 : 0.12)

      // Button/IconButton처럼 ambient traits를 참조하는 palette override도 검증한다.
      opposite.performAsCurrent {
        spinner.fillColorOverride = UIColor { _ in
          UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        }
      }
      try expectColor(spinner, white: dark ? 1 : 0, alpha: 1)

      opposite.performAsCurrent {
        spinner.fillColorOverride = nil
        spinner.componentTheme = .normal
      }
      try expectColor(spinner, white: dark ? 1 : 0, alpha: dark ? 0.12 : 0.08)
    }
  }

  @Test("100회 resize와 trait 변경에서도 지정 크기·중심·기존 회전을 유지한다")
  func repeatedResizeAndTraits() throws {
    let (window, spinner) = makeSpinner()
    defer { window.isHidden = true }
    let arc = try arcLayer(spinner)
    let key = "bezierSpinnerRotation"
    let animation = try #require(arc.animation(forKey: key))
    animation.setValue("original", forKey: "testIdentity")
    arc.add(animation, forKey: key)
    let sizes = [CGSize(width: 1024, height: 1366), CGSize(width: 320, height: 900),
                 CGSize(width: 900, height: 400), CGSize(width: 10, height: 10)]
    for index in 0..<100 {
      let compact = index.isMultiple(of: 2)
      window.frame.size = sizes[index % sizes.count]
      window.overrideUserInterfaceStyle = compact ? .dark : .light
      if #available(iOS 17.0, *) {
        window.traitOverrides.horizontalSizeClass = compact ? .compact : .regular
        window.traitOverrides.verticalSizeClass = compact ? .regular : .compact
        window.traitOverrides.displayScale = compact ? 2 : 3
        window.traitOverrides.preferredContentSizeCategory = compact ? .accessibilityExtraExtraExtraLarge : .large
        window.traitOverrides.layoutDirection = compact ? .rightToLeft : .leftToRight
      }
      window.layoutIfNeeded()
      #expect(spinner.bounds.size == window.bounds.size)
      #expect(arc.bounds.size == CGSize(width: 20, height: 20))
      #expect(arc.position == CGPoint(x: spinner.bounds.midX, y: spinner.bounds.midY))
      #expect(arc.animationKeys() == [key])
      #expect(arc.animation(forKey: key)?.value(forKey: "testIdentity") as? String == "original")
      #expect(arc.animation(forKey: key)?.duration == 1)
      try expectColor(spinner, white: compact ? 1 : 0, alpha: compact ? 0.12 : 0.08)
      if #available(iOS 17.0, *) {
        #expect(spinner.traitCollection.horizontalSizeClass == (compact ? .compact : .regular))
        #expect(spinner.traitCollection.verticalSizeClass == (compact ? .regular : .compact))
        #expect(spinner.traitCollection.displayScale == (compact ? 2 : 3))
        #expect(spinner.traitCollection.preferredContentSizeCategory == (compact ? .accessibilityExtraExtraExtraLarge : .large))
        #expect(spinner.traitCollection.layoutDirection == (compact ? .rightToLeft : .leftToRight))
      }
    }
  }

  private func makeSpinner() -> (UIWindow, BezierSpinner) {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 1024, height: 1366))
    let spinner = BezierSpinner(size: .size20)
    window.addSubview(spinner)
    NSLayoutConstraint.activate([
      spinner.leadingAnchor.constraint(equalTo: window.leadingAnchor),
      spinner.trailingAnchor.constraint(equalTo: window.trailingAnchor),
      spinner.topAnchor.constraint(equalTo: window.topAnchor),
      spinner.bottomAnchor.constraint(equalTo: window.bottomAnchor),
    ])
    window.isHidden = false
    window.layoutIfNeeded()
    return (window, spinner)
  }

  private func arcLayer(_ spinner: BezierSpinner) throws -> CAShapeLayer {
    try #require(spinner.layer.sublayers?.compactMap { $0 as? CAShapeLayer }.first)
  }

  private func expectColor(_ spinner: BezierSpinner, white: CGFloat, alpha: CGFloat) throws {
    let color = UIColor(cgColor: try #require(try arcLayer(spinner).fillColor))
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    #expect(color.getRed(&r, green: &g, blue: &b, alpha: &a))
    #expect(abs(r - white) < 0.001 && abs(g - white) < 0.001 && abs(b - white) < 0.001)
    #expect(abs(a - alpha) < 0.001)
  }
}
