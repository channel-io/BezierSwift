//
//  BezierIconButton.swift
//
//
//  Created by Tom on 8/16/24.
//

import SwiftUI

// - MARK: BezierIconButton
public struct BezierIconButton<Content: View>: View {
  public typealias ContentBuilder = (_ length: CGFloat, _ color: BezierColor) -> Content
  public typealias Action = () -> Void
  
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
    case tertiary
  }
  
  // MARK: Size
  public enum Size {
    case xsmall
    case small
    case medium
    case large
    case xlarge
  }
  
  // MARK: Color
  public enum Color {
    case blue
    case cobalt
    case red
    case orange
    case green
    case pink
    case purple
    case darkGrey
    case lightGrey
    case absoluteWhite
  }
  
  // MARK: Shape
  public enum Shape {
    case rectangle
    case circle
  }
  
  // MARK: Properties
  private let variant: Variant
  private let color: Color
  private let size: Size
  private let shape: Shape
  private let content: ContentBuilder
  private var isLoading: Bool = false
  private var dropdown: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary`, `tertiary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `large`가 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - shape: Shape는 `rectangle`, `circle` 2개의 모양을 가질 수 있습니다.
  ///   - content: 버튼의 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    variant: Variant,
    color: Color,
    size: Size = .large,
    shape: Shape,
    content: @escaping ContentBuilder,
    action: @escaping Action
  ) {
    self.variant = variant
    self.color = color
    self.size = size
    self.shape = shape
    self.content = content
    self.action = action
  }
  
  // MARK: Body
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: .zero) {
        self.content(self.contentLength, self.contentColor)
        if self.dropdown {
          BezierIcon.chevronSmallDown.image
            .foregroundColor(self.dropdownColor.color)
            .frame(length: self.dropdownLength)
        }
      }
      .padding(self.padding)
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(
      BezierIconButtonStyle(
        shape: self.shape,
        cornerRadius: self.cornerRadius,
        backgroundColor: self.backgroundColor
      )
    )
    .applyDisabledStyle()
    .disabled(self.isLoading)
    .if(self.isLoading) { view in
      view
        .overlay(
          BezierLoader(
            configuration: BezierLoaderConfiguration(
              size: self.loaderSize,
              variant: self.loaderVariant
            )
          )
        )
    }
  }
}

extension BezierIconButton {
  private var contentLength: CGFloat {
    switch self.size {
    case .xsmall: return 16
    case .small, .medium, .large: return 20
    case .xlarge: return 24
    }
  }
  
  private var contentColor: BezierColor {
    switch self.variant {
    case .primary:
      switch self.color {
      case .blue: return .fgAbsoluteWhiteDark
      case .cobalt: return .fgAbsoluteWhiteDark
      case .red: return .fgAbsoluteWhiteDark
      case .orange: return .fgAbsoluteWhiteDark
      case .green: return .fgAbsoluteWhiteDark
      case .pink: return .fgAbsoluteWhiteDark
      case .purple: return .fgAbsoluteWhiteDark
      case .darkGrey: return .fgWhiteNormal
      case .lightGrey: return .fgAbsoluteWhiteNormal
      case .absoluteWhite: return .fgAbsoluteBlackNormal
      }
    case .secondary, .tertiary:
      switch self.color {
      case .blue: return .primaryFgNormal
      case .cobalt: return .accentFgNormal
      case .red: return .criticalFgNormal
      case .orange: return .warningFgNormal
      case .green: return .successFgNormal
      case .pink: return .fgPinkNormal
      case .purple: return .fgPurpleNormal
      case .darkGrey: return .fgBlackDarker
      case .lightGrey: return .fgBlackDark
      case .absoluteWhite: return .fgAbsoluteWhiteLight
      }
    }
  }
  
  private var dropdownLength: CGFloat {
    return self.contentLength
  }
  
  private var dropdownColor: BezierColor {
    switch self.variant {
    case .primary:
      switch self.color {
      case .absoluteWhite: return .fgAbsoluteBlackLight
      default: return .fgAbsoluteWhiteLight
      }
    case .secondary, .tertiary:
      switch self.color {
      case .darkGrey, .lightGrey: return .fgBlackDark
      case .absoluteWhite: return .fgAbsoluteWhiteLight
      default: return self.contentColor
      }
    }
  }
  
