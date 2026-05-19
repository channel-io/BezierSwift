import UIKit
import BezierSwift

final class BezierIconCatalogViewController: BaseViewController {
  private let allIcons: [BezierIcon] = BezierIcon.allCases.sorted { $0.rawValue < $1.rawValue }
  private var filteredIcons: [BezierIcon] = []

  private lazy var searchController: UISearchController = {
    let controller = UISearchController(searchResultsController: nil)
    controller.searchResultsUpdater = self
    controller.obscuresBackgroundDuringPresentation = false
    controller.searchBar.placeholder = "Search icons"
    return controller
  }()

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { _, env in
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(96)
      )
      let columns = max(2, Int(env.container.effectiveContentSize.width / 96))
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: item,
        count: columns
      )
      group.interItemSpacing = .fixed(8)
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 8
      section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
      return section
    }
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .systemBackground
    cv.dataSource = self
    cv.register(IconCell.self, forCellWithReuseIdentifier: IconCell.reuseID)
    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.filteredIcons = self.allIcons
    self.title = "Bezier Icons (\(self.filteredIcons.count))"
    self.view.backgroundColor = .systemBackground
    self.navigationItem.searchController = self.searchController
    self.navigationItem.hidesSearchBarWhenScrolling = false

    self.view.addSubview(self.collectionView)
    NSLayoutConstraint.activate([
      self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
}

extension BezierIconCatalogViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.filteredIcons.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.reuseID, for: indexPath) as! IconCell
    cell.configure(with: self.filteredIcons[indexPath.item])
    return cell
  }
}

extension BezierIconCatalogViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let query = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    if query.isEmpty {
      self.filteredIcons = self.allIcons
    } else {
      self.filteredIcons = self.allIcons.filter {
        $0.rawValue.range(of: query, options: .caseInsensitive) != nil
      }
    }
    self.title = "Bezier Icons (\(self.filteredIcons.count))"
    self.collectionView.reloadData()
  }
}

private final class IconCell: UICollectionViewCell {
  static let reuseID = "IconCell"

  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    iv.tintColor = .label
    return iv
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 10)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingMiddle
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.backgroundColor = UIColor.systemGray6
    self.contentView.layer.cornerRadius = 8

    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.nameLabel)

    NSLayoutConstraint.activate([
      self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
      self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      self.imageView.widthAnchor.constraint(equalToConstant: 32),
      self.imageView.heightAnchor.constraint(equalToConstant: 32),

      self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 6),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4),
      self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4),
      self.nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with icon: BezierIcon) {
    self.imageView.image = icon.uiImage
    self.nameLabel.text = icon.rawValue.replacingOccurrences(of: "icon-", with: "")
  }
}
