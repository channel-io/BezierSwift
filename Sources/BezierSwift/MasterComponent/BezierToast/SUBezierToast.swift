//
//  SUBezierToast.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierToast: View, Themeable {
  private let preset: BezierToastPreset
  private let title: String

  @Environment(\.colorScheme) public var colorScheme

  private var invertedColorScheme: ColorScheme {
    self.colorScheme == .dark ? .light : .dark
  }

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
          .foregroundColor(self.preset.iconColor.map { self.palette($0, isInverted: true) })
      }

      Text(self.title)
        .applyBezierFontStyle(BezierToastSpec.typographyToken, semanticColorToken: BezierToastSpec.textToken)
        .lineLimit(BezierToastSpec.textLineLimit)
        .truncationMode(.tail)
        .padding(.vertical, BezierToastSpec.textVerticalPadding)
    }
    .padding(.vertical, BezierToastSpec.verticalPadding)
    .padding(
      .horizontal,
      self.preset.icon == nil ? BezierToastSpec.horizontalPaddingTextOnly : BezierToastSpec.horizontalPaddingWithIcon
    )
    .frame(minHeight: BezierToastSpec.minHeight)
    .background(self.palette(BezierToastSpec.backgroundToken, isInverted: true))
    .applyBlurEffect()
    .applyBezierCornerRadius(type: BezierToastSpec.cornerRadius)
    .frame(maxWidth: BezierToastSpec.maxWidth)
    // applyBezierFontStyle 내부 modifier가 자체 @Environment(\.colorScheme)로 텍스트 색을 해석해
    // isInverted를 받지 못하므로, 텍스트를 함께 반전시키려면 environment를 뒤집어 주입해야 한다.
    .environment(\.colorScheme, self.invertedColorScheme)
  }
}

struct SUBezierToast_Previews: PreviewProvider {
  static var previews: some View {
    ForEach([ColorScheme.light, ColorScheme.dark], id: \.self) { scheme in
      VStack(spacing: 16) {
        ForEach(BezierToastPreset.allCases, id: \.self) { preset in
          SUBezierToast(preset: preset, title: "Message")
        }
      }
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.gray)
      .preferredColorScheme(scheme)
    }
  }
}
