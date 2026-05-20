//
//  BezierTagTestViewController.swift
//  UIKitExample
//

import UIKit
import BezierSwift

final class BezierTagTestViewController: BaseViewController {
  // MARK: - State

  private var size: BezierTagSize = .small
  private var variant: BezierTagVariant = .default
  private var labelText: String = "Tag"
  private var hasOnDelete: Bool = false
  private var deleteCount: Int = 0

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

  private lazy var previewTag: BezierTag = {
    let tag = BezierTag(size: self.size, variant: self.variant)
    tag.label = self.labelText
    return tag
  }()

  private lazy var sizeControl: UISegmentedControl = {
    let control = UISegmentedControl(items: BezierTagSize.allCases.map { $0.rawValue })
    control.selectedSegmentIndex = BezierTagSize.allCases.firstIndex(of: self.size) ?? 0
    control.addTarget(self, action: #selector(self.onSizeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var variantPicker: UIPickerView = {
    let picker = UIPickerView()
    picker.dataSource = self
    picker.delegate = self
    picker.selectRow(BezierTagVariant.allCases.firstIndex(of: self.variant) ?? 0, inComponent: 0, animated: false)
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

  private lazy var onDeleteSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.hasOnDelete
    toggle.addTarget(self, action: #selector(self.onDeleteToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var deleteCountLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    label.text = "Delete tapped: 0 times"
    return label
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Tag (UIKit)"
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
    self.containerStackView.addArrangedSubview(self.makeRow(label: "onDelete enabled", control: self.onDeleteSwitch))
    self.containerStackView.addArrangedSubview(self.deleteCountLabel)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Catalog"))
    self.containerStackView.addArrangedSubview(self.makeCatalogSection())
  }

  private func makeCatalogSection() -> UIView {
    let container = UIStackView()
    container.axis = .vertical
    container.spacing = 16
    container.alignment = .fill

    for size in BezierTagSize.allCases {
      let title = UILabel()
      title.text = size.rawValue
      title.font = .preferredFont(forTextStyle: .footnote)
      title.textColor = .secondaryLabel
      container.addArrangedSubview(title)

      container.addArrangedSubview(self.makeCatalogRow(size: size, hasOnDelete: false))
      container.addArrangedSubview(self.makeCatalogRow(size: size, hasOnDelete: true))
    }
    return container
  }

  private func makeCatalogRow(size: BezierTagSize, hasOnDelete: Bool) -> UIView {
    let scroll = UIScrollView()
    scroll.showsHorizontalScrollIndicator = false
    scroll.translatesAutoresizingMaskIntoConstraints = false

    let row = UIStackView()
    row.axis = .horizontal
    row.spacing = 8
    row.alignment = .center
    row.translatesAutoresizingMaskIntoConstraints = false

    for variant in BezierTagVariant.allCases {
      let tag = BezierTag(size: size, variant: variant)
      tag.label = "Tag"
      if hasOnDelete {
        tag.onDelete = {}
      }
      row.addArrangedSubview(tag)
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

    let tagRow = UIView()
    tagRow.translatesAutoresizingMaskIntoConstraints = false
    tagRow.addSubview(self.previewTag)
    NSLayoutConstraint.activate([
      tagRow.leadingAnchor.constraint(equalTo: self.previewTag.leadingAnchor),
      tagRow.trailingAnchor.constraint(equalTo: self.previewTag.trailingAnchor),
      tagRow.topAnchor.constraint(equalTo: self.previewTag.topAnchor),
      tagRow.bottomAnchor.constraint(equalTo: self.previewTag.bottomAnchor),
    ])

    stack.addArrangedSubview(tagRow)
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
    self.previewTag.size = self.size
    self.previewTag.variant = self.variant
    self.previewTag.label = self.labelText.isEmpty ? nil : self.labelText
    self.previewTag.onDelete = self.hasOnDelete ? { [weak self] in
      guard let self else { return }
      self.deleteCount += 1
      self.deleteCountLabel.text = "Delete tapped: \(self.deleteCount) times"
    } : nil
    self.deleteCountLabel.isHidden = !self.hasOnDelete
  }

  // MARK: - Actions

  @objc private func onSizeChanged(_ sender: UISegmentedControl) {
    self.size = BezierTagSize.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onLabelChanged(_ sender: UITextField) {
    self.labelText = sender.text ?? ""
    self.refreshPreview()
  }

  @objc private func onDeleteToggled(_ sender: UISwitch) {
    self.hasOnDelete = sender.isOn
    self.refreshPreview()
  }
}

// MARK: - UIPickerView

extension BezierTagTestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    BezierTagVariant.allCases.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    BezierTagVariant.allCases[row].rawValue
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.variant = BezierTagVariant.allCases[row]
    self.refreshPreview()
  }
}
