import SwiftUI
import UIKit

/// Text, Caption 카테고리에서 사용하는 weight prop.
/// iOS는 400(regular)/700(bold) 이진 체계.
public enum BTFontWeight: Equatable {
  case regular
  case bold

  var swiftUIWeight: Font.Weight {
    switch self {
    case .regular: return .regular
    case .bold: return .bold
    }
  }

  var uiKitWeight: UIFont.Weight {
    switch self {
    case .regular: return .regular
    case .bold: return .bold
    }
  }
}
