import SwiftUI

struct RootView: View {
  @State private var selection: CatalogItem?

  var body: some View {
    NavigationSplitView {
      List(selection: self.$selection) {
        ForEach(CatalogSectionKind.allCases) { section in
          let items = CatalogRegistry.items(in: section)
          if !items.isEmpty {
            Section(section.rawValue) {
              ForEach(items) { item in
                NavigationLink(value: item) { Text(item.title) }
              }
            }
          }
        }
      }
      .navigationTitle("BezierExamples")
    } detail: {
      if let item = self.selection {
        item.destination
      }
    }
  }
}
