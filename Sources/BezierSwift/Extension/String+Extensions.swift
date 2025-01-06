//
//  Optinal+Extensions.swift
//  
//
//  Created by woody on 2023/07/27.
//

import UIKit

enum StringTagType: String {
  case bold = "b"
  case underline = "u"
}

extension String {
  func applyBezierFont(
    height: CGFloat,
    font: UIFont,
    color: UIColor,
    letterSpacing: CGFloat,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = lineBreakMode
    paragraphStyle.minimumLineHeight = height
    paragraphStyle.alignment = alignment
    
    if lineBreakMode == .byWordWrapping {
      paragraphStyle.lineBreakStrategy = .hangulWordPriority
    }
    
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: color,
      .font: font,
      .kern: letterSpacing,
      .paragraphStyle: paragraphStyle,
      .baselineOffset: (paragraphStyle.minimumLineHeight - font.lineHeight) / 4
    ]
    
    let attrText = NSMutableAttributedString(string: self)
    attrText.addAttributes(attributes, range: NSRange(location: 0, length: self.utf16.count))
    return attrText
  }
  
  func applyBezierTagFont(
    normalFont: BezierFont,
    normalColor: BezierColor,
    boldFont: BezierFont,
    boldColor: BezierColor,
    underlineStyle: NSUnderlineStyle = .single,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSAttributedString {
    let normalParagraphStyle = NSMutableParagraphStyle()
    normalParagraphStyle.lineBreakMode = lineBreakMode
    normalParagraphStyle.minimumLineHeight = normalFont.lineHeight
    normalParagraphStyle.alignment = alignment
    
    let blodParagraphStyle = NSMutableParagraphStyle()
    blodParagraphStyle.lineBreakMode = lineBreakMode
    blodParagraphStyle.minimumLineHeight = boldFont.lineHeight
    blodParagraphStyle.alignment = alignment
    
    if lineBreakMode == .byWordWrapping {
      normalParagraphStyle.lineBreakStrategy = .hangulWordPriority
      blodParagraphStyle.lineBreakStrategy = .hangulWordPriority
    }
    
    let normalAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: normalColor.uiColor,
      .font: normalFont.font,
      .kern: normalFont.letterSpacing,
      .paragraphStyle: normalParagraphStyle,
      .baselineOffset: (normalParagraphStyle.minimumLineHeight - normalFont.uiFont.lineHeight) / 4
    ]
    
    let boldAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: boldColor.uiColor,
      .font: boldFont.font,
      .kern: boldFont.letterSpacing,
      .paragraphStyle: blodParagraphStyle,
      .baselineOffset: (blodParagraphStyle.minimumLineHeight - boldFont.uiFont.lineHeight) / 4
    ]
    
    let underlineAttributes: [NSAttributedString.Key: Any] = [
      .underlineStyle: underlineStyle.rawValue
    ]
    
    return self.attributes(
      normalAttributes,
      tagAttributes: [
        .bold: boldAttributes,
        .underline: underlineAttributes
      ]
    )
  }
  
  func attributes(
    _ attributes: [NSAttributedString.Key: Any],
    tagAttributes: [StringTagType: [NSAttributedString.Key: Any]]? = nil) -> NSAttributedString {
      let keyString = self.replace("<br />", withString: "\n")
      var attributedString = NSMutableAttributedString(string: keyString)
      
      attributedString.addAttributes(attributes, range: NSRange(location: 0, length: keyString.utf16.count))
      
      if let tagAttributes = tagAttributes {
        for (tag, attrs) in tagAttributes {
          attributedString = attributedString.attributes(with: tag, attributes: attrs)
        }
      }
      
      return attributedString
    }
  
  func attributes(
    with tag: StringTagType? = nil,
    attributes: [NSAttributedString.Key: Any]
  ) -> NSMutableAttributedString {
    let keyString = self.replace("<br />", withString: "\n")
    let attributedString = NSMutableAttributedString(string: keyString)
    
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
          
          adjustLocation = startTag.count + endTag.count
        }
      } catch {
        return attributedString
      }
    }
    
    return attributedString
  }
  
  func replace(_ target: String, withString: String) -> String {
    return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
  }
}

extension String {
  func toRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    
    if self.hasPrefix("#") {
      let start = self.index(self.startIndex, offsetBy: 1)
      let hexColor = String(self[start...])
      
      if hexColor.count == 6 || hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          if hexColor.count == 8 {
            // RGBA 형태
            return (
              red: CGFloat((hexNumber & 0xFF000000) >> 24) / 255,
              green: CGFloat((hexNumber & 0x00FF0000) >> 16) / 255,
              blue: CGFloat((hexNumber & 0x0000FF00) >> 8) / 255,
              alpha: CGFloat(hexNumber & 0x000000FF) / 255
            )
          } else if hexColor.count == 6 {
            return (
              red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255,
              green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255,
              blue: CGFloat(hexNumber & 0x0000FF) / 255,
              alpha: 1
            )
          }
        }
      }
    }
    
    return (red: 1, green: 1, blue: 1, alpha: 1)
  }
}
