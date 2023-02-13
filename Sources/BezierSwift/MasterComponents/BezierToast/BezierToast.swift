//
//  BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

struct BezierToastInfo: Equatable {
  var leftImage: Image?
  var title: String
  
  var leftImageLength: CGFloat { CGFloat(20) }
  var leftImageTopPadding: CGFloat { CGFloat(3) }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
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
  
  private var info: BezierToastInfo
  
  init(info: BezierToastInfo) {
    self.info = info
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: .zero) {
      if self.isPresented {
        VStack {
          HStack(alignment: .top, spacing: Metric.conentHStackSpacing) {
            if let leftImage = self.info.leftImage {
              leftImage
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: self.info.leftImageLength, height: self.info.leftImageLength)
                .padding(.top, self.info.leftImageTopPadding)
            }
            
            VStack {
              Text(self.info.title)
                .applyBezierFontStyle(.bold14, semanticColor: .bgtxtAbsoluteWhiteDark)
                .lineLimit(Constant.textLineLimit)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, Metric.textTopPadding)
            }
          }
          .padding(.vertical, Metric.contentStackVerticalPadding)
          .padding(.horizontal, Metric.contentStackHorizontalPadding)
        }
        .background(self.palette(SemanticColor.bgBlackDarker))
        .applyBlurEffectIfApply()
        .applyBezierCornerRadius(type: .round22)
        .frame(maxWidth: Constant.contentMaxWidth)
        .padding(.horizontal, Metric.contentHorizontalPadding)
        .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .top)), removal: .opacity))
      }
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .onAppear {
      withAnimation(.easeInOut(duration: Constant.animationDuration)) {
        self.isPresented = true
      }
      
      withAnimation(.easeInOut(duration: Constant.animationDuration).delay(Constant.animationDuration + Constant.disappearDelay)) {
        self.isPresented = false
      }
    }
  }
}

private extension View {
  func applyBlurEffectIfApply() -> some View {
    if #available(iOS 15.0, *) {
      return self.background(.thickMaterial)
    } else {
      return self
    }
  }
}

struct BezierToast_Previews: PreviewProvider {
  static var previews: some View {
    EmptyView()
  }
}


