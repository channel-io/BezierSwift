//
//  BezierFont.swift
//
//
//  Created by Tom on 2/7/24.
//

import SwiftUI

public enum BezierFontType {
  case normal
  case bold
}

public enum BezierFont {
  case normal11
  case bold11
  case normal12
  case bold12
  case normal13
  case bold13
  case normal14
  case bold14
  case normal15
  case bold15
  case normal16
  case bold16
  case normal17
  case bold17
  case normal18
  case bold18
  case normal22
  case bold22
  case normal24
  case bold24
  case normal30
  case bold30
  case bold36
  case bold44
}

public extension BezierFont {
  var fontType: BezierFontType {
    switch self {
    case
        .normal11,
        .normal12,
        .normal13,
        .normal14,
        .normal15,
        .normal16,
        .normal17,
        .normal18,
        .normal22,
        .normal24,
        .normal30:
      return .normal
      
    case
        .bold11,
        .bold12,
        .bold13,
        .bold14,
        .bold15,
        .bold16,
        .bold17,
        .bold18,
        .bold22,
        .bold24,
        .bold30,
        .bold36,
        .bold44:
      return .bold
    }
  }
  
  var fontSize: CGFloat {
    switch self {
    case .normal11, .bold11: return 11
    case .normal12, .bold12: return 12
    case .normal13, .bold13: return 13
    case .normal14, .bold14: return 14
    case .normal15, .bold15: return 15
    case .normal16, .bold16: return 16
    case .normal17, .bold17: return 17
    case .normal18, .bold18: return 18
    case .normal22, .bold22: return 22
    case .normal24, .bold24: return 24
    case .normal30, .bold30: return 30
    case .bold36: return 36
    case .bold44: return 44
    }
  }
  
  var font: Font {
    switch self.fontType {
    case .normal: return self.getNormalFont(size: self.fontSize)
    case .bold: return self.getBoldFont(size: self.fontSize)
    }
  }
  
  var uiFont: UIFont {
    switch self.fontType {
    case .normal: return self.getNormalUIFont(size: self.fontSize)
    case .bold: return self.getBoldUIFont(size: self.fontSize)
    }
  }
  
  var lineHeight: CGFloat {
    switch self {
    case .normal11: return CGFloat(16)
    case .bold11: return CGFloat(16)
    case .normal12: return CGFloat(16)
    case .bold12: return CGFloat(16)
    case .normal13: return CGFloat(18)
    case .bold13: return CGFloat(18)
    case .normal14: return CGFloat(18)
    case .bold14: return CGFloat(18)
    case .normal15: return CGFloat(20)
    case .bold15: return CGFloat(20)
    case .normal16: return CGFloat(22)
    case .bold16: return CGFloat(22)
    case .normal17: return CGFloat(22)
    case .bold17: return CGFloat(22)
    case .normal18: return CGFloat(24)
    case .bold18: return CGFloat(24)
    case .normal22: return CGFloat(28)
    case .bold22: return CGFloat(28)
    case .normal24: return CGFloat(32)
    case .bold24: return CGFloat(32)
    case .normal30: return CGFloat(36)
    case .bold30: return CGFloat(36)
    case .bold36: return CGFloat(44)
    case .bold44: return CGFloat(53)
    }
  }
  
  var lineSpacing: CGFloat {
    switch self {
    case .normal11: return CGFloat(2.6)
    case .bold11: return CGFloat(2.6)
    case .normal12: return CGFloat(1.6)
    case .bold12: return CGFloat(1.6)
    case .normal13: return CGFloat(2.3)
    case .bold13: return CGFloat(2.3)
    case .normal14: return CGFloat(1)
    case .bold14: return CGFloat(1)
    case .normal15: return CGFloat(2)
    case .bold15: return CGFloat(2)
    case .normal16: return CGFloat(2.6)
    case .bold16: return CGFloat(2.6)
    case .normal17: return CGFloat(1.6)
    case .bold17: return CGFloat(1.6)
    case .normal18: return CGFloat(2.3)
    case .bold18: return CGFloat(2.3)
    case .normal22: return CGFloat(1.6)
    case .bold22: return CGFloat(1.6)
    case .normal24: return CGFloat(3.3)
    case .bold24: return CGFloat(3.3)
    case .normal30: return CGFloat(0)
    case .bold30: return CGFloat(0)
    case .bold36: return CGFloat(1)
    case .bold44: return CGFloat(0.3)
    }
  }
  
  var verticalPadding: CGFloat {
    return self.lineSpacing / 2
  }
  
  var letterSpacing: CGFloat {
    switch self {
    case .normal11: return CGFloat(0)
    case .bold11: return CGFloat(0)
    case .normal12: return CGFloat(0)
    case .bold12: return CGFloat(0)
    case .normal13: return CGFloat(0)
    case .bold13: return CGFloat(0)
    case .normal14: return CGFloat(0)
    case .bold14: return CGFloat(0)
    case .normal15: return -CGFloat(0.1)
    case .bold15: return -CGFloat(0.1)
    case .normal16: return -CGFloat(0.1)
    case .bold16: return -CGFloat(0.1)
    case .normal17: return -CGFloat(0.1)
    case .bold17: return -CGFloat(0.1)
    case .normal18: return CGFloat(0)
    case .bold18: return CGFloat(0)
    case .normal22: return -CGFloat(0.4)
    case .bold22: return -CGFloat(0.4)
    case .normal24: return -CGFloat(0.4)
    case .bold24: return -CGFloat(0.4)
    case .normal30: return -CGFloat(0.4)
    case .bold30: return -CGFloat(0.4)
    case .bold36: return -CGFloat(1.0)
    case .bold44: return -CGFloat(1.0)
    }
  }
}

extension BezierFont {
  var getPairedBoldFont: BezierFont {
    switch self {
    case .normal11: return .bold11
    case .normal12: return .bold12
    case .normal13: return .bold13
    case .normal14: return .bold14
    case .normal15: return .bold15
    case .normal16: return .bold16
    case .normal17: return .bold17
    case .normal18: return .bold18
    case .normal22: return .bold22
    case .normal24: return .bold24
    case .normal30: return .bold30
    default: return self
    }
  }
  
  func getNormalFont(size: CGFloat) -> Font {
    return Font(FontFamily.Pretendard.regular.font(size: size))
  }
  
  func getNormalUIFont(size: CGFloat) -> UIFont {
    return FontFamily.Pretendard.regular.font(size: size)
  }
  
  func getBoldFont(size: CGFloat) -> Font {
    return Font(FontFamily.Pretendard.bold.font(size: size))
  }
  
  func getBoldUIFont(size: CGFloat) -> UIFont {
    return FontFamily.Pretendard.bold.font(size: size)
  }
}

