//
//  BezierAvatarGroup.swift
//  BezierSwift
//

import UIKit

public final class BezierAvatarGroup: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refresh() }
  }

  // MARK: - Public Properties

  public var avatars: [UIImage?] = [] {
    didSet { self.refresh() }
  }

  public var size: BezierAvatarGroupSize = .size20 {
    didSet { if oldValue != self.size { self.refresh() } }
  }

  public var ellipsisType: BezierAvatarGroupEllipsisType = .icon {
    didSet { if oldValue != self.ellipsisType { self.refresh() } }
  }

  /// SPEC §4: true 면 avatar 가 겹치고(showBorder=true), false 면 나란히 배치(showBorder=false).
  public var overlap: Bool = true {
    didSet { if oldValue != self.overlap { self.refresh() } }
  }

  // MARK: - Private State

  private var managedSubviews: [UIView] = []

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  // MARK: - Init

  public init(
    avatars: [UIImage?] = [],
    size: BezierAvatarGroupSize = .size20,
    ellipsisType: BezierAvatarGroupEllipsisType = .icon,
    overlap: Bool = true
  ) {
    self.avatars = avatars
    self.size = size
    self.ellipsisType = ellipsisType
    self.overlap = overlap
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
    self.clipsToBounds = false

    let width = self.widthAnchor.constraint(equalToConstant: 0)
    let height = self.heightAnchor.constraint(equalToConstant: 0)
    NSLayoutConstraint.activate([width, height])
    self.widthConstraint = width
    self.heightConstraint = height

    self.refresh()
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refresh()
  }

  // MARK: - Refresh

  private func refresh() {
    for view in self.managedSubviews { view.removeFromSuperview() }
    self.managedSubviews.removeAll()

    let maxVisible = BezierAvatarGroupConstant.maxVisibleAvatars
    let visibleCount = min(self.avatars.count, maxVisible)
    let hasOverflow = self.avatars.count > maxVisible
    let stride = self.size.stride(overlap: self.overlap)
    let avatarLength = self.size.avatarLength

    var totalWidth: CGFloat = 0

    for index in 0..<visibleCount {
      let avatar = BezierAvatar(image: self.avatars[index], size: self.size.avatarSize, showBorder: self.overlap)
      self.addSubview(avatar)
      NSLayoutConstraint.activate([
        avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(index) * stride),
        avatar.topAnchor.constraint(equalTo: self.topAnchor),
      ])
      self.managedSubviews.append(avatar)
    }

    if hasOverflow {
      switch self.ellipsisType {
      case .icon:
        let ellipsisLeft = CGFloat(maxVisible) * stride
        let ellipsisAvatar = BezierAvatar(
          image: self.avatars[maxVisible],
          size: self.size.avatarSize,
          showBorder: false
        )
        self.addSubview(ellipsisAvatar)
        NSLayoutConstraint.activate([
          ellipsisAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ellipsisLeft),
          ellipsisAvatar.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        self.managedSubviews.append(ellipsisAvatar)

        let overlay = UIView()
        overlay.backgroundColor = BCSemanticToken.dimAbsoluteBlack.palette(self)
        overlay.layer.cornerRadius = self.size.avatarSize.cornerRadius
        overlay.layer.masksToBounds = true
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.isUserInteractionEnabled = false
        self.addSubview(overlay)
        NSLayoutConstraint.activate([
          overlay.leadingAnchor.constraint(equalTo: ellipsisAvatar.leadingAnchor),
          overlay.topAnchor.constraint(equalTo: ellipsisAvatar.topAnchor),
          overlay.widthAnchor.constraint(equalToConstant: avatarLength),
          overlay.heightAnchor.constraint(equalToConstant: avatarLength),
        ])
        self.managedSubviews.append(overlay)

        let icon = UIImageView()
        icon.image = BezierIcon.more.uiImage?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(icon)
        NSLayoutConstraint.activate([
          icon.leadingAnchor.constraint(equalTo: overlay.leadingAnchor, constant: self.size.moreIconInset),
          icon.topAnchor.constraint(equalTo: overlay.topAnchor, constant: self.size.moreIconInset),
          icon.widthAnchor.constraint(equalToConstant: self.size.moreIconLength),
          icon.heightAnchor.constraint(equalToConstant: self.size.moreIconLength),
        ])

        if self.overlap {
          let borderView = UIView()
          borderView.translatesAutoresizingMaskIntoConstraints = false
          borderView.isUserInteractionEnabled = false
          borderView.layer.borderColor = BCSemanticToken.surface.palette(self).cgColor
          borderView.layer.borderWidth = self.size.borderWidth
          borderView.layer.cornerRadius = self.size.avatarSize.cornerRadius
          self.addSubview(borderView)
          NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: ellipsisAvatar.leadingAnchor),
            borderView.topAnchor.constraint(equalTo: ellipsisAvatar.topAnchor),
            borderView.widthAnchor.constraint(equalToConstant: avatarLength),
            borderView.heightAnchor.constraint(equalToConstant: avatarLength),
          ])
          self.managedSubviews.append(borderView)
        }

        totalWidth = ellipsisLeft + avatarLength

      case .count:
        let overflowCount = self.avatars.count - maxVisible
        let countFont = self.size.countFont
        let attributedString = "+\(overflowCount)".applyBezierFont(
          height: countFont.lineHeight,
          font: countFont.uiFont,
          color: BCSemanticToken.textNeutralLighter.palette(self),
          letterSpacing: 0,
          alignment: .center
        )

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.attributedText = attributedString
        self.addSubview(label)
        self.managedSubviews.append(label)

        let labelWidth = ceil(attributedString.size().width)

        let lastAvatarRight = CGFloat(visibleCount - 1) * stride + avatarLength
        let labelLeft = lastAvatarRight + self.size.countTextSpacing(overlap: self.overlap)

        NSLayoutConstraint.activate([
          label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: labelLeft),
          label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          label.widthAnchor.constraint(equalToConstant: labelWidth),
          label.heightAnchor.constraint(equalToConstant: avatarLength),
        ])

        totalWidth = labelLeft + labelWidth
      }
    } else if visibleCount > 0 {
      totalWidth = CGFloat(visibleCount - 1) * stride + avatarLength
    }

    self.widthConstraint?.constant = totalWidth
    self.heightConstraint?.constant = avatarLength

    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }
}
