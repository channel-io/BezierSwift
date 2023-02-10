//
//  BezierToast.swift
//  
//
//  Created by dumba on 2023/02/10.
//

import SwiftUI

struct BezierToastInfo: Equatable {
  enum LeftItemInfo {
    case emoji(url: URL?)
    case icon(image: Image?, color: SemanticColor)
    
    var length: CGFloat { return CGFloat(20) }
    var top: CGFloat { return CGFloat(3) }
  }
  
  var leftItem: LeftItemInfo
  var title: String
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    return false
  }
}


@available(iOS 15.0, *)
struct BezierToast: View, Themeable {
  private enum Metric {
    static let contentHorizontalPadding = CGFloat(10)
    
    static let conentHStackSpacing = CGFloat(6)
    static let contentStackVerticalPadding = CGFloat(10)
    static let contentStackHorizontalPadding = CGFloat(14)
    
    static let iconLength = CGFloat(20)
    static let iconTopPadding = CGFloat(3)
    
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
            switch self.info.leftItem {
            case .emoji(let url):
              AsyncImage(url: url)
                .frame(width: Metric.iconLength, height: Metric.iconLength)
                .padding(.top, Metric.iconTopPadding)
            case .icon(let image, color: let color):
              image?
                .renderingMode(.template)
                .foregroundColor(self.palette(color))
                .frame(width: Metric.iconLength, height: Metric.iconLength)
                .padding(.top, Metric.iconTopPadding)
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
        .background(.thickMaterial)
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

struct BezierToast_Previews: PreviewProvider {
  static var previews: some View {
    EmptyView()
  }
}


