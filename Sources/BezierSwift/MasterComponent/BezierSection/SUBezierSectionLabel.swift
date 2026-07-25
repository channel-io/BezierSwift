//
//  SUBezierSectionLabel.swift
//  BezierSwift
//

import SwiftUI

/// 섹션 헤더 bar (SwiftUI). 선택적 좌측 슬롯 · 텍스트 · 우측 슬롯을 담는 `SUBezierSection` 전용 헤더다. 단독으로 쓰지 말고 섹션 헤더로 사용한다. UIKit에서는 `BezierSectionLabel`을 사용한다.
public struct SUBezierSectionLabel<Leading: View, Trailing: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let text: String
  private let color: BezierSectionLabelColor
  private let leading: Leading
  private let trailing: Trailing

  /// 라벨 텍스트·색과 좌우 슬롯 빌더로 헤더를 만든다.
  public init(
    _ text: String,
    color: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder leading: () -> Leading,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.text = text
    self.color = color
    self.leading = leading()
    self.trailing = trailing()
  }

  public var body: some View {
    HStack(spacing: 0) {
      HStack(spacing: BezierSectionConstant.labelLeadingSpacing) {
        self.leadingView

        Text(self.text)
          .applyBezierFontStyle(
            BezierSectionConstant.labelTypography,
            semanticColorToken: self.color.textColor
          )
          .lineLimit(1)
          .truncationMode(.tail)
      }

      Spacer(minLength: BezierSectionConstant.labelTrailingSpacing)

      self.trailingView
    }
    .padding(.horizontal, BezierSectionConstant.labelHorizontalPadding)
    .frame(minHeight: BezierSectionConstant.labelHeight)
    .frame(maxWidth: .infinity)
    .clipShape(RoundedRectangle(cornerRadius: BezierSectionConstant.labelCornerRadius))
  }

  @ViewBuilder
  private var leadingView: some View {
    if Leading.self != EmptyView.self {
      self.leading
        .frame(
          width: BezierSectionConstant.labelLeadingContentLength,
          height: BezierSectionConstant.labelLeadingContentLength
        )
    }
  }

  @ViewBuilder
  private var trailingView: some View {
    if Trailing.self != EmptyView.self {
      self.trailing
        .frame(height: BezierSectionConstant.labelTrailingContentHeight)
        .layoutPriority(1)
    }
  }
}

// MARK: - Convenience init

extension SUBezierSectionLabel where Leading == EmptyView {
  /// 좌측 슬롯 없이 텍스트·우측 슬롯만으로 만드는 편의 이니셜라이저.
  public init(
    _ text: String,
    color: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder trailing: () -> Trailing
  ) {
    self.init(text, color: color, leading: { EmptyView() }, trailing: trailing)
  }
}

extension SUBezierSectionLabel where Leading == EmptyView, Trailing == EmptyView {
  /// 텍스트(와 색)만으로 만드는 편의 이니셜라이저.
  public init(_ text: String, color: BezierSectionLabelColor = .neutralDark) {
    self.init(text, color: color, leading: { EmptyView() }, trailing: { EmptyView() })
  }
}

struct SUBezierSectionLabel_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 12) {
      SUBezierSectionLabel("태그")
      SUBezierSectionLabel("담당자", color: .neutralLight)
      SUBezierSectionLabel("첨부파일") {
        BezierIcon.plus.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(.secondary)
      }
      SUBezierSectionLabel(
        "폴더",
        leading: {
          BezierIcon.folder.image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundColor(.secondary)
        },
        trailing: { EmptyView() }
      )
    }
    .padding()
  }
}
