//
//  BezierButton.swift
//  
//
//  Created by Jam on 2023/02/09.
//

import SwiftUI

private enum Metric {
  static let textLeadingTrailing = CGFloat(2)
}

private enum Constant {
  static let disalbedOpacity = CGFloat(0.4)
}

public enum ButtonSize {
  case xsmall
  case small
  case medium
  case large
  case xlarge
  
  var height: CGFloat {
    switch self {
    case .xsmall:
      return 24
    case .small:
      return 30
    case .medium:
      return 40
    case .large:
      return 44
    case .xlarge:
      return 54
    }
  }
  
  var stackSpacing: CGFloat {
    switch self {
    case .xsmall, .small, .medium:
      return 4
    case .large:
      return 5
    case .xlarge:
      return 6
    }
  }
  
  var imageLength: CGFloat {
    switch self {
    case .xsmall:
      return 16
    case .small:
      return 20
    case .medium, .large, .xlarge:
      return 24
    }
  }
  
  var font: Font {
    self.bezierFont.font
  }
  
  var bezierFont: BezierFont {
    switch self {
    case .xsmall:
      return BezierFont.bold13
    case .small:
      return BezierFont.bold14
    case .medium:
      return BezierFont.bold15
    case .large, .xlarge:
      return BezierFont.bold16
    }
  }
  
  var minLeadingTrailingPadding: CGFloat {
    switch self {
    case .xsmall, .small:
      return 6
    case .medium:
      return 8
    case .large:
      return 10
    case .xlarge:
      return 12
    }
  }
  
  var topBottomPadding: CGFloat {
    return (self.height - self.imageLength) / CGFloat(2)
  }
  
  func cornerRadius(type: ButtonType) -> BezierCornerRadius {
    switch type {
    case .primary, .secondary, .tertiary:
      switch self {
      case .xsmall:
        return .round6
      case .small:
        return .round8
      case .medium:
        return .round12
      case .large:
        return .round12
      case .xlarge:
        return .round16
      }
    case .floating:
      return .roundHalf(length: self.height)
    }
  }
}

public enum ButtonColor: String {
  case blue
  case red
  case green
  case yellow
  case cobalt
  case monochrome // TODO: 레거시. monochromeLight / Dark 논의 이후에 색상 치환할 것.
  case monochromeLight
  case monochromeDark
  case absoulteWhite
}

