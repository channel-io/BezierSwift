//
//  BezierAvatar.swift
//  BezierSwift
//

import UIKit

/// 사용자·대상을 나타내는 아바타 (UIKit). 이미지·크기·테두리·접속 상태 표식을 조합한다. SwiftUI에서는 `SUBezierAvatar`를 사용한다.
public final class BezierAvatar: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 아바타에 표시할 이미지. 없으면 빈 영역으로 렌더된다.
  public var image: UIImage? {
    didSet { self.imageView.image = self.image }
  }

  /// 아바타 크기. 기본값은 `.size24`다.
  public var size: BezierAvatarSize = .size24 {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  /// 테두리 표시 여부. 기본값은 `false`다.
  public var showBorder: Bool = false {
    didSet { if oldValue != self.showBorder { self.refreshAppearance() } }
  }

  /// 겹쳐 표시할 접속 상태 표식. `nil`이면 표식을 그리지 않는다.
  public var statusType: BezierStatusType? {
    didSet { self.refreshStatusOverlay() }
  }

  /// 활성 여부. `false`면 흐리게(opacity `0.4`) 표시된다. 기본값은 `true`다.
  public var isEnabled: Bool = true {
    didSet { self.alpha = self.isEnabled ? 1.0 : BezierAvatarConstant.disabledOpacity }
  }

  // MARK: - Subviews

  /// 이미지와 테두리를 먼저 합성하고 외곽을 한 번만 마스킹한다. Status는 이 컨테이너 밖에 둔다.
  private let contentView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let contentMask = CAShapeLayer()
  private let borderLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.fillRule = .evenOdd
    return layer
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  /// 외곽은 사각형으로 완전히 덮고 안쪽 경계만 안티앨리어싱한다.
  /// 둥근 바깥 경계는 합성된 contentView의 마스크가 담당한다.
  private let borderView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = false
    view.isHidden = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  /// size20-160용 status overlay. size16은 별도 `miniStatusView`로 처리.
  private var statusView: BezierStatus?

  /// size16 전용 6×6 mini status. Status 매트릭스 외 special case (SPEC Part 1 §4).
  private var miniStatusView: UIView?

  // MARK: - Layout Constraints

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// 이미지·크기·테두리·상태 표식을 지정해 아바타를 만든다. 모든 인자는 기본값이 있어 필요한 것만 넘기면 된다.
  public init(
    image: UIImage? = nil,
    size: BezierAvatarSize = .size24,
    showBorder: Bool = false,
    statusType: BezierStatusType? = nil
  ) {
    self.image = image
    self.size = size
    self.showBorder = showBorder
    self.statusType = statusType
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    // Status overlay가 Avatar 바깥(좌표 (12,12) + 6×6 등)으로 일부 spill하므로 wrapper는 clip하지 않는다.
    // 이미지·테두리 clipping은 contentView 내부에서 처리한다.
    self.clipsToBounds = false
    self.imageView.image = self.image

    self.addSubview(self.contentView)
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.borderView)
    self.borderView.layer.addSublayer(self.borderLayer)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.length)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.length)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
      self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
      self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      self.borderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
      self.borderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.borderView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.borderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
    ])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint

    self.refreshLayout()
    self.refreshAppearance()
    self.refreshStatusOverlay()
  }

  // MARK: - Layout Update

  public override func layoutSubviews() {
    super.layoutSubviews()
    // showBorder=false는 기존 UIImageView clipping을 그대로 사용한다.
    self.imageView.layer.cornerRadius = self.showBorder ? 0 : self.size.cornerRadius
    guard self.showBorder else {
      self.contentView.layer.mask = nil
      return
    }
    let bounds = self.bounds
    let radius = self.size.cornerRadius
    let width = self.size.borderWidth
    // 사각형 끝의 AA가 외곽 마스크와 겹치지 않도록 채움은 마스크 바깥까지 연장한다.
    let borderPath = CGMutablePath()
    borderPath.addRect(bounds.insetBy(dx: -width, dy: -width))
    borderPath.addRoundedRect(
      in: bounds.insetBy(dx: width, dy: width),
      cornerWidth: max(0, radius - width), cornerHeight: max(0, radius - width)
    )

    CATransaction.begin()
    CATransaction.setDisableActions(true)
    self.contentMask.frame = bounds
    self.contentMask.contentsScale = self.traitCollection.displayScale
    // UIBezierPath의 둥근 사각형은 작은 크기에서 반경을 확장/제한할 수 있으므로
    // Core Graphics의 원호 경로로 기존 CALayer.cornerRadius의 기하를 유지한다.
    self.contentMask.path = CGPath(roundedRect: bounds, cornerWidth: radius, cornerHeight: radius, transform: nil)
    self.borderLayer.frame = bounds
    self.borderLayer.contentsScale = self.traitCollection.displayScale
    self.borderLayer.path = borderPath
    self.contentView.layer.mask = self.contentMask
    CATransaction.commit()
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.widthConstraint?.constant = self.size.length
    self.heightConstraint?.constant = self.size.length
    // size별 border 두께가 다르므로 size 변경 시 border 갱신 필수.
    self.refreshAppearance()
    self.refreshStatusOverlay()
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func refreshAppearance() {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    if self.showBorder {
      self.borderLayer.fillColor = BCSemanticToken.surface.palette(self).cgColor
      self.borderView.isHidden = false
    } else {
      self.borderLayer.fillColor = nil
      self.borderView.isHidden = true
    }
    CATransaction.commit()
    self.setNeedsLayout()
  }

  private func refreshStatusOverlay() {
    self.statusView?.removeFromSuperview()
    self.statusView = nil
    self.miniStatusView?.removeFromSuperview()
    self.miniStatusView = nil

    guard let statusType = self.statusType else { return }

    let position = self.size.statusOverlayPosition
    let overlayLength = self.size.statusOverlayLength

    if let avatarStatusSize = self.size.matchingAvatarStatusSize {
      let status = BezierStatus(type: statusType, size: avatarStatusSize)
      self.addSubview(status)
      NSLayoutConstraint.activate([
        status.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: position.x),
        status.topAnchor.constraint(equalTo: self.topAnchor, constant: position.y),
      ])
      // imageView가 wrapper 전체를 덮으므로 status를 명시적으로 z-축 최상위로 올린다.
      status.layer.zPosition = 1
      self.statusView = status
    } else {
      let mini = UIView()
      mini.translatesAutoresizingMaskIntoConstraints = false
      mini.backgroundColor = statusType.circleToken.palette(self)
      mini.layer.cornerRadius = overlayLength / 2
      mini.layer.masksToBounds = true
      self.addSubview(mini)
      NSLayoutConstraint.activate([
        mini.widthAnchor.constraint(equalToConstant: overlayLength),
        mini.heightAnchor.constraint(equalToConstant: overlayLength),
        mini.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: position.x),
        mini.topAnchor.constraint(equalTo: self.topAnchor, constant: position.y),
      ])
      mini.layer.zPosition = 1
      self.miniStatusView = mini
    }
  }
}
