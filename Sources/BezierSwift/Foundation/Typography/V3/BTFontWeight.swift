import SwiftUI
import UIKit

/// Bezier V3 타이포그래피의 iOS 폰트 굵기.
public enum BTFontWeight: Equatable {
  /// Regular (400).
  case regular
  /// Medium (600). Apple 시스템 폰트에서는 semibold에 해당한다.
  case medium
  /// Bold (700).
  case bold

  var swiftUIWeight: Font.Weight {
    switch self {
    case .regular: return .regular
    case .medium: return .semibold
    case .bold: return .bold
    }
  }

  var uiKitWeight: UIFont.Weight {
    switch self {
    case .regular: return .regular
    case .medium: return .semibold
    case .bold: return .bold
    }
  }
}
