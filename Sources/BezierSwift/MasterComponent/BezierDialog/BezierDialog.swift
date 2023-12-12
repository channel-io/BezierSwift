//
//  BezierDialog.swift
//
//
//  Created by Jam on 2023/02/15.
//

import SwiftUI
import Dispatch

private enum Metric {
  static let dimSideMinPadding = CGFloat(40)
  
  static let dialogMaxWidth = CGFloat(480)
  static let dialogPadding = CGFloat(16)
  
  static let upperStackContainerTop = CGFloat(4)
  static let upperStackSpace = CGFloat(8)
  
  static let middleStackTop = CGFloat(16)
  static let middleStackSpace = CGFloat(12)
  
  static let belowStackTop = CGFloat(20)
  static let belowStackSpace = CGFloat(8)
}

private enum Constant {
  static let maxHorizontalButtonCount = 4
  static let maxVerticalButtonCount = 2
}

struct BezierDialog: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  struct ViewState {
    let title: String
    let description: String
    let buttons: [BezierButton]
    let buttonAxis: Axis
    
    init(param: BezierDialogParam) {
      self.title = param.title
      self.description = param.description
      
      switch param.buttonInfo {
      case .horizontal(let buttons):
        self.buttonAxis = .horizontal
        self.buttons = Array(buttons.prefix(Constant.maxHorizontalButtonCount))
      case .vertical(let buttons):
        self.buttonAxis = .vertical
        self.buttons = Array(buttons.prefix(Constant.maxVerticalButtonCount))
      default:
        self.buttonAxis = .vertical
        self.buttons = []
      }
    }
  }
  
  private let viewState: ViewState
  
  init(param: BezierDialogParam) {
    self.viewState = ViewState(param: param)
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: .zero) {
      HStack(spacing: .zero) {
        HStack(spacing: .zero) {
          VStack(alignment: .center, spacing: Metric.belowStackTop) {
            VStack(alignment: .center, spacing: Metric.upperStackSpace) {
              if !self.viewState.title.isEmpty {
                Text(self.viewState.title)
                  .applyBezierFontStyle(.bold16)
                  .multilineTextAlignment(.center)
              }
              
              if !self.viewState.description.isEmpty {
                Text(self.viewState.description)
                  .applyBezierFontStyle(.normal14)
                  .multilineTextAlignment(.center)
              }
            }
            .padding(.top, Metric.upperStackContainerTop)
            
            if !self.viewState.buttons.isEmpty {
              switch self.viewState.buttonAxis {
              case .horizontal:
                HStack(spacing: Metric.belowStackSpace) {
                  ForEach(self.viewState.buttons.indices, id: \.self) { idx in
                    self.viewState.buttons[idx]
                  }
                }
                
              case .vertical:
                VStack(spacing: Metric.belowStackSpace) {
                  ForEach(self.viewState.buttons.indices, id: \.self) { idx in
                    self.viewState.buttons[idx]
                  }
                }
              }
            }
          }
          .padding(.all, Metric.dialogPadding)
          .frame(maxWidth: .infinity)
        }
        .background(self.palette(.bgWhiteHigh))
        .applyBezierCornerRadius(type: .round16)
        .applyBezierElevation(.mEv3)
        .frame(maxWidth: Metric.dialogMaxWidth)
        .padding(.horizontal, Metric.dimSideMinPadding)
      }
    }
  }
}
