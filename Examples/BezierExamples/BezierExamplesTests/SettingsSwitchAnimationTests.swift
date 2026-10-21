import Testing
import UIKit
@testable import BezierExamples

@MainActor
@Suite(.serialized)
struct SettingsSwitchAnimationTests {
  @Test(arguments: [false, true])
  func externalUpdatesAnimateInBothDirections(recreateSwitch: Bool) async throws {
    let controller = SettingsSwitchController()
    let scene = try #require(UIApplication.shared.connectedScenes.first as? UIWindowScene)
    let window = UIWindow(windowScene: scene)
    window.frame = CGRect(x: 0, y: 0, width: 320, height: 200)
    window.overrideUserInterfaceStyle = .light
    window.rootViewController = controller
    window.makeKeyAndVisible()
    defer { window.isHidden = true }
    controller.render(isOn: false, revision: 0, iconIsFilled: false, isEnabled: true, recreateSwitch: recreateSwitch)
    window.layoutIfNeeded()
    try await Task.sleep(nanoseconds: 300_000_000)

    for (revision, isOn) in [(1, true), (2, false)] {
      let start = try self.thumbPositions(controller)
      controller.render(isOn: isOn, revision: revision, iconIsFilled: isOn, isEnabled: true, recreateSwitch: recreateSwitch)
      var samples: [[CGFloat]] = []
      let deadline = CACurrentMediaTime() + 0.8
      while CACurrentMediaTime() < deadline {
        try await Task.sleep(nanoseconds: 16_000_000)
        samples.append(try self.thumbPositions(controller))
      }
      let end = try #require(samples.last)
      for index in 0..<2 {
        #expect(abs(end[index] - start[index]) > 15, "\(index == 0 ? "UIKit" : "SwiftUI") must actually change position")
        let lower = min(start[index], end[index]) + 2
        let upper = max(start[index], end[index]) - 2
        let hasIntermediatePosition = samples.contains { $0[index] > lower && $0[index] < upper }
        #expect(hasIntermediatePosition == (index == 0 || !recreateSwitch),
                "\(index == 0 ? "UIKit" : "SwiftUI") must render intermediate positions: \(samples.map { $0[index] })")
      }
    }
  }

  private func thumbPositions(_ controller: SettingsSwitchController) throws -> [CGFloat] {
    let view = try #require(controller.view)
    let image = UIGraphicsImageRenderer(bounds: view.bounds).image { _ in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    }
    let cgImage = try #require(image.cgImage)
    let width = cgImage.width
    let height = cgImage.height
    var pixels = [UInt8](repeating: 0, count: width * height * 4)
    let context = try #require(CGContext(
      data: &pixels, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4,
      space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    ))
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    let uiKitFrame = controller.uiKitSwitch.convert(controller.uiKitSwitch.bounds, to: view)
    let swiftUIFrame = try #require(controller.children.first?.view.frame)
    let scale = image.scale
    return [uiKitFrame.midY, swiftUIFrame.midY].map { centerY in
      let y = Int(centerY * scale)
      let range = Int((uiKitFrame.minX + 2) * scale)..<Int((uiKitFrame.maxX - 2) * scale)
      let thumbPixels = range.filter { x in
        let offset = (y * width + x) * 4
        return pixels[offset] > 248 && pixels[offset + 1] > 248 && pixels[offset + 2] > 248
      }
      #expect(!thumbPixels.isEmpty, "The hosted switch must be visible")
      return CGFloat(thumbPixels.reduce(0, +)) / CGFloat(max(1, thumbPixels.count)) / scale
    }
  }
}
