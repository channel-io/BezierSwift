//
//  BezierFloatingIconButton.swift
//
//
//  Created by Tom on 8/20/24.
//

import SwiftUI

// - MARK: BezierFloatingIconButton
public struct BezierFloatingIconButton<Content: View>: View {
  public typealias ContentBuilder = (_ length: CGFloat, _ color: BezierColor) -> Content
  public typealias Action = () -> Void
  
  // MARK: Variant
  public enum Variant {
    case primary
    case secondary
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
  }
  
  // MARK: Properties
  private let variant: Variant
  private let color: Color
  private let size: Size
  private let content: ContentBuilder
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - content: 버튼의 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    variant: Variant,
    color: Color,
    size: Size = .large,
    content: @escaping ContentBuilder,
    action: @escaping Action
  ) {
    self.variant = variant
    self.color = color
    self.size = size
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
      }
      .padding(self.padding)
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(BezierFloatingIconButtonStyle(backgroundColor: self.backgroundColor))
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

// - MARK: Style
extension BezierFloatingIconButton {
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
      }
    case .secondary:
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
      }
    }
  }
  
  private var padding: CGFloat {
    switch self.size {
    case .xsmall: return 4
    case .small: return 8
    case .medium: return 10
    case .large: return 12
    case .xlarge: return 15
    }
  }
  
  private var backgroundColor: BezierColor {
    guard self.variant != .secondary else { return .bgWhiteHigher }
    
    switch self.color {
    case .blue: return .primaryBgNormal
    case .cobalt: return .accentBgNormal
    case .red: return .criticalBgNormal
    case .green: return .successBgNormal
    case .orange: return .warningBgNormal
    case .pink: return .bgPinkNormal
    case .purple: return .bgPurpleNormal
    case .darkGrey: return .bgGreyDarkest
    case .lightGrey: return .bgBlackDark
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
extension BezierFloatingIconButton {
  /// 로딩 상태를 설정하여 버튼의 아이콘과 레이블 텍스트를 숨기고, Loader로만 표현합니다. 5초 이하의 짧고 단순한 의미 전달이 필요한 경우에만 사용합니다. 로딩 중일 때는 사용자와의 인터렉션이 불가능합니다.
  /// - Parameters:
  ///   - isLoading: 버튼의 로딩 상태를 설정하는 Bool 값입니다. `true`로 설정하면 버튼이 로딩 상태로 전환됩니다.
  public func isLoading(_ isLoading: Bool) -> Self {
    var view = self
    view.isLoading = isLoading
    return view
  }
}

// - MARK: Preview
#Preview {
  BezierFloatingIconButton(
    variant: .secondary,
    color: .blue,
    size: .xlarge,
    content: { length, color in
      BezierIcon.plus.image
        .frame(length: length)
        .foregroundColor(color.color)
    }
  ) {
    print("BezierFloatingIconButton")
  }
}
