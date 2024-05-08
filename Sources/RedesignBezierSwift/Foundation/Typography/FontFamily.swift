//
//  File.swift
//  
//
//  Created by Tom on 2/7/24.
//

import UIKit.UIFont

enum FontFamily {
  enum Pretendard {
    static let bold = FontConvertible(name: "Pretendard-Bold", family: "Pretendard", path: "Pretendard-Bold.otf")
    static let regular = FontConvertible(name: "Pretendard-Regular", family: "Pretendard", path: "Pretendard-Regular.otf")
    static let semiBold = FontConvertible(name: "Pretendard-SemiBold", family: "Pretendard", path: "Pretendard-SemiBold.otf")
    static let all: [FontConvertible] = [bold, regular, semiBold]
  }
  static let allCustomFonts: [FontConvertible] = [Pretendard.all].flatMap { $0 }
  static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}

struct FontConvertible {
  fileprivate let name: String
  fileprivate let family: String
  fileprivate let path: String

  typealias Font = UIFont

  func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(self.name)' (\(self.family))")
    }
    return font
  }

  func register() {
    guard let url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    return Bundle.module.url(forResource: self.path, withExtension: nil)
  }
}

extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }

    self.init(name: font.name, size: size)
  }
}
