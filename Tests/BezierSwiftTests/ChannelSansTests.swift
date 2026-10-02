import Testing
import UIKit
import BezierSwift

@Suite("Channel Sans")
struct ChannelSansTests {
  @Test("폰트 리소스 등록과 공개 굵기")
  func registrationAndWeights() {
    #expect(ChannelSans.fontURL?.lastPathComponent == "ChannelSans.ttf")
    #expect(ChannelSans.register())

    for (weight, name) in [
      (ChannelSans.Weight.regular, "ChannelSans-Regular"),
      (.medium, "ChannelSans-Medium"),
      (.bold, "ChannelSans-Bold"),
    ] {
      let font = ChannelSans.uiFont(ofSize: 16, weight: weight)
      #expect(font.fontName == name)
      #expect(font.pointSize == 16)
    }
  }

  @Test("토큰과 직접 지정 컴포넌트가 같은 폰트 사용")
  func typographyConsumers() {
    #expect(BTSemanticToken.textMedium().uiFont.fontName == "ChannelSans-Regular")
    #expect(BTSemanticToken.labelLarge.uiFont.fontName == "ChannelSans-Bold")
    #expect(BezierFont.normal14.uiFont.fontName == "ChannelSans-Regular")
    #expect(BezierFont.bold14.uiFont.fontName == "ChannelSans-Bold")
    #expect(BezierButtonSize.large.uiFont.fontName == "ChannelSans-Medium")
    #expect(BTSemanticToken.codeMedium.uiFont.fontName != "ChannelSans-Regular")
  }
}
