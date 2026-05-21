import SwiftUI

struct EnvironmentToolbar: ToolbarContent {
  @ObservedObject var env: CatalogEnvironment

  var body: some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      Menu {
        Picker("Color Scheme", selection: self.$env.colorScheme) {
          Text("System").tag(ColorScheme?.none)
          Text("Light").tag(ColorScheme?.some(.light))
          Text("Dark").tag(ColorScheme?.some(.dark))
        }
        Picker("Background", selection: self.$env.background) {
          ForEach(CatalogBackground.allCases) { bg in
            Text(bg.displayName).tag(bg)
          }
        }
        Picker("Dynamic Type", selection: self.$env.dynamicTypeSize) {
          Text("XS").tag(DynamicTypeSize.xSmall)
          Text("M").tag(DynamicTypeSize.large)
          Text("XL").tag(DynamicTypeSize.xLarge)
          Text("XXL").tag(DynamicTypeSize.xxLarge)
          Text("AX1").tag(DynamicTypeSize.accessibility1)
          Text("AX3").tag(DynamicTypeSize.accessibility3)
        }
      } label: {
        Image(systemName: "slider.horizontal.3")
      }
    }
  }
}
