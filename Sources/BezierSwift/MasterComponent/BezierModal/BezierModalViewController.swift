//
//  BezierModalViewController.swift
//  BezierSwift
//

import UIKit

// Figma에 dim/프레젠테이션 스펙이 없어 BezierModalSpec(SPEC.md 매핑)과 분리한 협의 상수
enum BezierModalPresentationConstant {
  static let dimToken: BCSemanticToken = .dimAbsoluteBlack
  static let horizontalMargin: CGFloat = 40
  static let expandedWidth: CGFloat = BezierModalSpec.maxWidth
  // BezierModal 내장 width 320(.defaultHigh) 제약을 1만큼 이겨서 카드를 최대로 확장하고,
  // required인 좌우 마진이 좁은 화면에서 이를 깎아 폭 = min(화면너비 − 80, 480)이 되게 한다
  static let widthExpansionPriority = UILayoutPriority(UILayoutPriority.defaultHigh.rawValue + 1)
}

public final class BezierModalViewController: UIViewController, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet { self.refreshAppearance() }
  }

  // MARK: - Public Properties

  public let modalView: UIView

  // MARK: - Subviews

  private let dimView = UIView()

  // MARK: - Init

  public init(modalView: UIView) {
    self.modalView = modalView
    super.init(nibName: nil, bundle: nil)
    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }

  public convenience init(contentView: UIView) {
    let modal = BezierModal()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    modal.contentView.addSubview(contentView)
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: modal.contentView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: modal.contentView.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: modal.contentView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: modal.contentView.trailingAnchor),
    ])
    self.init(modalView: modal)
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Cycles

  public override func viewDidLoad() {
    super.viewDidLoad()
    self.setUp()
  }

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Setup

  private func setUp() {
    self.view.backgroundColor = .clear

    self.dimView.translatesAutoresizingMaskIntoConstraints = false
    self.modalView.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(self.dimView)
    self.dimView.addSubview(self.modalView)

    let centerYConstraint = self.modalView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    centerYConstraint.priority = .defaultHigh

    let widthExpansionConstraint = self.modalView.widthAnchor.constraint(
      equalToConstant: BezierModalPresentationConstant.expandedWidth
    )
    widthExpansionConstraint.priority = BezierModalPresentationConstant.widthExpansionPriority

    NSLayoutConstraint.activate([
      self.dimView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.dimView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.dimView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.dimView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.modalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      centerYConstraint,
      widthExpansionConstraint,
      self.modalView.leadingAnchor.constraint(
        greaterThanOrEqualTo: self.view.leadingAnchor,
        constant: BezierModalPresentationConstant.horizontalMargin
      ),
      self.modalView.trailingAnchor.constraint(
        lessThanOrEqualTo: self.view.trailingAnchor,
        constant: -BezierModalPresentationConstant.horizontalMargin
      ),
      self.modalView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.modalView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])

    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.dimView.backgroundColor = BezierModalPresentationConstant.dimToken.palette(self)
  }
}
