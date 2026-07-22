//
//  SUBezierDivider.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierDivider: View, Themeable {
  private let sideIndent: Bool
  private let parallelIndent: Bool

  @Environment(\.colorScheme) public var colorScheme

  public init(sideIndent: Bool = true, parallelIndent: Bool = true) {
    self.sideIndent = sideIndent
    self.parallelIndent = parallelIndent
  }

  public var body: some View {
    Rectangle()
      .fill(self.palette(BCSemanticToken.borderNeutral))
      .frame(height: BezierDividerConstant.lineThickness)
      .frame(minWidth: BezierDividerConstant.lineThickness, maxWidth: .infinity)
      .padding(.horizontal, self.sideIndent ? BezierDividerConstant.indentSize : 0)
      .padding(.vertical, self.parallelIndent ? BezierDividerConstant.indentSize : 0)
  }
}

struct SUBezierDivider_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      SUBezierDivider()
      SUBezierDivider(sideIndent: false)
      SUBezierDivider(parallelIndent: false)
      SUBezierDivider(sideIndent: false, parallelIndent: false)
    }
    .padding()
  }
}
