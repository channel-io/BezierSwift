//
//  BezierFloatingButton.swift
//  
//
//  Created by Tom on 8/18/24.
//

import SwiftUI

// - MARK: BezierFloatingButton
public struct BezierFloatingButton<PrefixContent: View, SuffixContent: View>: View {
  public typealias PrefixContentBuilder = (_ length: CGFloat, _ color: BezierColor) -> PrefixContent
  public typealias SuffixContentBuilder = (_ length: CGFloat, _ color: BezierColor) -> SuffixContent
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
  private let text: String
  private let variant: Variant
  private let color: Color
  private let size: Size
  private let prefixContent: PrefixContentBuilder
  private let suffixContent: SuffixContentBuilder
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - text: 버튼에 표시될 텍스트를 지정합니다.
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large,
    prefixContent: @escaping PrefixContentBuilder,
    suffixContent: @escaping SuffixContentBuilder,
    action: @escaping Action
  ) {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - text: 버튼에 표시될 텍스트를 지정합니다.
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large,
    prefixContent: @escaping PrefixContentBuilder,
    action: @escaping Action
  ) where SuffixContent == EmptyView {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = prefixContent
    self.suffixContent = { _, _ in EmptyView() }
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - text: 버튼에 표시될 텍스트를 지정합니다.
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다. 디자인 가이드로 `length` 와 `color` 를 제공합니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large,
    suffixContent: @escaping SuffixContentBuilder,
    action: @escaping Action
  ) where PrefixContent == EmptyView {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = { _, _ in EmptyView() }
    self.suffixContent = suffixContent
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - text: 버튼에 표시될 텍스트를 지정합니다.
  ///   - variant: 스타일에는 위계와 형태가 모두 포함됩니다. `primary`, `secondary` 는 위계를 나타내는 표현으로 적힌 순서로 낮아집니다. 화면 내에서 액션의 중요도에 따라 버튼의 Hierachy를 다르게 사용합니다. 또한 `primary` 는 가장 중요한 버튼에 사용합니다. 일반적으로 한 화면에서 1개 사용을 권장하며, 너무 많이 사용하지 않도록 해주세요.
  ///   - color: Semantic 그룹에 속하는 모든 컬러를 사용할 수 있습니다.
  ///   - size: Button은 `xsmall`, `small`, `medium`,` large`, `xlarge` 5개의 사이즈를 가질 수 있습니다. `medium`이 가장 보편적으로 사용되며, 페이지 내의 중요도와 시각적 균형에 맞게 적절하게 사용합니다. 기본값은 `large` 입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    text: String,
    variant: Variant,
    color: Color,
    size: Size = .large,
    action: @escaping Action
  ) where PrefixContent == EmptyView, SuffixContent == EmptyView {
    self.text = text
    self.variant = variant
    self.color = color
    self.size = size
    self.prefixContent = { _, _ in EmptyView() }
    self.suffixContent = { _, _ in EmptyView() }
    self.action = action
  }
  
  // MARK: Body
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: .zero) {
        self.prefixContent(self.affixContentLength, self.affixContentColor)
        
        Text(self.text)
          .applyBezierFontStyle(self.textFont, bezierColor: self.textColor)
          .multilineTextAlignment(.leading)
          .lineLimit(1)
          .padding(.horizontal, self.textHorizontalPadding)
          .padding(.vertical, self.textVerticalPadding)
        
        self.suffixContent(self.affixContentLength, self.affixContentColor)
      }
      .padding(.horizontal, self.horizontalPadding)
      .padding(.vertical, self.verticalPadding)
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(BezierFloatingButtonStyle(backgroundColor: self.backgroundColor))
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
extension BezierFloatingButton {
  private var textFont: BezierFont {
    switch self.size {
    case .xsmall: return .caption2SemiBold
    case .small: return .caption1SemiBold
    case .medium: return .body2SemiBold
    case .large: return .body1SemiBold
    case .xlarge: return .title3SemiBold
    }
  }
  
  private var textColor: BezierColor {
    guard self.variant != .primary else { return .fgAbsoluteWhiteDark }
    
    switch self.color {
    case .blue: return .primaryFgNormal
    case .cobalt: return .fgCobaltNormal
    case .red: return .fgRedNormal
    case .orange: return .warningFgNormal
    case .green: return .successFgNormal
    case .pink: return .fgPinkNormal
    case .purple: return .fgPurpleNormal
    case .darkGrey: return .fgBlackDarkest
    case .lightGrey: return .fgBlackDarker
    }
  }
  
  private var affixContentLength: CGFloat {
    switch self.size {
    case .xsmall, .small: return 16
    case .medium, .large: return 20
    case .xlarge: return 24
    }
  }
  
  private var textHorizontalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 3
    case .small, .medium: return 4
    case .large: return 5
    case .xlarge: return 6
    }
  }
  
  // TODO: 새 폰트의 LineHeight 체크 후 VerticalPadding 정의 필요 by Tom 2024.09.03
  private var textVerticalPadding: CGFloat {
    switch self.size {
    case .xsmall, .medium: return 0
    case .small, .large, .xlarge: return 1
    }
  }
  
  private var affixContentColor: BezierColor {
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
  
  private var horizontalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 6
    case .small: return 8
    case .medium: return 12
    case .large: return 14
    case .xlarge: return 16
    }
  }
  
  private var verticalPadding: CGFloat {
    switch self.size {
    case .xsmall: return 3
    case .small: return 6
    case .medium: return 9
    case .large: return 9
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
extension BezierFloatingButton {
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
  BezierFloatingButton(
    text: "Test",
    variant: .primary,
    color: .blue,
    size: .xlarge,
    prefixContent: { length, color in
      BezierIcon.android.image
        .frame(length: length)
        .foregroundColor(color.color)
    },
    suffixContent: { length, color in
      BezierIcon.ios.image
        .frame(length: length)
        .foregroundColor(color.color)
    }
  ) {
    print("BezierFloatingButton")
  }
}
