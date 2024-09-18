//
//  BezierInnerBanner.swift
//
//
//  Created by Tom on 9/17/24.
//

import SwiftUI

// - MARK: Metric
private enum Metric {
  static let hStackSpacing: CGFloat = 6
  static let leadingPadding: CGFloat = 12
  static let trailingPadding: CGFloat = 6
  static let verticalPadding: CGFloat = 8
  static let cornerRadius: CGFloat = 14
  
  static let iconTopPadding: CGFloat = 6
  static let iconLegnth: CGFloat = 20
  
  static let titleVStackSpacing: CGFloat = 4
  static let titleVerticalPadding: CGFloat = 5
  static let titleTrailingPadding: CGFloat = 6
  
  static let buttonIconLenght: CGFloat = 20
  static let buttonIconPadding: CGFloat = 6
}

// - MARK: BezierInnerBanner
public struct BezierInnerBanner: View {
  public typealias Action = () -> Void
  
  // MARK: Semantic
  public enum Semantic {
    case info
    case tips
    case success
    case warning
    case error
  }
  
  // MARK: ActionType
  public enum ActionType {
    case closeButton(Action)
    case chevronIcon(Action)
  }
  
  // MARK: Properties
  private let sematic: Semantic
  private let icon: BezierIcon
  private let title: String?
  private let description: String
  private let actionType: ActionType?
  
  // MARK: Initializer
  /// - Parameters:
  ///   - sematic: 배너의 사용 의도에 따라 `info`, `tips`, `success`, `warning`, `error` 중 하나를 선택할 수 있습니다.
  ///   - icon: 사용자에게 알림의 종류를 한눈에 알려주는 Icon 입니다. 색상은 변경이 불가능합니다.
  ///   - title: 배너의 제목 텍스트로, 선택적으로 사용할 수 있습니다. `nil` 값을 전달하면 제목은 표시되지 않습니다. 최대 2줄을 권장합니다.
  ///   - description: 배너의 설명 텍스트로, 반드시 전달해야 하는 필수 값입니다. 배너의 본문 내용을 전달하는 역할을 합니다. 최대 4줄을 권장합니다.
  ///   - actionType: 배너 우측에 배치될 액션 버튼입니다. `closeButton` 또는 `chevronIcon`을 선택하여 사용자 인터랙션을 제공할 수 있으며, 이 값이 `nil`인 경우 버튼이 표시되지 않습니다.
  public init(
    sematic: Semantic = .info,
    icon: BezierIcon,
    title: String? = nil,
    description: String,
    actionType: ActionType? = nil
  ) {
    self.sematic = sematic
    self.icon = icon
    self.title = title
    self.description = description
    self.actionType = actionType
  }
  
  // MARK: Body
  public var body: some View {
    HStack(alignment: .top, spacing: Metric.hStackSpacing) {
      self.icon.image
        .frame(length: Metric.iconLegnth)
        .padding(.top, Metric.iconTopPadding)
        .foregroundColor(self.foregroundColor.color)
      
      VStack(alignment: .leading, spacing: Metric.titleVStackSpacing) {
        if let title {
          Text(title)
            .applyBezierFontStyle(.body2SemiBold, bezierColor: self.foregroundColor)
        }
        Text(self.description)
          .applyBezierFontStyle(.body2Regular, bezierColor: self.foregroundColor)
      }
      .padding(.vertical, Metric.titleVerticalPadding)
      .padding(.trailing, Metric.titleTrailingPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      self.actionButton
    }
    .padding(.vertical, Metric.verticalPadding)
    .padding(.leading, Metric.leadingPadding)
    .padding(.trailing, Metric.trailingPadding)
    .background(
      RoundedRectangle(cornerRadius: Metric.cornerRadius, style: .circular)
        .fill(self.backgroundColor.color)
    )
  }
}

// - MARK: Style
extension BezierInnerBanner {
  private var backgroundColor: BezierColor {
    switch self.sematic {
    case .info: .bgBlackLightest
    case .tips: .accentBgLightest
    case .success: .successBgLightest
    case .warning: .warningBgLightest
    case .error: .criticalBgLightest
    }
  }
  
  private var foregroundColor: BezierColor {
    switch self.sematic {
    case .info: .fgBlackDarker
    case .tips: .accentFgDark
    case .success: .successFgDark
    case .warning: .warningFgDark
    case .error: .criticalFgDark
    }
  }
  
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
  BezierInnerBanner(
    sematic: .error,
    icon: .info,
    title: "Title Text (optional)",
    description: "description",
    actionType: .closeButton {
      print("BezierInnerBanner")
    }
  )
}
