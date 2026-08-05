//
//  SUBezierCard.swift
//  BezierSwift
//

import SwiftUI

/// 콘텐츠를 하나의 독립 묶음으로 감싸는 카드 컨테이너 (SwiftUI). `surface` 배경 + 1pt `borderNeutral` 테두리 + radius 16의 외형만 소유하고 내용은 `content`에 위임한다. 제안받은 너비를 채우고 높이는 콘텐츠에 맞게 늘어난다. UIKit에서는 `BezierCard`를 사용한다.
public struct SUBezierCard<Content: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let content: Content

  /// 카드 안(contentSlot)에 그릴 콘텐츠로 카드를 만든다.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    self.content
      .padding(
        EdgeInsets(
          top: BezierCardConstant.verticalPadding,
          leading: BezierCardConstant.horizontalPadding,
          bottom: BezierCardConstant.verticalPadding,
          trailing: BezierCardConstant.horizontalPadding
        )
      )
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(
        RoundedRectangle(cornerRadius: BezierCardConstant.cornerRadius)
          .fill(self.palette(BezierCardConstant.backgroundColor))
      )
      .overlay(
        RoundedRectangle(cornerRadius: BezierCardConstant.cornerRadius)
          .strokeBorder(
            self.palette(BezierCardConstant.borderColor),
            lineWidth: BezierCardConstant.borderWidth
          )
      )
      .clipShape(RoundedRectangle(cornerRadius: BezierCardConstant.cornerRadius))
  }
}

struct SUBezierCard_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(spacing: 20) {
        SUBezierCard {
          VStack(alignment: .leading, spacing: 8) {
            Text("제목")
            Text("설명 텍스트가 들어가는 영역입니다.")
          }
          .padding(16)
        }

        SUBezierCard {
          Color.clear.frame(height: 120)
        }
      }
      .padding(16)
    }
  }
}
