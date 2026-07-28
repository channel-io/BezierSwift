//
//  BezierSearchSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Constant

enum BezierSearchConstant {
  static let metric: BezierBaseInputMetric = .small
  static let variant: BezierBaseInputVariant = .primary

  static let searchIcon: BezierIcon = .search
  static let clearIcon: BezierIcon = .cancelCircleFilled

  static let cancelButtonSpacing: CGFloat = 8
  static let cancelButtonHorizontalPadding: CGFloat = 4
  static let cancelButtonTypography: BTSemanticToken = .textMedium(weight: .regular)
  static let cancelButtonTextColor: BCSemanticToken = .textNeutral
}
