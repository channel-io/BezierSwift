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
      id: "base-item",
      title: "BaseItem",
      section: .v3Components,
      destination: AnyView(BaseItemCatalog())
    ),
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
    CatalogItem(
      id: "divider",
      title: "Divider",
      section: .v3Components,
      destination: AnyView(DividerCatalog())
    ),
    CatalogItem(
      id: "progress-bar",
      title: "ProgressBar",
      section: .v3Components,
      destination: AnyView(ProgressBarCatalog())
    ),
    CatalogItem(
      id: "modal",
      title: "Modal",
      section: .v3Components,
      destination: AnyView(ModalCatalog())
    ),
    CatalogItem(
      id: "toast",
      title: "Toast",
      section: .v3Components,
      destination: AnyView(ToastCatalog())
    ),
    CatalogItem(
      id: "confirm-modal",
      title: "ConfirmModal",
      section: .v3Components,
      destination: AnyView(ConfirmModalCatalog())
    ),
    CatalogItem(
      id: "banner",
      title: "Banner",
      section: .v3Components,
      destination: AnyView(BannerCatalog())
    ),
    CatalogItem(
      id: "card",
      title: "Card",
      section: .v3Components,
      destination: AnyView(CardCatalog())
    ),
    CatalogItem(
      id: "section",
      title: "Section",
      section: .v3Components,
      destination: AnyView(SectionCatalog())
    ),
    CatalogItem(
      id: "section-item",
      title: "SectionItem",
      section: .v3Components,
      destination: AnyView(SectionItemCatalog())
    ),
    CatalogItem(
      id: "floating-banner",
      title: "FloatingBanner",
      section: .v3Components,
      destination: AnyView(FloatingBannerCatalog())
    ),
    CatalogItem(
      id: "overlay",
      title: "Overlay",
      section: .v3Components,
      destination: AnyView(OverlayCatalog())
    ),
    CatalogItem(
      id: "switch",
      title: "Switch",
      section: .v3Components,
      destination: AnyView(SwitchCatalog())
    ),
    CatalogItem(
      id: "checkbox",
      title: "Checkbox",
      section: .v3Components,
      destination: AnyView(CheckboxCatalog())
    ),
    CatalogItem(
      id: "text-input",
      title: "TextInput",
      section: .v3Components,
      destination: AnyView(TextInputCatalog())
    ),
    CatalogItem(
      id: "dropdown-menu",
      title: "DropdownMenu",
      section: .v3Components,
      destination: AnyView(DropdownMenuCatalog())
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
