import SwiftUI

enum CatalogRegistry {
  static let all: [CatalogItem] = []

  static func items(in section: CatalogSectionKind) -> [CatalogItem] {
    self.all.filter { $0.section == section }
  }
}
