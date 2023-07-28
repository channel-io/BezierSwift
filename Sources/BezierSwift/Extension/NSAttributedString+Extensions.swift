//
//  NSAttributedString+Extensions.swift
//  
//
//  Created by woody on 2023/07/27.
//

import UIKit

extension NSAttributedString {
  func attributes(
    with tag: StringTagType? = nil,
    attributes: [NSAttributedString.Key: Any]
  ) -> NSMutableAttributedString {
    let keyString = self.string
    let attributedString = NSMutableAttributedString(attributedString: self)

    if tag == nil {
      attributedString.addAttributes(attributes, range: NSRange(location: 0, length: keyString.utf16.count))
      return attributedString
    }

    if let tag = tag {
      do {
        let pattern = "<\(tag.rawValue)>(.*?)</\(tag.rawValue)>"
        let startTag = "<\(tag.rawValue)>"
        let endTag = "</\(tag.rawValue)>"

        let regex = try NSRegularExpression(pattern: pattern) // \(startTag)(.*)\(endTag)")
        let results = regex.matches(in: keyString, range: NSRange(keyString.startIndex..., in: keyString))

        var adjustLocation = 0
        results.forEach { result in
          let regexResultRange = NSRange(location: result.range.location - adjustLocation, length: result.range.length)
          attributedString.addAttributes(attributes, range: regexResultRange)
          let startTagRange = NSRange(location: result.range.location - adjustLocation, length: startTag.count)
          let endTagRange = NSRange(
            location: result.range.location - adjustLocation + result.range.length - endTag.count,
            length: endTag.count
          )

          attributedString.replaceCharacters(in: endTagRange, with: "")
          attributedString.replaceCharacters(in: startTagRange, with: "")

          adjustLocation += startTag.count + endTag.count
        }
      } catch {
        return attributedString
      }
    }

    return attributedString
  }
}