  private var padding: CGFloat {
    switch self.size {
    case .xsmall: return 4
    case .small: return 6
    case .medium: return 10
    case .large: return 14
    case .xlarge: return 15
    }
  }
  
  private var cornerRadius: CGFloat {
    switch self.shape {
    case .rectangle:
      switch self.size {
      case .xsmall: return 8
      case .small: return 10
      case .medium: return 12
      case .large: return 14
      case .xlarge: return 16
      }
    case .circle: return 0
    }
  }
  
  private var backgroundColor: BezierColor {
    switch self.color {
    case .blue:
      switch self.variant {
      case .primary: return .primaryBgNormal
      case .secondary: return .primaryBgLightest
      case .tertiary: return .primaryBgTransparent
      }
    case .cobalt:
      switch self.variant {
      case .primary: return .accentBgNormal
      case .secondary: return .accentBgLightest
      case .tertiary: return .accentBgTransparent
      }
    case .red:
      switch self.variant {
      case .primary: return .criticalBgNormal
      case .secondary: return .criticalBgLightest
      case .tertiary: return .criticalBgTransparent
      }
    case .green:
      switch self.variant {
      case .primary: return .successBgNormal
      case .secondary: return .successBgLightest
      case .tertiary: return .successBgTransparent
      }
    case .orange:
      switch self.variant {
      case .primary: return .warningBgNormal
      case .secondary: return .warningBgLightest
      case .tertiary: return .warningBgTransparent
      }
    case .pink:
      switch self.variant {
      case .primary: return .bgPinkNormal
      case .secondary: return .bgPinkLightest
      case .tertiary: return .bgPinkTransparent
      }
    case .purple:
      switch self.variant {
      case .primary: return .bgPurpleNormal
      case .secondary: return .bgPurpleLightest
      case .tertiary: return .bgPurpleTransparent
      }
    case .darkGrey:
      switch self.variant {
      case .primary: return .bgGreyDarkest
      case .secondary: return .bgBlackLighter
      case .tertiary: return .bgGreyTransparent
      }
    case .lightGrey:
      switch self.variant {
      case .primary: return .bgBlackDark
      case .secondary: return .bgBlackLighter
      case .tertiary: return .bgBlackTransparent
      }
    case .absoluteWhite:
      switch self.variant {
      case .primary: return .bgAbsoluteWhiteDark
      case .secondary: return .bgAbsoluteWhiteLightest
      case .tertiary: return .bgAbsoluteWhiteTransparent
      }
    }
  }
  
  private var loaderSize: BezierLoaderConfiguration.Size {
    switch self.size {
    case .xsmall, .small: return .xxsmall
    case .medium, .large: return .xsmall
    case .xlarge: return .small
    }
  }
  
  private var loaderVariant: BezierLoaderConfiguration.Variant {
    return self.variant == .primary ? .onOverlay : .secondary
  }
}

// - MARK: Extensions
extension BezierIconButton {
  /// 로딩 상태를 설정하여 버튼의 아이콘과 레이블 텍스트를 숨기고, Loader로만 표현합니다. 5초 이하의 짧고 단순한 의미 전달이 필요한 경우에만 사용합니다. 로딩 중일 때는 사용자와의 인터렉션이 불가능합니다.
  /// - Parameters:
  ///   - isLoading: 버튼의 로딩 상태를 설정하는 Bool 값입니다. `true`로 설정하면 버튼이 로딩 상태로 전환됩니다.
  public func isLoading(_ isLoading: Bool) -> Self {
    var view = self
    view.isLoading = isLoading
    return view
  }
  
  /// 드랍다운 등의 인터렉션을 표현하기 위해 사용됩니다. 따라서 chevron 으로 아이콘이 고정되어 있습니다.
  /// - Parameters:
  ///   - dropdown: 드랍다운 등의 인터렉션을 표현하기 위해 사용되는 Bool 값입니다. `true` 로 설정하면 Dropdown UI가 보입니다.
  public func dropdown(_ dropdown: Bool) -> Self {
    var view = self
    view.dropdown = dropdown
    return view
  }
}

// - MARK: Preview
#Preview {
  BezierIconButton(
    variant: .primary,
    color: .blue,
    size: .xlarge,
    shape: .circle,
    content: { length, color in
      BezierIcon.plus.image
        .frame(length: length)
        .foregroundColor(color.color)
    }
  ) {
    print("BezierIconButton")
  }
}
