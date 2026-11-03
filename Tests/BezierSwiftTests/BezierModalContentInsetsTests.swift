import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierModal 콘텐츠 여백", .serialized)
@MainActor
struct BezierModalContentInsetsTests {
  @Test("기본 생성자는 상단 20·하단 16·좌우 16pt 여백을 유지한다")
  func defaultInsetsArePreserved() {
    let modal = BezierModal()
    withExtendedLifetime(self.layout(modal)) {
      #expect(modal.bounds.size == CGSize(width: 320, height: 37))
      #expect(modal.contentView.convert(modal.contentView.bounds, to: modal)
        == CGRect(x: 16, y: 20, width: 288, height: 1))
    }
  }

  @Test("명시적 zero 여백은 카드 전체 영역과 최소 높이 1pt를 허용한다")
  func zeroInsetsFillCard() {
    let modal = BezierModal(contentInsets: .zero)
    withExtendedLifetime(self.layout(modal)) {
      #expect(modal.bounds.size == CGSize(width: 320, height: 1))
      #expect(modal.contentView.convert(modal.contentView.bounds, to: modal) == modal.bounds)
    }
  }

  private func layout(_ modal: BezierModal) -> UIWindow {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 800))
    window.addSubview(modal)
    NSLayoutConstraint.activate([
      modal.leadingAnchor.constraint(equalTo: window.leadingAnchor),
      modal.topAnchor.constraint(equalTo: window.topAnchor),
    ])
    window.setNeedsLayout()
    window.layoutIfNeeded()
    return window
  }
}
