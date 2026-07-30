import SwiftUI
import UIKit

/// SwiftUI가 제안한 크기를 그대로 차지하는 UIKit 래퍼.
///
/// `UIKitWrap`은 `systemLayoutSizeFitting`으로 크기를 정하므로, Auto Layout 제약도 intrinsic
/// size도 없는 뷰는 0×0으로 렌더된다(색 스와치·도형용 빈 `UIView`가 그렇다). `.frame(...)`은
/// 제안값일 뿐 결과값이 아니라서 그것만으로는 해결되지 않는다. 크기를 바깥에서 정하는
/// 뷰라면 `UIKitWrap` 대신 이 래퍼를 쓴다.
struct UIKitSizedWrap<V: UIView>: UIViewRepresentable {
  private let make: () -> V
  private let update: (V) -> Void

  init(_ make: @escaping () -> V, update: @escaping (V) -> Void = { _ in }) {
    self.make = make
    self.update = update
  }

  func makeUIView(context: Context) -> V { self.make() }

  func updateUIView(_ uiView: V, context: Context) { self.update(uiView) }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: V, context: Context) -> CGSize? {
    CGSize(
      width: Self.resolve(proposal.width),
      height: Self.resolve(proposal.height)
    )
  }

  private static func resolve(_ length: CGFloat?) -> CGFloat {
    guard let length, length.isFinite else { return 0 }
    return length
  }
}
