import SwiftUI
import Foundation
import Testing
@testable import BezierSwift

@Suite("BezierAvatar Rendering", .serialized)
@MainActor
struct BezierAvatarRenderingTests {
  private func solidImage(_ color: UIColor) -> UIImage {
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    return UIGraphicsImageRenderer(size: CGSize(width: 80, height: 60), format: format).image { context in
      color.setFill()
      context.fill(CGRect(x: 0, y: 0, width: 80, height: 60))
    }
  }

  private func renderUIKit(
    size: BezierAvatarSize, image: UIImage?, scale: CGFloat,
    dark: Bool, border: Bool = true, overlap: Bool = false, status: Bool = false, phase: CGFloat = 0
  ) -> UIImage {
    let length = size.length
    let width = overlap ? length * 2.4 + 16 : length + 16
    let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: length + 16))
    let window = UIWindow(frame: container.bounds)
    if #available(iOS 17.0, *) { window.traitOverrides.displayScale = scale }
    window.overrideUserInterfaceStyle = dark ? .dark : .light
    window.addSubview(container)
    container.overrideUserInterfaceStyle = dark ? .dark : .light
    container.backgroundColor = dark ? UIColor(white: 0.18, alpha: 1) : UIColor(white: 0.72, alpha: 1)
    let traits = UITraitCollection(traitsFrom: [
      UITraitCollection(userInterfaceStyle: dark ? .dark : .light),
      UITraitCollection(displayScale: scale),
    ])
    traits.performAsCurrent {
      for index in 0..<(overlap ? 3 : 1) {
        let avatar = BezierAvatar(
          image: image, size: size, showBorder: border,
          statusType: status ? .online : nil
        )
        container.addSubview(avatar)
        avatar.componentTheme = .normal
        NSLayoutConstraint.activate([
          avatar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8 + phase + CGFloat(index) * length * 0.7),
          avatar.topAnchor.constraint(equalTo: container.topAnchor, constant: 8 + phase),
        ])
      }
      container.layoutIfNeeded()
    }
    return snapshotUIKit(container, scale: scale, traits: traits)
  }

  private func snapshotUIKit(_ container: UIView, scale: CGFloat, traits: UITraitCollection) -> UIImage {
    func setLayerScale(_ layer: CALayer) {
      layer.contentsScale = scale
      if let mask = layer.mask { setLayerScale(mask) }
      layer.sublayers?.forEach(setLayerScale)
    }
    func setScale(_ view: UIView) {
      view.contentScaleFactor = scale
      view.subviews.forEach(setScale)
    }
    setScale(container)
    setLayerScale(container.layer)
    let format = UIGraphicsImageRendererFormat()
    format.scale = scale
    format.opaque = true
    format.preferredRange = .standard
    return traits.performAsCurrentReturning {
      UIGraphicsImageRenderer(bounds: container.bounds, format: format).image { context in
        container.layer.render(in: context.cgContext)
      }
    }
  }

  private func renderSwiftUI(
    size: BezierAvatarSize, image: UIImage?, scale: CGFloat,
    dark: Bool, border: Bool = true, overlap: Bool = false, status: Bool = false, phase: CGFloat = 0
  ) -> UIImage {
    let length = size.length
    let width = overlap ? length * 2.4 : length
    let content = ZStack(alignment: .topLeading) {
      ForEach(0..<(overlap ? 3 : 1), id: \.self) { index in
        SUBezierAvatar(
          image: image.map { Image(uiImage: $0) }, size: size, showBorder: border,
          statusType: status ? .online : nil
        )
        .offset(x: phase + CGFloat(index) * length * 0.7, y: phase)
      }
    }
    .frame(width: width, height: length, alignment: .topLeading)
    .padding(8)
    .background(Color(white: dark ? 0.18 : 0.72))
    .environment(\.colorScheme, dark ? .dark : .light)
    .environment(\.displayScale, scale)
    let renderer = ImageRenderer(content: content)
    renderer.scale = scale
    return renderer.uiImage!
  }

  /// TEST_RUNNER_BEZIER_AVATAR_SNAPSHOT_DIRECTORY를 지정한 xcodebuild 실행에서만 PNG를 내보낸다.
  @Test(.enabled(if: ProcessInfo.processInfo.environment["BEZIER_AVATAR_SNAPSHOT_DIRECTORY"] != nil))
  func exportComparisonSnapshots() throws {
    let path = try #require(ProcessInfo.processInfo.environment["BEZIER_AVATAR_SNAPSHOT_DIRECTORY"])
    let directory = URL(fileURLWithPath: path)
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    var pathElements: [[Double]] = []
    CGPath(roundedRect: CGRect(x: 0, y: 0, width: 16, height: 16), cornerWidth: 6.72, cornerHeight: 6.72, transform: nil).applyWithBlock { element in
      let count: Int
      switch element.pointee.type {
      case .moveToPoint, .addLineToPoint: count = 1
      case .addQuadCurveToPoint: count = 2
      case .addCurveToPoint: count = 3
      case .closeSubpath: count = 0
      @unknown default: count = 0
      }
      pathElements.append([Double(element.pointee.type.rawValue)] + (0..<count).flatMap {
        [Double(element.pointee.points[$0].x), Double(element.pointee.points[$0].y)]
      })
    }
    try JSONEncoder().encode(pathElements).write(to: directory.appendingPathComponent("uikit-size16-path.json"))
    let photo = try #require(UIImage(contentsOfFile: Bundle.module.url(forResource: "AvatarPhoto", withExtension: "png")!.path))
    let images: [(String, UIImage?)] = [("solid", solidImage(.magenta)), ("photo", photo), ("nil", nil)]
    for size in [BezierAvatarSize.size16, .size24, .size48] {
      for scale: CGFloat in [2, 3] {
        for dark in [false, true] {
          for (imageName, image) in images {
            for arrangement in ["single", "overlap", "status", "no-border", "quarter-pixel", "half-pixel"] {
              for framework in ["uikit", "swiftui"] {
                let renderer = framework == "uikit" ? renderUIKit : renderSwiftUI
                let phase: CGFloat = arrangement == "quarter-pixel" ? 0.25 : arrangement == "half-pixel" ? 0.5 : 0
                let result = renderer(size, image, scale, dark, arrangement != "no-border", arrangement == "overlap", arrangement == "status", phase)
                let name = "\(framework)-\(size.rawValue)-\(dark ? "dark" : "light")-\(Int(scale))x-\(imageName)-\(arrangement).png"
                try result.pngData()!.write(to: directory.appendingPathComponent(name))
              }
            }
          }
        }
      }
    }
  }

  @Test
  func sizeBorderAndStatusUpdates() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    let avatar = BezierAvatar(image: solidImage(.red), size: .size16, showBorder: true, statusType: .online)
    container.addSubview(avatar)
    NSLayoutConstraint.activate([
      avatar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      avatar.topAnchor.constraint(equalTo: container.topAnchor),
    ])
    for size in BezierAvatarSize.allCases {
      avatar.size = size
      for border in [false, true, false, true] {
        avatar.showBorder = border
        container.setNeedsLayout()
        container.layoutIfNeeded()
        #expect(avatar.bounds.size == CGSize(width: size.length, height: size.length))
        #expect(!avatar.clipsToBounds)
        let status = avatar.subviews.last!
        #expect(status.frame.origin == size.statusOverlayPosition)
        #expect(status.bounds.width == size.statusOverlayLength)
        #expect(status.layer.zPosition == 1)
      }
    }
    avatar.isEnabled = false
    #expect(abs(avatar.alpha - BezierAvatarConstant.disabledOpacity) <= 0.00001)
    avatar.statusType = nil
    #expect(!avatar.subviews.contains { $0.layer.zPosition == 1 })
  }

  /// 안쪽 경계에서 충분히 떨어진 외곽 픽셀은 원본 이미지의 색에 영향을 받으면 안 된다.
  /// 단순 golden 비교 대신 서로 다른 이미지로 합성 결함을 검출한다.
  @Test
  func outerBorderIsIndependentOfImageColor() throws {
    var snapshotIndices: [String: [Int]] = [:]
    for size in BezierAvatarSize.allCases {
      for scale: CGFloat in [2, 3] {
        for dark in [false, true] {
          for (swiftUI, phase) in [false, true].flatMap({ framework in [CGFloat(0), 0.25, 0.5].map { (framework, $0) } }) {
            let render = swiftUI ? renderSwiftUI : renderUIKit
            let red = render(size, solidImage(.red), scale, dark, true, false, false, phase)
            let blue = render(size, solidImage(.blue), scale, dark, true, false, false, phase)
            let empty = render(size, nil, scale, dark, true, false, false, phase)
            let redPixels = pixels(red)
            let bluePixels = pixels(blue)
            let emptyPixels = pixels(empty)
            let cgImage = try #require(red.cgImage)
            let rect = CGRect(x: 0, y: 0, width: size.length, height: size.length)
            let inner: CGPath
            let outerInterior: CGPath
            let outerInset = 0.25 / scale
            if swiftUI {
              inner = RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous)
                .inset(by: size.borderWidth).path(in: rect).cgPath
              outerInterior = RoundedRectangle(cornerRadius: size.cornerRadius, style: .continuous)
                .inset(by: outerInset).path(in: rect).cgPath
            } else {
              inner = CGPath(
                roundedRect: rect.insetBy(dx: size.borderWidth, dy: size.borderWidth),
                cornerWidth: size.cornerRadius - size.borderWidth,
                cornerHeight: size.cornerRadius - size.borderWidth, transform: nil
              )
              outerInterior = CGPath(
                roundedRect: rect.insetBy(dx: outerInset, dy: outerInset),
                cornerWidth: size.cornerRadius - outerInset,
                cornerHeight: size.cornerRadius - outerInset, transform: nil
              )
            }
            var checked = 0
            var maxDifference = 0
            var maxPoint = CGPoint.zero
            var checkedIndices: [Int] = []
            for y in 0..<cgImage.height {
              for x in 0..<cgImage.width {
                let point = CGPoint(x: (CGFloat(x) + 0.5) / scale - 8 - phase, y: (CGFloat(y) + 0.5) / scale - 8 - phase)
                // AA 필터의 영향 범위까지 안쪽 경계에서 제외한다.
                let touchesInner = [-0.75, 0, 0.75].contains { dx in
                  [-0.75, 0, 0.75].contains { dy in
                    inner.contains(CGPoint(x: point.x + dx / scale, y: point.y + dy / scale))
                  }
                }
                let offset = (y * cgImage.width + x) * 4
                let isBorder = (0..<3).contains { abs(Int(emptyPixels[offset + $0]) - Int(emptyPixels[$0])) > 5 }
                // 외곽 AA 픽셀만 검사한다. 소수 좌표에서 리샘플링되는 안쪽 AA는 이미지와 섞이는 것이 정상이다.
                guard !touchesInner, !outerInterior.contains(point), isBorder else { continue }
                checked += 1
                checkedIndices.append(y * cgImage.width + x)
                for channel in 0..<3 {
                  let difference = abs(Int(redPixels[offset + channel]) - Int(bluePixels[offset + channel]))
                  if difference > maxDifference { maxDifference = difference; maxPoint = CGPoint(x: x, y: y) }
                }
              }
            }
            let label = "\(swiftUI ? "SwiftUI" : "UIKit") \(size) \(scale)x dark=\(dark) phase=\(phase)"
            #expect(checked > 10, "\(label)")
            #expect(maxDifference <= 1, "외곽에 이미지 색이 비침: \(label) pixel=\(maxPoint)")
            if phase == 0, [.size16, .size24, .size48].contains(size) {
              let name = "\(swiftUI ? "swiftui" : "uikit")-\(size.rawValue)-\(dark ? "dark" : "light")-\(Int(scale))x"
              snapshotIndices[name] = checkedIndices
            }
          }
        }
      }
    }
    if let path = ProcessInfo.processInfo.environment["BEZIER_AVATAR_SNAPSHOT_DIRECTORY"] {
      let directory = URL(fileURLWithPath: path)
      try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
      try JSONEncoder().encode(snapshotIndices).write(to: directory.appendingPathComponent("outer-pixel-indices.json"))
    }
  }

  @Test
  func borderPreservesImageSamplingAndEmptyCenter() {
    let image = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 60)).image { context in
      UIColor.red.setFill()
      context.fill(CGRect(x: 0, y: 0, width: 40, height: 60))
      UIColor.blue.setFill()
      context.fill(CGRect(x: 40, y: 0, width: 40, height: 60))
    }
    for size in [BezierAvatarSize.size16, .size24, .size48] {
      for scale: CGFloat in [2, 3] {
        for render in [renderUIKit, renderSwiftUI] {
          let bordered = render(size, image, scale, false, true, false, false, 0)
          let unbordered = render(size, image, scale, false, false, false, false, 0)
          let a = pixels(bordered)
          let b = pixels(unbordered)
          let empty = pixels(render(size, nil, scale, false, true, false, false, 0))
          let transparent = pixels(render(size, solidImage(.clear), scale, false, true, false, false, 0))
          let width = bordered.cgImage!.width
          for y in Int((8 + size.length * 0.35) * scale)..<Int((8 + size.length * 0.65) * scale) {
            for x in Int((8 + size.length * 0.35) * scale)..<Int((8 + size.length * 0.65) * scale) {
              let offset = (y * width + x) * 4
              // Core Animation의 중간 합성 버퍼에서 발생하는 8-bit 반올림 오차만 허용한다.
              for channel in 0..<4 {
                #expect(abs(Int(a[offset + channel]) - Int(b[offset + channel])) <= 1)
              }
              #expect(Array(empty[offset..<offset + 4]) == Array(empty[0..<4]))
              #expect(Array(transparent[offset..<offset + 4]) == Array(empty[0..<4]))
            }
          }
        }
      }
    }
  }

  @Test
  func standardBorderWidthAtBothScales() {
    for size in BezierAvatarSize.allCases {
      for scale: CGFloat in [2, 3] {
        for render in [renderUIKit, renderSwiftUI] {
          let image = render(size, nil, scale, false, true, false, false, 0)
          let data = pixels(image)
          let width = image.cgImage!.width
          let x = Int((8 + size.length / 2) * scale)
          let background = Double(data[0])
          var coverage: Double = 0
          for y in Int(8 * scale)..<Int((8 + size.borderWidth + 2) * scale) {
            let value = Double(data[(y * width + x) * 4])
            coverage += (value - background) / (255 - background)
          }
          #expect(abs(coverage / Double(scale) - Double(size.borderWidth)) <= 0.05, "\(size) \(scale)x")
        }
      }
    }
  }

  @Test
  func changingSizeAndBorderMatchesFreshRendering() {
    let image = solidImage(.magenta)
    let container = UIView()
    container.backgroundColor = UIColor(white: 0.72, alpha: 1)
    let window = UIWindow()
    window.overrideUserInterfaceStyle = .light
    window.addSubview(container)
    let avatar = BezierAvatar(image: image, size: .size16, showBorder: true)
    container.addSubview(avatar)
    NSLayoutConstraint.activate([
      avatar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
      avatar.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
    ])
    let traits = UITraitCollection(userInterfaceStyle: .light)
    for scale: CGFloat in [2, 3] {
      for size in [BezierAvatarSize.size16, .size48, .size24, .size16] {
        for border in [true, false, true] {
          traits.performAsCurrent {
            avatar.size = size
            avatar.showBorder = border
            avatar.componentTheme = .normal
            container.frame = CGRect(x: 0, y: 0, width: size.length + 16, height: size.length + 16)
            window.frame = container.frame
            container.setNeedsLayout()
            container.layoutIfNeeded()
          }
          let actual = snapshotUIKit(container, scale: scale, traits: traits)
          let expected = renderUIKit(size: size, image: image, scale: scale, dark: false, border: border)
          #expect(pixels(actual) == pixels(expected), "\(size) border=\(border) \(scale)x")
        }
      }
    }
  }

  private func pixels(_ image: UIImage) -> [UInt8] {
    let image = image.cgImage!
    var bytes = [UInt8](repeating: 0, count: image.width * image.height * 4)
    bytes.withUnsafeMutableBytes { buffer in
      let context = CGContext(
        data: buffer.baseAddress, width: image.width, height: image.height,
        bitsPerComponent: 8, bytesPerRow: image.width * 4,
        space: CGColorSpace(name: CGColorSpace.sRGB)!,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
      )!
      context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    }
    return bytes
  }
}

private extension UITraitCollection {
  func performAsCurrentReturning<T>(_ action: () -> T) -> T {
    var result: T!
    performAsCurrent { result = action() }
    return result
  }
}
