//
//  SUBezierOverlay.swift
//  BezierSwift
//

import SwiftUI

/// floating UI를 직접 구성할 때 쓰는 범용 오버레이 컨테이너 (SwiftUI). `surfaceHighest` 배경·32pt 라운드·elevation 그림자를 가진 240pt 고정 폭 카드로, `content`에 임의 뷰를 담는다. 자식 구조가 정해진 목적형 오버레이(드롭다운 목록 등)로 표현할 수 없는 floating UI에만 쓰며, 열림/닫힘·위치 계산(backdrop 없는 앵커형 팝오버 배치)은 사용처 책임이다. UIKit에서는 `BezierOverlay`를 사용한다.
public struct SUBezierOverlay<Content: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let content: Content

  /// content 슬롯 뷰를 지정해 오버레이를 만든다. 슬롯 폭은 220pt(= 240 − 10×2)로 고정되고 높이는 콘텐츠에 맞게 늘어난다.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    self.content
      .frame(maxWidth: .infinity, alignment: .topLeading)
      .padding(BezierOverlayConstant.padding)
      .frame(width: BezierOverlayConstant.width)
      .background(
        RoundedRectangle(cornerRadius: BezierOverlayConstant.cornerRadius)
          .fill(self.palette(BezierOverlayConstant.backgroundColor))
      )
      .applyBezierElevation(BezierOverlayConstant.elevation)
  }
}

struct SUBezierOverlay_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 32) {
      SUBezierOverlay {
        VStack(alignment: .leading, spacing: 0) {
          SUBezierBaseItem(
            title: "이름 변경",
            onTap: {},
            leading: { EmptyView() },
            trailing: { EmptyView() }
          )
          SUBezierBaseItem(
            title: "복제",
            onTap: {},
            leading: { EmptyView() },
            trailing: { EmptyView() }
          )
          SUBezierBaseItem(
            title: "삭제",
            onTap: {},
            leading: { EmptyView() },
            trailing: { EmptyView() }
          )
        }
      }

      SUBezierOverlay {
        Text("자유 구성 콘텐츠")
          .padding(8)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.2))
  }
}
