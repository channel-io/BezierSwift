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
  case orange
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
  
  func textColor(_ size: ButtonSize) -> BezierColor {
    switch self {
    case .primary(let buttonColor):
      switch buttonColor {
      case .monochromeLight, .monochromeDark: return .fgWhiteNormal
      default: return .fgAbsoluteWhiteDark
      }
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .fgBlueNormal
      case .red:
        return .fgRedNormal
      case .green:
        return .fgGreenNormal
      case .yellow:
        return .fgYellowNormal
      case .cobalt:
        return .fgCobaltNormal
      case .orange:
        return .fgOrangeNormal
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .fgBlackDarker
        case .medium, .large, .xlarge:
          return .fgBlackDarkest
        }
      case .monochromeLight:
        return .fgBlackDarker
      case .monochromeDark:
        return .fgBlackDarkest
      case .absoulteWhite:
        return .fgAbsoluteWhiteDark
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite, .orange:
        return .fgAbsoluteWhiteDark
      case .monochrome, .monochromeLight, .monochromeDark:
        return .fgBlackDarkest
      }
    }
  }
  
  func imageTintColor(_ size: ButtonSize) -> BezierColor {
    switch self {
    case .primary(let buttonColor):
      switch buttonColor {
      case .monochromeLight, .monochromeDark: return .fgWhiteNormal
      default: return .fgAbsoluteWhiteDark
      }
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .fgBlueNormal
      case .red:
        return .fgRedNormal
      case .green:
        return .fgGreenNormal
      case .yellow:
        return .fgYellowNormal
      case .cobalt:
        return .fgCobaltNormal
      case .orange:
        return .fgOrangeNormal
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .fgBlackDark
        case .medium, .large, .xlarge:
          return .fgBlackDarker
        }
      case .monochromeLight:
        return .fgBlackDark
      case .monochromeDark:
        return .fgBlackDarker
      case .absoulteWhite:
        return .fgAbsoluteWhiteDark
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite, .orange:
        return .fgAbsoluteWhiteDark
      case .monochrome, .monochromeLight, .monochromeDark:
        return .fgBlackDarker
      }
    }
  }
  
  func backgroundColor(state: ButtonState) -> BezierColor {
    switch self {
    case .primary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgBlueNormal
        case .pressed:
          return .bgBlueDark
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgRedNormal
        case .pressed:
          return .bgRedDark
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgGreenNormal
        case .pressed:
          return .bgGreenDark
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgYellowNormal
        case .pressed:
          return .bgYellowDark
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgCobaltNormal
        case .pressed:
          return .bgCobaltDark
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .bgOrangeNormal
        case .pressed:
          return .bgOrangeDark
        }
      case .monochrome:
        switch state {
        case .default, .disabled:
          return .bgAbsoluteBlackLightest
        case .pressed:
          return .bgAbsoluteBlackLighter
        }
      case .monochromeLight:
        return .bgBlackDarker
      case .monochromeDark:
        return .bgGreyDarkest
      case .absoulteWhite:
        return .bgWhiteAlphaTransparent
      }
    case .secondary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgBlueLightest
        case .pressed:
          return .bgBlueLighter
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgRedLightest
        case .pressed:
          return .bgRedLighter
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgGreenLightest
        case .pressed:
          return .bgGreenLighter
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgYellowLightest
        case .pressed:
          return .bgYellowLighter
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgCobaltLightest
        case .pressed:
          return .bgCobaltLighter
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .bgOrangeLightest
        case .pressed:
          return .bgOrangeLighter
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgBlackLighter
        case .pressed:
          return .bgBlackLight
        }
      case .absoulteWhite:
        return .bgWhiteAlphaTransparent
      }
    case .tertiary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgBlueLightest
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgRedLightest
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgGreenLightest
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgYellowLightest
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgCobaltLightest
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgOrangeLightest
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgWhiteAlphaTransparent
        case .pressed:
          return .bgBlackLighter
        }
      case .absoulteWhite:
        return .bgWhiteAlphaTransparent
      }
    case .floating(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .bgBlueNormal
        case .pressed:
          return .bgBlueDark
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .bgRedNormal
        case .pressed:
          return .bgRedDark
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .bgGreenNormal
        case .pressed:
          return .bgGreenDark
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .bgYellowNormal
        case .pressed:
          return .bgYellowDark
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .bgCobaltNormal
        case .pressed:
          return .bgCobaltDark
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .bgOrangeNormal
        case .pressed:
          return .bgOrangeDark
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .bgWhiteHighest
        case .pressed:
          return .bgWhiteHigher
        }
      case .absoulteWhite:
        return .bgWhiteAlphaTransparent
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

public struct BezierButton: View {
  private var size: ButtonSize
  private var type: ButtonType
  private var resizing: ButtonResizing
  
  private let action: () -> Void
  private let title: String?
  private let leftImage: Image?
  private let rightImage: Image?
  
  private init(
    size: ButtonSize,
    type: ButtonType,
    resizing: ButtonResizing,
    titleContent: String? = nil,
    leftContent: Image? = nil,
    rightContent: Image? = nil,
    action: @escaping () -> Void
  ) {
    self.size = size
    self.type = type
    self.resizing = resizing
    self.action = action
    self.title = titleContent
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
      titleContent: title,
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
      titleContent: title,
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
      titleContent: title,
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
    title: String,
    action: @escaping () -> Void
  ) {
    self.init(
      size: size,
      type: type,
      resizing: resizing,
      titleContent: title,
      action: action
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
            .foregroundColor(self.type.imageTintColor(self.size).color)
            .frame(width: self.size.imageLength, height: self.size.imageLength)
        }
        
        if let title {
          Text(title)
            .applyBezierFontStyle(
              self.size.bezierFont,
              bezierColor: self.type.textColor(self.size)
            )
            .padding(.horizontal, Metric.textLeadingTrailing)
        }
        
        if let rightImage {
          rightImage
            .applyBaseImageStyle()
            .foregroundColor(self.type.imageTintColor(self.size).color)
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

private struct BezierButtonStyle: ButtonStyle {
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
      .background(self.type.backgroundColor(state: buttonState).color)
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
