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
  let uuid = UUID()
  var id: UUID { self.uuid }
}

public final class BezierToastViewModel1: ObservableObject {
  @Published private(set) var toastItems: [BezierToastItem] = []
  private(set) var removeToastSubject = PassthroughSubject<UUID, Never>()
  private var cancelBag = Set<AnyCancellable>()

  init() {
    self.removeToastSubject
      .delay(for: 3, scheduler: DispatchQueue.main)
      .sink { uuid in
        guard let index = self.toastItems.firstIndex(where: { $0.uuid == uuid }) else { return }
        
        self.toastItems.remove(at: index)
      }
      .store(in: &self.cancelBag)
  }
  
  func appendToastParam(_ param: BezierToastParam) {
    self.toastItems.forEach {
      self.removeToastSubject.send($0.uuid)
    }

    self.toastItems.append(BezierToastItem(param: param))
  }
  
  func pulisherForRemoteToast() -> AnyPublisher<UUID, Never> {
    self.removeToastSubject.eraseToAnyPublisher()
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
      ForEach(self.viewModel.toastItems) { item in
        BezierToast1(item: item)
      }
      Color.clear
    }
    .environmentObject(self.viewModel)
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
  @State private var timer = Timer.publish(every: Constant.disappearDelay, on: .main, in: .common).autoconnect()
  @State private var isPresented: Bool = false
  @State private var willDismiss: Bool = false

  private var offsetY: CGFloat {
    self.isPresented || self.willDismiss
    ? self.param.toastPosition.endOffsetY
    : self.param.toastPosition.startOffsetY
  }
  
  private var opacity: CGFloat {
    self.isPresented ? 1 : 0
  }

  private var param: BezierToastParam
  private let viewId: UUID?
  
  init(item: BezierToastItem) {
    self.param = item.param
    self.viewId = item.uuid
  }
  
  public init(param: BezierToastParam) {
    self.param = param
    self.viewId = nil
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
    .offset(y: self.offsetY)
    .opacity(self.opacity)
    .onAppear {
      withAnimation(.easeIn(duration: Constant.animationDuration)) {
        self.isPresented = true
      }
    }
    .onReceive(self.viewModel.pulisherForRemoteToast()) { uuid in
      guard uuid == self.viewId else { return }
      
      self.prepareDismiss()
    }
    .onReceive(self.timer) { _ in
      self.prepareDismiss()
    }
  }
  
  private func prepareDismiss() {
    withAnimation(.easeOut(duration: Constant.animationDuration)) {
      self.willDismiss = true
      self.isPresented = false
      self.param.isShowing?.wrappedValue = false
    }
  }
}

public struct BezierToastParam {
  var title: String
  var toastPosition: BezierToastPosition
  var leftItem: BezierToastLeftItem?
  var isShowing: Binding<Bool>?
  
  public init(title: String, leftItem: BezierToastLeftItem? = nil, isShowing: Binding<Bool>? = nil) {
    self.title = title
    self.toastPosition = .top
    self.leftItem = leftItem
    self.isShowing = isShowing
  }
}

public enum BezierToastLeftItem {
  // TODO: 추후 이모지 지원 작업하기
  // by woody 2003.31
  // case emoji(name: String)
  case icon(image: Image, color: SemanticColor)

  var length: CGFloat { return 20 }
  var top: CGFloat { return 3 }
}

public enum BezierToastPosition {
  case top

  var startOffsetY: CGFloat {
    switch self {
    case .top: return -16
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
