//
//  BezierSwitch.swift
//  BezierSwift
//

import UIKit

/// ON/OFF 설정 토글 컴포넌트 (UIKit). 라벨 없이 `50×28pt` 단일 크기로 제공되며, 라벨과 배치는 컨테이너(행)가 소유한다. 값이 바뀌면 `.valueChanged` 이벤트를 보낸다. SwiftUI에서는 `SUBezierSwitch`를 사용한다.
public final class BezierSwitch: UIControl, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  /// 스위치 ON 여부. 직접 설정하면 애니메이션 없이 즉시 반영된다. 애니메이션이 필요하면 `setOn(_:animated:)`를 사용한다. 기본값은 `false`.
  public var isOn: Bool = false {
    didSet {
      guard oldValue != self.isOn else { return }
      self.refreshToggle(animated: self.isAnimatedChangeInProgress)
    }
  }

  /// 오류 상태 표시 여부. Figma `hasError` 프로퍼티에 대응하며, `true`면 트랙 외곽에 warning ring이 나타난다. 기본값은 `false`.
  public var hasError: Bool = false {
    didSet {
      guard oldValue != self.hasError else { return }
      self.errorRingView.isHidden = !self.hasError
    }
  }

  public override var isEnabled: Bool {
    didSet {
      guard oldValue != self.isEnabled else { return }
      self.alpha = self.isEnabled ? 1 : BezierSwitchConstant.disabledOpacity
    }
  }

  // MARK: - Private Properties

  private var isAnimatedChangeInProgress = false

  // MARK: - Subviews

  private let thumbView = UIView()
  private let errorRingView = UIView()
  private var thumbLeadingConstraint: NSLayoutConstraint?

  // MARK: - Init

  /// ON 여부와 오류 표시 여부를 지정해 스위치를 만든다. 탭하면 값이 토글되고 `.valueChanged` 이벤트가 발송된다.
  public init(isOn: Bool = false, hasError: Bool = false) {
    self.isOn = isOn
    self.hasError = hasError
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Public Methods

  /// ON 여부를 변경한다. `animated`가 `true`면 thumb 슬라이드·트랙 색 전환이 애니메이션되며, Reduce Motion 설정 시에는 즉시 전환된다.
  public func setOn(_ isOn: Bool, animated: Bool) {
    guard self.isOn != isOn else { return }
    self.isAnimatedChangeInProgress = animated
    self.isOn = isOn
    self.isAnimatedChangeInProgress = false
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.layer.cornerRadius = BezierSwitchConstant.trackCornerRadius

    self.thumbView.isUserInteractionEnabled = false
    self.thumbView.translatesAutoresizingMaskIntoConstraints = false
    self.thumbView.layer.cornerRadius = BezierSwitchConstant.thumbLength / 2
    self.thumbView.layer.shadowColor = UIColor.black.cgColor
    self.thumbView.layer.shadowOpacity = BezierSwitchConstant.thumbShadowOpacity
    self.thumbView.layer.shadowOffset = BezierSwitchConstant.thumbShadowOffset
    self.thumbView.layer.shadowRadius = BezierSwitchConstant.thumbShadowRadius

    self.errorRingView.isUserInteractionEnabled = false
    self.errorRingView.translatesAutoresizingMaskIntoConstraints = false
    self.errorRingView.isHidden = !self.hasError
    self.errorRingView.layer.cornerRadius = BezierSwitchConstant.errorRingCornerRadius
    self.errorRingView.layer.borderWidth = BezierSwitchConstant.errorRingWidth

    self.addSubview(self.errorRingView)
    self.addSubview(self.thumbView)

    let thumbLeading = self.thumbView.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: self.thumbLeadingOffset
    )
    self.thumbLeadingConstraint = thumbLeading

    let ringSpacing = BezierSwitchConstant.errorRingSpacing
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: BezierSwitchConstant.trackWidth),
      self.heightAnchor.constraint(equalToConstant: BezierSwitchConstant.trackHeight),
      thumbLeading,
      self.thumbView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.thumbView.widthAnchor.constraint(equalToConstant: BezierSwitchConstant.thumbLength),
      self.thumbView.heightAnchor.constraint(equalToConstant: BezierSwitchConstant.thumbLength),
      self.errorRingView.topAnchor.constraint(equalTo: self.topAnchor, constant: -ringSpacing),
      self.errorRingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -ringSpacing),
      self.errorRingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ringSpacing),
      self.errorRingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ringSpacing),
    ])

    self.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)

    self.refreshAppearance()
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private var thumbLeadingOffset: CGFloat {
    self.isOn
      ? BezierSwitchConstant.trackWidth
        - BezierSwitchConstant.thumbInset
        - BezierSwitchConstant.thumbLength
      : BezierSwitchConstant.thumbInset
  }

  private func refreshToggle(animated: Bool) {
    self.thumbLeadingConstraint?.constant = self.thumbLeadingOffset

    guard animated, !UIAccessibility.isReduceMotionEnabled else {
      self.refreshAppearance()
      return
    }

    UIView.animate(
      withDuration: BezierSwitchConstant.toggleAnimationDuration,
      delay: 0,
      options: [.curveEaseInOut, .beginFromCurrentState]
    ) {
      self.refreshAppearance()
      self.layoutIfNeeded()
    }
  }

  private func refreshAppearance() {
    self.backgroundColor = (
      self.isOn
        ? BezierSwitchConstant.trackOnColor
        : BezierSwitchConstant.trackOffColor
    ).palette(self)
    self.thumbView.backgroundColor = BezierSwitchConstant.thumbColor.palette(self)
    self.errorRingView.layer.borderColor = BezierSwitchConstant.errorRingColor.palette(self).cgColor
  }

  // MARK: - Touch

  @objc private func didTap() {
    self.setOn(!self.isOn, animated: true)
    self.sendActions(for: .valueChanged)
  }
}
