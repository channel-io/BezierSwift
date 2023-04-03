//
//  BezierToastContainerView.swift
//  
//
//  Created by woody on 2023/03/31.
//

import Foundation
import SwiftUI

import Combine

private enum Constant {
  static let maxToastCount = 1
}

struct BezierToastItem: Identifiable {
  let param: BezierToastParam
  let binding: Binding<BezierToastParam?>?
  let uuid = UUID()
  var id: UUID { self.uuid }
  
  init(param: BezierToastParam, binding: Binding<BezierToastParam?>? = nil) {
    self.param = param
    self.binding = binding
  }
}

public final class BezierToastViewModel1: ObservableObject {
  @Published private(set) var toastItems: [BezierToastItem] = []
//  private var cancelBag = Set<AnyCancellable>()
//  private var timerCancelBags: [UUID: AnyCancellable] = [:]
  
  func appendToastItem(_ item: BezierToastItem) {
//    while self.toastItems.count >= Constant.maxToastCount {
//      let toastItem = self.toastItems.removeFirst()
//      toastItem.binding?.wrappedValue = nil
//    }
//
    withAnimation(.easeIn(duration: 2)) {
      self.toastItems.append(item)
    }
  }
}

public struct BezierToastContainerView: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @StateObject private var viewModel: BezierToastViewModel1
  
  public init(viewModel: BezierToastViewModel1) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ZStack(alignment: .top) {
      if let item = self.viewModel.toastItems.first {
        BezierToast1(item: item)
          .transition(.scale)
      }
//      ForEach(self.viewModel.toastItems) { item in
//      }
//      Color.clear
    }
//    .environmentObject(self.viewModel)
  }
}

public struct BezierToast1: View, Themeable {
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
  @EnvironmentObject private var viewModel: BezierToastViewModel1
  
  private var param: BezierToastParam

  init(item: BezierToastItem) {
    self.param = item.param
  }
  
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
//    .transition(.toast(position: self.param.toastPosition))
  }
}

public struct BezierToastParam: Equatable {
  var title: String
  var toastPosition: BezierToastPosition
  var leftItem: BezierToastLeftItem?
  
  public init(title: String, leftItem: BezierToastLeftItem? = nil) {
    self.title = title
    self.toastPosition = .top
    self.leftItem = leftItem
  }
}

public enum BezierToastLeftItem: Equatable {
  // TODO: 추후 이모지 지원 작업하기
  // by woody 2003.31
  // case emoji(name: String)
  case icon(image: Image, color: SemanticColor)

  var length: CGFloat { return 20 }
  var top: CGFloat { return 3 }
  
  public static func == (lhs: BezierToastLeftItem, rhs: BezierToastLeftItem) -> Bool {
    switch (lhs, rhs) {
    case (.icon(let lhsImage, let lhsColor), .icon(let rhsImage, let rhsColor)):
      return lhsImage == rhsImage
      && lhsColor.light == rhsColor.light
      && lhsColor.dark == rhsColor.dark
    }
  }
}

public enum BezierToastPosition: Equatable {
  case top

  var startOffsetY: CGFloat {
    switch self {
    case .top: return -50 // -16
    }
  }

  var endOffsetY: CGFloat {
    switch self {
    case .top: return 4
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

extension AnyTransition {
  public static func toast(position: BezierToastPosition) -> AnyTransition {
    AnyTransition.modifier(
      active: ModalModifier(position: position, transitionPercent: 0),
      identity: ModalModifier(position: position, transitionPercent: 1)
    )
  }
  
  struct ModalModifier: Animatable, ViewModifier {
    let position: BezierToastPosition
    var transitionPercent: Double
    
    private var offsetY: CGFloat {
      position.startOffsetY + (position.endOffsetY - position.startOffsetY) * transitionPercent
    }
    
    func body(content: Content) -> some View {
      let _ = print(transitionPercent)
      return content
        .opacity(self.transitionPercent)
        .offset(y: self.transitionPercent > 0.5 ? -20 : 0)
    }
  }
}
