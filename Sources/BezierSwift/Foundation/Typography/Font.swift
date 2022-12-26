//
//  Font.swift
//  
//
//  Created by Jam on 2022/12/02.
//

import SwiftUI

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
  case bold36
  case bold44
}

public extension BezierFont {
  var font: Font {
    switch self {
    case .normal11: return self.getNormalFont(size: 11)
    case .bold11: return self.getBoldFont(size: 11)
    case .normal12: return self.getNormalFont(size: 12)
    case .bold12: return self.getBoldFont(size: 12)
    case .normal13: return self.getNormalFont(size: 13)
    case .bold13: return self.getBoldFont(size: 13)
    case .normal14: return self.getNormalFont(size: 14)
    case .bold14: return self.getBoldFont(size: 14)
    case .normal15: return self.getNormalFont(size: 15)
    case .bold15: return self.getBoldFont(size: 15)
    case .normal16: return self.getNormalFont(size: 16)
    case .bold16: return self.getBoldFont(size: 16)
    case .normal17: return self.getNormalFont(size: 17)
    case .bold17: return self.getBoldFont(size: 17)
    case .normal18: return self.getNormalFont(size: 18)
    case .bold18: return self.getBoldFont(size: 18)
    case .normal22: return self.getNormalFont(size: 22)
    case .bold22: return self.getBoldFont(size: 22)
    case .normal24: return self.getNormalFont(size: 24)
    case .bold24: return self.getBoldFont(size: 24)
    case .bold36: return self.getBoldFont(size: 36)
    case .bold44: return self.getBoldFont(size: 44)
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
    case .bold36: return CGFloat(44)
    case .bold44: return CGFloat(53)
    }
  }
  
  var lineSpacing: CGFloat {
    switch self {
    case .normal11: return CGFloat(2.7)
    case .bold11: return CGFloat(2.7)
    case .normal12: return CGFloat(1.5)
    case .bold12: return CGFloat(1.5)
    case .normal13: return CGFloat(2.5)
    case .bold13: return CGFloat(2.5)
    case .normal14: return CGFloat(1.4)
    case .bold14: return CGFloat(1.4)
    case .normal15: return CGFloat(2)
    case .bold15: return CGFloat(2)
    case .normal16: return CGFloat(3)
    case .bold16: return CGFloat(3)
    case .normal17: return CGFloat(1.8)
    case .bold17: return CGFloat(1.8)
    case .normal18: return CGFloat(2.5)
    case .bold18: return CGFloat(2.5)
    case .normal22: return CGFloat(1.8)
    case .bold22: return CGFloat(1.8)
    case .normal24: return CGFloat(3.2)
    case .bold24: return CGFloat(3.2)
    case .bold36: return CGFloat(1.1)
    case .bold44: return CGFloat(0.5)
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
    case .bold36: return -CGFloat(1.0)
    case .bold44: return -CGFloat(1.0)
    }
  }
}

private extension BezierFont {
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
    default: return self
    }
  }
  
  func getNormalFont(size: CGFloat) -> Font {
    return .system(size: size, weight: .regular)
  }
  
  func getBoldFont(size: CGFloat) -> Font {
    return .system(size: size, weight: .bold)
  }
}
