//
//  BezierModalSpec.swift
//  BezierSwift
//

import CoreGraphics

public enum BezierModalSpec {
  public static let width: CGFloat = 320
  public static let maxWidth: CGFloat = 480
  public static let topPadding: CGFloat = 20
  public static let bottomPadding: CGFloat = 16
  public static let horizontalPadding: CGFloat = 16
  public static let contentMinHeight: CGFloat = 1
  public static let cornerRadius: BezierCornerRadius = .round32
  public static let elevation: BezierElevation = .mEv3
  public static let backgroundToken: BCSemanticToken = .surfaceHigher
}
