import SwiftUI
import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierButton Vertical Alignment", .serialized)
@MainActor
struct BezierButtonVerticalAlignmentTests {
  @Test("UIKit과 SwiftUI 텍스트는 버튼 중앙에 렌더링된다")
  func textIsVerticallyCentered() throws {
    for size in BezierButtonSize.allCases {
      for text in ["Label", "버튼"] {
        let uiKitImage = self.renderUIKitButton(size: size, text: text)
        let swiftUIImage = try self.renderSwiftUIButton(size: size, text: text)

        let uiKitDelta = try self.verticalCenterDelta(in: uiKitImage)
        let swiftUIDelta = try self.verticalCenterDelta(in: swiftUIImage)

        #expect(abs(uiKitDelta) <= 0.5)
        #expect(abs(swiftUIDelta) <= 0.5)
        #expect(abs(uiKitDelta - swiftUIDelta) <= 0.5)
      }
    }
  }

  @Test("Badge와 Tag 텍스트는 컴포넌트 중앙에 렌더링된다")
  func relatedComponentTextIsVerticallyCentered() throws {
    for text in ["Label", "버튼"] {
      for size in BezierBadgeSize.allCases {
        let badge = BezierBadge(size: size, variant: .default)
        badge.label = text
        let window = self.layoutInWindow(badge, size: badge.intrinsicContentSize)

        let label = try #require(self.firstLabel(in: badge))
        let image = withExtendedLifetime(window) { self.render(view: label) }
        #expect(abs(try self.verticalCenterDelta(in: image)) <= 0.5)
      }

      for size in BezierTagSize.allCases {
        let tag = BezierTag(size: size, variant: .default)
        tag.label = text
        let window = self.layoutInWindow(tag, size: CGSize(width: 120, height: size.height))

        let label = try #require(self.firstLabel(in: tag))
        let image = withExtendedLifetime(window) { self.render(view: label) }
        #expect(abs(try self.verticalCenterDelta(in: image)) <= 0.5)
      }
    }
  }

  private func renderUIKitButton(size: BezierButtonSize, text: String) -> UIImage {
    let button = BezierButton(size: size, variant: .ghost, semantic: .primary)
    button.title = text
    let window = self.layoutInWindow(button, size: button.intrinsicContentSize)

    return withExtendedLifetime(window) { self.render(view: button) }
  }

  private func renderSwiftUIButton(size: BezierButtonSize, text: String) throws -> UIImage {
    let renderer = ImageRenderer(
      content: SUBezierButton(
        size: size,
        variant: .ghost,
        semantic: .primary,
        title: text,
        action: {}
      )
    )
    renderer.scale = 3
    return try #require(renderer.uiImage)
  }

  private func verticalCenterDelta(in image: UIImage) throws -> CGFloat {
    let cgImage = try #require(image.cgImage)
    let data = try #require(cgImage.dataProvider?.data)
    let bytes = CFDataGetBytePtr(data)
    let bytesPerPixel = cgImage.bitsPerPixel / 8
    var minY = cgImage.height
    var maxY = -1

    for y in 0..<cgImage.height {
      for x in 0..<cgImage.width {
        let index = y * cgImage.bytesPerRow + x * bytesPerPixel
        if bytes?[index + 3] ?? 0 > 8 {
          minY = min(minY, y)
          maxY = max(maxY, y)
        }
      }
    }

    #expect(maxY >= minY)
    let glyphMidY = CGFloat(minY + maxY + 1) / 2 / image.scale
    return glyphMidY - image.size.height / 2
  }

  private func render(view: UIView) -> UIImage {
    let format = UIGraphicsImageRendererFormat()
    format.scale = 3
    format.opaque = false
    return UIGraphicsImageRenderer(size: view.bounds.size, format: format).image { context in
      view.layer.render(in: context.cgContext)
    }
  }

  private func layoutInWindow(_ view: UIView, size: CGSize) -> UIWindow {
    let window = UIWindow(frame: CGRect(origin: .zero, size: size))
    window.addSubview(view)
    view.frame = window.bounds
    window.setNeedsLayout()
    window.layoutIfNeeded()
    return window
  }

  private func firstLabel(in view: UIView) -> UILabel? {
    if let label = view as? UILabel { return label }
    return view.subviews.lazy.compactMap(self.firstLabel(in:)).first
  }
}
