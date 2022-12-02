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
  case bold30
  case bold36
}

public extension BezierFont {
  var font: Font {
    switch self {
    case .normal11: return self.getNormalFont(size: 11.f)
    case .bold11: return self.getBoldFont(size: 11.f)
    case .normal12: return self.getNormalFont(size: 12.f)
    case .bold12: return self.getBoldFont(size: 12.f)
    case .normal13: return self.getNormalFont(size: 13.f)
    case .bold13: return self.getBoldFont(size: 13.f)
    case .normal14: return self.getNormalFont(size: 14.f)
    case .bold14: return self.getBoldFont(size: 14.f)
    case .normal15: return self.getNormalFont(size: 15.f)
    case .bold15: return self.getBoldFont(size: 15.f)
    case .normal16: return self.getNormalFont(size: 16.f)
    case .bold16: return self.getBoldFont(size: 16.f)
    case .normal17: return self.getNormalFont(size: 17.f)
    case .bold17: return self.getBoldFont(size: 17.f)
    case .normal18: return self.getNormalFont(size: 18.f)
    case .bold18: return self.getBoldFont(size: 18.f)
    case .normal22: return self.getNormalFont(size: 22.f)
    case .bold22: return self.getBoldFont(size: 22.f)
    case .normal24: return self.getNormalFont(size: 24.f)
    case .bold24: return self.getBoldFont(size: 24.f)
    case .bold30: return self.getBoldFont(size: 30.f)
    case .bold36: return self.getBoldFont(size: 36.f)
    }
  }

  var lineHeight: CGFloat {
    switch self {
    case .normal11: return 16.f
    case .bold11: return 16.f
    case .normal12: return 16.f
    case .bold12: return 16.f
    case .normal13: return 18.f
    case .bold13: return 18.f
    case .normal14: return 18.f
    case .bold14: return 18.f
    case .normal15: return 20.f
    case .bold15: return 20.f
    case .normal16: return 22.f
    case .bold16: return 22.f
    case .normal17: return 22.f
    case .bold17: return 22.f
    case .normal18: return 24.f
    case .bold18: return 24.f
    case .normal22: return 28.f
    case .bold22: return 28.f
    case .normal24: return 32.f
    case .bold24: return 32.f
    case .bold30: return 32.f
    case .bold36: return 44.f
    }
  }

  var letterSpacing: CGFloat {
    switch self {
    case .normal11: return 0.f
    case .bold11: return 0.f
    case .normal12: return 0.f
    case .bold12: return 0.f
    case .normal13: return 0.f
    case .bold13: return 0.f
    case .normal14: return 0.f
    case .bold14: return 0.f
    case .normal15: return -0.1.f
    case .bold15: return -0.1.f
    case .normal16: return -0.1.f
    case .bold16: return -0.1.f
    case .normal17: return -0.1.f
    case .bold17: return -0.1.f
    case .normal18: return 0.f
    case .bold18: return 0.f
    case .normal22: return -0.4.f
    case .bold22: return -0.4.f
    case .normal24: return -0.4.f
    case .bold24: return -0.4.f
    case .bold30: return -0.4.f
    case .bold36: return -1.0.f
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
