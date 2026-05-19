import SwiftUI
import BezierSwift

struct BezierIconCatalogView: View {
  private static let allSortedIcons: [BezierIcon] = BezierIcon.allCases
    .sorted { $0.rawValue < $1.rawValue }

  @State private var searchText: String = ""

  private let columns = [
    GridItem(.adaptive(minimum: 88), spacing: 12)
  ]

  var body: some View {
    let icons = self.filteredIcons(query: self.searchText)

    return ScrollView {
      LazyVGrid(columns: self.columns, spacing: 12) {
        ForEach(icons, id: \.self) { icon in
          VStack(spacing: 6) {
            icon.image
              .frame(width: 32, height: 32)
              .foregroundColor(.primary)
            Text(icon.rawValue.replacingOccurrences(of: "icon-", with: ""))
              .font(.system(size: 10))
              .lineLimit(1)
              .truncationMode(.middle)
              .foregroundColor(.secondary)
          }
          .frame(maxWidth: .infinity, minHeight: 80)
          .padding(8)
          .background(Color.gray.opacity(0.08))
          .cornerRadius(8)
        }
      }
      .padding()
    }
    .navigationTitle("Bezier Icons (\(icons.count))")
    .searchable(text: self.$searchText, prompt: "Search icons")
  }

  private func filteredIcons(query: String) -> [BezierIcon] {
    let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return Self.allSortedIcons }
    return Self.allSortedIcons.filter {
      $0.rawValue.localizedCaseInsensitiveContains(trimmed)
    }
  }
}

struct BezierIconCatalogView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierIconCatalogView()
    }
  }
}
