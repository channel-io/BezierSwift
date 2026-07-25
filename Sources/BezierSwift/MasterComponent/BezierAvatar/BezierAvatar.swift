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

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  /// CALayer 렌더링 순서상 `layer.border`는 sublayers보다 항상 위에 그려지므로,
  /// status overlay가 border에 의해 가려지지 않도록 별도 subview로 border를 분리한다.
  /// z-order: imageView(bottom) → borderView(middle) → statusView(top).
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
    // 이미지의 corner radius clipping은 imageView 자체의 masksToBounds가 담당.
    self.clipsToBounds = false
    self.imageView.image = self.image

    self.addSubview(self.imageView)
    self.addSubview(self.borderView)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.length)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.length)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
      self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.borderView.topAnchor.constraint(equalTo: self.topAnchor),
      self.borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
    self.imageView.layer.cornerRadius = self.size.cornerRadius
    self.borderView.layer.cornerRadius = self.size.cornerRadius
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
    if self.showBorder {
      self.borderView.layer.borderWidth = self.size.borderWidth
      self.borderView.layer.borderColor = BCSemanticToken.surface.palette(self).cgColor
      self.borderView.isHidden = false
    } else {
      self.borderView.layer.borderWidth = 0
      self.borderView.layer.borderColor = nil
      self.borderView.isHidden = true
    }
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
