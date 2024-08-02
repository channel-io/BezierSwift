//
//  BezierButton.swift
//
//
//  Created by Tom on 6/28/24.
//

import SwiftUI

// - MARK: Protocols
public protocol BezierButtonPrefixContent: View { }
public protocol BezierButtonSuffixContent: View { }

// - MARK: BezierButton
/// - Parameters:
///   - configuration: 버튼의 스타일과 모양을 정의하는 BezierButtonConfiguration 객체입니다.
///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다. 기본값은 `EmptyView`입니다.
///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다. 기본값은 `EmptyView`입니다.
///   - isFilled: 버튼이 가로 길이를 모두 채울지 여부를 설정합니다. 기본값은 `false`입니다.
///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
public struct BezierButton<
  PrefixContent: BezierButtonPrefixContent,
  SuffixContent: BezierButtonSuffixContent
>: View {
  public typealias Action = () -> Void
  
  // MARK: Properties
  private let configuration: BezierButtonConfiguration
  private let prefixContent: PrefixContent
  private let suffixContent: SuffixContent
  private let isFilled: Bool
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 BezierButtonConfiguration 객체입니다.
  ///   - prefixContent: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다. 기본값은 `EmptyView`입니다.
  ///   - suffixContent: 버튼의 뒷부분에 표시될 내용을 지정하는 뷰입니다. 기본값은 `EmptyView`입니다.
  ///   - isFilled: 버튼이 가로 길이를 모두 채울지 여부를 설정합니다. 기본값은 `false`입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: BezierButtonConfiguration,
    prefixContent: PrefixContent = EmptyView(),
    suffixContent: SuffixContent = EmptyView(),
    isFilled: Bool = false,
    action: @escaping Action
  ) {
    self.configuration = configuration
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
    self.isFilled = isFilled
    self.action = action
  }
  
  // MARK: Body
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: self.configuration.horizontalSpacing) {
        self.suffixContent
          .frame(
            width: self.configuration.affixContentSize.width,
            height: self.configuration.affixContentSize.height
          )
          .applyTintBezierColor(self.configuration.affixContentForegroundColor)
        
        Text(self.configuration.text)
          .applyBezierFontStyle(self.configuration.textFont, bezierColor: self.configuration.textColor)
          .multilineTextAlignment(.leading)
        
        self.prefixContent
          .frame(
            width: self.configuration.affixContentSize.width,
            height: self.configuration.affixContentSize.height
          )
          .applyTintBezierColor(self.configuration.affixContentForegroundColor)
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
              size: .small,
              variant: self.configuration.variant == .primary ? .onOverlay : .secondary
            )
          )
          .scaleToFit(size: self.configuration.affixContentSize)
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
}

// - MARK: Affix Content Extensions
extension EmptyView: BezierButtonPrefixContent { }
extension EmptyView: BezierButtonSuffixContent { }

// - MARK: Preview
#Preview {
  BezierButton(
    configuration: BezierButtonConfiguration(
      text: "Test",
      variant: .primary,
      color: .blue,
      size: .xlarge
    ),
    prefixContent: BezierIconView(bezierIcon: .all),
    suffixContent: BezierIconView(bezierIcon: .ios)
  ) {
    print("BezierButton")
  }
}
