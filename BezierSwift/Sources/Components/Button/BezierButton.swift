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
public struct BezierButton<
  PrefixContent: BezierButtonPrefixContent,
  SuffixContent: BezierButtonSuffixContent
>: View {
  public typealias Action = () -> Void
  
  // MARK: Properties
  private let configuration: BezierButtonConfiguration
  private let prefixContent: PrefixContent
  private let suffixContent: SuffixContent
  private var isLoading: Bool = false
  private let action: Action
  
  // MARK: Initializer
  public init(
    configuration: BezierButtonConfiguration,
    prefixContent: PrefixContent = EmptyView(),
    suffixContent: SuffixContent = EmptyView(),
    action: @escaping Action
  ) {
    self.configuration = configuration
    self.prefixContent = prefixContent
    self.suffixContent = suffixContent
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
        
        self.prefixContent
          .frame(
            width: self.configuration.affixContentSize.width,
            height: self.configuration.affixContentSize.height
          )
          .applyTintBezierColor(self.configuration.affixContentForegroundColor)
      }
      .padding(.horizontal, self.configuration.horizontalPadding)
      .frame(height: self.configuration.height)
      .frame(maxWidth: .infinity, alignment: .center)
      .if(self.isLoading) { view in
        view
          .opacity(.zero)
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
    .buttonStyle(BezierButtonStyle(configuration: self.configuration))
    .applyDisabledStyle()
  }
}

// - MARK: Extensions
extension BezierButton {
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
