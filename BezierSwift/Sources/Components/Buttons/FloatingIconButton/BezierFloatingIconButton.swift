//
//  BezierFloatingIconButton.swift
//
//
//  Created by Tom on 8/20/24.
//

import SwiftUI

// - MARK: BezierFloatingIconButton
/// - Parameters:
///   - configuration: 버튼의 스타일과 모양을 정의하는 BezierFloatingIconButtonConfiguration 객체입니다.
///   - content: 버튼의 앞부분에 표시될 내용을 지정하는 뷰입니다.
///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
public struct BezierFloatingIconButton<Content: View>: View {
  public typealias Configuration = BezierFloatingIconButtonConfiguration
  public typealias Action = () -> Void
  
  // MARK: Properties
  private let configuration: Configuration
  private let content: (Configuration) -> Content
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierFloatingIconButtonConfiguration` 객체입니다.
  ///   - content: 버튼의 표시될 내용을 지정하는 뷰입니다.
  ///   - action: 버튼이 눌렸을 때 실행될 클로저입니다.
  public init(
    configuration: Configuration,
    content: @escaping (Configuration) -> Content,
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
        self.content(self.configuration)
      }
      .padding(self.configuration.padding)
      .contentShape(Rectangle())
      .visible(!self.isLoading)
    }
    .buttonStyle(BezierFloatingIconButtonStyle(configuration: self.configuration))
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
    configuration: BezierFloatingIconButtonConfiguration(
      variant: .secondary,
      color: .blue,
      size: .xlarge
    ),
    content: { configuration in
      BezierIcon.plus.image
        .frame(length: configuration.contentLength)
        .foregroundColor(configuration.contentForegroundColor.color)
    }
  ) {
    print("BezierFloatingIconButton")
  }
}
