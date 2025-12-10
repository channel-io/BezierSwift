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
  
  func textColor(_ size: ButtonSize) -> SemanticColorToken {
    switch self {
    case .primary(let buttonColor):
      switch buttonColor {
      case .monochromeLight, .monochromeDark: return .textAbsoluteWhite
      default: return .textAbsoluteWhite
      }
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .textAccentBlue
      case .red:
        return .textAccentRed
      case .green:
        return .textAccentGreen
      case .yellow:
        return .textAccentYellow
      case .cobalt:
        return .textAccentCobalt
      case .orange:
        return .textAccentOrange
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .textNeutralLight
        case .medium, .large, .xlarge:
          return .textNeutral
        }
      case .monochromeLight:
        return .textNeutralLight
      case .monochromeDark:
        return .textNeutral
      case .absoulteWhite:
        return .textAbsoluteWhite
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite, .orange:
        return .textAbsoluteWhite
      case .monochrome, .monochromeLight, .monochromeDark:
        return .textNeutral
      }
    }
  }
  
  func imageTintColor(_ size: ButtonSize) -> SemanticColorToken {
    switch self {
    case .primary(let buttonColor):
      switch buttonColor {
      case .monochromeLight, .monochromeDark: return .iconAbsoluteWhite
      default: return .iconAbsoluteWhite
      }
    case .secondary(let color), .tertiary(let color):
      switch color {
      case .blue:
        return .iconAccentBlue
      case .red:
        return .iconAccentRed
      case .green:
        return .iconAccentGreen
      case .yellow:
        return .iconAccentYellow
      case .cobalt:
        return .iconAccentCobalt
      case .orange:
        return .iconAccentOrange
      case .monochrome:
        switch size {
        case .xsmall, .small:
          return .iconNeutral
        case .medium, .large, .xlarge:
          return .iconNeutralHeavy
        }
      case .monochromeLight:
        return .iconNeutral
      case .monochromeDark:
        return .iconNeutralHeavy
      case .absoulteWhite:
        return .iconAbsoluteWhite
      }
    case .floating(let color):
      switch color {
      case .blue, .red, .green, .yellow, .cobalt, .absoulteWhite, .orange:
        return .iconAbsoluteWhite
      case .monochrome, .monochromeLight, .monochromeDark:
        return .iconNeutralHeavy
      }
    }
  }
  
  func backgroundColor(state: ButtonState) -> SemanticColorToken {
    switch self {
    case .primary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .fillAccentBlueHeavier
        case .pressed:
          return .fillAccentBlueHeavier
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .fillAccentRedHeavier
        case .pressed:
          return .fillAccentRedHeavier
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .fillAccentGreenHeavier
        case .pressed:
          return .fillAccentGreenHeavier
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .fillAccentYellowHeavier
        case .pressed:
          return .fillAccentYellowHeavier
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .fillAccentCobaltHeavier
        case .pressed:
          return .fillAccentCobaltHeavier
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .fillAccentOrangeHeavier
        case .pressed:
          return .fillAccentOrangeHeavier
        }
      case .monochrome:
        switch state {
        case .default, .disabled:
          return .fillAbsoluteBlackLight
        case .pressed:
          return .dimAbsoluteBlack
        }
      case .monochromeLight:
        return .fillNeutralHeavier
      case .monochromeDark:
        return .fillNeutralHeaviest
      case .absoulteWhite:
        return .fillNeutralTransparent
      }
    case .secondary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .fillAccentBlue
        case .pressed:
          return .fillAccentBlueHeavy
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .fillAccentRed
        case .pressed:
          return .fillAccentRedHeavy
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .fillAccentGreen
        case .pressed:
          return .fillAccentGreenHeavy
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .fillAccentYellow
        case .pressed:
          return .fillAccentYellowHeavy
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .fillAccentCobalt
        case .pressed:
          return .fillAccentCobaltHeavy
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .fillAccentOrange
        case .pressed:
          return .fillAccentOrangeHeavy
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .fillNeutralLighter
        case .pressed:
          return .fillNeutralLight
        }
      case .absoulteWhite:
        return .fillNeutralTransparent
      }
    case .tertiary(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentBlue
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentRed
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentGreen
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentYellow
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentCobalt
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillAccentOrange
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .fillNeutralTransparent
        case .pressed:
          return .fillNeutralLighter
        }
      case .absoulteWhite:
        return .fillNeutralTransparent
      }
    case .floating(let color):
      switch color {
      case .blue:
        switch state {
        case .default, .disabled:
          return .fillAccentBlueHeavier
        case .pressed:
          return .fillAccentBlueHeavier
        }
      case .red:
        switch state {
        case .default, .disabled:
          return .fillAccentRedHeavier
        case .pressed:
          return .fillAccentRedHeavier
        }
      case .green:
        switch state {
        case .default, .disabled:
          return .fillAccentGreenHeavier
        case .pressed:
          return .fillAccentGreenHeavier
        }
      case .yellow:
        switch state {
        case .default, .disabled:
          return .fillAccentYellowHeavier
        case .pressed:
          return .fillAccentYellowHeavier
        }
      case .cobalt:
        switch state {
        case .default, .disabled:
          return .fillAccentCobaltHeavier
        case .pressed:
          return .fillAccentCobaltHeavier
        }
      case .orange:
        switch state {
        case .default, .disabled:
          return .fillAccentOrangeHeavier
        case .pressed:
          return .fillAccentOrangeHeavier
        }
      case .monochrome, .monochromeLight, .monochromeDark:
        switch state {
        case .default, .disabled:
          return .surfaceHighest
        case .pressed:
          return .surfaceHigh
        }
      case .absoulteWhite:
        return .fillNeutralTransparent
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
            .foregroundColor(self.palette(self.type.imageTintColor(self.size)))
            .frame(width: self.size.imageLength, height: self.size.imageLength)
        }
        
        if let title {
          Text(title)
            .applyBezierFontStyle(
              self.size.bezierFont,
              semanticColorToken: self.type.textColor(self.size)
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
