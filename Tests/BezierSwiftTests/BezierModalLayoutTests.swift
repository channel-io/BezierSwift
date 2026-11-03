import SwiftUI
import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierModal 기본 여백과 전체 영역 콘텐츠", .serialized)
@MainActor
struct BezierModalLayoutTests {
  @Test("기본 생성자는 상단 20·하단 16·좌우 16pt와 최소 카드 높이 37pt를 유지한다")
  func defaultInsetsArePreserved() {
    let modal = BezierModal()
    let window = self.layout(modal)

    #expect(modal.bounds.size == CGSize(width: 320, height: 37))
    #expect(modal.contentView.convert(modal.contentView.bounds, to: modal)
      == CGRect(x: 16, y: 20, width: 288, height: 1))
    #expect(window.subviews.contains(modal))
  }

  @Test("기본 콘텐츠 편의 생성자도 여백을 유지한다")
  func convenienceControllerPreservesInsets() {
    let content = UIView()
    content.heightAnchor.constraint(equalToConstant: 80).isActive = true
    let controller = BezierModalViewController(contentView: content)
    let window = self.layout(controller)

    #expect(controller.modalView.bounds.height == 116)
    #expect(content.convert(content.bounds, to: controller.modalView)
      == CGRect(x: 16, y: 20, width: controller.modalView.bounds.width - 32, height: 80))
    #expect(window.rootViewController === controller)
  }

  @Test("명시적 zero 여백에서 빈 카드의 최소 높이는 1pt다")
  func zeroInsetsAllowOnePointMinimum() {
    let modal = BezierModal(contentInsets: .zero)
    let window = self.layout(modal)

    #expect(modal.bounds.size == CGSize(width: 320, height: 1))
    #expect(modal.contentView.convert(modal.contentView.bounds, to: modal) == modal.bounds)
    #expect(window.subviews.contains(modal))
  }

  @Test("명시적 zero 여백은 37pt 미만을 포함한 요청 높이와 카드 가장자리 hit testing을 유지한다",
        arguments: [CGFloat(1), 16, 36, 100])
  func zeroInsetsHostContentAtRequestedHeight(height: CGFloat) {
    let modal = BezierModal(contentInsets: .zero)
    let content = UIView()
    self.pin(content, to: modal.contentView)
    content.heightAnchor.constraint(equalToConstant: height).isActive = true
    modal.heightAnchor.constraint(equalToConstant: height).isActive = true
    let controller = BezierModalViewController(modalView: modal)
    let window = self.layout(controller)

    #expect(modal.bounds.height == height)
    #expect(content.convert(content.bounds, to: modal) == modal.bounds)
    #expect(!modal.hasAmbiguousLayout)
    #expect(!modal.contentView.hasAmbiguousLayout)
    #expect(!content.hasAmbiguousLayout)
    for point in [
      CGPoint(x: 0.25, y: height / 2),
      CGPoint(x: modal.bounds.width - 0.25, y: height / 2),
      CGPoint(x: modal.bounds.midX, y: 0.25),
      CGPoint(x: modal.bounds.midX, y: height - 0.25),
    ] {
      #expect(modal.hitTest(point, with: nil) === content)
    }
    #expect(modal.hitTest(CGPoint(x: -1, y: height / 2), with: nil) == nil)
    #expect(modal.hitTest(CGPoint(x: modal.bounds.maxX + 1, y: height / 2), with: nil) == nil)
    #expect(modal.frame.minY >= controller.view.safeAreaInsets.top)
    #expect(modal.frame.maxY <= controller.view.bounds.height - controller.view.safeAreaInsets.bottom)
    #expect(controller.modalPresentationStyle == .overFullScreen)
    #expect(controller.modalTransitionStyle == .crossDissolve)
    #expect(window.rootViewController === controller)
  }

  @Test("명시적 비대칭 여백은 LTR·RTL에서 UIEdgeInsets의 네 방향에 적용된다",
        arguments: [UISemanticContentAttribute.forceLeftToRight, .forceRightToLeft])
  func customInsetsApplyToEveryEdge(direction: UISemanticContentAttribute) {
    let modal = BezierModal(contentInsets: UIEdgeInsets(top: 3, left: 5, bottom: 7, right: 11))
    modal.semanticContentAttribute = direction
    modal.contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    let window = self.layout(modal)

    #expect(modal.bounds.height == 50)
    #expect(modal.contentView.convert(modal.contentView.bounds, to: modal)
      == CGRect(x: 5, y: 3, width: 304, height: 40))
    #expect(window.subviews.contains(modal))
  }

  @Test("zero 여백에서도 콘텐츠 모서리는 클리핑되고 바깥 그림자는 유지된다")
  func zeroInsetsPreserveClippingAndShadow() throws {
    let modal = BezierModal(contentInsets: .zero)
    modal.contentView.backgroundColor = .red
    modal.contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    let window = self.layout(modal)
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1
    format.preferredRange = .standard
    let image = UIGraphicsImageRenderer(bounds: modal.bounds, format: format).image { context in
      modal.layer.render(in: context.cgContext)
    }
    let cgImage = try #require(image.cgImage)
    var pixels = [UInt8](repeating: 0, count: cgImage.width * cgImage.height * 4)
    pixels.withUnsafeMutableBytes { buffer in
      let context = CGContext(
        data: buffer.baseAddress, width: cgImage.width, height: cgImage.height,
        bitsPerComponent: 8, bytesPerRow: cgImage.width * 4,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
      )!
      context.draw(cgImage, in: modal.bounds)
    }
    let center = (50 * cgImage.width + 160) * 4
    #expect(pixels[center] == 255)
    #expect(pixels[center + 1] == 0)
    #expect(pixels[center + 2] == 0)
    for (x, y) in [(0, 0), (319, 0), (0, 99), (319, 99)] {
      #expect(pixels[(y * cgImage.width + x) * 4] < 10)
    }
    #expect(!modal.layer.masksToBounds)
    #expect(modal.layer.shadowOpacity == 1)
    #expect(modal.layer.shadowRadius == BezierModalSpec.elevation.rawValue.blur)
    #expect(modal.layer.shadowPath == UIBezierPath(
      roundedRect: modal.bounds, cornerRadius: BezierModalSpec.cornerRadius.rawValue
    ).cgPath)
    #expect(window.subviews.contains(modal))
  }

  @Test("확인 모달은 기본 여백 안에 버튼을 배치한다")
  func confirmModalPreservesInsets() {
    let modal = BezierConfirmModal(
      title: "확인", confirmAction: .init(title: "확인"), cancelAction: nil
    )
    let window = self.layout(modal)
    let buttonFrame = modal.confirmButton.convert(modal.confirmButton.bounds, to: modal)

    #expect(buttonFrame.minX == 16)
    #expect(buttonFrame.maxX == modal.bounds.width - 16)
    #expect(buttonFrame.maxY == modal.bounds.height - 16)
    #expect(window.subviews.contains(modal))
  }

  @Test("SwiftUI 기본 카드도 콘텐츠에 상하 36pt 여백을 유지한다")
  func swiftUICardPreservesInsets() throws {
    let renderer = ImageRenderer(content: SUBezierModal {
      Color.red.frame(height: 80)
    })
    renderer.scale = 1
    let image = try #require(renderer.uiImage)

    #expect(image.size == CGSize(width: 320, height: 116))
  }

  private func pin(_ content: UIView, to container: UIView) {
    content.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(content)
    NSLayoutConstraint.activate([
      content.topAnchor.constraint(equalTo: container.topAnchor),
      content.bottomAnchor.constraint(equalTo: container.bottomAnchor),
      content.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      content.trailingAnchor.constraint(equalTo: container.trailingAnchor),
    ])
  }

  private func layout(_ view: UIView) -> UIWindow {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
    window.addSubview(view)
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: window.leadingAnchor),
      view.topAnchor.constraint(equalTo: window.topAnchor),
    ])
    window.setNeedsLayout()
    window.layoutIfNeeded()
    return window
  }

  private func layout(_ controller: UIViewController) -> UIWindow {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
    window.rootViewController = controller
    window.isHidden = false
    window.setNeedsLayout()
    window.layoutIfNeeded()
    return window
  }
}
