import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierOverlay 상수")
struct BezierOverlayConstantTests {
  @Test("Figma 실측 수치와 일치한다")
  func constantsMatchFigma() {
    #expect(BezierOverlayConstant.width == 240)
    #expect(BezierOverlayConstant.padding == 10)
    #expect(BezierOverlayConstant.cornerRadius == 32)
    #expect(BezierOverlayConstant.elevation == .mEv3)
    #expect(BezierOverlayConstant.backgroundColor == .surfaceHighest)
  }
}

@Suite("BezierOverlay 레이아웃", .serialized)
@MainActor
struct BezierOverlayLayoutTests {
  @Test("고정 폭 240 안에서 content가 패딩 10을 두고 배치된다")
  func contentIsInsetByPadding() {
    let content = UIView()
    content.translatesAutoresizingMaskIntoConstraints = false
    content.heightAnchor.constraint(equalToConstant: 100).isActive = true
    let overlay = BezierOverlay(content: content)

    Self.layout(overlay)

    #expect(overlay.frame.width == 240)
    #expect(overlay.frame.height == 120)
    #expect(content.frame == CGRect(x: 10, y: 10, width: 220, height: 100))
  }

  @Test("content가 nil이면 패딩만큼의 빈 카드가 된다")
  func emptyContentKeepsPaddingHeight() {
    let overlay = BezierOverlay()

    Self.layout(overlay)

    #expect(overlay.frame.width == 240)
    #expect(overlay.frame.height == 20)
  }

  @Test("content 교체 시 이전 뷰가 제거된다")
  func replacingContentRemovesOldView() {
    let first = UIView()
    let overlay = BezierOverlay(content: first)

    let second = UIView()
    overlay.content = second

    #expect(first.superview == nil)
    #expect(second.superview === overlay)

    overlay.content = nil
    #expect(second.superview == nil)
  }

  @Test("라운드 32에 그림자 렌더를 위한 masksToBounds가 꺼져 있다")
  func layerConfiguration() {
    let overlay = BezierOverlay()

    #expect(overlay.layer.cornerRadius == 32)
    #expect(overlay.layer.masksToBounds == false)
  }

  // MARK: - Helpers

  private static func layout(_ overlay: BezierOverlay) {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    window.isHidden = false
    let host = UIView(frame: window.bounds)
    window.addSubview(host)
    host.addSubview(overlay)
    NSLayoutConstraint.activate([
      overlay.topAnchor.constraint(equalTo: host.topAnchor),
      overlay.leadingAnchor.constraint(equalTo: host.leadingAnchor),
    ])
    host.layoutIfNeeded()
  }
}
