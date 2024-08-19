//
//  BezierDialog.swift
//
//
//  Created by Jam on 2023/02/15.
//

import SwiftUI
import Dispatch
import SDWebImageSwiftUI

private enum Metric {
  static let dialogPadding = 16.f
  static let dialogMaxWidth = 480.f
  
  static let containerVStackSpacing = 20.f
  
  static let upperVStackTopPadding = 4.f
  static let upperVStackSpacing = 8.f

  static let belowStackSpacing = 8.f
}

private enum Constant {
  static let maxHorizontalButtonCount = 2
  static let maxVerticalButtonCount = 4
}

struct BezierDialog: View, Themeable {
  @Environment(\.colorScheme) var colorScheme
  
  struct ViewState {
    let title: String
    let description: String
    let imageUrl: URL?
    let buttons: [BezierButton]
    let buttonAxis: Axis
    
    init(param: BezierDialogParam) {
      self.title = param.title
      self.description = param.description
      self.imageUrl = param.imageUrl
      
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
    VStack(alignment: .center, spacing: Metric.containerVStackSpacing) {
      VStack(alignment: .center, spacing: Metric.upperVStackSpacing) {
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
        
        if let imageUrl = self.viewState.imageUrl {
          WebImage(url: imageUrl)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
        }
      }
      .padding(.top, Metric.upperVStackTopPadding)
      
      // TODO: middle custom views spec 구현 예정
      // by woody 2023.01.08
      
      if !self.viewState.buttons.isEmpty {
        switch self.viewState.buttonAxis {
        case .horizontal:
          HStack(spacing: Metric.belowStackSpacing) {
            ForEach(self.viewState.buttons.indices, id: \.self) { idx in
              self.viewState.buttons[idx]
            }
          }
          
        case .vertical:
          VStack(spacing: Metric.belowStackSpacing) {
            ForEach(self.viewState.buttons.indices, id: \.self) { idx in
              self.viewState.buttons[idx]
            }
          }
        }
      }
    }
    .padding(.all, Metric.dialogPadding)
    .frame(maxWidth: Metric.dialogMaxWidth)
    .background(self.palette(.bgWhiteHigh))
    .applyBezierCornerRadius(type: .round16)
    .applyBezierElevation(.mEv3)
  }
}
