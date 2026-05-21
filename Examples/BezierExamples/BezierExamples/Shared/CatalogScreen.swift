import SwiftUI

struct CatalogScreen<Content: View>: View {
  let title: String
  @ViewBuilder let content: () -> Content
  @EnvironmentObject private var env: CatalogEnvironment

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        self.content()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(16)
    }
    .background(self.env.background.color.ignoresSafeArea())
    .navigationTitle(self.title)
    .navigationBarTitleDisplayMode(.inline)
    .preferredColorScheme(self.env.colorScheme)
    .dynamicTypeSize(self.env.dynamicTypeSize)
    .toolbar { EnvironmentToolbar(env: self.env) }
  }
}
