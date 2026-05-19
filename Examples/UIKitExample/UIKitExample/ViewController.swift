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
    case bezierButton
    case bezierIconButton

    var title: String {
      switch self {
      case .bezierButton:     return "Button"
      case .bezierIconButton: return "IconButton"
      }
    }
  }

  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "BezierSwift Examples"
    self.view.backgroundColor = .systemGroupedBackground

    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    self.view.addSubview(self.tableView)
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Row.allCases.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let row = Row.allCases[indexPath.row]
    cell.textLabel?.text = row.title
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let row = Row.allCases[indexPath.row]
    switch row {
    case .bezierButton:
      self.navigationController?.pushViewController(BezierButtonTestViewController(), animated: true)
    case .bezierIconButton:
      self.navigationController?.pushViewController(BezierIconButtonTestViewController(), animated: true)
    }
  }
}
