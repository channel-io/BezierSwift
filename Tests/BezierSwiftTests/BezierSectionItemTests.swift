import Testing
import UIKit
@testable import BezierSwift

// MARK: - Size Spec 해석

@Suite("BezierSectionItemSize Spec 해석")
struct BezierSectionItemSizeTests {
  @Test("min-height는 40/48/52다")
  func minHeights() {
    #expect(BezierSectionItemSize.small.minHeight == 40)
    #expect(BezierSectionItemSize.medium.minHeight == 48)
    #expect(BezierSectionItemSize.large.minHeight == 52)
  }

  @Test("상하 패딩은 6/8/6이다")
  func verticalPaddings() {
    #expect(BezierSectionItemSize.small.verticalPadding == 6)
    #expect(BezierSectionItemSize.medium.verticalPadding == 8)
    #expect(BezierSectionItemSize.large.verticalPadding == 6)
  }

  @Test("leading 길이는 icon/avatar 24/24/36, custom 20/20/36이다")
  func leadingLengths() {
    #expect(BezierSectionItemSize.small.leadingLength == 24)
    #expect(BezierSectionItemSize.medium.leadingLength == 24)
    #expect(BezierSectionItemSize.large.leadingLength == 36)
    #expect(BezierSectionItemSize.small.customLeadingLength == 20)
    #expect(BezierSectionItemSize.medium.customLeadingLength == 20)
    #expect(BezierSectionItemSize.large.customLeadingLength == 36)
  }

  @Test("description은 large만 nested다")
  func descriptionNesting() {
    #expect(BezierSectionItemSize.small.isDescriptionNested == false)
    #expect(BezierSectionItemSize.medium.isDescriptionNested == false)
    #expect(BezierSectionItemSize.large.isDescriptionNested == true)
  }
}

// MARK: - Leading 해석

@Suite("BezierSectionItemLeading 해석")
@MainActor
struct BezierSectionItemLeadingTests {
  @Test("custom 판별과 leading 길이 선택")
  func customLeadingLength() {
    let custom = BezierSectionItemLeading<UIView>.custom(UIView())
    let icon = BezierSectionItemLeading<UIView>.icon(.folder)
    let none = BezierSectionItemLeading<UIView>.none

    #expect(custom.isCustom)
    #expect(custom.hasLeadingContent)
    #expect(custom.leadingLength(size: .medium) == 20)
    #expect(icon.isCustom == false)
    #expect(icon.leadingLength(size: .medium) == 24)
    #expect(none.hasLeadingContent == false)
  }
}

// MARK: - Accessory

@Suite("BezierSectionItemAccessory", .serialized)
@MainActor
struct BezierSectionItemAccessoryTests {
  @Test("multiselect 값은 콤마로 결합된다")
  func multiselectJoin() {
    #expect(BezierSectionItemConstant.multiselectText(values: ["Value1", "Value2"]) == "Value1, Value2")
  }

  @Test("toggle 표시자는 isOn에 따라 thumb 실측 위치가 바뀐다")
  func toggleThumbPosition() {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let toggle = BezierSectionItemToggleView()
    window.addSubview(toggle)
    NSLayoutConstraint.activate([
      toggle.leadingAnchor.constraint(equalTo: window.leadingAnchor),
      toggle.topAnchor.constraint(equalTo: window.topAnchor),
    ])

    toggle.isOn = false
    window.layoutIfNeeded()
    let thumb = toggle.subviews.first
    #expect(thumb?.frame.minX == BezierSectionItemConstant.toggleThumbInset)

    toggle.isOn = true
    window.layoutIfNeeded()
    let onLeading = BezierSectionItemConstant.toggleWidth
      - BezierSectionItemConstant.toggleThumbInset
      - BezierSectionItemConstant.toggleThumbLength
    #expect(thumb?.frame.minX == onLeading)
  }

  @Test("accessory 뷰는 높이 32 제약을 가진다")
  func accessoryHeight() {
    #expect(BezierSectionItemConstant.accessoryHeight == 32)
  }
}

// MARK: - UIKit 구조

@Suite("BezierSectionItem UIKit 구조", .serialized)
@MainActor
struct BezierSectionItemStructureTests {
  @Test("custom leading은 description과 centerSlot을 숨긴다")
  func customHidesDescriptionAndCenterSlot() {
    let item = BezierSectionItem(content: "Label", description: "desc")
    let slotView = UIView()
    item.centerSlot = slotView
    item.leading = .custom(UIView())

    let labels = Self.allLabels(in: item)
    let visibleDescription = labels.contains {
      $0.attributedText?.string == "desc" && !$0.isHidden
    }
    #expect(visibleDescription == false)
    #expect(slotView.superview?.isHidden == true)
  }

  @Test("custom leading 이후에 설정한 centerSlot도 숨겨진다")
  func centerSlotSetAfterCustomLeadingStaysHidden() {
    let item = BezierSectionItem(content: "Label")
    item.leading = .custom(UIView())

    let slotView = UIView()
    item.centerSlot = slotView
    #expect(slotView.superview?.isHidden == true)

    item.leading = .icon(.folder)
    #expect(slotView.superview?.isHidden == false)
  }

  @Test("onTap이 없으면 상호작용이 비활성화된다")
  func nonInteractiveWithoutOnTap() {
    let item = BezierSectionItem(content: "Label")
    #expect(item.isUserInteractionEnabled == false)

    item.onTap = {}
    #expect(item.isUserInteractionEnabled)
  }

  @Test("disabled면 alpha가 0.4다")
  func disabledAlpha() {
    let item = BezierSectionItem(content: "Label", onTap: {})
    item.isEnabled = false
    #expect(abs(item.alpha - 0.4) < 0.001)
  }

  private static func allLabels(in view: UIView) -> [UILabel] {
    var result: [UILabel] = []
    for subview in view.subviews {
      if let label = subview as? UILabel { result.append(label) }
      result.append(contentsOf: self.allLabels(in: subview))
    }
    return result
  }
}
