import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierTag Layout - Text Truncation", .serialized)
@MainActor
struct BezierTagLayoutTests {
  @Test("고정 폭에서 긴 라벨은 trailing ellipsis를 사용하고 close 버튼은 보존한다")
  func fixedWidthUsesTrailingEllipsisAndPreservesCloseButton() {
    let tag = BezierTag(size: .xsmall)
    tag.label = "아주 긴 태그 라벨 텍스트"
    tag.onDelete = {}

    let naturalWidth = tag.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    let targetWidth = (naturalWidth * 0.6).rounded()
    let container = UIView(frame: CGRect(x: 0, y: 0, width: targetWidth, height: 40))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    container.addSubview(tag)

    NSLayoutConstraint.activate([
      tag.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      tag.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      tag.centerYAnchor.constraint(equalTo: container.centerYAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    let titleLabel = Self.firstLabel(in: tag)
    #expect(titleLabel != nil)
    if let titleLabel {
      #expect(titleLabel.numberOfLines == 1)
      #expect(titleLabel.lineBreakMode == .byTruncatingTail)
      #expect(titleLabel.bounds.width < titleLabel.intrinsicContentSize.width)

      let paragraphStyle = titleLabel.attributedText?.attribute(
        .paragraphStyle,
        at: 0,
        effectiveRange: nil
      ) as? NSParagraphStyle
      #expect(paragraphStyle?.lineBreakMode == .byTruncatingTail)
    }

    let closeButton = Self.firstButton(in: tag)
    #expect(closeButton != nil)
    #expect(abs((closeButton?.bounds.width ?? 0) - BezierTagSize.xsmall.closeIconLength) < 0.5)
  }

  private static func firstLabel(in view: UIView) -> UILabel? {
    for subview in view.subviews {
      if let label = subview as? UILabel { return label }
      if let found = firstLabel(in: subview) { return found }
    }
    return nil
  }

  private static func firstButton(in view: UIView) -> UIButton? {
    for subview in view.subviews {
      if let button = subview as? UIButton { return button }
      if let found = firstButton(in: subview) { return found }
    }
    return nil
  }
}
