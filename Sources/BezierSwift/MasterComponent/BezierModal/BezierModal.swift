//
//  BezierModal.swift
//  BezierSwift
//

import UIKit

/// 현재 맥락을 유지한 채 집중 작업(설정·폼·정보 확인)을 담는 모달 카드 (UIKit). 단순 확인 흐름은 `BezierConfirmModal`을 쓴다. Figma의 `size`(420/540 등 너비 프리셋)는 Figma 전용이라 코드에는 prop이 없고, 컨테이너에서 너비를 직접 지정한다. SwiftUI에서는 `SUBezierModal`을 사용한다.
public final class BezierModal: UIView, BezierComponentable {
  // 프레젠테이션 확장 제약(BezierModalPresentationConstant)이 이 값을 기준으로 +1 우선순위를 계산한다
  static let widthConstraintPriority: UILayoutPriority = .defaultHigh

  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 모달 카드 안쪽에 콘텐츠를 담는 컨테이너. 이 뷰에 서브뷰를 추가해 모달 본문을 구성한다.
  public let contentView = UIView()

  // MARK: - Subviews

  private let containerView = UIView()

  // MARK: - Init

  /// 기본 여백(상단 20·하단 16·좌우 16pt)을 유지한 빈 모달 카드를 생성한다. 본문은 `contentView`에 직접 구성한다.
  public init() {
    super.init(frame: .zero)
    self.setUp()
  }

  /// 콘텐츠 여백을 명시적으로 지정하는 코드 전용 생성자. 일반 콘텐츠는 기본 `init()`을 사용한다.
  ///
  /// 웹 콘텐츠처럼 자체 padding을 관리하며 카드 전체 영역을 사용해야 할 때만
  /// `BezierModal(contentInsets: .zero)`로 생성한다. 최소 콘텐츠 높이 1pt와 카드의 모서리 클리핑·그림자는 유지된다.
  /// 구성한 카드는 `BezierModalViewController(modalView:)`로 표시할 수 있다.
  public init(contentInsets: UIEdgeInsets) {
    super.init(frame: .zero)
    self.setUp(contentInsets: contentInsets)
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp(contentInsets: UIEdgeInsets = UIEdgeInsets(
    top: BezierModalSpec.topPadding,
    left: BezierModalSpec.horizontalPadding,
    bottom: BezierModalSpec.bottomPadding,
    right: BezierModalSpec.horizontalPadding
  )) {
    self.translatesAutoresizingMaskIntoConstraints = false

    // 그림자는 클리핑되지 않는 바깥 layer에, 콘텐츠 클리핑은 containerView에 분리 적용
    self.layer.masksToBounds = false
    self.layer.shadowOpacity = 1

    self.containerView.translatesAutoresizingMaskIntoConstraints = false
    self.containerView.layer.cornerRadius = BezierModalSpec.cornerRadius.rawValue
    self.containerView.layer.cornerCurve = .continuous
    self.containerView.layer.masksToBounds = true

    self.contentView.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(self.containerView)
    self.containerView.addSubview(self.contentView)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: BezierModalSpec.width)
    widthConstraint.priority = Self.widthConstraintPriority

    NSLayoutConstraint.activate([
      widthConstraint,
      self.widthAnchor.constraint(lessThanOrEqualToConstant: BezierModalSpec.maxWidth),
      self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
      self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.contentView.topAnchor.constraint(
        equalTo: self.containerView.topAnchor,
        constant: contentInsets.top
      ),
      self.contentView.bottomAnchor.constraint(
        equalTo: self.containerView.bottomAnchor,
        constant: -contentInsets.bottom
      ),
      self.contentView.leftAnchor.constraint(
        equalTo: self.containerView.leftAnchor,
        constant: contentInsets.left
      ),
      self.contentView.rightAnchor.constraint(
        equalTo: self.containerView.rightAnchor,
        constant: -contentInsets.right
      ),
      self.contentView.heightAnchor.constraint(
        greaterThanOrEqualToConstant: BezierModalSpec.contentMinHeight
      ),
    ])

    self.refreshAppearance()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.shadowPath = UIBezierPath(
      roundedRect: self.bounds,
      cornerRadius: BezierModalSpec.cornerRadius.rawValue
    ).cgPath
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.containerView.backgroundColor = BezierModalSpec.backgroundToken.palette(self)

    let elevation = BezierModalSpec.elevation.rawValue
    self.layer.shadowColor = elevation.semanticColor.palette(self).cgColor
    self.layer.shadowOffset = CGSize(width: elevation.x, height: elevation.y)
    self.layer.shadowRadius = elevation.blur
  }
}