public enum ButtonType: Equatable {
  case primary(ButtonColor)
  case secondary(ButtonColor)
  case tertiary(ButtonColor)
  case floating(ButtonColor)
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case (let .primary(lhsColor), let .primary(rhsColor)):
      return lhsColor == rhsColor
    case (let .secondary(lhsColor), let .secondary(rhsColor)):
      return lhsColor == rhsColor
    case (let .tertiary(lhsColor), let .tertiary(rhsColor)):
      return lhsColor == rhsColor
    case (let .floating(lhsColor), let .floating(rhsColor)):
      return lhsColor == rhsColor
    default:
      return false
    }
  }
  
  func textColor(_ size: ButtonSize) -> SemanticColor {
    switch self {
    case .primary:
      return .bgtxtAbsoluteWhiteDark
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .bgtxtBlueNormal
      case .red:
        return .bgtxtRedNormal
      case .green:
        return .bgtxtGreenNormal
      case .yellow:
        return .bgtxtYellowNormal
      case .cobalt:
        return .bgtxtCobaltNormal
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .txtBlackDarker
        case .medium, .large, .xlarge:
          return .txtBlackDarkest
        }
      case .monochromeLight:
        return .txtBlackDarker
      case .monochromeDark:
        return .txtBlackDarkest
      case .absoulteWhite:
        return .bgtxtAbsoluteWhiteDark
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite:
        return .bgtxtAbsoluteWhiteDark
      case .monochrome, .monochromeLight, .monochromeDark:
        return .txtBlackDarkest
      }
    }
  }
  
  func imageTintColor(_ size: ButtonSize) -> SemanticColor {
    switch self {
    case .primary:
      return .bgtxtAbsoluteWhiteDark
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .bgtxtBlueNormal
      case .red:
        return .bgtxtRedNormal
      case .green:
        return .bgtxtGreenNormal
      case .yellow:
        return .bgtxtYellowNormal
      case .cobalt:
        return .bgtxtCobaltNormal
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .txtBlackDark
        case .medium, .large, .xlarge:
          return .txtBlackDarker
        }
      case .monochromeLight:
        return .txtBlackDark
      case .monochromeDark:
        return .txtBlackDarker
      case .absoulteWhite:
        return .bgtxtAbsoluteWhiteDark
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite:
        return .bgtxtAbsoluteWhiteDark
      case .monochrome, .monochromeLight, .monochromeDark:
        return .txtBlackDarker
      }
    }
  }
  
  func backgroundColor(state: ButtonState) -> SemanticColor {
    switch self {
    case .primary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgtxtBlueNormal
        case .pressed:
          return .bgtxtBlueDark
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgtxtRedNormal
        case .pressed:
          return .bgtxtRedDark
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgtxtGreenNormal
        case .pressed:
          return .bgtxtGreenDark
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgtxtYellowNormal
        case .pressed:
          return .bgtxtYellowDark
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgtxtCobaltNormal
        case .pressed:
          return .bgtxtCobaltDark
        }
      case .monochrome:
        switch state {
        case .default, .disabled:
          return .bgtxtAbsoluteBlackLightest
        case .pressed:
          return .bgtxtAbsoluteBlackLighter
        }
      case .monochromeLight, .monochromeDark:
        return .bgBlackLighter
      case .absoulteWhite:
        return .bgTransparent
      }
    case .secondary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgtxtBlueLightest
        case .pressed:
          return .bgtxtBlueLighter
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgtxtRedLightest
        case .pressed:
          return .bgtxtRedLighter
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgtxtGreenLightest
        case .pressed:
          return .bgtxtGreenLighter
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgtxtYellowLightest
        case .pressed:
          return .bgtxtYellowLighter
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgtxtCobaltLightest
        case .pressed:
          return .bgtxtCobaltLighter
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgBlackLighter
        case .pressed:
          return .bgBlackLight
        }
      case .absoulteWhite:
        return .bgTransparent
      }
    case .tertiary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgtxtBlueLightest
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgtxtRedLightest
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgtxtGreenLightest
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgtxtYellowLightest
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgtxtCobaltLightest
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgTransparent
        case .pressed:
          return .bgBlackLighter
        }
      case .absoulteWhite:
        return .bgTransparent
      }
    case .floating(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgtxtBlueNormal
        case .pressed:
          return .bgtxtBlueDark
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgtxtRedNormal
        case .pressed:
          return .bgtxtRedDark
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgtxtGreenNormal
        case .pressed:
          return .bgtxtGreenDark
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgtxtYellowNormal
        case .pressed:
          return .bgtxtYellowDark
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgtxtCobaltNormal
        case .pressed:
          return .bgtxtCobaltDark
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgWhiteHigh
        case .pressed:
          return .bgWhiteLow
        }
      case .absoulteWhite:
        return .bgTransparent
      }
    }
  }
}

enum ButtonState {
  case `default`
  case pressed
  case disabled
}

public enum ButtonResizing {
  case hug
  case fill
}

public struct BezierButton: View, Themeable {
  private var size: ButtonSize
  private var type: ButtonType
  private var resizing: ButtonResizing
  
  private let action: () -> Void
  private let title: String?
  private let leftImage: Image?
  private let rightImage: Image?
  
  @Environment(\.colorScheme) public var colorScheme
  
