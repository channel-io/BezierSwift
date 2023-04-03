//
//  BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

public struct BezierToast: View, Themeable {
  private enum Metric {
    static let contentHorizontalPadding = CGFloat(10)
    
    static let conentHStackSpacing = CGFloat(6)
    static let contentStackVerticalPadding = CGFloat(10)
    static let contentStackHorizontalPadding = CGFloat(14)
    
    static let textTopPadding = CGFloat(4)
  }
  
  private enum Constant {
    static let contentMaxWidth = CGFloat(460)
    static let textLineLimit = 2
    static let animationDuration = CGFloat(0.3)
    static let disappearDelay = CGFloat(3.0)
  }
  
  @Environment(\.colorScheme) public var colorScheme
  @EnvironmentObject private var viewModel: BezierToastViewModel
  
  private let param: BezierToastParam

  public init(param: BezierToastParam) {
    self.param = param
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      HStack(alignment: .top, spacing: Metric.conentHStackSpacing) {
        if let leftItem = self.param.leftItem {
          switch leftItem {
          case .icon(let image, let color):
            image
              .renderingMode(.template)
              .resizable()
              .scaledToFit()
              .frame(width: leftItem.length, height: leftItem.length)
              .padding(.top, leftItem.top)
              .foregroundColor(self.palette(color))
          }
        }
        
        Text(self.param.title)
          .applyBezierFontStyle(.bold14, semanticColor: .bgtxtAbsoluteWhiteDark)
          .lineLimit(Constant.textLineLimit)
          .padding(.vertical, Metric.textTopPadding)
      }
      .padding(.vertical, Metric.contentStackVerticalPadding)
      .padding(.horizontal, Metric.contentStackHorizontalPadding)
    }
    .background(self.palette(.bgBlackDarker))
    .applyBlurEffect()
    .applyBezierCornerRadius(type: .round22)
    .frame(maxWidth: Constant.contentMaxWidth)
    .padding(.horizontal, Metric.contentHorizontalPadding)
  }
}

private extension View {
  func applyBlurEffect() -> some View {
    if #available(iOS 15.0, *) {
      return self.background(.thickMaterial)
    } else {
      return self
    }
  }
}
