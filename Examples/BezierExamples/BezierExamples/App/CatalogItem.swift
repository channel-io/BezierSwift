import SwiftUI

enum CatalogSectionKind: String, CaseIterable, Identifiable {
  case foundation = "Foundation"
  case components = "Components"

  var id: String { self.rawValue }
}

struct CatalogItem: Identifiable, Hashable {
  let id: String
  let title: String
  let section: CatalogSectionKind
  let destination: AnyView

  static func == (lhs: CatalogItem, rhs: CatalogItem) -> Bool { lhs.id == rhs.id }
  func hash(into hasher: inout Hasher) { hasher.combine(self.id) }
}
