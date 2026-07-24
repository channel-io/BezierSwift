import Testing
import UIKit
@testable import BezierSwift

// MARK: - Appearance 해석

@Suite("BezierSectionVariant Appearance 해석")
struct BezierSectionAppearanceTests {
  @Test("solid는 chrome/divider가 없다")
  func solidHasNoChrome() {
    let appearance = BezierSectionVariant.solid.appearance

    #expect(appearance.backgroundColor == nil)
    #expect(appearance.border == nil)
    #expect(appearance.divider == nil)
    #expect(appearance.hasChrome == false)
    #expect(appearance.contentInsets.top == 0)
    #expect(appearance.contentInsets.leading == 0)
    #expect(appearance.contentInsets.bottom == 0)
    #expect(appearance.contentInsets.trailing == 0)
  }

  @Test("card는 surface 배경/테두리/라운드/divider를 가진다")
  func cardHasChromeAndDivider() throws {
    let appearance = BezierSectionVariant.card.appearance

    #expect(appearance.backgroundColor == .surface)
    #expect(appearance.cornerRadius == 16)
    #expect(appearance.hasChrome == true)
    #expect(appearance.contentInsets.top == 2)
    #expect(appearance.contentInsets.leading == 0)
    #expect(appearance.contentInsets.bottom == 2)
    #expect(appearance.contentInsets.trailing == 0)

    let border = try #require(appearance.border)
    #expect(border.color == .borderNeutral)
    #expect(border.width == 1)

    let divider = try #require(appearance.divider)
    #expect(divider.color == .borderNeutral)
    #expect(divider.thickness == 1)
    #expect(divider.leadingInset == 0)
    #expect(divider.trailingInset == 0)
  }

  @Test("decoration elementKind는 왕복 변환된다", arguments: BezierSectionDecorationKind.allCases)
  func decorationElementKindRoundTrips(kind: BezierSectionDecorationKind) {
    let parsed = BezierSectionDecorationKind(elementKind: kind.elementKind)
    #expect(parsed == kind)
    #expect(
      BezierSectionDecorationKind(
        variant: kind.variant,
        componentTheme: kind.componentTheme
      ) == kind
    )
  }

  @Test("variant × componentTheme마다 decoration elementKind가 유일하다")
  func decorationElementKindsAreUnique() {
    let kinds = BezierSectionDecorationKind.allCases.map(\.elementKind)
    #expect(Set(kinds).count == kinds.count)
    #expect(kinds.count == BezierSectionVariant.allCases.count * 2)
  }

  @Test("알 수 없는 elementKind는 해석되지 않는다")
  func unknownElementKindReturnsNil() {
    #expect(BezierSectionDecorationKind(elementKind: "unknown") == nil)
  }
}

// MARK: - LabelColor 해석

@Suite("BezierSectionLabelColor 색 토큰")
struct BezierSectionLabelColorTests {
  @Test("neutralDark → textNeutral, neutralLight → textNeutralLighter")
  func labelColorTokens() {
    #expect(BezierSectionLabelColor.neutralDark.textColor == .textNeutral)
    #expect(BezierSectionLabelColor.neutralLight.textColor == .textNeutralLighter)
  }
}

// MARK: - 정적 컨테이너 구조

@Suite("BezierSection 정적 컨테이너", .serialized)
@MainActor
struct BezierSectionContainerTests {
  @Test("card는 행 사이에 divider를 인터리브한다")
  func cardInterleavesDividers() {
    let section = BezierSection(variant: .card, items: Self.makeItems(3))

    #expect(Self.allDividers(in: section).count == 2)
  }

  @Test("solid는 divider를 넣지 않는다")
  func solidHasNoDividers() {
    let section = BezierSection(variant: .solid, items: Self.makeItems(3))

    #expect(Self.allDividers(in: section).isEmpty)
  }

  @Test("setItems를 다시 호출해도 divider 개수가 일관된다")
  func setItemsRebuildsDividers() {
    let section = BezierSection(variant: .card, items: Self.makeItems(3))
    section.setItems(Self.makeItems(5))

    #expect(section.items.count == 5)
    #expect(Self.allDividers(in: section).count == 4)
  }

  @Test("variant를 바꾸면 divider가 재구성된다")
  func variantChangeRebuildsDividers() {
    let section = BezierSection(variant: .card, items: Self.makeItems(3))
    section.variant = .solid

    #expect(Self.allDividers(in: section).isEmpty)

    section.variant = .card
    #expect(Self.allDividers(in: section).count == 2)
  }

  @Test("addItem은 divider를 유지하며 행을 추가한다")
  func addItemAppendsRow() {
    let section = BezierSection(variant: .card, items: Self.makeItems(2))
    section.addItem(UIView())

    #expect(section.items.count == 3)
    #expect(Self.allDividers(in: section).count == 2)
  }

  @Test("labelText가 nil이면 label이 숨는다")
  func nilLabelTextHidesLabel() throws {
    let section = BezierSection(variant: .solid, items: Self.makeItems(1))

    let label = try #require(Self.sectionLabel(in: section))
    #expect(label.isHidden)

    section.labelText = "태그"
    #expect(label.isHidden == false)

    section.labelText = nil
    #expect(label.isHidden)
  }

  // MARK: - Helpers

  private static func makeItems(_ count: Int) -> [UIView] {
    (0..<count).map { _ in UIView() }
  }

  private static func sectionLabel(in view: UIView) -> BezierSectionLabel? {
    for subview in view.subviews {
      if let label = subview as? BezierSectionLabel { return label }
      if let found = self.sectionLabel(in: subview) { return found }
    }
    return nil
  }

  private static func allDividers(in view: UIView) -> [BezierSectionRowDivider] {
    var result: [BezierSectionRowDivider] = []
    for subview in view.subviews {
      if let divider = subview as? BezierSectionRowDivider { result.append(divider) }
      result.append(contentsOf: self.allDividers(in: subview))
    }
    return result
  }
}
