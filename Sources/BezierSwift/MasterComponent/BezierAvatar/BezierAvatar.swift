//
//  BezierAvatar.swift
//  BezierSwift
//

import UIKit

public final class BezierAvatar: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public var image: UIImage? {
    didSet { self.imageView.image = self.image }
  }

  public var size: BezierAvatarSize = .size24 {
    didSet { if oldValue != self.size { self.refreshLayout() } }
  }

  public var showBorder: Bool = false {
    didSet { if oldValue != self.showBorder { self.refreshAppearance() } }
  }

  public var statusType: BezierAvatarStatusType? {
    didSet { self.refreshStatusOverlay() }
  }

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
  private var statusView: BezierAvatarStatus?

  /// size16 전용 6×6 mini status. AvatarStatus 매트릭스 외 special case (SPEC Part 1 §4).
  private var miniStatusView: UIView?

  // MARK: - Layout Constraints

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    image: UIImage? = nil,
    size: BezierAvatarSize = .size24,
    showBorder: Bool = false,
    statusType: BezierAvatarStatusType? = nil
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
      let status = BezierAvatarStatus(type: statusType, size: avatarStatusSize)
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
      mini.backgroundColor = statusType.indicatorToken.palette(self)
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
