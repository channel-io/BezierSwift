//
//  BezierFormField.swift
//  BezierSwift
//

import UIKit

/// 라벨 · 컨트롤 · 설명 · 에러 메시지를 하나의 필드 행으로 묶는 FormField (UIKit). `BezierForm` 안에서만 사용하고 단독 배치하지 않는다. 컨트롤 슬롯에는 `BezierTextInput` 등 실제 입력 컴포넌트를 넣으며, 에러 시 컨트롤 자체의 에러 표시(`BezierTextInput.hasError` 등)는 소비자가 별도로 지정한다. SwiftUI에서는 `SUBezierFormField`를 사용한다.
public final class BezierFormField: UIView, BezierComponentable {
  // MARK: - BezierComponentable

  public var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  public var componentTheme: BezierComponentTheme = .normal {
    didSet {
      self.errorMessageView.componentTheme = self.componentTheme
      self.refreshAppearance()
    }
  }

  // MARK: - Public Properties

  /// 라벨-컨트롤 배치(top/left) (기본값 `.top`). `left`는 라벨을 전제로 한 배치다.
  public var labelPosition: BezierFormFieldLabelPosition = .top {
    didSet {
      if oldValue != self.labelPosition {
        self.rebuildContentLayout()
        self.refreshLabelArea()
      }
    }
  }

  /// 라벨 텍스트. `top`에서 `nil`이면 라벨 영역(설명 포함)을 숨긴다. `left`에서는 라벨 영역이 자리를 유지한다 (기본값 `nil`).
  public var labelText: String? {
    didSet { if oldValue != self.labelText { self.refreshLabelArea() } }
  }

  /// 라벨 부제(필드 의미·입력 형식 안내). `nil`이면 숨긴다 (기본값 `nil`).
  public var fieldDescription: String? {
    didSet { if oldValue != self.fieldDescription { self.refreshLabelArea() } }
  }

  /// 필수 입력 표시. `true`면 라벨 끝에 주황색 `*` 마커를 붙인다 (기본값 `false`).
  public var isRequired: Bool = false {
    didSet { if oldValue != self.isRequired { self.refreshLabelArea() } }
  }

  /// 에러 메시지. `nil`이 아니면 필드 하단에 에러 메시지 행을 표시한다 (기본값 `nil`).
  public var errorText: String? {
    didSet { if oldValue != self.errorText { self.refreshErrorMessage() } }
  }

  /// 컨트롤 슬롯 뷰. `top`이면 전체 폭, `left`면 우측 정렬(최소 120pt · 최대 200pt)로 배치된다.
  public var control: UIView? {
    didSet { self.updateSlot(container: self.controlContainer, old: oldValue, new: self.control) }
  }

