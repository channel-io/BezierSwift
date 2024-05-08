//
//  BezierFont.swift
//
//
//  Created by Tom on 2/7/24.
//

import SwiftUI

public enum BezierFontType {
  case regular
  case semiBold
  case bold
}

public enum BezierFont {
  case caption1Regular
  case caption1SemiBold
  case caption2Regular
  case caption2SemiBold
  case caption3Regular
  case caption3SemiBold
  case caption4Regular
  case caption4SemiBold
 
  case body1Regular
  case body1SemiBold
  case body2Regular
  case body2SemiBold

  case title1Regular
  case title1Bold
  case title2Regular
  case title2SemiBold
  case title2Bold
  case title3Regular
  case title3SemiBold
  case title3Bold
  
  case heading1Bold
}

public extension BezierFont {
  var fontType: BezierFontType {
    switch self {
    case
        .caption1Regular,
        .caption2Regular,
        .caption3Regular,
        .caption4Regular,
        .body1Regular,
        .body2Regular,
        .title1Regular,
        .title2Regular,
        .title3Regular
      :
      return .regular
      
    case
        .caption1SemiBold,
        .caption2SemiBold,
        .caption3SemiBold,
        .caption4SemiBold,
        .body1SemiBold,
        .body2SemiBold,
        .title2SemiBold,
        .title3SemiBold
      :
      return .semiBold
      
    case
        .title1Bold,
        .title2Bold,
        .title3Bold,
        .heading1Bold
      :
      return .bold
    }
  }
  
  var fontSize: CGFloat {
    switch self {
    case .caption4Regular, .caption4SemiBold: return 11
    case .caption3Regular, .caption3SemiBold: return 12
    case .caption2Regular, .caption2SemiBold: return 13
    case .caption1Regular, .caption1SemiBold: return 14
    case .body2Regular, .body2SemiBold: return 15
    case .body1Regular, .body1SemiBold: return 16
    case .title3Regular, .title3SemiBold, .title3Bold: return 17
    case .title2Regular, .title2SemiBold, .title2Bold: return 18
    case .title1Regular, .title1Bold: return 24
    case .heading1Bold: return 30
    }
  }
  
  var font: Font {
    switch self.fontType {
    case .regular: return self.getRegularFont(size: self.fontSize)
    case .semiBold: return self.getSemiBoldFont(size: self.fontSize)
    case .bold: return self.getBoldFont(size: self.fontSize)
    }
  }
  
  var uiFont: UIFont {
    switch self.fontType {
    case .regular: return self.getRegularUIFont(size: self.fontSize)
    case .semiBold: return self.getSemiBoldUIFont(size: self.fontSize)
    case .bold: return self.getBoldUIFont(size: self.fontSize)
    }
  }
}

extension BezierFont {
  func getRegularFont(size: CGFloat) -> Font {
    return Font(FontFamily.Pretendard.regular.font(size: size))
  }
  
  func getRegularUIFont(size: CGFloat) -> UIFont {
    return FontFamily.Pretendard.regular.font(size: size)
  }
  
  func getSemiBoldFont(size: CGFloat) -> Font {
    return Font(FontFamily.Pretendard.bold.font(size: size))
  }
  
  func getSemiBoldUIFont(size: CGFloat) -> UIFont {
    return FontFamily.Pretendard.bold.font(size: size)
  }
  
  func getBoldFont(size: CGFloat) -> Font {
    return Font(FontFamily.Pretendard.bold.font(size: size))
  }
  
  func getBoldUIFont(size: CGFloat) -> UIFont {
    return FontFamily.Pretendard.bold.font(size: size)
  }
}

