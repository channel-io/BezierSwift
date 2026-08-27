import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierToast Appearance")
struct BezierToastAppearanceTests {
  @Test("Blur Material은 앱의 color theme을 따른다")
  func blurMaterialFollowsAppColorTheme() {
    #expect(
      BezierToastSpec.blurEffectStyle(for: .light) == .systemUltraThinMaterialLight
    )
    #expect(
      BezierToastSpec.blurEffectStyle(for: .dark) == .systemUltraThinMaterialDark
    )
  }
}
