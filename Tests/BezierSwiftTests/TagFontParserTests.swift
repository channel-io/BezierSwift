import Testing
import UIKit
@testable import BezierSwift

// MARK: - NSAttributedString 태그 파서 테스트 (V1/V3 공통 경로)

@Suite("NSAttributedString Tag Parser")
struct NSAttributedStringTagParserTests {
  @Test("단일 bold 태그 파싱")
  func singleBoldTag() {
    let input = NSAttributedString(string: "Hello <b>World</b>")
    let normalAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "Hello World")
    #expect(!result.string.contains("<b>"))
    #expect(!result.string.contains("</b>"))

    let boldRange = (result.string as NSString).range(of: "World")
    let attrs = result.attributes(at: boldRange.location, effectiveRange: nil)
    let font = attrs[.font] as! UIFont
    #expect(font == UIFont.boldSystemFont(ofSize: 14))
  }

  @Test("다중 bold 태그 파싱 — adjustLocation 누적 검증")
  func multipleBoldTags() {
    let input = NSAttributedString(string: "<b>First</b> and <b>Second</b>")
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "First and Second")

    // First에 bold 적용 확인
    let firstRange = (result.string as NSString).range(of: "First")
    let firstAttrs = result.attributes(at: firstRange.location, effectiveRange: nil)
    let firstFont = firstAttrs[.font] as! UIFont
    #expect(firstFont == UIFont.boldSystemFont(ofSize: 14))

    // Second에 bold 적용 확인
    let secondRange = (result.string as NSString).range(of: "Second")
    let secondAttrs = result.attributes(at: secondRange.location, effectiveRange: nil)
    let secondFont = secondAttrs[.font] as! UIFont
    #expect(secondFont == UIFont.boldSystemFont(ofSize: 14))
  }

  @Test("3개 이상 bold 태그 — 누적 오프셋")
  func tripleBoldTags() {
    let input = NSAttributedString(string: "<b>A</b> <b>B</b> <b>C</b>")
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "A B C")

    for char in ["A", "B", "C"] {
      let range = (result.string as NSString).range(of: char)
      let attrs = result.attributes(at: range.location, effectiveRange: nil)
      let font = attrs[.font] as! UIFont
      #expect(font == UIFont.boldSystemFont(ofSize: 14), "'\(char)' should be bold")
    }
  }

  @Test("underline 태그 파싱")
  func underlineTag() {
    let input = NSAttributedString(string: "Click <u>here</u> now")
    let underlineAttrs: [NSAttributedString.Key: Any] = [
      .underlineStyle: NSUnderlineStyle.single.rawValue,
    ]

    let result = input.attributes(with: .underline, attributes: underlineAttrs)

    #expect(result.string == "Click here now")

    let hereRange = (result.string as NSString).range(of: "here")
    let attrs = result.attributes(at: hereRange.location, effectiveRange: nil)
    let underline = attrs[.underlineStyle] as? Int
    #expect(underline == NSUnderlineStyle.single.rawValue)
  }

  @Test("태그 없는 문자열은 변경 없이 반환")
  func noTags() {
    let input = NSAttributedString(string: "No tags here")
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "No tags here")
  }
}

// MARK: - String 태그 파서 테스트 (레거시 경로)

@Suite("String Tag Parser (Legacy)")
struct StringTagParserTests {
  @Test("단일 bold 태그 파싱")
  func singleBoldTag() {
    let input = "Hello <b>World</b>"
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "Hello World")
  }

  @Test("다중 bold 태그 파싱 — adjustLocation 누적 검증")
  func multipleBoldTags() {
    let input = "<b>First</b> and <b>Second</b>"
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "First and Second")

    // Second에 bold 적용 확인
    let secondRange = (result.string as NSString).range(of: "Second")
    #expect(secondRange.location != NSNotFound, "Second should exist in result")
    let secondAttrs = result.attributes(at: secondRange.location, effectiveRange: nil)
    let secondFont = secondAttrs[.font] as? UIFont
    #expect(secondFont == UIFont.boldSystemFont(ofSize: 14), "Second should be bold")
  }

  @Test("3개 이상 bold 태그")
  func tripleBoldTags() {
    let input = "<b>A</b> <b>B</b> <b>C</b>"
    let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]

    let result = input.attributes(with: .bold, attributes: boldAttrs)

    #expect(result.string == "A B C")

    for char in ["A", "B", "C"] {
      let range = (result.string as NSString).range(of: char)
      #expect(range.location != NSNotFound, "'\(char)' should exist")
      let attrs = result.attributes(at: range.location, effectiveRange: nil)
      let font = attrs[.font] as? UIFont
      #expect(font == UIFont.boldSystemFont(ofSize: 14), "'\(char)' should be bold")
    }
  }
}

// MARK: - V1/V3 통합 경로 테스트 (attributes(_:tagAttributes:))

@Suite("Integrated Tag Font Path")
struct IntegratedTagFontPathTests {
  @Test("다중 bold 태그 — V1/V3 공통 attributes(_:tagAttributes:) 경로")
  func multiTagThroughIntegratedPath() {
    let input = "<b>Hello</b> world <b>foo</b>"
    let normalAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 14),
      .foregroundColor: UIColor.black,
    ]
    let boldAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 14),
      .foregroundColor: UIColor.red,
    ]

    let result = input.attributes(
      normalAttrs,
      tagAttributes: [.bold: boldAttrs]
    )

    #expect(result.string == "Hello world foo")

    // Hello — bold
    let helloRange = (result.string as NSString).range(of: "Hello")
    let helloAttrs = result.attributes(at: helloRange.location, effectiveRange: nil)
    #expect((helloAttrs[.font] as? UIFont) == UIFont.boldSystemFont(ofSize: 14))

    // world — normal
    let worldRange = (result.string as NSString).range(of: "world")
    let worldAttrs = result.attributes(at: worldRange.location, effectiveRange: nil)
    #expect((worldAttrs[.font] as? UIFont) == UIFont.systemFont(ofSize: 14))

    // foo — bold
    let fooRange = (result.string as NSString).range(of: "foo")
    let fooAttrs = result.attributes(at: fooRange.location, effectiveRange: nil)
    #expect((fooAttrs[.font] as? UIFont) == UIFont.boldSystemFont(ofSize: 14))
  }

  @Test("bold + underline 혼합 태그")
  func mixedBoldAndUnderline() {
    let input = "<b>Bold</b> and <u>Underline</u>"
    let normalAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.systemFont(ofSize: 14),
    ]
    let boldAttrs: [NSAttributedString.Key: Any] = [
      .font: UIFont.boldSystemFont(ofSize: 14),
    ]
    let underlineAttrs: [NSAttributedString.Key: Any] = [
      .underlineStyle: NSUnderlineStyle.single.rawValue,
    ]

    let result = input.attributes(
      normalAttrs,
      tagAttributes: [
        .bold: boldAttrs,
        .underline: underlineAttrs,
      ]
    )

    #expect(result.string == "Bold and Underline")

    let boldRange = (result.string as NSString).range(of: "Bold")
    let boldResultAttrs = result.attributes(at: boldRange.location, effectiveRange: nil)
    #expect((boldResultAttrs[.font] as? UIFont) == UIFont.boldSystemFont(ofSize: 14))

    let underlineRange = (result.string as NSString).range(of: "Underline")
    let underlineResultAttrs = result.attributes(at: underlineRange.location, effectiveRange: nil)
    #expect(underlineResultAttrs[.underlineStyle] as? Int == NSUnderlineStyle.single.rawValue)
  }
}
