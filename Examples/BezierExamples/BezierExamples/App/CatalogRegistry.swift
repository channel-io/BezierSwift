import SwiftUI

enum CatalogRegistry {
  static let all: [CatalogItem] = [
    CatalogItem(
      id: "color",
      title: "Color Token",
      section: .foundation,
      destination: AnyView(ColorTokenCatalog())
    ),
    CatalogItem(
      id: "typography",
      title: "Typography",
      section: .foundation,
      destination: AnyView(TypographyCatalog())
    ),
    CatalogItem(
      id: "icon",
      title: "Icon",
      section: .foundation,
      destination: AnyView(IconCatalog())
    ),
    CatalogItem(
      id: "dimension",
      title: "Dimension",
      section: .foundation,
      destination: AnyView(DimensionCatalog())
    ),
  ]

  static func items(in section: CatalogSectionKind) -> [CatalogItem] {
    self.all.filter { $0.section == section }
  }
}
