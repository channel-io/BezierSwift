//
//  BezierSwift.swift
//
//
//  Created by Jam on 2022/12/02.
//

import UIKit

public protocol BezierSwiftDelegate: AnyObject {
  func windowsForThemeUpdate() -> [UIWindow]
}

public final class BezierSwift {
  public struct Config {
    fileprivate let hideKeyboardOnDialogDisplay: Bool
    
    public init(hideKeyboardOnDialogDisplay: Bool = true) {
      self.hideKeyboardOnDialogDisplay = hideKeyboardOnDialogDisplay
    }
  }
  
  static let shared = BezierSwift()
  
  let toastViewModel = BezierToastViewModel()
  let dialogViewModel = BezierDialogViewModel()
  var config = Config()
  
  weak var bezierWindow: BezierWindow?
  
  private weak var _delegate: BezierSwiftDelegate?
  public static var delegate: BezierSwiftDelegate? {
    get {
      return BezierSwift.shared._delegate
    }
    set {
      BezierSwift.shared._delegate = newValue
    }
  }
  
  private var _theme: BezierTheme? = .system
  public private(set) static var theme: BezierTheme? {
    get {
      return BezierSwift.shared._theme
    }
    set {
      BezierSwift.shared._theme = newValue
    }
  }
  
  var allowHitTest: Bool { self.dialogViewModel.item.isNotNil }
  
  private init() { }
  
  fileprivate func hideKeyboard() {
    // NOTE: BezierDialog update 시 firstResponder 전달이 안돼서 키보드가 닫히지 않는 문제가 있습니다.
    // Keyboard 를 닫아 키보드 입력을 막기 위한 함수입니다. by Tom 2024.04.17
    if self.config.hideKeyboardOnDialogDisplay {
      DispatchQueue.main.async {
        if #available(iOS 15.0, *) {
          self.bezierWindow?.windowScene?.keyWindow?.endEditing(true)
        } else {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
      }
    }
  }
}

extension BezierSwift {
  @available(iOS, deprecated: 16.0)
  @MainActor
  public static func initializeWindow(
    windowLevel: UIWindow.Level = .bezierSwift,
    config: Config = Config()
  ) -> UIWindow {
    guard let bezierWindow = BezierSwift.shared.bezierWindow else {
      let bezierWindow = BezierWindow(frame: UIScreen.main.bounds, windowLevel: windowLevel)
      BezierSwift.shared.bezierWindow = bezierWindow
      BezierSwift.shared.config = config
      return bezierWindow
    }
    
    return bezierWindow
  }
  
  @MainActor
  public static func initializeWindow(
    windowScene: UIWindowScene,
    windowLevel: UIWindow.Level = .bezierSwift,
    config: Config = Config()
  ) -> UIWindow {
    guard let bezierWindow = BezierSwift.shared.bezierWindow else {
      let bezierWindow = BezierWindow(windowScene: windowScene, windowLevel: windowLevel)
      BezierSwift.shared.bezierWindow = bezierWindow
      BezierSwift.shared.config = config
      return bezierWindow
    }
    
    return bezierWindow
  }
}

extension BezierSwift {
  public static func showToast(param: BezierToastParam) {
    BezierSwift.shared.toastViewModel.appendToastItem(BezierToastItem(param: param))
  }
  
  public static func showToast(item: BezierToastItem) {
    BezierSwift.shared.toastViewModel.appendToastItem(item)
  }
}

extension BezierSwift {
  public static func showDialog(param: BezierDialogParam) {
    BezierSwift.shared.dialogViewModel.update(item: BezierDialogItem(param: param))
    BezierSwift.shared.hideKeyboard()
  }
  
  public static func showDialog(item: BezierDialogItem) {
    BezierSwift.shared.dialogViewModel.update(item: item)
    BezierSwift.shared.hideKeyboard()
  }
  
  public static func dismissDialog(id: UUID) {
    BezierSwift.shared.dialogViewModel.dismiss(with: id)
  }
  
  public static func dismissDialog() {
    BezierSwift.shared.dialogViewModel.dismiss()
  }
}

extension BezierSwift {
  public static func applyTheme(_ theme: BezierTheme) {
    guard BezierSwift.theme != theme else { return }
    
    BezierSwift.theme = theme
    BezierSwift.shared.bezierWindow?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    
    BezierSwift.delegate?.windowsForThemeUpdate().forEach { window in
      window.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
  }
}