  private init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    title: String? = nil,
    leftContent: Image? = nil,
    rightContent: Image? = nil,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.type = type
    self.resizing = resizing
    self.action = action
    self.title = title
    self.leftImage = leftContent
    self.rightImage = rightContent
  }
  
  public init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    title: String,
    leftImage: Image,
    rightImage: Image,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      title: title,
      leftContent: leftImage,
      rightContent: rightImage,
      action: action
    )
  }
  
  public init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    title: String,
    leftImage: Image,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      title: title,
      leftContent: leftImage,
      action: action
    )
  }
  
  public init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    title: String,
    rightImage: Image,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      title: title,
      rightContent: rightImage,
      action: action
    )
  }
  
  public init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    centerImage: Image,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      leftContent: centerImage,
      action: action
    )
  }
  
  public init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    action: @escaping () -> Void,
    title: @escaping () -> String
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      action: action,
      title: title
    )
  }
  
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(alignment: .center, spacing: self.size.stackSpacing) {
        if self.resizing == .fill {
          Spacer(minLength: 0)
        }
        
        if let leftImage {
          leftImage
            .applyBaseImageStyle()
            .foregroundColor(self.palette(self.type.imageTintColor(self.size)))
            .frame(width: self.size.imageLength, height: self.size.imageLength)
        }
        
        if let title {
          Text(title)
            .applyBezierFontStyle(
              self.size.bezierFont,
              semanticColor: self.type.textColor(self.size)
            )
            .padding(.horizontal, Metric.textLeadingTrailing)
        }
        
        if let rightImage {
          rightImage
            .applyBaseImageStyle()
            .foregroundColor(self.palette(self.type.imageTintColor(self.size)))
            .frame(width: self.size.imageLength, height: self.size.imageLength)
        }
        
        if self.resizing == .fill {
          Spacer(minLength: 0)
        }
      }
      .padding(.horizontal, self.minLeadingTrailing)
    }
    .buttonStyle(
      BezierButtonStyle(
        size: size,
        type: type,
        resizing: resizing
      )
    )
  }
  
  private var minLeadingTrailing: CGFloat {
    let isImageOnly = self.title.isNil
    && (
      (self.leftImage.isNotNil || self.rightImage.isNil)
      || (self.leftImage.isNil || self.rightImage.isNotNil)
    )
    let minLeadingTrailing = isImageOnly
    ? self.size.topBottomPadding : self.size.minLeadingTrailingPadding
    
    return minLeadingTrailing
  }
}

private extension Image {
  func applyBaseImageStyle() -> some View {
    self
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
  }
}

private struct BezierButtonStyle: ButtonStyle, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  private let size: ButtonSize
  private let type: ButtonType
  private let resizing: ButtonResizing
  
  @Environment(\.isEnabled) var isEnabled: Bool
  
  init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing
  ) {
    self.size = size
    self.type = type
    self.resizing = resizing
  }
  
  func makeBody(configuration: Configuration) -> some View {
    let buttonState: ButtonState = self.getState(configuration: configuration, isEnabled: self.isEnabled)
    configuration.label
      .frame(height: self.size.height)
      .disabled(!self.isEnabled)
      .background(self.palette(self.type.backgroundColor(state: buttonState)))
      .applyBezierCornerRadius(type: self.size.cornerRadius(type: self.type))
      .opacity(self.isEnabled ? 1 : Constant.disalbedOpacity)
  }
  
  private func getState(configuration: Configuration, isEnabled: Bool) -> ButtonState {
    return configuration.isPressed ? .pressed : isEnabled ? .default : .disabled
  }
}

struct BezierButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      BezierButton(size: .large, type: .primary(.green), resizing: .fill, title: "Get started", leftImage: Image(systemName: "trash")) {
        print("")
      }
      
      
      BezierButton(size: .large, type: .primary(.blue), resizing: .hug, title: "Get started", leftImage: Image(systemName: "trash"), rightImage: Image(systemName: "trash")) {
        print("")
      }
      
      BezierButton(size: .large, type: .primary(.red), resizing: .hug, title: "Get started", leftImage: Image(systemName: "trash"), rightImage: Image(systemName: "trash")) {
        print("")
      }
      
      BezierButton(size: .large, type: .secondary(.red), resizing: .hug, title: "Get started", leftImage: Image(systemName: "trash"), rightImage: Image(systemName: "trash")) {
        print("")
      }
      
      BezierButton(size: .large, type: .tertiary(.red), resizing: .hug, title: "Get started", leftImage: Image(systemName: "trash"), rightImage: Image(systemName: "trash")) {
        print("")
      }
      
      BezierButton(size: .large, type: .floating(.cobalt), resizing: .hug, title: "Get started", leftImage: Image(systemName: "trash"), rightImage: Image(systemName: "trash")) {
        print("")
      }
      
      BezierButton(size: .large, type: .primary(.yellow), resizing: .hug, centerImage: Image(systemName: "trash")) {
        print("")
      }
      
    }.padding()
  }
}
