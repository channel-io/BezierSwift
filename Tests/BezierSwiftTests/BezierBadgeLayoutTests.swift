import Testing
import UIKit
@testable import BezierSwift

// MARK: - BezierBadge 레이아웃 / 압축 저항 테스트 (MOB-6018)
//
// 재현 대상: 가로 UIStackView(.fill) 안에서 공간이 부족할 때, BezierBadge 가
// 자연폭보다 작게 압축(collapse)되는 버그. 근본 원인은 BezierBadge 가
// intrinsicContentSize 를 노출하지 않아 setContentCompressionResistancePriority(.required)
// 가 무효화되는 것.

@Suite("BezierBadge Layout - Compression Resistance", .serialized)
@MainActor
struct BezierBadgeLayoutTests {
  /// 좁은 .fill 스택에서, 압축 저항이 낮은 형제(UILabel, .defaultLow)가 먼저 압축되고
  /// .required 로 설정한 BezierBadge 는 자연폭을 사수해야 한다.
  @Test("좁은 .fill 스택에서 xsmall 배지가 자연폭 미만으로 압축되지 않는다")
  func badgeDoesNotCollapseInFillStack() {
    let badge = BezierBadge(size: .xsmall)
    badge.label = "bot"
    badge.setContentCompressionResistancePriority(.required, for: .horizontal)

    // 배지 단독 자연폭. 내부 contentStack leading/trailing(required equalTo) 제약으로 계산된다.
    let badgeNatural = badge.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    #expect(badgeNatural > 0)

    // 형제: 압축 저항이 낮은 긴 텍스트 라벨 → 공간 부족 시 이쪽이 먼저 줄어들어야 정상.
    let sibling = UILabel()
    sibling.text = "매우 긴 형제 라벨 텍스트입니다 정말로 깁니다"
    sibling.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    let siblingNatural = sibling.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width

    let stack = UIStackView(arrangedSubviews: [badge, sibling])
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.alignment = .center
    stack.spacing = 0
    stack.translatesAutoresizingMaskIntoConstraints = false

    // 두 자연폭 합보다 40pt 부족한 컨테이너 폭. 형제(.defaultLow)가 흡수할 만큼만 부족하게 만든다.
    let deficit: CGFloat = 40
    let containerWidth = badgeNatural + siblingNatural - deficit

    // 실제 렌더 계층(window)에 붙여 detached 레이아웃 아티팩트를 배제한다.
    let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 40))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    container.addSubview(stack)

    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    #expect(
      badge.frame.width >= badgeNatural - 0.5,
      "배지 폭 \(badge.frame.width)pt 가 자연폭 \(badgeNatural)pt 미만으로 압축됨 (형제 폭 \(sibling.frame.width)pt / 형제 자연폭 \(siblingNatural)pt, 컨테이너 \(containerWidth)pt)"
    )
  }

  /// intrinsicContentSize 가 실제 콘텐츠 폭(패딩 + 라벨)을 노출해야 한다.
  /// systemLayoutSizeFitting 으로 얻는 자연폭과 일치해야 표준 UIKit 압축 메커니즘에 편입된다.
  @Test("BezierBadge 는 콘텐츠 기반 intrinsicContentSize 를 노출한다")
  func badgeExposesIntrinsicContentSize() {
    let badge = BezierBadge(size: .xsmall)
    badge.label = "bot"

    let fitting = badge.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let intrinsic = badge.intrinsicContentSize

    #expect(intrinsic.width > 0)
    #expect(abs(intrinsic.width - fitting.width) < 0.5)
    #expect(abs(intrinsic.height - BezierBadgeSize.xsmall.height) < 0.5)
  }

  /// label 변경 시 intrinsicContentSize 가 갱신되어야 한다(invalidate 경로 검증).
  @Test("label 변경이 intrinsicContentSize 에 반영된다")
  func intrinsicUpdatesOnLabelChange() {
    let badge = BezierBadge(size: .xsmall)
    badge.label = "a"
    let shortWidth = badge.intrinsicContentSize.width

    badge.label = "aaaaaaaaaaaaaaaaaaaa"
    let longWidth = badge.intrinsicContentSize.width

    #expect(longWidth > shortWidth)
  }

  /// 실제 메시지 셀 구조([이름 · 배지 3개 · 타임스탬프])에서, 폭이 배지 자연폭 합 수준으로
  /// 좁아져도 배지들은 각자 자연폭을 유지하고 이름 라벨만 압축을 흡수해야 한다.
  @Test("여러 배지 복합 행에서 모든 배지가 자연폭을 유지하고 이름만 줄어든다")
  func multipleBadgesSurviveCompression() {
    func makeBadge(_ text: String, _ variant: BezierBadgeVariant) -> BezierBadge {
      let badge = BezierBadge(size: .xsmall, variant: variant)
      badge.label = text
      badge.setContentCompressionResistancePriority(.required, for: .horizontal)
      return badge
    }
    let badges = [makeBadge("bot", .blue), makeBadge("lead", .green), makeBadge("차단", .red)]
    let naturals = badges.map { $0.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width }

    let nameLabel = UILabel()
    nameLabel.text = "김채널 프로덕트 디자이너"
    nameLabel.font = .systemFont(ofSize: 13, weight: .medium)
    nameLabel.lineBreakMode = .byTruncatingTail
    nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    let nameNatural = nameLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width

    let stack = UIStackView(arrangedSubviews: [nameLabel] + badges)
    stack.axis = .horizontal
    stack.spacing = 4
    stack.distribution = .fill
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false

    // 배지 자연폭 합 + 여유 60pt. 이름 자연폭(~150)보다 훨씬 좁아 이름이 압축을 흡수한다.
    let containerWidth = naturals.reduce(0, +) + 60
    let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 40))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    container.addSubview(stack)

    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    for (badge, natural) in zip(badges, naturals) {
      #expect(
        badge.frame.width >= natural - 0.5,
        "배지 '\(badge.label ?? "")' 폭 \(badge.frame.width)pt 가 자연폭 \(natural)pt 미만으로 압축됨"
      )
    }
    #expect(
      nameLabel.frame.width < nameNatural,
      "이름 라벨이 압축을 흡수하지 않음 (폭 \(nameLabel.frame.width)pt / 자연폭 \(nameNatural)pt)"
    )
  }

  /// 접근 A(라이브러리 무변경): 호출부에서 compressionResistance 를 낮추면, 표준 UIKit 메커니즘에 따라
  /// 배지가 자연폭 미만으로 축소되고 내부 라벨이 tail truncation 조건(표시폭 < 콘텐츠폭)에 들어간다.
  /// 즉 별도 API 없이 UIKit 표준만으로 "어느 정도 축소 허용 + 말줄임"이 가능하다.
  @Test("compressionResistance를 낮추면 배지가 축소되고 라벨이 truncate 조건에 들어간다")
  func loweringResistanceAllowsTruncation() {
    let badge = BezierBadge(size: .xsmall)
    badge.label = "botbotbot"
    badge.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    let natural = badge.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width

    let targetWidth = (natural * 0.6).rounded()
    let container = UIView(frame: CGRect(x: 0, y: 0, width: targetWidth, height: 40))
    let window = UIWindow(frame: container.bounds)
    window.addSubview(container)
    badge.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(badge)

    NSLayoutConstraint.activate([
      badge.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      badge.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      badge.centerYAnchor.constraint(equalTo: container.centerYAnchor),
    ])

    window.setNeedsLayout()
    window.layoutIfNeeded()

    // 우선순위가 낮으면 배지가 컨테이너 폭(자연폭 미만)으로 축소된다.
    #expect(badge.frame.width < natural)
    #expect(abs(badge.frame.width - targetWidth) < 1.0)

    // 내부 라벨이 자연폭보다 좁은 영역에 배치되어 tail truncation 이 성립한다.
    let titleLabel = Self.firstLabel(in: badge)
    #expect(titleLabel != nil)
    if let titleLabel {
      #expect(titleLabel.numberOfLines == 1)
      #expect(titleLabel.bounds.width < titleLabel.intrinsicContentSize.width)
    }
  }

  private static func firstLabel(in view: UIView) -> UILabel? {
    for subview in view.subviews {
      if let label = subview as? UILabel { return label }
      if let found = firstLabel(in: subview) { return found }
    }
    return nil
  }
}
