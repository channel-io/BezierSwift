//
//  SUBezierModal.swift
//  BezierSwift
//

import SwiftUI

/// 현재 맥락을 유지한 채 집중 작업(설정·폼·정보 확인)을 담는 모달 카드 (SwiftUI). 단순 확인 흐름은 `SUBezierConfirmModal`을 쓴다. Figma의 `size`(420/540 등 너비 프리셋)는 Figma 전용이라 코드에는 prop이 없고, 컨테이너에서 너비를 직접 지정한다. UIKit에서는 `BezierModal`을 사용한다.
public struct SUBezierModal<Content: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let content: Content

  /// 모달 카드에 담을 본문을 `@ViewBuilder`로 받아 생성한다.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    VStack(spacing: 0) {
      self.content
        .frame(maxWidth: .infinity, minHeight: BezierModalSpec.contentMinHeight)
    }
    .padding(.top, BezierModalSpec.topPadding)
    .padding(.bottom, BezierModalSpec.bottomPadding)
    .padding(.horizontal, BezierModalSpec.horizontalPadding)
    .frame(width: BezierModalSpec.width)
    .background(self.palette(BezierModalSpec.backgroundToken))
    .applyBezierCornerRadius(type: BezierModalSpec.cornerRadius)
    .applyBezierElevation(BezierModalSpec.elevation)
  }
}

struct SUBezierModal_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
      SUBezierModal {
        Text("Custom Content")
          .frame(height: 184)
      }
    }
  }
}
