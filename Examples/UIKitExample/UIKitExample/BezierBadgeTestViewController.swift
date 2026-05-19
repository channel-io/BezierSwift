//
//  BezierBadgeTestViewController.swift
//  UIKitExample
//

import UIKit
import BezierSwift

final class BezierBadgeTestViewController: BaseViewController {
  // MARK: - State

  private var size: BezierBadgeSize = .small
  private var variant: BezierBadgeVariant = .default
  private var labelText: String = "Badge"
  private var hasLeadingIcon: Bool = false

  // MARK: - Subviews

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 16
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

  private lazy var previewBadge: BezierBadge = {
    let badge = BezierBadge(size: self.size, variant: self.variant)
    badge.label = self.labelText
    return badge
  }()

  private lazy var sizeControl: UISegmentedControl = {
    let control = UISegmentedControl(items: BezierBadgeSize.allCases.map { $0.rawValue })
    control.selectedSegmentIndex = BezierBadgeSize.allCases.firstIndex(of: self.size) ?? 0
    control.addTarget(self, action: #selector(self.onSizeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var variantPicker: UIPickerView = {
    let picker = UIPickerView()
    picker.dataSource = self
    picker.delegate = self
    picker.selectRow(BezierBadgeVariant.allCases.firstIndex(of: self.variant) ?? 0, inComponent: 0, animated: false)
    return picker
  }()

  private lazy var labelTextField: UITextField = {
    let field = UITextField()
    field.borderStyle = .roundedRect
    field.text = self.labelText
    field.placeholder = "Label"
    field.autocorrectionType = .no
    field.autocapitalizationType = .none
    field.addTarget(self, action: #selector(self.onLabelChanged(_:)), for: .editingChanged)
    return field
  }()

  private lazy var leadingIconSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.hasLeadingIcon
    toggle.addTarget(self, action: #selector(self.onLeadingIconToggled(_:)), for: .valueChanged)
    return toggle
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Badge (UIKit)"
    self.view.backgroundColor = .systemBackground
    self.setUpLayout()
    self.refreshPreview()
  }

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
    self.containerStackView.addArrangedSubview(self.variantPicker)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Label"))
    self.containerStackView.addArrangedSubview(self.labelTextField)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Content"))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "Leading Icon", control: self.leadingIconSwitch))
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Catalog"))
    self.containerStackView.addArrangedSubview(self.makeCatalogSection())
  }

  private func makeCatalogSection() -> UIView {
    let container = UIStackView()
    container.axis = .vertical
    container.spacing = 16
    container.alignment = .fill

    for size in BezierBadgeSize.allCases {
      let title = UILabel()
      title.text = size.rawValue
      title.font = .preferredFont(forTextStyle: .footnote)
      title.textColor = .secondaryLabel
      container.addArrangedSubview(title)

      container.addArrangedSubview(self.makeCatalogRow(size: size, leadingIcon: nil))
      container.addArrangedSubview(self.makeCatalogRow(size: size, leadingIcon: UIImage(systemName: "plus")))
    }
    return container
  }

  private func makeCatalogRow(size: BezierBadgeSize, leadingIcon: UIImage?) -> UIView {
    let scroll = UIScrollView()
    scroll.showsHorizontalScrollIndicator = false
    scroll.translatesAutoresizingMaskIntoConstraints = false

    let row = UIStackView()
    row.axis = .horizontal
    row.spacing = 8
    row.alignment = .center
    row.translatesAutoresizingMaskIntoConstraints = false

    for variant in BezierBadgeVariant.allCases {
      let badge = BezierBadge(size: size, variant: variant)
      badge.label = "Badge"
      badge.leadingIcon = leadingIcon
      row.addArrangedSubview(badge)
    }

    scroll.addSubview(row)
    NSLayoutConstraint.activate([
      row.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
      row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
      row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
      row.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
      row.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor),
      scroll.heightAnchor.constraint(equalToConstant: size.height + 4),
    ])
    return scroll
  }

  private func makePreviewSection() -> UIView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 12
    stack.isLayoutMarginsRelativeArrangement = true
    stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    stack.translatesAutoresizingMaskIntoConstraints = false

    self.previewContainer.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: self.previewContainer.topAnchor),
      stack.leadingAnchor.constraint(equalTo: self.previewContainer.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: self.previewContainer.trailingAnchor),
      stack.bottomAnchor.constraint(equalTo: self.previewContainer.bottomAnchor),
    ])

    let badgeRow = UIView()
    badgeRow.translatesAutoresizingMaskIntoConstraints = false
    badgeRow.addSubview(self.previewBadge)
    NSLayoutConstraint.activate([
      badgeRow.leadingAnchor.constraint(equalTo: self.previewBadge.leadingAnchor),
      badgeRow.trailingAnchor.constraint(equalTo: self.previewBadge.trailingAnchor),
      badgeRow.topAnchor.constraint(equalTo: self.previewBadge.topAnchor),
      badgeRow.bottomAnchor.constraint(equalTo: self.previewBadge.bottomAnchor),
    ])

    stack.addArrangedSubview(badgeRow)
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
    self.previewBadge.size = self.size
    self.previewBadge.variant = self.variant
    self.previewBadge.label = self.labelText.isEmpty ? nil : self.labelText
    self.previewBadge.leadingIcon = self.hasLeadingIcon ? UIImage(systemName: "plus") : nil
  }

  // MARK: - Actions

  @objc private func onSizeChanged(_ sender: UISegmentedControl) {
    self.size = BezierBadgeSize.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onLabelChanged(_ sender: UITextField) {
    self.labelText = sender.text ?? ""
    self.refreshPreview()
  }

  @objc private func onLeadingIconToggled(_ sender: UISwitch) {
    self.hasLeadingIcon = sender.isOn
    self.refreshPreview()
  }
}

// MARK: - UIPickerView

extension BezierBadgeTestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    BezierBadgeVariant.allCases.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    BezierBadgeVariant.allCases[row].rawValue
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.variant = BezierBadgeVariant.allCases[row]
    self.refreshPreview()
  }
}