  /// 필드 직속 복합 콘텐츠 슬롯 뷰(전체 폭). `nil`이면 비운다.
  public var customContent: UIView? {
    didSet { self.updateSlot(container: self.customContentContainer, old: oldValue, new: self.customContent) }
  }

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierFormConstant.fieldContentSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let contentStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let labelAreaStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .fill
    stackView.spacing = BezierFormConstant.labelToDescriptionSpacing
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
      top: 0,
      leading: BezierFormConstant.labelAreaLeadingPadding,
      bottom: 0,
      trailing: 0
    )
    return stackView
  }()

  private let labelRowStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = BezierFormConstant.labelRowSpacing
    return stackView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let requiredMarkerLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()

  private let controlContainer = UIView()
  private let customContentContainer = UIView()
  private let errorMessageView = BezierFormFieldErrorMessage()

  private var controlLayoutConstraints: [NSLayoutConstraint] = []

  // MARK: - Init

  /// 배치·라벨·설명·필수 여부·에러 메시지·슬롯 뷰로 필드를 만든다.
  public init(
    labelPosition: BezierFormFieldLabelPosition = .top,
    labelText: String? = nil,
    description: String? = nil,
    isRequired: Bool = false,
    errorText: String? = nil,
    control: UIView? = nil,
    customContent: UIView? = nil
  ) {
    self.labelPosition = labelPosition
    self.labelText = labelText
    self.fieldDescription = description
    self.isRequired = isRequired
    self.errorText = errorText
    self.control = control
    self.customContent = customContent
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

    self.labelAreaStackView.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
    self.labelAreaStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    self.titleLabel.setContentHuggingPriority(.required, for: .horizontal)
    self.requiredMarkerLabel.setContentHuggingPriority(.required, for: .horizontal)
    self.requiredMarkerLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

    self.labelRowStackView.addArrangedSubview(self.titleLabel)
    self.labelRowStackView.addArrangedSubview(self.requiredMarkerLabel)
    self.labelAreaStackView.addArrangedSubview(self.labelRowStackView)
    self.labelAreaStackView.addArrangedSubview(self.descriptionLabel)

    self.contentStackView.addArrangedSubview(self.labelAreaStackView)
    self.contentStackView.addArrangedSubview(self.controlContainer)

    self.rootStackView.addArrangedSubview(self.contentStackView)
    self.rootStackView.addArrangedSubview(self.customContentContainer)
    self.rootStackView.addArrangedSubview(self.errorMessageView)
    self.addSubview(self.rootStackView)

    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(
        equalTo: self.bottomAnchor,
        constant: -BezierFormConstant.fieldBottomPadding
      ),
    ])

    self.updateSlot(container: self.controlContainer, old: nil, new: self.control)
    self.updateSlot(container: self.customContentContainer, old: nil, new: self.customContent)
    self.rebuildContentLayout()
    self.refreshLabelArea()
    self.refreshErrorMessage()
  }

  // MARK: - Layout

  private func rebuildContentLayout() {
    NSLayoutConstraint.deactivate(self.controlLayoutConstraints)
    self.controlLayoutConstraints = []

    switch self.labelPosition {
    case .top:
      self.contentStackView.axis = .vertical
      self.contentStackView.alignment = .fill
      self.contentStackView.spacing = BezierFormConstant.labelToControlSpacing

      if let control = self.control {
        self.controlLayoutConstraints = [
          control.leadingAnchor.constraint(equalTo: self.controlContainer.leadingAnchor),
          control.trailingAnchor.constraint(equalTo: self.controlContainer.trailingAnchor),
        ]
      }

    case .left:
      self.contentStackView.axis = .horizontal
      self.contentStackView.alignment = .top
      self.contentStackView.spacing = 0

      var constraints = [
        self.controlContainer.widthAnchor.constraint(
          greaterThanOrEqualToConstant: BezierFormConstant.inlineControlMinWidth
        ),
        self.controlContainer.widthAnchor.constraint(
          lessThanOrEqualToConstant: BezierFormConstant.inlineControlMaxWidth
        ),
      ]
      if let control = self.control {
        // controlContainer는 intrinsic size가 없어 스택이 폭을 정할 근거가 없다. 선호 폭을
        // 최소 폭으로 고정해 남는 폭을 LabelArea가 가져가게 한다. control 폭에 등호를 걸면
        // 그 등호가 control의 content hugging을 이겨 컨트롤 자체가 컨테이너 폭까지 늘어난다.
        let preferredWidthConstraint = self.controlContainer.widthAnchor.constraint(
          equalToConstant: BezierFormConstant.inlineControlMinWidth
        )
        preferredWidthConstraint.priority = .defaultHigh
        // 고유 폭이 없는 컨트롤이 0폭으로 접히지 않게 하는 최후 순위 fallback.
        // content hugging보다 낮은 우선순위라 고유 폭이 있는 컨트롤은 늘어나지 않는다.
        let fallbackFillConstraint = control.leadingAnchor.constraint(
          equalTo: self.controlContainer.leadingAnchor
        )
        fallbackFillConstraint.priority = UILayoutPriority(1)
        constraints += [
          control.leadingAnchor.constraint(greaterThanOrEqualTo: self.controlContainer.leadingAnchor),
          control.trailingAnchor.constraint(equalTo: self.controlContainer.trailingAnchor),
          preferredWidthConstraint,
          fallbackFillConstraint,
        ]
      }
      self.controlLayoutConstraints = constraints
    }

    NSLayoutConstraint.activate(self.controlLayoutConstraints)
  }

  // MARK: - Slot

  private func updateSlot(container: UIView, old: UIView?, new: UIView?) {
    old?.removeFromSuperview()
    guard let new else {
      container.isHidden = true
      if container === self.controlContainer { self.rebuildContentLayout() }
      return
    }
    new.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(new)
    NSLayoutConstraint.activate([
      new.topAnchor.constraint(equalTo: container.topAnchor),
      new.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    if container === self.controlContainer {
      self.rebuildContentLayout()
    } else {
      NSLayoutConstraint.activate([
        new.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        new.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      ])
    }
    container.isHidden = false
  }

  // MARK: - Trait

  public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    self.refreshAppearance()
  }

  // MARK: - Refresh

  private func refreshAppearance() {
    self.refreshLabelArea()
  }

  private func refreshLabelArea() {
    if let labelText = self.labelText {
      self.titleLabel.attributedText = BezierFormConstant.labelTypography.attributedString(
        self,
        text: labelText,
        semanticColorToken: BezierFormConstant.labelColor,
        alignment: .left,
        lineBreakMode: .byTruncatingTail
      )
      self.titleLabel.isHidden = false
    } else {
      self.titleLabel.attributedText = nil
      self.titleLabel.isHidden = true
    }

    // left 배치는 LabelArea가 상시 표시된다. 라벨이 비어도 컨테이너를 남겨야 남는 폭을
    // 흡수해 컨트롤이 우측에 고정된다 — 숨기면 space-between 구조가 무너진다.
    self.labelAreaStackView.isHidden = self.labelText == nil && self.labelPosition == .top

    if self.isRequired {
      self.requiredMarkerLabel.attributedText = BezierFormConstant.labelTypography.attributedString(
        self,
        text: BezierFormConstant.requiredMarkerText,
        semanticColorToken: BezierFormConstant.requiredMarkerColor,
        alignment: .left
      )
      self.requiredMarkerLabel.isHidden = false
    } else {
      self.requiredMarkerLabel.attributedText = nil
      self.requiredMarkerLabel.isHidden = true
    }

    if let fieldDescription = self.fieldDescription {
      self.descriptionLabel.attributedText = BezierFormConstant.descriptionTypography.attributedString(
        self,
        text: fieldDescription,
        semanticColorToken: BezierFormConstant.descriptionColor,
        alignment: .left
      )
      self.descriptionLabel.isHidden = false
    } else {
      self.descriptionLabel.attributedText = nil
      self.descriptionLabel.isHidden = true
    }
  }

  private func refreshErrorMessage() {
    if let errorText = self.errorText {
      self.errorMessageView.text = errorText
      self.errorMessageView.isHidden = false
    } else {
      self.errorMessageView.text = ""
      self.errorMessageView.isHidden = true
    }
  }
}
