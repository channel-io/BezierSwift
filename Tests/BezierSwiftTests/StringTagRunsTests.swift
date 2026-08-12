import Testing
@testable import BezierSwift

@Suite("태그 문자열 run 분해")
struct StringTagRunsTests {
  @Test("태그가 없으면 조각 하나로 남는다")
  func plainTextYieldsSingleRun() {
    #expect("그냥 텍스트".bezierTagRuns() == [
      BezierTagRun(text: "그냥 텍스트", isBold: false, isUnderlined: false),
    ])
  }

  @Test("<b>는 앞뒤와 분리된 강조 조각이 된다")
  func boldTagSplitsRuns() {
    #expect("앞 <b>강조</b> 뒤".bezierTagRuns() == [
      BezierTagRun(text: "앞 ", isBold: false, isUnderlined: false),
      BezierTagRun(text: "강조", isBold: true, isUnderlined: false),
      BezierTagRun(text: " 뒤", isBold: false, isUnderlined: false),
    ])
  }

  @Test("<u>는 밑줄 조각이 된다")
  func underlineTagSplitsRuns() {
    #expect("<u>밑줄</u>만".bezierTagRuns() == [
      BezierTagRun(text: "밑줄", isBold: false, isUnderlined: true),
      BezierTagRun(text: "만", isBold: false, isUnderlined: false),
    ])
  }

  @Test("강조가 여러 번 나오면 각각 분리된다")
  func multipleBoldTagsSplitIndependently() {
    #expect("<b>가</b>와 <b>나</b>".bezierTagRuns() == [
      BezierTagRun(text: "가", isBold: true, isUnderlined: false),
      BezierTagRun(text: "와 ", isBold: false, isUnderlined: false),
      BezierTagRun(text: "나", isBold: true, isUnderlined: false),
    ])
  }

  @Test("강조와 밑줄이 함께 있어도 각각 제 구간에만 적용된다")
  func boldAndUnderlineCoexist() {
    #expect("<b>강조</b>와 <u>밑줄</u>".bezierTagRuns() == [
      BezierTagRun(text: "강조", isBold: true, isUnderlined: false),
      BezierTagRun(text: "와 ", isBold: false, isUnderlined: false),
      BezierTagRun(text: "밑줄", isBold: false, isUnderlined: true),
    ])
  }

  @Test("<br />는 조각을 나누지 않고 개행 문자가 된다")
  func lineBreakStaysInsideRun() {
    #expect("첫 줄<br />둘째 줄".bezierTagRuns() == [
      BezierTagRun(text: "첫 줄\n둘째 줄", isBold: false, isUnderlined: false),
    ])
  }

  @Test("닫히지 않은 태그는 글자 그대로 남는다")
  func unclosedTagIsLeftAsIs() {
    #expect("<b>닫히지 않음".bezierTagRuns() == [
      BezierTagRun(text: "<b>닫히지 않음", isBold: false, isUnderlined: false),
    ])
  }

  @Test("빈 문자열은 조각이 없다")
  func emptyStringYieldsNoRuns() {
    #expect("".bezierTagRuns().isEmpty)
  }
}
