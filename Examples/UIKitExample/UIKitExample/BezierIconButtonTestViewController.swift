//
//  BezierIconButtonTestViewController.swift
//  UIKitExample
//

import UIKit
import BezierSwift

final class BezierIconButtonTestViewController: BaseViewController {
  // MARK: - Icon Options

  private enum IconOption: Int, CaseIterable {
    case xmark
    case plus
    case trash
    case ellipsis
    case arrowRight

    var systemName: String {
      switch self {
      case .xmark:      return "xmark"
      case .plus:       return "plus"
      case .trash:      return "trash"
      case .ellipsis:   return "ellipsis"
      case .arrowRight: return "arrow.right"
      }
    }

    var label: String { self.systemName }
  }

  // MARK: - State

  private var size: BezierIconButtonSize = .medium
  private var variant: BezierIconButtonVariant = .ghost
  private var iconOption: IconOption = .xmark
  private var isLoadingState: Bool = false
  private var isEnabledState: Bool = true
  private var isActiveState: Bool = false
  private var tapCount: Int = 0

  // MARK: - Subviews

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.alignment = .fill
    stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private let previewContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .secondarySystemBackground
    view.layer.cornerRadius = 12
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var previewButton: BezierIconButton = {
    let button = BezierIconButton(
      size: self.size,
      variant: self.variant
    )
    button.icon = UIImage(systemName: self.iconOption.systemName)
    button.addTarget(self, action: #selector(self.onPreviewTapped), for: .touchUpInside)
    return button
  }()

  private let tapCountLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .caption1)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var sizeControl: UISegmentedControl = {
    let control = UISegmentedControl(items: BezierIconButtonSize.allCases.map { $0.rawValue })
    control.selectedSegmentIndex = BezierIconButtonSize.allCases.firstIndex(of: self.size) ?? 0
    control.addTarget(self, action: #selector(self.onSizeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var variantControl: UISegmentedControl = {
    let control = UISegmentedControl(items: BezierIconButtonVariant.allCases.map { $0.rawValue })
    control.selectedSegmentIndex = BezierIconButtonVariant.allCases.firstIndex(of: self.variant) ?? 0
    control.addTarget(self, action: #selector(self.onVariantChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var iconControl: UISegmentedControl = {
    let control = UISegmentedControl(items: IconOption.allCases.map { $0.label })
    control.selectedSegmentIndex = self.iconOption.rawValue
    control.addTarget(self, action: #selector(self.onIconChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var enabledSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.isEnabledState
    toggle.addTarget(self, action: #selector(self.onEnabledToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var loadingSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.isLoadingState
    toggle.addTarget(self, action: #selector(self.onLoadingToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var activeSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.isActiveState
    toggle.addTarget(self, action: #selector(self.onActiveToggled(_:)), for: .valueChanged)
    return toggle
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "IconButton (UIKit)"
    self.view.backgroundColor = .systemBackground
    self.setUpLayout()
    self.refreshPreview()
    self.refreshTapCount()
  }

  // MARK: - Layout

  private func setUpLayout() {
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.containerStackView)

    NSLayoutConstraint.activate([
      self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

      self.containerStackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
      self.containerStackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
      self.containerStackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
      self.containerStackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
      self.containerStackView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
    ])

    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Preview"))
    self.containerStackView.addArrangedSubview(self.makePreviewSection())
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Size"))
    self.containerStackView.addArrangedSubview(self.sizeControl)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Variant"))
    self.containerStackView.addArrangedSubview(self.variantControl)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Icon"))
    self.containerStackView.addArrangedSubview(self.iconControl)
    self.containerStackView.addArrangedSubview(self.makeRow(label: "Active", control: self.activeSwitch))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "Enabled", control: self.enabledSwitch))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "Loading", control: self.loadingSwitch))
  }

  private func makePreviewSection() -> UIView {
    let containerStackView = UIStackView()
    containerStackView.axis = .vertical
    containerStackView.spacing = 8
    containerStackView.alignment = .center
    containerStackView.isLayoutMarginsRelativeArrangement = true
    containerStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    containerStackView.translatesAutoresizingMaskIntoConstraints = false

    self.previewContainer.addSubview(containerStackView)
    NSLayoutConstraint.activate([
      containerStackView.topAnchor.constraint(equalTo: self.previewContainer.topAnchor),
      containerStackView.leadingAnchor.constraint(equalTo: self.previewContainer.leadingAnchor),
      containerStackView.trailingAnchor.constraint(equalTo: self.previewContainer.trailingAnchor),
      containerStackView.bottomAnchor.constraint(equalTo: self.previewContainer.bottomAnchor),
    ])

    let buttonRow = UIView()
    buttonRow.translatesAutoresizingMaskIntoConstraints = false
    buttonRow.addSubview(self.previewButton)
    NSLayoutConstraint.activate([
      buttonRow.leadingAnchor.constraint(equalTo: self.previewButton.leadingAnchor),
      buttonRow.trailingAnchor.constraint(equalTo: self.previewButton.trailingAnchor),
      buttonRow.topAnchor.constraint(equalTo: self.previewButton.topAnchor),
      buttonRow.bottomAnchor.constraint(equalTo: self.previewButton.bottomAnchor),
    ])

    containerStackView.addArrangedSubview(buttonRow)
    containerStackView.addArrangedSubview(self.tapCountLabel)

    return self.previewContainer
  }

  private func makeSectionTitle(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    return label
  }

  private func makeRow(label text: String, control: UIView) -> UIView {
    let container = UIStackView()
    container.axis = .horizontal
    container.distribution = .fill
    container.alignment = .center
    container.spacing = 12

    let titleLabel = UILabel()
    titleLabel.text = text
    titleLabel.font = .preferredFont(forTextStyle: .body)

    container.addArrangedSubview(titleLabel)
    let spacer = UIView()
    spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
    container.addArrangedSubview(spacer)
    container.addArrangedSubview(control)
    return container
  }

  // MARK: - Refresh

  private func refreshPreview() {
    self.previewButton.size = self.size
    self.previewButton.variant = self.variant
    self.previewButton.icon = UIImage(systemName: self.iconOption.systemName)
    self.previewButton.isLoading = self.isLoadingState
    self.previewButton.isEnabled = self.isEnabledState
    self.previewButton.isSelected = self.isActiveState
  }

  private func refreshTapCount() {
    self.tapCountLabel.text = "Tapped: \(self.tapCount)"
  }

  // MARK: - Actions

  @objc private func onPreviewTapped() {
    self.tapCount += 1
    self.refreshTapCount()
  }

  @objc private func onSizeChanged(_ sender: UISegmentedControl) {
    self.size = BezierIconButtonSize.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onVariantChanged(_ sender: UISegmentedControl) {
    self.variant = BezierIconButtonVariant.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onIconChanged(_ sender: UISegmentedControl) {
    self.iconOption = IconOption.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onEnabledToggled(_ sender: UISwitch) {
    self.isEnabledState = sender.isOn
    self.refreshPreview()
  }

  @objc private func onLoadingToggled(_ sender: UISwitch) {
    self.isLoadingState = sender.isOn
    self.refreshPreview()
  }

  @objc private func onActiveToggled(_ sender: UISwitch) {
    self.isActiveState = sender.isOn
    self.refreshPreview()
  }
}
