import Testing
@testable import BezierExamples

struct BezierExamplesTests {

  @Test func catalogRegistryHasItemsInAllSections() async throws {
    for section in CatalogSectionKind.allCases {
      let items = CatalogRegistry.items(in: section)
      #expect(!items.isEmpty, "section \(section.rawValue) is empty")
    }
  }

  @Test func catalogItemIdsAreUnique() async throws {
    let ids = CatalogRegistry.all.map(\.id)
    #expect(ids.count == Set(ids).count, "duplicate ids: \(ids)")
  }
}
