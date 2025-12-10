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
    _ component: BezierComponentable,
    normalFont: BezierFont,
    normalColor: SemanticColor,
    boldFont: BezierFont,
    boldColor: SemanticColor,
    underlineStyle: NSUnderlineStyle = .single,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSAttributedString {
    return self.applyBezierTagFont(
      normalFont: normalFont,
      normalColor: normalColor.palette(component),
      boldFont: boldFont,
      boldColor: normalColor.palette(component),
      underlineStyle: underlineStyle,
      alignment: alignment,
      lineBreakMode: lineBreakMode
    )
  }

  func applyBezierTagFont(
    _ component: BezierComponentable,
    normalFont: BezierFont,
    normalColor: SemanticColorToken,
    boldFont: BezierFont,
    boldColor: SemanticColorToken,
    underlineStyle: NSUnderlineStyle = .single,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byWordWrapping
  ) -> NSAttributedString {
    return self.applyBezierTagFont(
      normalFont: normalFont,
      normalColor: normalColor.palette(component),
      boldFont: boldFont,
      boldColor: boldColor.palette(component),
      underlineStyle: underlineStyle,
      alignment: alignment,
      lineBreakMode: lineBreakMode
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
  private func applyBezierTagFont(
    normalFont: BezierFont,
    normalColor: UIColor,
    boldFont: BezierFont,
    boldColor: UIColor,
    underlineStyle: NSUnderlineStyle,
    alignment: NSTextAlignment,
    lineBreakMode: NSLineBreakMode
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
      .foregroundColor: normalColor,
      .font: normalFont.font,
      .kern: normalFont.letterSpacing,
      .paragraphStyle: normalParagraphStyle,
      .baselineOffset: (normalParagraphStyle.minimumLineHeight - normalFont.uiFont.lineHeight) / 4
    ]
    
    let boldAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: boldColor,
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
}
