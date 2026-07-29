import SwiftUI

enum CatalogRegistry {
  // MARK: - V3 Foundation
  // 알파벳순 유지 — 신규 항목은 배열 끝이 아니라 제자리에 삽입할 것 (병렬 PR 충돌 방지)
  private static let v3Foundation: [CatalogItem] = [
    .init(id: "color", title: "Color Token", section: .v3Foundation, destination: AnyView(ColorTokenCatalog())),
    .init(id: "dimension", title: "Dimension", section: .v3Foundation, destination: AnyView(DimensionCatalog())),
    .init(id: "icon", title: "Icon", section: .v3Foundation, destination: AnyView(IconCatalog())),
    .init(id: "typography", title: "Typography", section: .v3Foundation, destination: AnyView(TypographyCatalog())),
  ]

  // MARK: - V3 Components
  // 알파벳순 유지 — 신규 항목은 배열 끝이 아니라 제자리에 삽입할 것 (병렬 PR 충돌 방지)
  private static let v3Components: [CatalogItem] = [
    .init(id: "avatar", title: "Avatar", section: .v3Components, destination: AnyView(AvatarCatalog())),
    .init(id: "avatar-group", title: "AvatarGroup", section: .v3Components, destination: AnyView(AvatarGroupCatalog())),
    .init(id: "badge", title: "Badge", section: .v3Components, destination: AnyView(BadgeCatalog())),
    .init(id: "banner", title: "Banner", section: .v3Components, destination: AnyView(BannerCatalog())),
    .init(id: "base-item", title: "BaseItem", section: .v3Components, destination: AnyView(BaseItemCatalog())),
    .init(id: "button", title: "Button", section: .v3Components, destination: AnyView(ButtonCatalog())),
    .init(id: "card", title: "Card", section: .v3Components, destination: AnyView(CardCatalog())),
    .init(id: "checkbox", title: "Checkbox", section: .v3Components, destination: AnyView(CheckboxCatalog())),
    .init(id: "collapsible-section", title: "CollapsibleSection", section: .v3Components, destination: AnyView(CollapsibleSectionCatalog())),
    .init(id: "confirm-modal", title: "ConfirmModal", section: .v3Components, destination: AnyView(ConfirmModalCatalog())),
    .init(id: "divider", title: "Divider", section: .v3Components, destination: AnyView(DividerCatalog())),
    .init(id: "dropdown-menu", title: "DropdownMenu", section: .v3Components, destination: AnyView(DropdownMenuCatalog())),
    .init(id: "emoji", title: "Emoji", section: .v3Components, destination: AnyView(EmojiCatalog())),
    .init(id: "floating-banner", title: "FloatingBanner", section: .v3Components, destination: AnyView(FloatingBannerCatalog())),
    .init(id: "form-group", title: "FormGroup", section: .v3Components, destination: AnyView(FormGroupCatalog())),
    .init(id: "icon-button", title: "IconButton", section: .v3Components, destination: AnyView(IconButtonCatalog())),
    .init(id: "modal", title: "Modal", section: .v3Components, destination: AnyView(ModalCatalog())),
    .init(id: "overlay", title: "Overlay", section: .v3Components, destination: AnyView(OverlayCatalog())),
    .init(id: "progress-bar", title: "ProgressBar", section: .v3Components, destination: AnyView(ProgressBarCatalog())),
    .init(id: "section", title: "Section", section: .v3Components, destination: AnyView(SectionCatalog())),
    .init(id: "section-item", title: "SectionItem", section: .v3Components, destination: AnyView(SectionItemCatalog())),
    .init(id: "spinner", title: "Spinner", section: .v3Components, destination: AnyView(SpinnerCatalog())),
    .init(id: "switch", title: "Switch", section: .v3Components, destination: AnyView(SwitchCatalog())),
    .init(id: "tag", title: "Tag", section: .v3Components, destination: AnyView(TagCatalog())),
    .init(id: "text-input", title: "TextInput", section: .v3Components, destination: AnyView(TextInputCatalog())),
    .init(id: "toast", title: "Toast", section: .v3Components, destination: AnyView(ToastCatalog())),
  ]

  // MARK: - Legacy Components
  // 알파벳순 유지 — 신규 항목은 배열 끝이 아니라 제자리에 삽입할 것 (병렬 PR 충돌 방지)
  private static let legacyComponents: [CatalogItem] = [
    .init(id: "legacy-button", title: "Legacy Button", section: .legacyComponents, destination: AnyView(LegacyButtonCatalog())),
  ]

  static let all: [CatalogItem] = v3Foundation + v3Components + legacyComponents

  static func items(in section: CatalogSectionKind) -> [CatalogItem] {
    self.all.filter { $0.section == section }
  }
}
