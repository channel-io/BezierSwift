//
//  SUBezierDivider.swift
//  BezierSwift
//

import SwiftUI

/// 콘텐츠를 구분하는 가로 구분선 (SwiftUI). Figma `Divider`의 `orientation` 중 가로(horizontal)만 지원하며 세로(vertical)는 제공하지 않는다. UIKit에서는 `BezierDivider`를 사용한다.
public struct SUBezierDivider: View, Themeable {
  private let sideIndent: Bool
  private let parallelIndent: Bool

  @Environment(\.colorScheme) public var colorScheme

  /// 좌우(`sideIndent`)·상하(`parallelIndent`) 여백 적용 여부를 지정해 생성한다. 각각 Figma `Divider`의 동명 BOOLEAN 프로퍼티에 대응하며 기본 `true`다.
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
