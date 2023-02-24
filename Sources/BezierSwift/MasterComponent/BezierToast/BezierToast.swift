//
//  BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

public struct BezierToastViewModel: Equatable {
  var leftImage: Image?
  var leftImageTintColor: SemanticColor?
  var title: String
  
  var leftImageLength: CGFloat { 20 }
  var leftImageTopPadding: CGFloat { 3 }
  
  public init(title: String) {
    self.title = title
  }
  
  public init(leftImage: Image, title: String) {
    self.leftImage = leftImage
    self.title = title
  }
  
  public init(leftImage: Image, leftImageTintColor: SemanticColor, title: String) {
    self.leftImage = leftImage
    self.leftImageTintColor = leftImageTintColor
    self.title = title
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return false
  }
}

struct BezierToast: View, Themeable {
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
  
  @State private var isPresented: Bool = false
  
  private var viewModel: BezierToastViewModel
  
  init(viewModel: BezierToastViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: .zero) {
      if self.isPresented {
        VStack(spacing: .zero) {
          HStack(alignment: .top, spacing: Metric.conentHStackSpacing) {
            if let leftImage = self.viewModel.leftImage, let leftImageTintColor = self.viewModel.leftImageTintColor {
              leftImage
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: self.viewModel.leftImageLength, height: self.viewModel.leftImageLength)
                .padding(.top, self.viewModel.leftImageTopPadding)
                .foregroundColor(self.palette(leftImageTintColor))
            } else if let leftImage = self.viewModel.leftImage {
              leftImage
                .resizable()
                .scaledToFit()
                .frame(width: self.viewModel.leftImageLength, height: self.viewModel.leftImageLength)
                .padding(.top, self.viewModel.leftImageTopPadding)
            }
            
            Text(self.viewModel.title)
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
        .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
      }
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .onAppear {
      withAnimation(.easeIn(duration: Constant.animationDuration)) {
        self.isPresented = true
      }
      
      withAnimation(.easeOut(duration: Constant.animationDuration).delay(Constant.animationDuration + Constant.disappearDelay)) {
        self.isPresented = false
      }
    }
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

struct BezierToast_Previews: PreviewProvider {
  static var previews: some View {
    let onlyTitleViewModel = BezierToastViewModel(title: "Bezier Toast")
    let withImageViewModel = BezierToastViewModel(leftImage: Image(systemName: "globe"), title: "Bezier Toast")
    let withIconViewModel = BezierToastViewModel(
      leftImage: Image(systemName: "globe"),
      leftImageTintColor: .bgtxtOrangeNormal,
      title: "Bezier Toast"
    )
    
    return VStack {
      BezierToast(viewModel: onlyTitleViewModel)
      BezierToast(viewModel: withImageViewModel)
      BezierToast(viewModel: withIconViewModel)
    }
    // If you want a global toast, use it
    .bezierToast(viewModel: .constant(onlyTitleViewModel))
  }
}


