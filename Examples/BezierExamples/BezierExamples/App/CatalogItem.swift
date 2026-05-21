import SwiftUI

enum CatalogSectionKind: String, CaseIterable, Identifiable {
  case v3Foundation = "V3 · Foundation"
  case v3Components = "V3 · Components"
  case legacyComponents = "Legacy · Components"

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
