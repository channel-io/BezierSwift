import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierFormGroup 레이아웃 그룹", .serialized)
@MainActor
struct BezierFormGroupTests {
  @Test("기본 간격은 4pt다")
  func defaultSpacing() {
    let formGroup = BezierFormGroup()

    #expect(BezierFormGroupConstant.contentSpacing == 4)
    #expect(formGroup.spacing == BezierFormGroupConstant.contentSpacing)
    #expect(Self.contentStackView(in: formGroup)?.spacing == BezierFormGroupConstant.contentSpacing)
  }

  @Test("items 순서대로 세로 스택에 쌓인다")
  func itemsStackInOrder() throws {
    let items = Self.makeItems(3)
    let formGroup = BezierFormGroup(items: items)

    let stackView = try #require(Self.contentStackView(in: formGroup))
    #expect(stackView.axis == .vertical)
    #expect(stackView.alignment == .leading)
    #expect(stackView.arrangedSubviews == items)
  }

  @Test("setItems는 전체 교체, addItem은 끝에 추가한다")
  func setAndAddItems() throws {
    let formGroup = BezierFormGroup(items: Self.makeItems(2))

    formGroup.setItems(Self.makeItems(4))
    #expect(formGroup.items.count == 4)

    let appended = UIView()
    formGroup.addItem(appended)
    #expect(formGroup.items.count == 5)

    let stackView = try #require(Self.contentStackView(in: formGroup))
    #expect(stackView.arrangedSubviews.count == 5)
    #expect(stackView.arrangedSubviews.last === appended)
  }

  @Test("spacing 변경이 스택 간격에 반영된다")
  func spacingUpdates() {
    let formGroup = BezierFormGroup(items: Self.makeItems(2))

    formGroup.spacing = 12
    #expect(Self.contentStackView(in: formGroup)?.spacing == 12)
  }

  @Test("40pt 행 3개가 4pt 간격으로 배치된다 (y = 0/44/88, 전체 높이 128)")
  func rowsLayoutWithDefaultSpacing() {
    let items = Self.makeItems(3, width: 160, height: 40)
    let formGroup = BezierFormGroup(items: items)

    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    window.addSubview(formGroup)
    NSLayoutConstraint.activate([
      formGroup.topAnchor.constraint(equalTo: window.topAnchor),
      formGroup.leadingAnchor.constraint(equalTo: window.leadingAnchor),
    ])
    window.layoutIfNeeded()

    #expect(items[0].frame.minY == 0)
    #expect(items[1].frame.minY == 44)
    #expect(items[2].frame.minY == 88)
    #expect(formGroup.bounds.height == 128)
  }

  @Test("VoiceOver 그룹핑이 켜져 있다")
  func accessibilityGrouping() {
    let formGroup = BezierFormGroup()

    #expect(formGroup.shouldGroupAccessibilityChildren)
  }

  // MARK: - Helpers

  private static func makeItems(_ count: Int) -> [UIView] {
    (0..<count).map { _ in UIView() }
  }

  private static func makeItems(_ count: Int, width: CGFloat, height: CGFloat) -> [UIView] {
    (0..<count).map { _ in
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: width),
        view.heightAnchor.constraint(equalToConstant: height),
      ])
      return view
    }
  }

  private static func contentStackView(in view: UIView) -> UIStackView? {
    for subview in view.subviews {
      if let stackView = subview as? UIStackView { return stackView }
      if let found = self.contentStackView(in: subview) { return found }
    }
    return nil
  }
}
