import SwiftUI
import BezierSwift

struct BezierIconCatalogView: View {
  @State private var searchText: String = ""

  private var filteredIcons: [BezierIcon] {
    let all = BezierIcon.allCases.sorted { $0.rawValue < $1.rawValue }
    guard !searchText.isEmpty else { return all }
    return all.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText) }
  }

  private let columns = [
    GridItem(.adaptive(minimum: 88), spacing: 12)
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 12) {
        ForEach(filteredIcons, id: \.self) { icon in
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
    .navigationTitle("Bezier Icons (\(filteredIcons.count))")
    .searchable(text: $searchText, prompt: "Search icons")
  }
}

struct BezierIconCatalogView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierIconCatalogView()
    }
  }
}
