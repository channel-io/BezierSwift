//
//  BezierButton.swift
//
//
//  Created by Tom on 6/28/24.
//

import SwiftUI

// - MARK: BezierButton
/// - Parameters:
///   - configuration: 버튼의 스타일과 모양을 정의하는 BezierButtonConfiguration 객체입니다.
///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다.
///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다.
///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
public struct BezierButton<PrefixContent: View, SuffixContent: View>: View {
  public typealias Configuration = BezierButtonConfiguration
  public typealias PrefixContentBuilder = (Configuration) -> PrefixContent
  public typealias SuffixContentBuilder = (Configuration) -> SuffixContent
  public typealias Action = () -> Void
  
  // MARK: Properties
  private let configuration: Configuration
  private let prefixContent: PrefixContentBuilder
  private let suffixContent: SuffixContentBuilder
  private var isFilled: Bool =  false
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierButtonConfiguration` 객체입니다.
  ///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다.
  ///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    prefixContent: @escaping PrefixContentBuilder,
    suffixContent: @escaping SuffixContentBuilder,
    action: @escaping Action
  ) {
    self.configuration = configuration
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierButtonConfiguration` 객체입니다.
  ///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    prefixContent: @escaping PrefixContentBuilder,
    action: @escaping Action
  ) where SuffixContent == EmptyView {
    self.configuration = configuration
    self.prefixContent = prefixContent
    self.suffixContent = { _ in EmptyView() }
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierButtonConfiguration` 객체입니다.
  ///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    suffixContent: @escaping SuffixContentBuilder,
    action: @escaping Action
  ) where PrefixContent == EmptyView {
    self.configuration = configuration
    self.prefixContent = { _ in EmptyView() }
    self.suffixContent = suffixContent
    self.action = action
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierButtonConfiguration` 객체입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    action: @escaping Action
  ) where PrefixContent == EmptyView, SuffixContent == EmptyView {
    self.configuration = configuration
    self.prefixContent = { _ in EmptyView() }
    self.suffixContent = { _ in EmptyView() }
    self.action = action
  }
  
  // MARK: Body
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: self.configuration.horizontalSpacing) {
        self.prefixContent(self.configuration)
        
        Text(self.configuration.text)
          .applyBezierFontStyle(self.configuration.textFont, bezierColor: self.configuration.textColor)
          .multilineTextAlignment(.leading)
        
        self.suffixContent(self.configuration)
      }
      .padding(.horizontal, self.configuration.horizontalPadding)
      .padding(.vertical, self.configuration.verticalPadding)
      .if(self.isFilled) { view in
        view
          .frame(maxWidth: .infinity, alignment: .center)
      }
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(BezierButtonStyle(configuration: self.configuration))
    .applyDisabledStyle()
    .disabled(self.isLoading)
    .if(self.isLoading) { view in
      view
        .overlay(
          BezierLoader(
            configuration: BezierLoaderConfiguration(
              size: self.configuration.loaderSize,
              variant: self.configuration.loaderVariant
            )
          )
        )
    }
  }
}

// - MARK: Extensions
extension BezierButton {
  /// 로딩 상태를 설정하여 버튼의 아이콘과 레이블 텍스트를 숨기고, Loader로만 표현합니다. 5초 이하의 짧고 단순한 의미 전달이 필요한 경우에만 사용합니다. 로딩 중일 때는 사용자와의 인터렉션이 불가능합니다.
  /// - Parameters:
  ///   - isLoading: 버튼의 로딩 상태를 설정하는 Bool 값입니다. `true`로 설정하면 버튼이 로딩 상태로 전환됩니다.
  public func isLoading(_ isLoading: Bool) -> Self {
    var view = self
    view.isLoading = isLoading
    return view
  }
  
  /// - Parameters:
  ///   - isFilled: 버튼이 가로 길이를 모두 채울지 여부를 설정합니다. 기본값은 `false`입니다.
  public func isFilled(_ isFilled: Bool) -> Self {
    var view = self
    view.isFilled = isFilled
    return view
  }
}

// - MARK: Preview
#Preview {
  BezierButton(
    configuration: BezierButtonConfiguration(
      text: "Test",
      variant: .primary,
      color: .blue,
      size: .xlarge
    ),
    prefixContent: { configuration in
      BezierIcon.android.image
        .frame(length: configuration.affixContentLength)
        .foregroundColor(configuration.affixContentColor.color)
    },
    suffixContent: { configuration in
      BezierIcon.ios.image
        .frame(length: configuration.affixContentLength)
        .foregroundColor(configuration.affixContentColor.color)
    }
  ) {
    print("BezierButton")
  }
}
