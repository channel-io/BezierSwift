import Foundation

/// 토큰 enum case에서 표시용 이름을 만든다. 카탈로그가 이름을 따로 들고 있지 않게 하려는 것이다.
enum TokenName {
  /// case 이름. associated value는 잘라낸다.
  /// `textXXLarge(weight: BezierSwift.BTFontWeight.regular)` → `textXXLarge`
  static func caseName<T>(_ value: T) -> String {
    String(String(describing: value).prefix { $0 != "(" })
  }

  /// case 이름을 Figma 토큰 표기(kebab-case)로 바꾼다.
  /// `borderNeutralHeavy` → `border-neutral-heavy`, `chartThemeDefault01` → `chart-theme-default-01`
  static func kebab<T>(_ value: T) -> String {
    self.segments(value).joined(separator: "-")
  }

  /// case 이름을 소문자 세그먼트로 쪼갠다. 카탈로그 그룹 키로도 쓴다.
  ///
  /// 연속된 대문자는 뒤따르는 단어까지 한 세그먼트로 묶는다 — `textXXLarge`는 `["text", "xxlarge"]`다.
  /// Figma 토큰 이름이 `text-xxlarge`이므로 `xx-large`로 쪼개면 SSOT와 어긋난다.
  static func segments<T>(_ value: T) -> [String] {
    var segments: [String] = []
    var current = ""
    var previous: Character?

    for character in self.caseName(value) {
      let startsNewSegment: Bool
      if character.isUppercase {
        startsNewSegment = previous.map { $0.isLowercase || $0.isNumber } ?? false
      } else if character.isNumber {
        startsNewSegment = previous?.isLetter ?? false
      } else {
        startsNewSegment = false
      }

      if startsNewSegment, !current.isEmpty {
        segments.append(current.lowercased())
        current = ""
      }
      current.append(character)
      previous = character
    }

    if !current.isEmpty {
      segments.append(current.lowercased())
    }
    return segments
  }
}
