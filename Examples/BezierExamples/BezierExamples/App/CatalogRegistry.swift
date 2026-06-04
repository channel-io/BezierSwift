import SwiftUI

enum CatalogRegistry {
  static let all: [CatalogItem] = [
    // MARK: - V3 Foundation
    CatalogItem(
      id: "color",
      title: "Color Token",
      section: .v3Foundation,
      destination: AnyView(ColorTokenCatalog())
    ),
    CatalogItem(
      id: "typography",
      title: "Typography",
      section: .v3Foundation,
      destination: AnyView(TypographyCatalog())
    ),
    CatalogItem(
      id: "icon",
      title: "Icon",
      section: .v3Foundation,
      destination: AnyView(IconCatalog())
    ),
    CatalogItem(
      id: "dimension",
      title: "Dimension",
      section: .v3Foundation,
      destination: AnyView(DimensionCatalog())
    ),
    // MARK: - V3 Components
    CatalogItem(
      id: "button",
      title: "Button",
      section: .v3Components,
      destination: AnyView(ButtonCatalog())
    ),
    CatalogItem(
      id: "icon-button",
      title: "IconButton",
      section: .v3Components,
      destination: AnyView(IconButtonCatalog())
    ),
    CatalogItem(
      id: "badge",
      title: "Badge",
      section: .v3Components,
      destination: AnyView(BadgeCatalog())
    ),
    CatalogItem(
      id: "tag",
      title: "Tag",
      section: .v3Components,
      destination: AnyView(TagCatalog())
    ),
    CatalogItem(
      id: "avatar",
      title: "Avatar",
      section: .v3Components,
      destination: AnyView(AvatarCatalog())
    ),
    CatalogItem(
      id: "avatar-group",
      title: "AvatarGroup",
      section: .v3Components,
      destination: AnyView(AvatarGroupCatalog())
    ),
    CatalogItem(
      id: "spinner",
      title: "Spinner",
      section: .v3Components,
      destination: AnyView(SpinnerCatalog())
    ),
    // MARK: - Legacy Components
    CatalogItem(
      id: "legacy-button",
      title: "Legacy Button",
      section: .legacyComponents,
      destination: AnyView(LegacyButtonCatalog())
    ),
  ]

  static func items(in section: CatalogSectionKind) -> [CatalogItem] {
    self.all.filter { $0.section == section }
  }
}
