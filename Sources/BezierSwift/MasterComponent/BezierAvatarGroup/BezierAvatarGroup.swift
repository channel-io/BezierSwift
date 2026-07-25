//
//  BezierAvatarGroup.swift
//  BezierSwift
//

import UIKit

/// 여러 아바타를 겹치거나 나란히 묶어 보여주는 그룹 (UIKit). 최대 3명까지 표시하고 초과분은 아이콘·카운트로 나타낸다. SwiftUI에서는 `SUBezierAvatarGroup`을 사용한다.
public final class BezierAvatarGroup: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refresh() }
  }

  // MARK: - Public Properties

  /// 표시할 아바타 이미지 목록. 최대 3개까지 보이고 나머지는 초과 표식으로 접힌다.
  public var avatars: [UIImage?] = [] {
    didSet { self.refresh() }
  }

  /// 아바타 크기. 기본값은 `.size20`이다.
  public var size: BezierAvatarGroupSize = .size20 {
    didSet { if oldValue != self.size { self.refresh() } }
  }

  /// 초과 인원 표현 방식. 기본값은 `.icon`이다.
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

  /// 아바타 이미지 목록·크기·초과 표현·겹침 여부를 지정해 그룹을 만든다.
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
        let attributes: [NSAttributedString.Key: Any] = [
          .font: self.size.countFont.uiFont,
          .foregroundColor: BCSemanticToken.textNeutralLighter.palette(self),
        ]
        let attributedString = NSAttributedString(string: "+\(overflowCount)", attributes: attributes)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.attributedText = attributedString
        self.addSubview(label)
        self.managedSubviews.append(label)

        let labelWidth = self.size.countTextWidth(overflowCount: overflowCount)

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
