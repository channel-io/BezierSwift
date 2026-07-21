//
//  SUBezierToast.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierToast: View, Themeable {
  private let preset: BezierToastPreset
  private let title: String

  // Toast는 항상 dark 표면. colorScheme을 .dark 상수로 고정하여 palette()가 dark 값(배경·아이콘)을 해석하게 한다.
  public var colorScheme: ColorScheme { .dark }

  public init(preset: BezierToastPreset = .info, title: String) {
    self.preset = preset
    self.title = title
  }

  public var body: some View {
    HStack(alignment: .top, spacing: BezierToastSpec.iconTextGap) {
      if let icon = self.preset.icon {
        icon.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: BezierToastSpec.iconLength, height: BezierToastSpec.iconLength)
          .foregroundColor(self.palette(self.preset.iconColor))
      }

      Text(self.title)
        .applyBezierFontStyle(BezierToastSpec.typographyToken, semanticColorToken: BezierToastSpec.textToken)
        .lineLimit(BezierToastSpec.textLineLimit)
        .truncationMode(.tail)
    }
    .padding(.vertical, BezierToastSpec.verticalPadding)
    .padding(
      .horizontal,
      self.preset.icon == nil ? BezierToastSpec.horizontalPaddingTextOnly : BezierToastSpec.horizontalPaddingWithIcon
    )
    .frame(minHeight: BezierToastSpec.minHeight)
    .background(Capsule().fill(self.palette(BezierToastSpec.backgroundToken)))
    .clipShape(Capsule())
    .frame(maxWidth: BezierToastSpec.maxWidth)
    // applyBezierFontStyle 내부 modifier가 자체 @Environment(\.colorScheme)로 텍스트 색을 해석하므로,
    // 텍스트도 dark로 고정하려면 environment도 함께 pin해야 한다.
    .environment(\.colorScheme, .dark)
  }
}

struct SUBezierToast_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      ForEach(BezierToastPreset.allCases, id: \.self) { preset in
        SUBezierToast(preset: preset, title: "Message")
      }
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
  }
}
