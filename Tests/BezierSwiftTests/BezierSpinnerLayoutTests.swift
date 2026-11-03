import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierSpinner Layout", .serialized)
@MainActor
struct BezierSpinnerLayoutTests {
  @Test("외부 할당 영역과 clipping에 관계없이 지정 크기로 제자리 회전한다", arguments: [
    CGSize(width: 20, height: 780),
    CGSize(width: 80, height: 20),
    CGSize(width: 20, height: 30),
    CGSize(width: 20, height: 20),
    CGSize(width: 20, height: 10),
    CGSize(width: 10, height: 10),
    .zero,
  ], [false, true])
  func rotatesInAllocatedBounds(allocatedSize: CGSize, clipsToBounds: Bool) throws {
    let (window, spinner) = self.makeSpinner(allocatedSize: allocatedSize)
    defer { window.isHidden = true }
    spinner.clipsToBounds = clipsToBounds

    #expect(spinner.bounds.size == allocatedSize)
    #expect(!spinner.hasAmbiguousLayout)
    try self.expectCenteredRotation(spinner)
    #expect(spinner.clipsToBounds == clipsToBounds)
  }

  @Test("외부 크기 제약이 없으면 모든 size의 기본 크기를 제공한다", arguments: BezierSpinnerSize.allCases.map(\.rawValue))
  func usesNaturalSize(sizeRawValue: String) throws {
    let size = try #require(BezierSpinnerSize(rawValue: sizeRawValue))
    let (window, spinner) = self.makeSpinner(size: size)
    defer { window.isHidden = true }
    let expectedSize = CGSize(width: size.length, height: size.length)

    #expect(spinner.intrinsicContentSize == expectedSize)
    #expect(spinner.bounds.size == expectedSize)
    #expect(!spinner.hasAmbiguousLayout)
    try self.expectCenteredRotation(spinner)
  }

  @Test("size 변경 시 기본 뷰 크기와 호 크기가 함께 갱신된다")
  func updatesNaturalSize() throws {
    let (window, spinner) = self.makeSpinner()
    defer { window.isHidden = true }

    spinner.size = .size48
    window.layoutIfNeeded()

    #expect(spinner.bounds.size == CGSize(width: 48, height: 48))
    #expect(spinner.intrinsicContentSize == CGSize(width: 48, height: 48))
    try self.expectCenteredRotation(spinner)
  }

  @Test("작은 영역에서 size를 변경해도 호가 축소되거나 회전축에서 벗어나지 않는다")
  func updatesSizeInsideSmallBounds() throws {
    let allocatedSize = CGSize(width: 10, height: 10)
    let (window, spinner) = self.makeSpinner(allocatedSize: allocatedSize)
    defer { window.isHidden = true }

    spinner.size = .size48
    window.layoutIfNeeded()

    #expect(spinner.bounds.size == allocatedSize)
    #expect(spinner.intrinsicContentSize == CGSize(width: 48, height: 48))
    try self.expectCenteredRotation(spinner)
  }

  @Test("회전 중 bounds의 크기와 원점이 바뀌어도 새 중앙을 유지한다")
  func recentersAfterBoundsChange() throws {
    let (window, spinner) = self.makeSpinner()
    defer { window.isHidden = true }
    spinner.bounds = CGRect(x: 7, y: 11, width: 20, height: 780)
    spinner.setNeedsLayout()
    spinner.layoutIfNeeded()
    try self.expectCenteredRotation(spinner)

    spinner.bounds = CGRect(x: -3, y: 5, width: 10, height: 10)
    spinner.setNeedsLayout()
    spinner.layoutIfNeeded()
    try self.expectCenteredRotation(spinner)
  }

  private func makeSpinner(
    size: BezierSpinnerSize = .size20,
    allocatedSize: CGSize? = nil
  ) -> (UIWindow, BezierSpinner) {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 800))
    let spinner = BezierSpinner(size: size)
    window.addSubview(spinner)
    NSLayoutConstraint.activate([
      spinner.centerXAnchor.constraint(equalTo: window.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: window.centerYAnchor),
    ])
    if let allocatedSize {
      NSLayoutConstraint.activate([
        spinner.widthAnchor.constraint(equalToConstant: allocatedSize.width),
        spinner.heightAnchor.constraint(equalToConstant: allocatedSize.height),
      ])
    }
    window.isHidden = false
    window.layoutIfNeeded()
    return (window, spinner)
  }

  private func expectCenteredRotation(_ spinner: BezierSpinner) throws {
    let arc = try #require(spinner.layer.sublayers?.compactMap { $0 as? CAShapeLayer }.first)
    let length = spinner.size.length
    let center = CGPoint(x: length / 2, y: length / 2)
    let expectedCenter = CGPoint(x: spinner.bounds.midX, y: spinner.bounds.midY)
    let path = try #require(arc.path)

    #expect(abs(path.boundingBoxOfPath.width - length) < 0.001)
    #expect(!path.contains(center))
    #expect(path.contains(CGPoint(x: length / 2, y: length / 16)))
    #expect(arc.animationKeys()?.isEmpty == false)

    let originalTransform = arc.transform
    defer { arc.transform = originalTransform }
    for angle in [CGFloat(0), .pi / 4, .pi / 2, .pi, .pi * 3 / 2] {
      arc.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
      spinner.setNeedsLayout()
      spinner.layoutIfNeeded()

      let actualCenter = arc.convert(center, to: spinner.layer)
      #expect(abs(actualCenter.x - expectedCenter.x) < 0.001)
      #expect(abs(actualCenter.y - expectedCenter.y) < 0.001)
      #expect(arc.bounds.size == CGSize(width: length, height: length))
    }
  }
}
