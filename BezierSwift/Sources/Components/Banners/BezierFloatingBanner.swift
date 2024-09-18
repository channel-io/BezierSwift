//
//  BezierFloatingBanner.swift
//
//
//  Created by Tom on 9/18/24.
//

import SwiftUI

// - MARK: Metric
private enum Metric {
  static let padding: CGFloat = 8
  static let cornerRadius: CGFloat = 14
  
  static let contentHStackSpacing: CGFloat = 6
  static let contentHorizontalPadding: CGFloat = 6
  
  static let iconVerticalPadding: CGFloat = 6
  static let iconLegnth: CGFloat = 20
  
  static let descriptionVerticalPadding: CGFloat = 5
  
  static let buttonIconLenght: CGFloat = 20
  static let buttonIconPadding: CGFloat = 6
}

// - MARK: BezierFloatingBanner
public struct BezierFloatingBanner: View {
  public typealias Action = () -> Void
  
  // MARK: ActionType
  public enum ActionType {
    case closeButton(Action)
    case chevronIcon(Action)
  }
  
  // MARK: Properties
  private let icon: BezierIcon
  private let iconColor: BezierColor
  private let description: String
  private let actionType: ActionType?
  
  // MARK: Initializer
  /// - Parameters:
  ///   - icon: 사용자에게 알림의 종류를 한눈에 알려주는 Icon 입니다.
  ///   - iconColor: Icon Color를 변경할 수 있습니다. 기본 값은 `fgBlackDark` 입니다.
  ///   - description: 배너의 본문 내용을 전달하는 역할을 합니다. 최대 4줄을 권장합니다.
  ///   - actionType: 배너 우측에 배치될 액션 버튼입니다. `closeButton` 또는 `chevronIcon`을 선택하여 사용자 인터랙션을 제공할 수 있으며, 이 값이 `nil`인 경우 버튼이 표시되지 않습니다.
  public init(
    icon: BezierIcon,
    iconColor: BezierColor = .fgBlackDark,
    description: String,
    actionType: ActionType? = nil
  ) {
    self.icon = icon
    self.iconColor = iconColor
    self.description = description
    self.actionType = actionType
  }
  
  // MARK: Body
  public var body: some View {
    HStack(alignment: .top, spacing: .zero) {
      HStack(alignment: .top, spacing: Metric.contentHStackSpacing) {
        self.icon.image
          .frame(length: Metric.iconLegnth)
          .padding(.top, Metric.iconVerticalPadding)
          .foregroundColor(self.iconColor.color)
        
        Text(self.description)
          .applyBezierFontStyle(.body2Regular, bezierColor: .fgBlackDarkest)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, Metric.descriptionVerticalPadding)
      }
      .padding(.horizontal, Metric.contentHorizontalPadding)
      
      self.actionButton
    }
    .padding(Metric.padding)
    .background(
      RoundedRectangle(cornerRadius: Metric.cornerRadius, style: .circular)
        .fill(BezierColor.bgGreyLighter.color)
    )
    .applyBezierShadow(.shadow3)
  }
}

// - MARK: Style
extension BezierFloatingBanner {
  @ViewBuilder
  private var actionButton: some View {
    switch self.actionType {
    case .chevronIcon(let action):
      Button {
        action()
      } label: {
        BezierIcon.chevronSmallRight.image
          .foregroundColor(BezierColor.fgBlackDark.color)
          .frame(length: Metric.buttonIconLenght)
          .padding(Metric.buttonIconPadding)
          .contentShape(Rectangle())
      }
    case .closeButton(let action):
      Button {
        action()
      } label: {
        BezierIcon.cancelSmall.image
          .foregroundColor(BezierColor.fgBlackDark.color)
          .frame(length: Metric.buttonIconLenght)
          .padding(Metric.buttonIconPadding)
          .contentShape(Rectangle())
      }
    case .none: EmptyView()
    }
  }
}

#Preview {
  BezierFloatingBanner(icon: .info, description: "description")
}
