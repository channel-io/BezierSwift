//
//  BezierConfirmModal.swift
//  BezierSwift
//

import UIKit

/// 되돌릴 수 없거나 영향이 큰 액션 실행 전 확인을 받는 모달 (UIKit). 제목·설명·버튼으로 구성되며, 표시는 `BezierModalViewController.confirm(...)`을 사용한다. SwiftUI에서는 `SUBezierConfirmModal`을 사용한다.
public final class BezierConfirmModal: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.modalView.componentTheme = self.componentTheme
      self.confirmButton.componentTheme = self.componentTheme
      self.cancelButton?.componentTheme = self.componentTheme
      self.altButton?.componentTheme = self.componentTheme
      self.refreshAppearance()
    }
  }

  // MARK: - Public Properties

  /// 모달 상단에 표시하는 제목.
  public var title: String {
    didSet { self.refreshAppearance() }
  }

  // UIView.description(NSObject)과의 충돌을 피하기 위한 명명
  /// 제목 아래 표시하는 설명 텍스트. `nil`이면 숨겨진다.
  public var descriptionText: String? {
    didSet { self.refreshAppearance() }
  }

  /// 주 액션(확인) 버튼. `type`에 따라 강조 색이 결정된다.
  public let confirmButton: BezierButton
  /// 취소 버튼. `cancelAction`을 지정하지 않으면 `nil`이다.
  public let cancelButton: BezierButton?
  /// 세로 배치에서 쓰는 세 번째 대체 액션 버튼. `.vertical(altAction:)`에 액션을 넘겼을 때만 존재한다.
  public let altButton: BezierButton?

  // MARK: - Subviews

  private let modalView = BezierModal()
  private let rootStackView = UIStackView()
  private let contentStackView = UIStackView()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let buttonStackView = UIStackView()

  // MARK: - Init

  /// 제목·설명·버튼 구성으로 확인 모달을 생성한다. `type`으로 확인 버튼의 강조를, `buttonLayout`으로 버튼 배치를 정하며, `cancelAction`이 `nil`이면 확인 단일 버튼이 된다.
  public init(
    title: String,
    description: String? = nil,
    customContent: UIView? = nil,
    type: BezierConfirmModalType = .default,
    buttonLayout: BezierConfirmModalButtonLayout = .horizontal,
    confirmAction: BezierConfirmModalAction,
    cancelAction: BezierConfirmModalAction?
  ) {
    self.title = title
    self.descriptionText = description
    self.confirmButton = BezierButton(
      size: BezierConfirmModalSpec.buttonSize,
      variant: BezierConfirmModalSpec.buttonVariant,
      semantic: type.confirmButtonSemantic
    )
    self.cancelButton = cancelAction.map { _ in
      BezierButton(
        size: BezierConfirmModalSpec.buttonSize,
        variant: BezierConfirmModalSpec.buttonVariant,
        semantic: BezierConfirmModalSpec.cancelSemantic
      )
    }

    var altAction: BezierConfirmModalAction?
    if case .vertical(let action) = buttonLayout {
      altAction = action
    }
    // 취소 없는 1버튼(acknowledge) 케이스는 altAction 조합이 무효 (Figma showCancel 유효 조합 규칙)
    if cancelAction == nil, altAction != nil {
      assertionFailure("cancelAction 없이 altAction을 사용할 수 없습니다")
      altAction = nil
    }
    self.altButton = altAction.map { _ in
      BezierButton(
        size: BezierConfirmModalSpec.buttonSize,
        variant: BezierConfirmModalSpec.buttonVariant,
        semantic: BezierConfirmModalSpec.cancelSemantic
      )
    }

    super.init(frame: .zero)
    self.setUp(
      customContent: customContent,
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      altAction: altAction,
      cancelAction: cancelAction
    )
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  private func setUp(
    customContent: UIView?,
    buttonLayout: BezierConfirmModalButtonLayout,
    confirmAction: BezierConfirmModalAction,
    altAction: BezierConfirmModalAction?,
    cancelAction: BezierConfirmModalAction?
  ) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.rootStackView.translatesAutoresizingMaskIntoConstraints = false

    self.rootStackView.axis = .vertical
    self.rootStackView.alignment = .fill
    self.rootStackView.spacing = 0

    self.contentStackView.axis = .vertical
    self.contentStackView.alignment = .fill
    self.contentStackView.spacing = BezierConfirmModalSpec.contentSpacing

    self.titleLabel.numberOfLines = 0
    self.descriptionLabel.numberOfLines = 0

    self.contentStackView.addArrangedSubview(self.titleLabel)
    self.contentStackView.addArrangedSubview(self.descriptionLabel)

    self.setUpButtons(
      buttonLayout: buttonLayout,
      confirmAction: confirmAction,
      altAction: altAction,
      cancelAction: cancelAction
    )

    self.rootStackView.addArrangedSubview(self.contentStackView)
    if let customContent {
      self.rootStackView.addArrangedSubview(customContent)
      self.rootStackView.setCustomSpacing(
        BezierConfirmModalSpec.contentBottomPadding,
        after: self.contentStackView
      )
      self.rootStackView.setCustomSpacing(
        BezierConfirmModalSpec.buttonsTopPadding,
        after: customContent
      )
    } else {
      self.rootStackView.setCustomSpacing(
        BezierConfirmModalSpec.contentBottomPadding + BezierConfirmModalSpec.buttonsTopPadding,
        after: self.contentStackView
      )
    }
    self.rootStackView.addArrangedSubview(self.buttonStackView)

    self.addSubview(self.modalView)
    self.modalView.contentView.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.modalView.topAnchor.constraint(equalTo: self.topAnchor),
      self.modalView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      self.modalView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.modalView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.topAnchor.constraint(equalTo: self.modalView.contentView.topAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.modalView.contentView.bottomAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.modalView.contentView.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.modalView.contentView.trailingAnchor),
    ])

    self.refreshAppearance()
  }

  private func setUpButtons(
    buttonLayout: BezierConfirmModalButtonLayout,
    confirmAction: BezierConfirmModalAction,
    altAction: BezierConfirmModalAction?,
    cancelAction: BezierConfirmModalAction?
  ) {
    switch buttonLayout {
    case .vertical:
      self.buttonStackView.axis = .vertical
      self.buttonStackView.spacing = BezierConfirmModalSpec.verticalButtonSpacing
      self.buttonStackView.distribution = .fill
      self.buttonStackView.addArrangedSubview(self.confirmButton)
      if let altButton = self.altButton {
        self.buttonStackView.addArrangedSubview(altButton)
      }
      if let cancelButton = self.cancelButton {
        self.buttonStackView.addArrangedSubview(cancelButton)
      }

    case .horizontal:
      self.buttonStackView.axis = .horizontal
      self.buttonStackView.spacing = BezierConfirmModalSpec.horizontalButtonSpacing
      self.buttonStackView.distribution = .fillEqually
      if let cancelButton = self.cancelButton {
        self.buttonStackView.addArrangedSubview(cancelButton)
      }
      self.buttonStackView.addArrangedSubview(self.confirmButton)
    }

    self.confirmButton.title = confirmAction.title
    self.confirmButton.addAction(UIAction { _ in confirmAction.handler() }, for: .touchUpInside)

    if let cancelAction {
      self.cancelButton?.title = cancelAction.title
      self.cancelButton?.addAction(UIAction { _ in cancelAction.handler() }, for: .touchUpInside)
    }

    if let altAction {
      self.altButton?.title = altAction.title
      self.altButton?.addAction(UIAction { _ in altAction.handler() }, for: .touchUpInside)
    }
  }

  // MARK: - Layout Update

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.titleLabel.attributedText = BezierConfirmModalSpec.titleTypography.attributedString(
      self,
      text: self.title,
      semanticColorToken: BezierConfirmModalSpec.textColorToken,
      alignment: .center
    )

    if let descriptionText = self.descriptionText {
      self.descriptionLabel.isHidden = false
      self.descriptionLabel.attributedText = BezierConfirmModalSpec.descriptionTypography.attributedString(
        self,
        text: descriptionText,
        semanticColorToken: BezierConfirmModalSpec.textColorToken,
        alignment: .center
      )
    } else {
      self.descriptionLabel.isHidden = true
      self.descriptionLabel.attributedText = nil
    }
  }
}
