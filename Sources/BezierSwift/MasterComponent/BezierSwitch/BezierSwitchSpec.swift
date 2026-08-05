//
//  BezierSwitchSpec.swift
//  BezierSwift
//

import Foundation

enum BezierSwitchConstant {
  static let trackWidth: CGFloat = 50
  static let trackHeight: CGFloat = 28
  static let trackCornerRadius: CGFloat = 14

  static let thumbLength: CGFloat = 24
  static let thumbInset: CGFloat = 2
  static let thumbShadowOpacity: Float = 0.25
  static let thumbShadowOffset = CGSize(width: 0, height: 2)
  static let thumbShadowRadius: CGFloat = 2

  static let errorRingSpacing: CGFloat = 3
  static let errorRingWidth: CGFloat = 1.5
  static let errorRingCornerRadius: CGFloat = (trackHeight + errorRingSpacing * 2) / 2

  static let disabledOpacity: CGFloat = BOGlobalToken.disabled
  static let toggleAnimationDuration: TimeInterval = 0.2

  static let trackOffColor: BCSemanticToken = .fillNeutralHeavy
  static let trackOnColor: BCSemanticToken = .fillNeutralHeaviest
  static let thumbColor: BCSemanticToken = .iconInverseHeavier
  static let errorRingColor: BCSemanticToken = .stateWarning
}
