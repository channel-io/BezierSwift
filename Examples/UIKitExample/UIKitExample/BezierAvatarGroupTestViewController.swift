//
//  BezierAvatarGroupTestViewController.swift
//  UIKitExample
//

import UIKit
import BezierSwift

final class BezierAvatarGroupTestViewController: BaseViewController {
  // MARK: - State

  private var size: BezierAvatarGroupSize = .size24
  private var ellipsisType: BezierAvatarGroupEllipsisType = .icon
  private var avatarCount: Int = 5

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

  private lazy var previewAvatarGroup: BezierAvatarGroup = {
    BezierAvatarGroup(
      avatars: Array(repeating: self.sampleImage, count: self.avatarCount),
      size: self.size,
      ellipsisType: self.ellipsisType
    )
  }()

  private lazy var sizeControl: UISegmentedControl = {
    let titles = BezierAvatarGroupSize.allCases.map { $0.rawValue }
    let control = UISegmentedControl(items: titles)
    control.selectedSegmentIndex = BezierAvatarGroupSize.allCases.firstIndex(of: self.size) ?? 0
    control.addTarget(self, action: #selector(self.onSizeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var ellipsisTypeControl: UISegmentedControl = {
    let titles = BezierAvatarGroupEllipsisType.allCases.map { $0.rawValue }
    let control = UISegmentedControl(items: titles)
    control.selectedSegmentIndex = BezierAvatarGroupEllipsisType.allCases.firstIndex(of: self.ellipsisType) ?? 0
    control.addTarget(self, action: #selector(self.onEllipsisTypeChanged(_:)), for: .valueChanged)
    return control
  }()

  private lazy var countSlider: UISlider = {
    let slider = UISlider()
    slider.minimumValue = 0
    slider.maximumValue = 10
    slider.value = Float(self.avatarCount)
    slider.isContinuous = true
    slider.addTarget(self, action: #selector(self.onCountChanged(_:)), for: .valueChanged)
    return slider
  }()

  private lazy var countLabel: UILabel = {
    let label = UILabel()
    label.text = "Avatar count: \(self.avatarCount)"
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    return label
  }()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "AvatarGroup (UIKit)"
    self.view.backgroundColor = .systemBackground
    self.setUpLayout()
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
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Ellipsis Type"))
    self.containerStackView.addArrangedSubview(self.ellipsisTypeControl)
    self.containerStackView.addArrangedSubview(self.countLabel)
    self.containerStackView.addArrangedSubview(self.countSlider)
    self.containerStackView.addArrangedSubview(self.makeSectionTitle("Catalog (4 variant × count)"))
    self.containerStackView.addArrangedSubview(self.makeCatalogSection())
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

    stack.addArrangedSubview(self.previewAvatarGroup)
    return self.previewContainer
  }

  private func makeCatalogSection() -> UIView {
    let container = UIStackView()
    container.axis = .vertical
    container.spacing = 20
    container.alignment = .fill

    let counts = [1, 2, 3, 4, 5, 8, 12]

    for size in BezierAvatarGroupSize.allCases {
      for type in BezierAvatarGroupEllipsisType.allCases {
        let title = UILabel()
        title.text = "size=\(size.rawValue), ellipsisType=\(type.rawValue)"
        title.font = .preferredFont(forTextStyle: .footnote)
        title.textColor = .secondaryLabel
        container.addArrangedSubview(title)
        container.addArrangedSubview(self.makeCatalogRow(size: size, type: type, counts: counts))
      }
    }
    return container
  }

  private func makeCatalogRow(
    size: BezierAvatarGroupSize,
    type: BezierAvatarGroupEllipsisType,
    counts: [Int]
  ) -> UIView {
    let scroll = UIScrollView()
    scroll.showsHorizontalScrollIndicator = false
    scroll.translatesAutoresizingMaskIntoConstraints = false

    let row = UIStackView()
    row.axis = .horizontal
    row.alignment = .top
    row.spacing = 24
    row.translatesAutoresizingMaskIntoConstraints = false

    for count in counts {
      let column = UIStackView()
      column.axis = .vertical
      column.spacing = 4
      column.alignment = .leading

      let countLabel = UILabel()
      countLabel.text = "\(count)"
      countLabel.font = .preferredFont(forTextStyle: .caption2)
      countLabel.textColor = .secondaryLabel
      column.addArrangedSubview(countLabel)

      let group = BezierAvatarGroup(
        avatars: Array(repeating: self.sampleImage, count: count),
        size: size,
        ellipsisType: type
      )
      column.addArrangedSubview(group)
      row.addArrangedSubview(column)
    }

    scroll.addSubview(row)
    NSLayoutConstraint.activate([
      row.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
      row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
      row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
      row.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
      row.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor),
      scroll.heightAnchor.constraint(equalToConstant: size.avatarLength + 28),
    ])
    return scroll
  }

  private func makeSectionTitle(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .secondaryLabel
    return label
  }

  // MARK: - Refresh

  private func refreshPreview() {
    self.previewAvatarGroup.avatars = Array(repeating: self.sampleImage, count: self.avatarCount)
    self.previewAvatarGroup.size = self.size
    self.previewAvatarGroup.ellipsisType = self.ellipsisType
    self.countLabel.text = "Avatar count: \(self.avatarCount)"
  }

  // MARK: - Actions

  @objc private func onSizeChanged(_ sender: UISegmentedControl) {
    self.size = BezierAvatarGroupSize.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onEllipsisTypeChanged(_ sender: UISegmentedControl) {
    self.ellipsisType = BezierAvatarGroupEllipsisType.allCases[sender.selectedSegmentIndex]
    self.refreshPreview()
  }

  @objc private func onCountChanged(_ sender: UISlider) {
    self.avatarCount = Int(sender.value.rounded())
    self.refreshPreview()
  }
}
