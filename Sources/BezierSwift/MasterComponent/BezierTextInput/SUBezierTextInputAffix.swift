//
//  SUBezierTextInputAffix.swift
//  BezierSwift
//

import SwiftUI

/// `SUBezierTextInput`의 leadingContent/trailingContent 슬롯에 넣는 접사 텍스트 (SwiftUI). `https://`, `%`, `.channel.io`처럼 짧고 고정된 포맷 힌트에 쓴다. 단독 배치는 금지한다. UIKit에서는 `BezierTextInputAffix`를 사용한다.
public struct SUBezierTextInputAffix: View {
  private let text: String

  /// 접사 텍스트를 지정해 생성한다.
  public init(text: String) {
    self.text = text
  }

  public var body: some View {
    Text(self.text)
      .applyBezierFontStyle(
        BezierBaseInputConstant.affixTypography,
        semanticColorToken: BezierBaseInputConstant.affixTextColor
      )
      .lineLimit(1)
      .fixedSize()
  }
}
