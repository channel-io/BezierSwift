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
    CatalogItem(
      id: "button",
      title: "Button",
      section: .components,
      destination: AnyView(ButtonCatalog())
    ),
    CatalogItem(
      id: "icon-button",
      title: "IconButton",
      section: .components,
      destination: AnyView(IconButtonCatalog())
    ),
    CatalogItem(
      id: "badge",
      title: "Badge",
      section: .components,
      destination: AnyView(BadgeCatalog())
    ),
    CatalogItem(
      id: "tag",
      title: "Tag",
      section: .components,
      destination: AnyView(TagCatalog())
    ),
    CatalogItem(
      id: "avatar",
      title: "Avatar",
      section: .components,
      destination: AnyView(AvatarCatalog())
    ),
    CatalogItem(
      id: "avatar-group",
      title: "AvatarGroup",
      section: .components,
      destination: AnyView(AvatarGroupCatalog())
    ),
  ]

  static func items(in section: CatalogSectionKind) -> [CatalogItem] {
    self.all.filter { $0.section == section }
  }
}
