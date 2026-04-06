import SwiftUI
import UIKit

/// Bezier Typography V3 Global Token
/// 시멘틱 토큰이 참조하는 기초 값. iOS pt 단위.
/// internal 접근자 — 외부에서는 BTSemanticToken을 통해서만 사용.
enum BTGlobalToken {
  enum FontSize {
    static let size11: CGFloat = 11
    static let size12: CGFloat = 12
    static let size13: CGFloat = 13
    static let size14: CGFloat = 14
    static let size15: CGFloat = 15
    static let size16: CGFloat = 16
    static let size17: CGFloat = 17
    static let size18: CGFloat = 18
    static let size22: CGFloat = 22
    static let size24: CGFloat = 24
    static let size30: CGFloat = 30
    static let size36: CGFloat = 36
  }

  enum LineHeight {
    static let height16: CGFloat = 16
    static let height18: CGFloat = 18
    static let height20: CGFloat = 20
    static let height24: CGFloat = 24
    static let height28: CGFloat = 28
    static let height32: CGFloat = 32
    static let height36: CGFloat = 36
    static let height44: CGFloat = 44
  }

  enum LetterSpacing {
    static let spacing0: CGFloat = 0
    static let spacing0_1: CGFloat = -0.1
    static let spacing0_4: CGFloat = -0.4
  }

  enum FontWeight: Int {
    case regular = 400
    case bold = 700

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

  enum FontFamily: Equatable {
    case system
    case monospace

    func font(size: CGFloat, weight: FontWeight) -> Font {
      switch self {
      case .system:
        return .system(size: size, weight: weight.swiftUIWeight)
      case .monospace:
        return .system(size: size, weight: weight.swiftUIWeight, design: .monospaced)
      }
    }

    func uiFont(size: CGFloat, weight: FontWeight) -> UIFont {
      switch self {
      case .system:
        return .systemFont(ofSize: size, weight: weight.uiKitWeight)
      case .monospace:
        return .monospacedSystemFont(ofSize: size, weight: weight.uiKitWeight)
      }
    }
  }
}
