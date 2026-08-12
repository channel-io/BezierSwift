//
//  String+TagRuns.swift
//  BezierSwift
//

import Foundation

/// 태그 서식이 적용된 텍스트 조각.
struct BezierTagRun: Equatable {
  let text: String
  let isBold: Bool
  let isUnderlined: Bool
}

private extension NSAttributedString.Key {
  static let bezierTagBold = NSAttributedString.Key("bezierTagBold")
  static let bezierTagUnderline = NSAttributedString.Key("bezierTagUnderline")
}

extension String {
  /// `<b>`·`<u>`·`<br />` 태그를 파싱해 서식 조각으로 쪼갠다.
  ///
  /// SwiftUI `Text`는 `NSAttributedString`을 그대로 받으면 `paragraphStyle`을 무시해 UIKit과 행높이가 어긋난다. 그래서 서식을 조각 단위로 옮겨 `Text`를 잇는데, 파싱만은 UIKit 경로와 같은 파서를 타게 해 두 구현의 태그 해석이 갈라지지 않게 한다.
  func bezierTagRuns() -> [BezierTagRun] {
    let parsed = self.attributes(
      [:],
      tagAttributes: [
        .bold: [.bezierTagBold: true],
        .underline: [.bezierTagUnderline: true],
      ]
    )

    let text = parsed.string as NSString
    var runs: [BezierTagRun] = []
    parsed.enumerateAttributes(
      in: NSRange(location: 0, length: parsed.length),
      options: []
    ) { attributes, range, _ in
      runs.append(
        BezierTagRun(
          text: text.substring(with: range),
          isBold: attributes[.bezierTagBold] != nil,
          isUnderlined: attributes[.bezierTagUnderline] != nil
        )
      )
    }
    return runs
  }
}
