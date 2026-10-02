import CoreText
import SwiftUI
import UIKit

/// BezierSwift에 포함된 Channel Sans 0.1.2 폰트.
public enum ChannelSans {
  public enum Weight: CaseIterable {
    case thin
    case extraLight
    case light
    case regular
    case medium
    case semiBold
    case bold
    case extraBold
    case black

    fileprivate var postScriptName: String {
      switch self {
      case .thin: return "ChannelSans-Thin"
      case .extraLight: return "ChannelSans-ExtraLight"
      case .light: return "ChannelSans-Light"
      case .regular: return "ChannelSans-Regular"
      case .medium: return "ChannelSans-Medium"
      case .semiBold: return "ChannelSans-SemiBold"
      case .bold: return "ChannelSans-Bold"
      case .extraBold: return "ChannelSans-ExtraBold"
      case .black: return "ChannelSans-Black"
      }
    }

    fileprivate var systemWeight: UIFont.Weight {
      switch self {
      case .thin: return .thin
      case .extraLight: return .ultraLight
      case .light: return .light
      case .regular: return .regular
      case .medium: return .medium
      case .semiBold: return .semibold
      case .bold: return .bold
      case .extraBold: return .heavy
      case .black: return .black
      }
    }
  }

  /// 라이브러리에 포함된 가변 TTF 파일의 URL.
  public static var fontURL: URL? {
    Bundle.module.url(forResource: "ChannelSans", withExtension: "ttf")
  }

  /// 프로세스에 폰트를 한 번 등록한다. 폰트 파일이 없거나 등록에 실패하면 `false`를 반환한다.
  @discardableResult
  public static func register() -> Bool {
    registrationSucceeded
  }

  /// UIKit에서 사용할 Channel Sans 폰트. 등록에 실패하면 같은 크기와 굵기의 시스템 폰트를 반환한다.
  public static func uiFont(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
    guard register(), let font = UIFont(name: weight.postScriptName, size: size) else {
      return .systemFont(ofSize: size, weight: weight.systemWeight)
    }
    return font
  }

  /// SwiftUI에서 사용할 Channel Sans 폰트.
  public static func font(size: CGFloat, weight: Weight = .regular) -> Font {
    Font(uiFont(ofSize: size, weight: weight))
  }

  private static let registrationSucceeded: Bool = {
    guard let url = fontURL else { return false }
    var error: Unmanaged<CFError>?
    return CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
  }()
}
