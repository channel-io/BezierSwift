import SwiftUI
import Combine

enum CatalogBackground: String, CaseIterable, Identifiable {
  case system
  case white
  case black
  case gray

  var id: String { self.rawValue }

  var displayName: String {
    switch self {
    case .system: return "System"
    case .white:  return "White"
    case .black:  return "Black"
    case .gray:   return "Gray"
    }
  }

  var color: Color {
    switch self {
    case .system: return Color(.systemBackground)
    case .white:  return .white
    case .black:  return .black
    case .gray:   return Color(.systemGray5)
    }
  }
}

final class CatalogEnvironment: ObservableObject {
  @Published var colorScheme: ColorScheme? = nil
  @Published var dynamicTypeSize: DynamicTypeSize = .large
  @Published var background: CatalogBackground = .system
}
