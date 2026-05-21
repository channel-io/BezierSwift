//
//  BezierAvatarTestViewController.swift
//  UIKitExample
//

import UIKit
import BezierSwift

final class BezierAvatarTestViewController: BaseViewController {
  // MARK: - State

  private var size: BezierAvatarSize = .size48
  private var showBorder: Bool = false
  private var hasStatus: Bool = false
  private var statusType: BezierAvatarStatusType = .online
  private var isEnabled: Bool = true

  private let sampleImage: UIImage? = UIImage(named: "AvatarSample")

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

  private lazy var previewAvatar: BezierAvatar = {
    let avatar = BezierAvatar(image: self.sampleImage, size: self.size)
    return avatar
  }()

  private lazy var sizeControl: UISegmentedControl = {
    let titles = BezierAvatarSize.allCases.map { String(Int($0.length)) }
    let control = UISegmentedControl(items: titles)
    control.selectedSegmentIndex = BezierAvatarSize.allCases.firstIndex(of: self.size) ?? 0
    control.addTarget(self, action: #selector(self.onSizeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var borderSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.showBorder
    toggle.addTarget(self, action: #selector(self.onBorderToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var statusSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.hasStatus
    toggle.addTarget(self, action: #selector(self.onStatusToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var enabledSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.isOn = self.isEnabled
    toggle.addTarget(self, action: #selector(self.onEnabledToggled(_:)), for: .valueChanged)
    return toggle
  }()

  private lazy var statusTypePicker: UIPickerView = {
    let picker = UIPickerView()
    picker.dataSource = self
    picker.delegate = self
    picker.selectRow(BezierAvatarStatusType.allCases.firstIndex(of: self.statusType) ?? 0, inComponent: 0, animated: false)
    return picker
  }()

  private lazy var statusTypeSectionTitle: UILabel = self.makeSectionTitle("Status type")

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Avatar (UIKit)"
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
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Toggle"))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "showBorder", control: self.borderSwitch))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "hasStatus", control: self.statusSwitch))
    self.containerStackView.addArrangedSubview(self.makeRow(label: "isEnabled", control: self.enabledSwitch))
    self.containerStackView.addArrangedSubview(self.statusTypeSectionTitle)
    self.containerStackView.addArrangedSubview(self.statusTypePicker)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Catalog"))
    self.containerStackView.addArrangedSubview(self.makeCatalogSection())
  }

  private func makeCatalogSection() -> UIView {
    let container = UIStackView()
    container.axis = .vertical
    container.spacing = 20
    container.alignment = .fill

    let rows: [(String, Bool, BezierAvatarStatusType?)] = [
      ("default", false, nil),
      ("showBorder", true, nil),
      ("status = online", false, .online),
      ("status = lock", false, .lock),
      ("status = onlineDnd", false, .onlineDnd),
    ]

    for (label, showBorder, statusType) in rows {
      let title = UILabel()
      title.text = label
      title.font = .preferredFont(forTextStyle: .footnote)
      title.textColor = .secondaryLabel
      container.addArrangedSubview(title)
      container.addArrangedSubview(self.makeCatalogRow(showBorder: showBorder, statusType: statusType))
    }
    return container
  }

  private func makeCatalogRow(showBorder: Bool, statusType: BezierAvatarStatusType?) -> UIView {
    let scroll = UIScrollView()
    scroll.showsHorizontalScrollIndicator = false
    scroll.translatesAutoresizingMaskIntoConstraints = false

    let row = UIStackView()
    row.axis = .horizontal
    row.alignment = .top
    row.spacing = 24
    row.translatesAutoresizingMaskIntoConstraints = false

    for size in BezierAvatarSize.allCases {
      let avatar = BezierAvatar(
        image: self.sampleImage,
        size: size,
        showBorder: showBorder,
        statusType: statusType
      )
      row.addArrangedSubview(avatar)
    }

    scroll.addSubview(row)
    NSLayoutConstraint.activate([
      row.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
      row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
      row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
      row.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
      row.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor),
      scroll.heightAnchor.constraint(equalToConstant: (BezierAvatarSize.allCases.map(\.length).max() ?? 0) + 8),
    ])
    return scroll
  }

  private func makePreviewSection() -> UIView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 12
    stack.isLayoutMarginsRelativeArrangement = true
    stack.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    stack.translatesAutoresizingMaskIntoConstraints = false

    self.previewContainer.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: self.previewContainer.topAnchor),
      stack.leadingAnchor.constraint(equalTo: self.previewContainer.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: self.previewContainer.trailingAnchor),
      stack.bottomAnchor.constraint(equalTo: self.previewContainer.bottomAnchor),
    ])

    stack.addArrangedSubview(self.previewAvatar)
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
    self.previewAvatar.size = self.size
    self.previewAvatar.showBorder = self.showBorder
    self.previewAvatar.statusType = self.hasStatus ? self.statusType : nil
    self.previewAvatar.isEnabled = self.isEnabled
    // SwiftUI 예제와 UX 일관성 — hasStatus가 false면 status type picker 영역을 숨긴다.
    self.statusTypeSectionTitle.isHidden = !self.hasStatus
    self.statusTypePicker.isHidden = !self.hasStatus
  }

  // MARK: - Actions

  @objc private func onSizeChanged(_ sender: UISegmentedControl) {
    self.size = BezierAvatarSize.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onBorderToggled(_ sender: UISwitch) {
    self.showBorder = sender.isOn
    self.refreshPreview()
  }

  @objc private func onStatusToggled(_ sender: UISwitch) {
    self.hasStatus = sender.isOn
    self.refreshPreview()
  }

  @objc private func onEnabledToggled(_ sender: UISwitch) {
    self.isEnabled = sender.isOn
    self.refreshPreview()
  }
}

// MARK: - UIPickerView

extension BezierAvatarTestViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    BezierAvatarStatusType.allCases.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    BezierAvatarStatusType.allCases[row].rawValue
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.statusType = BezierAvatarStatusType.allCases[row]
    self.refreshPreview()
  }
}
