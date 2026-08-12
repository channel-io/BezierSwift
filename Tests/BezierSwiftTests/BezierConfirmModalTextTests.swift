import Testing
import UIKit
@testable import BezierSwift

@Suite("BezierConfirmModal 태그 서식", .serialized)
@MainActor
struct BezierConfirmModalTagStyleTests {
  @Test("설명의 <b> 구간에만 bold 짝 폰트가 적용된다")
  func boldTagAppliesBoldPairFont() throws {
    let modal = makeModal(description: "일반 <b>강조</b> 끝")
    let rendered = try #require(attributedText(matching: "일반 강조 끝", in: modal))

    let typography = BezierConfirmModalSpec.descriptionTypography
    #expect(typography.uiFont != typography.boldPair.uiFont)
    #expect(rendered.attribute(.font, at: 0, effectiveRange: nil) as? UIFont == typography.uiFont)
    #expect(rendered.attribute(.font, at: 3, effectiveRange: nil) as? UIFont == typography.boldPair.uiFont)
  }

  @Test("설명의 <u> 구간에만 밑줄이 적용된다")
  func underlineTagAppliesUnderline() throws {
    let modal = makeModal(description: "보통 <u>밑줄</u>")
    let rendered = try #require(attributedText(matching: "보통 밑줄", in: modal))

    #expect(rendered.attribute(.underlineStyle, at: 0, effectiveRange: nil) == nil)
    #expect(rendered.attribute(.underlineStyle, at: 3, effectiveRange: nil) != nil)
  }

  @Test("<br />는 줄바꿈이 된다")
  func lineBreakTagBecomesNewline() {
    let modal = makeModal(description: "첫 줄<br />둘째 줄")

    #expect(attributedText(matching: "첫 줄\n둘째 줄", in: modal) != nil)
  }

  @Test("태그는 화면에 글자로 남지 않는다")
  func tagsAreStrippedFromRenderedText() {
    let modal = makeModal(title: "<b>제목</b>", description: "<u>설명</u>")

    #expect(attributedText(matching: "제목", in: modal) != nil)
    #expect(attributedText(matching: "설명", in: modal) != nil)
  }

  @Test("태그가 없는 설명은 전 구간이 한 서식으로 렌더된다")
  func plainDescriptionRendersUniformly() throws {
    let modal = makeModal(description: "태그 없는 설명")
    let rendered = try #require(attributedText(matching: "태그 없는 설명", in: modal))

    var effectiveRange = NSRange()
    let font = rendered.attribute(.font, at: 0, effectiveRange: &effectiveRange) as? UIFont

    #expect(font == BezierConfirmModalSpec.descriptionTypography.uiFont)
    #expect(effectiveRange.length == rendered.length)
  }

  @Test("태그를 써도 가운데 정렬과 행높이는 SPEC 값을 유지한다")
  func paragraphStyleFollowsSpec() throws {
    let modal = makeModal(description: "설명 <b>강조</b>")
    let rendered = try #require(attributedText(matching: "설명 강조", in: modal))
    let style = try #require(rendered.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle)

    #expect(style.alignment == .center)
    #expect(style.minimumLineHeight == BezierConfirmModalSpec.descriptionTypography.lineHeight)
  }

  @Test("설명을 nil로 바꾸면 사라진다")
  func settingNilDescriptionHidesIt() {
    let modal = makeModal(description: "설명")
    #expect(attributedText(matching: "설명", in: modal) != nil)

    modal.descriptionText = nil

    #expect(attributedText(matching: "설명", in: modal) == nil)
  }

  @Test("제목을 바꾸면 태그가 다시 해석된다")
  func updatingTitleReparsesTags() {
    let modal = makeModal(title: "처음")

    modal.title = "<b>나중</b>"

    #expect(attributedText(matching: "나중", in: modal) != nil)
    #expect(attributedText(matching: "처음", in: modal) == nil)
  }
}

@Suite("BezierConfirmModal 태그 텍스트 테마 추종", .serialized)
@MainActor
struct BezierConfirmModalTagThemeTests {
  @Test("다크모드에서 태그 텍스트 색이 달라진다")
  func tagTextFollowsDarkMode() throws {
    let modal = makeModal(description: "일반 <b>강조</b>")
    let color = try #require(foregroundColor(matching: "일반 강조", in: modal))

    #expect(resolved(color, style: .light) != resolved(color, style: .dark))
  }

  @Test("componentTheme을 뒤집으면 태그 텍스트 색도 반전된다")
  func tagTextFollowsComponentThemeInversion() throws {
    let modal = makeModal(description: "일반 <b>강조</b>")
    let normal = try #require(foregroundColor(matching: "일반 강조", in: modal))
    let normalDark = resolved(normal, style: .dark)

    modal.componentTheme = .inverted
    let inverted = try #require(foregroundColor(matching: "일반 강조", in: modal))

    #expect(resolved(inverted, style: .light) == normalDark)
  }

  @Test("강조 구간도 나머지와 같은 색을 쓴다")
  func boldRunSharesColorWithRest() throws {
    let modal = makeModal(description: "일반 <b>강조</b>")
    let rendered = try #require(attributedText(matching: "일반 강조", in: modal))

    let normal = try #require(rendered.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor)
    let bold = try #require(rendered.attribute(.foregroundColor, at: 3, effectiveRange: nil) as? UIColor)

    #expect(resolved(normal, style: .light) == resolved(bold, style: .light))
    #expect(resolved(normal, style: .dark) == resolved(bold, style: .dark))
  }
}

// MARK: - Helpers

@MainActor
private func makeModal(title: String = "Title", description: String? = nil) -> BezierConfirmModal {
  BezierConfirmModal(
    title: title,
    description: description,
    confirmAction: BezierConfirmModalAction(title: "Confirm"),
    cancelAction: BezierConfirmModalAction(title: "Cancel")
  )
}

@MainActor
private func label(withText text: String, in view: UIView) -> UILabel? {
  if let label = view as? UILabel, label.attributedText?.string == text, !label.isHidden {
    return label
  }
  for subview in view.subviews {
    if let found = label(withText: text, in: subview) {
      return found
    }
  }
  return nil
}

@MainActor
private func attributedText(matching text: String, in view: UIView) -> NSAttributedString? {
  label(withText: text, in: view)?.attributedText
}

@MainActor
private func foregroundColor(matching text: String, in view: UIView) -> UIColor? {
  attributedText(matching: text, in: view)?
    .attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
}

private func resolved(_ color: UIColor, style: UIUserInterfaceStyle) -> UIColor {
  let traits = UITraitCollection(userInterfaceStyle: style)
  var result = color
  traits.performAsCurrent { result = color.resolvedColor(with: traits) }
  return result
}
