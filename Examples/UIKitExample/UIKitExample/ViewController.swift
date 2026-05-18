//
//  ViewController.swift
//  UIKitExample
//
//  Created by Tom on 2023/06/27.
//

import UIKit
import BezierSwift

final class ViewController: BaseViewController {
  private enum Row: Int, CaseIterable {
    case bezierIconCatalog
    case bezierButton

    var title: String {
      switch self {
      case .bezierIconCatalog: return "Bezier Icon Catalog"
      case .bezierButton: return "Button"
      }
    }
  }

  private lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .insetGrouped)
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.dataSource = self
    tv.delegate = self
    tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    return tv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "BezierSwift Examples"
    self.view.backgroundColor = .systemBackground

    self.view.addSubview(self.tableView)
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Row.allCases.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = Row(rawValue: indexPath.row)?.title
    cell.accessoryType = .disclosureIndicator
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let row = Row(rawValue: indexPath.row) else { return }
    switch row {
    case .bezierIconCatalog:
      self.navigationController?.pushViewController(BezierIconCatalogViewController(), animated: true)
    case .bezierButton:
      self.navigationController?.pushViewController(BezierButtonTestViewController(), animated: true)
    }
  }
}
