import Testing
import UIKit
@testable import BezierSwift

// MARK: - BezierBanner 레이아웃 테스트
//
// 검증 대상: full-width 배너에서 content(제목/본문)가 남은 가로 공간을 채워
// actionIcon(닫기/chevron)이 오른쪽 끝(trailing padding 안쪽)에 정렬되는지.
// content가 확장하지 못하면 actionIcon이 텍스트 바로 뒤(왼쪽)로 치우친다.

@Suite("BezierBanner Layout - actionIcon trailing 정렬", .serialized)
@MainActor
struct BezierBannerLayoutTests {
  @Test("actionIcon이 배너 오른쪽 끝에 정렬된다 (content 가로 확장)")
  func actionIconAlignsToTrailing() {
    let banner = BezierBanner(
      variant: .default,
      leadingIcon: .info,
      title: "Banner Title",
      description: "Banner description text goes here.",
      clickArea: .actionIcon(onClick: {})
    )
    banner.translatesAutoresizingMaskIntoConstraints = false

    let width: CGFloat = 346
    let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 120))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    container.addSubview(banner)

    NSLayoutConstraint.activate([
      banner.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      banner.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      banner.topAnchor.constraint(equalTo: container.topAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    let imageViews = Self.allImageViews(in: banner)
    #expect(imageViews.count >= 2, "leading + action 아이콘 2개가 있어야 함 (실제 \(imageViews.count))")
    guard let actionIV = imageViews.last, let leadingIV = imageViews.first else { return }

    let actionCenter = banner.convert(actionIV.center, from: actionIV.superview)
    let leadingCenter = banner.convert(leadingIV.center, from: leadingIV.superview)

    // actionIcon 기대 center x: width - horizontalPadding(8) - actionIconContainer/2(15)
    let expectedActionX = width
      - BezierBannerConstant.horizontalPadding
      - BezierBannerConstant.actionIconContainerLength / 2
    // leadingIcon 기대 center x: horizontalPadding(8) + leadingIconLeadingPadding(4) + iconLength/2(10)
    let expectedLeadingX = BezierBannerConstant.horizontalPadding
      + BezierBannerConstant.leadingIconLeadingPadding
      + BezierBannerConstant.iconLength / 2

    #expect(
      abs(actionCenter.x - expectedActionX) < 2,
      "actionIcon center x=\(actionCenter.x)pt, 기대 \(expectedActionX)pt (배너 오른쪽 끝). content 미확장 시 왼쪽으로 치우침"
    )
    #expect(
      abs(leadingCenter.x - expectedLeadingX) < 2,
      "leadingIcon center x=\(leadingCenter.x)pt, 기대 \(expectedLeadingX)pt (왼쪽 padding 안쪽)"
    )
  }

  @Test("FloatingBanner actionIcon이 배너 오른쪽 끝에 정렬된다 (content 가로 확장)")
  func floatingActionIconAlignsToTrailing() {
    let banner = BezierFloatingBanner(
      leadingIcon: .plus,
      title: "Banner Title",
      description: "Banner description text goes here.",
      clickArea: .actionIcon(onClick: {})
    )
    banner.translatesAutoresizingMaskIntoConstraints = false

    let width: CGFloat = 346
    let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 120))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    container.addSubview(banner)

    NSLayoutConstraint.activate([
      banner.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      banner.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      banner.topAnchor.constraint(equalTo: container.topAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    let imageViews = Self.allImageViews(in: banner)
    #expect(imageViews.count >= 2, "leading + action 아이콘 2개가 있어야 함 (실제 \(imageViews.count))")
    guard let actionIV = imageViews.last else { return }

    let actionCenter = banner.convert(actionIV.center, from: actionIV.superview)
    let expectedActionX = width
      - BezierFloatingBannerConstant.trailingPadding
      - BezierFloatingBannerConstant.actionIconContainerLength / 2

    #expect(
      abs(actionCenter.x - expectedActionX) < 2,
      "FloatingBanner actionIcon center x=\(actionCenter.x)pt, 기대 \(expectedActionX)pt (오른쪽 끝). content 미확장 시 왼쪽으로 치우침"
    )
  }

  private static func allImageViews(in view: UIView) -> [UIImageView] {
    var result: [UIImageView] = []
    for sub in view.subviews {
      if let iv = sub as? UIImageView { result.append(iv) }
      result += allImageViews(in: sub)
    }
    return result
  }
}
