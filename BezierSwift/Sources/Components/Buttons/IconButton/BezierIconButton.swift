//
//  BezierIconButton.swift
//
//
//  Created by Tom on 8/16/24.
//

import SwiftUI

// - MARK: BezierButton
/// - Parameters:
///   - configuration: 버튼의 스타일과 모양을 정의하는 BezierButtonConfiguration 객체입니다.
///   - content: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다.
///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
public struct BezierIconButton<Content: View>: View {
  public typealias Configuration = BezierIconButtonConfiguration
  public typealias Action = () -> Void
  
  // MARK: Properties
  private let configuration: Configuration
  private let content: Content
  private var isLoading: Bool = false
  private var dropdown: Bool?
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierButtonConfiguration` 객체입니다.
  ///   - content: 버튼의 표시될 내용을 지정하는 뷰입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    content: Content = EmptyView(),
    action: @escaping Action
  ) {
    self.configuration = configuration
    self.content = content
    self.action = action
  }
  
  // MARK: Body
  public var body: some View {
    Button {
      self.action()
    } label: {
      HStack(spacing: .zero) {
        Color.clear
          .frame(length: self.configuration.contentLength)
          .overlay(self.content)
        // TODO: dropdown UI 구현 필요 by Tom, 2024.08.16
        // 피그마에 Dropdown 관련 요소가 부족하여 구현이 어려운 상태입니다.
      }
      .padding(self.configuration.padding)
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(BezierIconButtonStyle(configuration: self.configuration))
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
  ///   - dropdown: 드랍다운 등의 인터렉션을 표현하기 위해 사용되는 Bool 값입니다. `true` or `false` 로 설정하면 Dropdown UI가 보입니다.
  public func dropdown(_ dropdown: Bool) -> Self {
    var view = self
    view.dropdown = dropdown
    return view
  }
}

// - MARK: Preview
#Preview {
  BezierIconButton(
    configuration: BezierIconButtonConfiguration(
      variant: .primary,
      color: .blue,
      size: .xlarge,
      shape: .circle
    ),
    content:
      BezierIcon.plus.image
        .frame(length: 24)
        .foregroundColor(BezierColor.fgWhiteNormal.color)
  ) {
    print("BezierButton")
  }
}
