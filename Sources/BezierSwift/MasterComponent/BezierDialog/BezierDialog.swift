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

public enum BezierDialogButtonInfo {
  case vertical([BezierButton])
  case horizontal([BezierButton])
}

public struct BezierDialogParam {
  var id = UUID()
  
  // TODO: priority 일정 enum으로 제한두기. by jam 2023.02.24
  var priority: Int
  var title: String
  var description: String
  var buttonInfo: BezierDialogButtonInfo?
  var dismissCompletion: (() -> Void)?
  
  public init(priority: Int, title: String?, description: String?, buttonInfo: BezierDialogButtonInfo?, dismissCompletion: (() -> Void)?) {
    self.priority = priority
    self.title = title ?? ""
    self.description = description ?? ""
    self.buttonInfo = buttonInfo
    self.dismissCompletion = dismissCompletion
  }
}

public struct BezierDialogManager {
  public static func show(with param: BezierDialogParam) {
    BezierDialogSingleton.shared.viewModel.update(param: param)
  }

  public static func dismiss() {
    BezierDialogSingleton.shared.viewModel.dismiss()
  }
}

extension View {
  @available(iOS 15.0, *)
  public func initBezierDialog() -> some View {
    self.modifier(BezierDialog())
  }
}

class DialogViewModel: ObservableObject {
  @Published private(set) var isPresented: Bool = false
  
  @Published var title: String = ""
  @Published var description: String = ""
  @Published var buttons: [BezierButton] = []
  @Published var isButtonStackVertical = false
  
  var currentParamId: UUID = UUID()
  var currentDismissCompletion: (() -> Void)?
  var currentPriority: Int = Int.min
  
  func update(param: BezierDialogParam) {
    guard param.priority > self.currentPriority else {
      param.dismissCompletion?()
      return
    }
    
    self.dismiss()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      guard let self = self else { return }
      
      self.currentParamId = param.id
      self.currentDismissCompletion = param.dismissCompletion
      self.currentPriority = param.priority
      
      self.title = param.title
      self.description = param.description
      
      if let buttonInfo = param.buttonInfo {
        switch buttonInfo {
        case .vertical(let buttons):
          self.buttons = buttons
          self.isButtonStackVertical = true
        case .horizontal(let buttons):
          self.buttons = buttons
          self.isButtonStackVertical = false
        }
      }
    }
    
    self.isPresented = true
  }
  
  func dismiss() {
    self.currentDismissCompletion?()
    
    self.currentDismissCompletion = nil
    self.currentParamId = UUID()
    self.currentPriority = Int.min
    
    self.isPresented = false
  }
}

class BezierDialogSingleton {
  var viewModel: DialogViewModel
  
  static let shared = BezierDialogSingleton()

  init() {
    self.viewModel = DialogViewModel()
  }
}

@available(iOS 15.0, *)
struct BezierDialog: ViewModifier, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  
  @StateObject private var viewModel: DialogViewModel = BezierDialogSingleton.shared.viewModel
  
  
  func body(content: Content) -> some View {
    
    content
      .overlay {
        if viewModel.isPresented {
          self.palette(.bgtxtAbsoluteBlackLighter)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
              VStack(alignment: .center, spacing: .zero) {
                HStack(spacing: .zero) {
                  HStack(spacing: .zero) {
                    Spacer()
                    VStack(alignment: .center, spacing: Metric.belowStackTop) {
                      if !viewModel.title.isEmpty || !viewModel.description.isEmpty {
                        VStack(alignment: .center, spacing: Metric.upperStackSpace) {
                          Text(viewModel.title)
                            .applyBezierFontStyle(.bold16)
                          Text(viewModel.description)
                            .applyBezierFontStyle(.normal14)
                        }
                        .padding(.top, Metric.upperStackContainerTop)
                      }

                      if !viewModel.buttons.isEmpty {
                        if viewModel.isButtonStackVertical {
                          VStack(spacing: Metric.belowStackSpace) {
                            ForEach(viewModel.buttons.prefix(4).indices, id: \.self) { idx in
                              viewModel.buttons[idx]
                            }
                          }
                        } else {
                          HStack(spacing: Metric.belowStackSpace) {
                            ForEach(viewModel.buttons.prefix(2).indices, id: \.self) { idx in
                              viewModel.buttons[idx]
                            }
                          }
                        }
                      }
                      
                    }
                    .padding(.all, Metric.dialogPadding)
                    .frame(maxWidth: .infinity)

                    Spacer()
                  }
                  .background(self.palette(.bgWhiteHigh))
                  .applyBezierCornerRadius(type: .round16)
                  .applyBezierElevation(self, type: .mEv3)
                  .frame(maxWidth: Metric.dialogMaxWidth)
                  .padding(.horizontal, Metric.dimSideMinPadding)
                }
              }
            }
        }
      }
  }
}

// TODO: 프리뷰 살리기(현재 xcode 크러시 남) by jam 2023.02.24
//struct BezierDialog_Previews: PreviewProvider {
//    static var previews: some View {
//      if #available(iOS 15.0, *) {
//        Color.clear
//          .initBezierDialog()
//          .task {
//            BezierDialogManager.show(
//              with: BezierDialogParam(
//                title: "testTitle",
//                description: "testDescription",
//                buttonInfo: .horizontal(
//                  [
//                    BezierButton(size: .large, type: .primary(.blue), resizing: .fill, title: "버튼1") {
//                      print("")
//                    },
//
//                    BezierButton(size: .large, type: .primary(.monochromeDark), resizing: .fill, title: "버튼2") {
//                      print("")
//                    }
//                  ]
//                ))
//            )
//          }
//      } else {
//        EmptyView()
//      }
//    }
//}
