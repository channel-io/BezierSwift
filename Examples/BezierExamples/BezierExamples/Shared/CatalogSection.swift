import SwiftUI

enum CatalogVariant: String {
  case swiftUI = "SwiftUI"
  case uiKit = "UIKit"
}

struct CatalogSection<Content: View>: View {
  let variant: CatalogVariant
  @ViewBuilder let content: () -> Content

  init(_ variant: CatalogVariant, @ViewBuilder content: @escaping () -> Content) {
    self.variant = variant
    self.content = content
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(self.variant.rawValue)
        .font(.system(size: 11, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      VStack(alignment: .leading, spacing: 12) { self.content() }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .stroke(Color.secondary.opacity(0.2))
        )
    }
  }
}
